#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#ifdef __MINGW32__
#include <ws2tcpip.h>
#include <wininet.h>
#include <fcntl.h>
#define	pipe(fds) _pipe(fds, 1024, O_BINARY)
#else
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <signal.h>
#include <netdb.h>
#endif

#include <math.h>
#include "ahdlc.h"

#define QUEUE   4
#define MAXSIZE (8*1024)
#define printnl fprintf(stderr,"\n")


char ack_rcvd = 0;
long long addr_rcvd;

char rbuff[MAXSIZE];

struct rgtr {
	char unsigned id;
	char unsigned len;
	char unsigned *data;
	struct rgtr * next;
};

struct rgtr rgtrs[256];

struct rgtr * sio_parse(char unsigned *data, int len)
{
	enum states { stt_id, stt_len, stt_data };
	enum states state;

	struct rgtr rgtr;
	char unsigned *ptr;

	state = stt_id;
	ptr = data;
	while (data-ptr < len) {
		switch(state) {
		case stt_id:
			rgtr.id = ptr++;
			state   = stt_len;
			break;
		case stt_len:
			rgtr.len = ptr++;
			state    = stt_data;
			break;
		case stt_data:
			rgtr.data = ptr;
			ptr += rgtr.len;
			state = stt_id;
			break;
		}
	}
}

sio_rgtr0 (char * buff, int len) {

}

void init_ahdlc ()
{
	setbuf(stdin, NULL);
	setbuf(stdout, NULL);
}

char sbuff[MAXSIZE];
char *sload = sbuff+5;
int  pkt_sent = 0;
int  ack      = 0x4a;

void print_pkt (void *pkt, int len)
{
	for(int i = 0; i < len; i++) {
		fprintf(stderr,"0x%02x ", ((char unsigned *) pkt)[i]);
	}
}

void send_char (char unsigned c)
{
	fwrite(&c, sizeof(char), 1, stdout);
//	fprintf(stderr,"0x%02x ", c);
}

void send_ahdlc (int psize)
{
	u16 fcs;

    fcs = ~reverse(pppfcs16(PPPINITFCS16, sbuff, psize), 16);
	memcpy(sbuff+psize+0, (char *) &fcs+1, sizeof(fcs)/2);
	memcpy(sbuff+psize+1, (char *) &fcs+0, sizeof(fcs)/2);
	psize += sizeof(fcs);
	send_char(0x7e);
	for (int i = 0; i < psize; i++) {
		if (sbuff[i] == 0x7e) {
			send_char(0x7d);
			sbuff[i] ^= 0x20;
		} else if(sbuff[i] == 0x7d) {
			send_char(0x7d);
			sbuff[i] ^= 0x20;
		}
		send_char(sbuff[i]);
	}
	send_char(0x7e);
}

void send_pkt(int psize)
{
	int len = 0;

	sbuff[len++] = 0x00;
	sbuff[len++] = 0x02;
	sbuff[len++] = 0x00;
	sbuff[len++] = 0x00;
	sbuff[len++] = (ack & 0x03f);
	len += psize;

	send_ahdlc(len);
	pkt_sent++;
}

int  pkt_lost = 0;

int rcvd_pkt()
{
	short unsigned fcs;
	fd_set rfds;
	struct timeval tv;
	int err;
	int len;

	pkt_lost++;
	for (len = 0; len < sizeof(rbuff); len++) {
		FD_ZERO(&rfds);
		FD_SET(fileno(stdout), &rfds);
		tv.tv_sec  = 0;
		tv.tv_usec = 1000;

		if ((err = select(fileno(stdout)+1, &rfds, NULL, NULL, &tv)) == -1) {
			perror ("select");
			exit (1);
		} else {
			if (err > 0) {
				if (fread(rbuff+len, sizeof(char), 1, stdout) > 0)
					if (rbuff[len] == 0x7e)
						break;
					else
						continue;
				perror("reading serial");
				exit(1);
			} else {
				fprintf(stderr, "reading time out\n");
				len--;
			}
		}
	}

	int i;
	int j;
	for (i = 0, j = 0; i < len; rbuff[j++] = rbuff[i++]) {
		if (rbuff[i] == 0x7d) {
			rbuff[++i] ^= 0x20;
		}
	}
	len += (j-i);
	fcs = pppfcs16(PPPINITFCS16, rbuff, len);
	if (fcs == PPPGOODFCS16) {
		len -= 2;
		print_pkt(rbuff, len);
		fprintf(stderr, "OK!!!!!!!! fcs 0x%04x\n", fcs);
		pkt_lost--;
		return len;
	}
	len -= 2;
	print_pkt(rbuff, len);
	fprintf(stderr, ">>> WRONG <<< fcs 0x%04x\n", fcs);

	return 0;
}

int main (int argc, char *argv[])
{

#ifdef __MINGW32__
	WSADATA wsaData;
#endif

	int  c;
	char hostname[256] = "";

	unsigned char *bufptr;
	char pktmd;

	fd_set rfds;
	int n;
	int l;
	int ssize;
	int rlen;


#ifdef __MINGW32__
	if (WSAStartup(MAKEWORD(2,2), &wsaData))
		exit(-1);
#endif

	pktmd  = 0;
	opterr = 0;
	while ((c = getopt (argc, argv, "dph:")) != -1) {
		switch (c) {
		case 'p':
			pktmd = 1;
			break;
		case 'h':
			if (optarg)
				sscanf (optarg, "%64s", hostname);
			break;
		case '?':
			fprintf (stderr, "usage : sendbyudp -p -h hostname\n");
			exit(1);
		default:
			exit(1);
		}
	}

	init_ahdlc();

	// Reset ack //
	// --------- //

	if (debug) fprintf (stderr, ">>> SETTING ACK <<<\n");
	for(;;) {
		if (debug) fprintf (stderr, "Sending acknowlage\n");
		send_pkt(0);
		sio_parse(sbuff, sload-sbuff); printnl;

		if (debug) fprintf (stderr, "Waiting acknowlage\n");
		rlen = rcvd_pkt();
		if (debug) fprintf (stderr, "Acknowlage received\n");
		sio_parse(rbuff, rlen); printnl;

		if (((ack ^ ack_rcvd) & 0x3f) == 0 && rlen > 0)
			break;
	}
	if (debug) fprintf (stderr, ">>> ACKNOWLEGE SET <<<\n");

	if (!pktmd)
		if (debug) fprintf (stderr, "No-packet-size mode\n");

	for(;;) {
		int size = sizeof(sbuff)-(sload-sbuff);

		if (debug) fprintf (stderr, ">>> READING PACKET <<<\n");
		if (pktmd) {
			if ((fread(&size, sizeof(unsigned short), 1, stdin) > 0))
				if (debug) fprintf (stderr, "Packet size %d\n", size);
			else
				break;
		}

		if ((n = fread(sload, sizeof(unsigned char), size, stdin)) > 0) {
			if (debug) fprintf (stderr, "Packet read length %d\n", n);
			size = n;
			if (size > MAXSIZE) {
				if (debug) fprintf (stderr, "Packet size %d greater than %d\n", size, MAXSIZE);
				exit(1);
			}

			ack++;

			if (debug) fprintf (stderr, ">>> SENDING PACKET <<<\n");
			send_pkt(size);
			sio_parse(sbuff, sload-sbuff+size); printnl; ack = ack_rcvd;
			if (debug) fprintf (stderr, ">>> CHECKING ACK <<<\n");
			for(;;) {
				if (debug) fprintf (stderr, "waiting for acknowlege\n", n); //exit(1);
				rlen = rcvd_pkt();
				if (rlen > 0) {
					if (debug) fprintf (stderr, "acknowlege received\n", n); //exit(1);
					sio_parse(rbuff, rlen); printnl;
					if (((ack ^ ack_rcvd) & 0x3f) == 0)
						break;
					else {
						if (debug) fprintf (stderr, "acknowlege sent 0x%02x received 0x%02x\n", ack & 0xff, ack_rcvd & 0xff);
						continue;
					}
				}

				if (debug) fprintf (stderr, "waiting time out\n", n); //exit(1);
				if (debug) fprintf (stderr, "sending package again\n", n); //exit(1);
				send_pkt(size);
				sio_parse(sbuff, sload-sbuff+size); printnl; ack = ack_rcvd;
			}

			if (debug) fprintf (stderr, "package acknowleged\n", n); //exit(1);

			if (debug) fprintf (stderr, ">>> CHECKING DMA STATUS <<<\n");
			for (;;) {
				if (!((addr_rcvd & 0xc0000000) ^ 0xc0000000)) 
					break;

				if (debug) fprintf (stderr, "dma not ready\n");
				ack++;
				if (debug) fprintf (stderr, "sending new acknowlege\n");
				send_pkt(0);
				sio_parse(sbuff, sload-sbuff); printnl; ack = ack_rcvd;

				for (;;) {
					rlen = rcvd_pkt();
					if (rlen > 0) {
						sio_parse(rbuff, rlen); printnl;
						if (rlen > 0)
							if (((ack ^ ack_rcvd) & 0x3f) == 0)
								break;
							else
								continue;
					}
					send_pkt(0);
					sio_parse(sbuff, sload-sbuff); printnl; ack = ack_rcvd;
				}
			}
			if (debug) fprintf (stderr, "dma ready\n");
	//		if ((addr_rcvd & 0xfff) != ((addr_rcvd >> 12) & 0xfff))
	//			break;
		
//			for (int i = 1; i < 4; i++)
//				if ((addr_rcvd & 0xf) != ((addr_rcvd >> (4*i) & 0xf))) {
//					if (debug) fprintf(stderr,"marca -->\n");
//					break;
//				}


		} else if (n < 0) {
			perror ("reading packet");
			exit(1);
		} else
			break;

	}

	return 0;
}
