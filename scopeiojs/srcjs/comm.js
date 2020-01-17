//                                                                            //
// Author(s):                                                                 //
//   Miguel Angel Sagreras                                                    //
//                                                                            //
// Copyright (C) 2015                                                         //
//    Miguel Angel Sagreras                                                   //
//                                                                            //
// This source file may be used and distributed without restriction provided  //
// that this copyright statement is not removed from the file and that any    //
// derivative work contains  the original copyright notice and the associated //
// disclaimer.                                                                //
//                                                                            //
// This source file is free software; you can redistribute it and/or modify   //
// it under the terms of the GNU General Public License as published by the   //
// Free Software Foundation, either version 3 of the License, or (at your     //
// option) any later version.                                                 //
//                                                                            //
// This source is distributed in the hope that it will be useful, but WITHOUT //
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or      //
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for   //
// more details at http://www.gnu.org/licenses/.                              //
//                                                                            //

// Asynchronous communication
//

const SerialPort = require('serialport');
const Readline = SerialPort.parsers.Readline;

const baudRates  = [ 9600, 38400, 115200 ];

var uart;
var hostName;
var commOption;

function toHex(buffer)
{
	let len = (typeof buffer.length === 'undefined') ? buffer.byteLength : buffer.length;
	let str = "";
	str = str + ' ' + Number(buffer[0]).toString('16');

	for (var i=1; i < len; i++)
		str = str + ' ' + Number(buffer[i]).toString('16');
	return str;
}

function streamout (data) {

	let str = '';
	function write (data) {
		uart.write(data);
		str = str + toHex(data);
	}

	let uint8 = new Uint8Array(1);
	let esc   = new Uint8Array(1);
	let eos   = new Uint8Array(1);

	esc[0] = 0x5c;
	eos[0] = 0x00;

	for (var i = 0; i < data.length; i++) {
		uint8[0] = data[i];
		if (uint8[0] == esc[0] || uint8[0] == eos[0]) {
			write(esc);
		}
		write(uint8);
	}
	write(eos);
	return str;
}

// TCP/IP communication
//

const dgram = require('dgram');
var udpsckt = dgram.createSocket('udp4');

function send(data) {

	switch (commOption) {
	case 'UART':
		console.log(commOption + streamout(data));
		break;
	case 'TCPIP':
		const ipport = 57001;
		var buffer   = new Uint8Array(data.length+2);
	
		for (i=0; i < data.length; i++)
			buffer[i] = data[i];
		buffer[i++] = 0xff;
		buffer[i++] = 0xff;
		udpsckt.send(buffer, ipport, hostName, function(err, bytes) {
			if (err)
				throw err;
			else 
				console.log('UDP :' + toHex(buffer));
		});
		break;
	}
}

function createUART (uartName, options) {
	if (typeof uart !== 'undefined')
		if (uart.err === false) {
			console.log("closed : " + uart.path);
			uart.close();
		}

	let uartError;
	uart = new SerialPort(uartName, options, function(err) {
		uart.err = false;
		if (err) {
			uart.err = true;
		}
	});
	return uart;
}

function listUART () {
	return SerialPort.list();
}

function getHost() {
	return hostName;
}

function setHost(name) {
	hostName = name;
}

function setCommOption(option) {
	commOption = option;
}

function getCommOption(option) {
	return commOption;
}

try {
exports.listUART      = listUART;
exports.createUART    = createUART;
exports.setCommOption = setCommOption;
exports.getHost       = getHost;
exports.setHost       = setHost;
exports.send          = send;
}
catch(e) {
}
