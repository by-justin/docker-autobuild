#!/bin/bash
echo "  _ ____            _ "
echo " (_)___ \ _ __   __| |"
echo " | | __) | '_ \ / _\` |"
echo " | |/ __/| |_) | (_| |"
echo " |_|_____| .__/ \__,_|"
echo "         |_|          "

# copy config for first time installtion
if [ ! -e /config/i2pd.conf ]; then

    echo "Copying new files to directory."

    if [ -n "$(find /config -mindepth 1 -maxdepth 1)" ]; then
			echo >&2 "Directory not empty!"
            exit 
	fi

    cp -r /config.default/* /config

fi

/usr/local/bin/i2pd --datadir=/config