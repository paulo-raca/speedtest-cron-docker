#!/bin/sh

RESULT_CSV=/tmp/speedtest.csv

THINGSPEAK_KEY=XXXX

SERVER_NET_TURBO=1846
SERVER_MPC=9960
SERVER_MINUTOS_TELECOM=10451

speedtest --server $SERVER_MPC --csv > $RESULT_CSV && {
	server_id=`cat $RESULT_CSV | cut -d, -f1`
	server_sponsor=`cat $RESULT_CSV | cut -d, -f2`
	server_name=`cat $RESULT_CSV | cut -d, -f3`
	timestamp=`cat $RESULT_CSV | cut -d, -f4`
	distance_km=`cat $RESULT_CSV | cut -d, -f5`
	ping=`cat $RESULT_CSV | cut -d, -f6`
	download=`cat $RESULT_CSV | cut -d, -f7`
	upload=`cat $RESULT_CSV | cut -d, -f8`
	
	curl -s "https://api.thingspeak.com/update?api_key=${THINGSPEAK_KEY}&field1=${download}&field2=${upload}&field3=${ping}"
	
	echo Download: ${download}, Upload: ${upload}, ping: ${ping}ms
}
