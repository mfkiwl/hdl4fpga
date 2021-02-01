#!/bin/sh
TTY="${TTY:-/dev/ttyUSB0}"
SPEED="${SPEED:-3000000}"
PKMODE="STREAM"
export TTY SPEED PKMODE

./scritps/setack.sh

ADDR=0
UPTO=`expr 800 \* 600`
while [ ${ADDR} -lt ${UPTO} ] ; do
		BADDR=`printf %08x ${ADDR}`
		echo "\
18ff\
f81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81f\
f81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81ff81f\
f800f800f800f800f800f800f800f800f800f800f800f800f800f800f800f800\
f800f800f800f800f800f800f800f800f800f800f800f800f800f800f800f800\
07e007e007e007e007e007e007e007e007e007e007e007e007e007e007e007e0\
07e007e007e007e007e007e007e007e007e007e007e007e007e007e007e007e0\
07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff\
07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff07ff05a0\
170200007f1602${BADDR}"|xxd -r -ps|./scripts/siocomm.sh|xxd -ps| tr -d '\n'
		ADDR=`expr ${ADDR} + 128`
done
		echo ${BADDR};
