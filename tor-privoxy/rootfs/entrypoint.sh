#!/bin/bash

echo "  _____               ____       _                      "
echo " |_   _|__  _ __     |  _ \ _ __(_)_   _______  ___   _ "
echo "   | |/ _ \| '__|____| |_) | '__| \ \ / / _ \ \/ / | | |"
echo "   | | (_) | | |_____|  __/| |  | |\ V / (_) >  <| |_| |"
echo "   |_|\___/|_|       |_|   |_|  |_| \_/ \___/_/\_\\\\__, |"
echo "                                                  |___/ "

# copy config for first time installtion
if [ ! -e /etc/tor/torrc ]; then

    echo "Copying new files to config directory."

    if [ -n "$(find /etc/tor/torrc -mindepth 1 -maxdepth 1)" ]; then
			echo >&2 "Directory not empty!"
            exit 
	fi

    cp -r /etc/tor.default/* /etc/tor

fi

echo ""
echo "--------------------------------------------------------"
echo ""

chown -R root /var/lib/tor

socat -d tcp-listen:9051,reuseaddr,fork tcp:127.0.0.1:9052 &> /dev/null &
privoxy /etc/privoxy/config &> /dev/null &
tor -f /etc/tor/torrc

