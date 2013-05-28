#!/bin/bash
# Description: This download the Ubuntu Touch daily image from the ubuntu server, patch it for Nexus S, create a ~1,7GB image and copy the entire system into it.
# At the end of the process you have to copy the 'ubuntu' folder into the root folder of the phone.
# Matsca09

debug(){
	echo "[DEBUG] $1"
}

error(){
	echo "[ERROR] $1"
	exit
}

download_image(){
	debug " -> Downloading Ubuntu Touch daily image"
wget http://cdimage.ubuntu.com/ubuntu-touch-preview/daily-preinstalled/current/raring-preinstalled-phablet-armhf.zip || error "Something went wrong while downloading the Ubuntu image!"
}

create_image(){
	debug "-> Creating the image file..."
	mkdir ubuntu
	dd if=/dev/zero of=ubuntu/system.img bs=1M count=1700
	debug "-> Formatting and mounting"
	sudo mkfs.ext4 -F ubuntu/system.img
	mkdir mnt
	sudo mount -o loop ubuntu/system.img mnt
}

install_os(){
	debug "-> Copying system files..."
	unzip -q -j "raring-preinstalled-phablet-armhf.zip" "ubuntu-touch-raring-armhf.tar.gz" -d .
	sudo tar --numeric-owner -xzf ubuntu-touch-raring-armhf.tar.gz -C mnt/
	sudo mv mnt/binary/* mnt/
	sudo rmdir mnt/binary
	debug "-> Creating configuration file..."
	echo -e "GRID_UNIT_PX=10\nQTWEBKIT_DPR=1.0\nFORM_FACTOR=""phone""" | sudo tee mnt/etc/ubuntu-session.d/crespo.conf >/dev/null
}

cleanup(){
	debug "-> Cleaning..."
	sleep 5
	sync
	sudo umount mnt/
	rmdir mnt
	rm ubuntu-touch-raring-armhf.tar.gz
	rm raring-preinstalled-phablet-armhf.zip
}

if [ -d ubuntu ]; then
		error "There is an 'ubuntu' folder in this dir. If you want to recreate the image, please move it or delete it. Exiting."
		exit
fi
if [ -e "raring-preinstalled-phablet-armhf.zip" ]; then
	debug "Found Ubuntu Touch zip"
	debug "Do you want to remove it? (y/n)"
	read ans
	if [ "$ans" = "y" -o "$ans" = "Y" ]; then
		rm "raring-preinstalled-phablet-armhf.zip"
	fi
	create_image
	install_os
	cleanup
else
	download_image
	create_image
	install_os
	cleanup
fi
echo "Everything done! Copy the 'ubuntu' folder into the root of your phone and flash the base system you can find on the thread on xda"
echo " -> http://forum.xda-developers.com/showthread.php?t=2162735"
echo "Enjoy ;)"






