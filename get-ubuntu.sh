#!/bin/bash
# Description: This download the Ubuntu Touch daily image from the ubuntu server, patch it for Nexus S, create a ~1,8GB image and copy the entire system into it.
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
	wget http://cdimage.ubuntu.com/ubuntu-touch/saucy/daily-preinstalled/20131018/saucy-preinstalled-touch-armhf.tar.gz || error "Something went wrong while downloading the Ubuntu image!"
}

create_image(){
	debug "-> Creating the image file..."
	mkdir ubuntu
	dd if=/dev/zero of=ubuntu/system.img bs=1M count=1800
	debug "-> Formatting and mounting"
	sudo mkfs.ext4 -F ubuntu/system.img
	mkdir mnt
	sudo mount -o loop ubuntu/system.img mnt
}

install_os(){
	debug "-> Copying system files..."
	sudo tar --numeric-owner -xzf saucy-preinstalled-touch-armhf.tar.gz -C mnt/
	debug "-> Creating configuration files..."
	echo -e "GRID_UNIT_PX=10\nQTWEBKIT_DPR=1.0" | sudo tee mnt/etc/ubuntu-touch-session.d/crespo.conf >/dev/null
	echo -e 'ACTION=="add", KERNEL=="qemu_trace", OWNER="system", GROUP="system", MODE="0666"\nACTION=="add", KERNEL=="qemu_pipe", OWNER="system", GROUP="system", MODE="0666"\nACTION=="add", KERNEL=="ttyS*", OWNER="system", GROUP="system", MODE="0666"\nACTION=="add", KERNEL=="pvrsrvkm", OWNER="system", GROUP="system", MODE="0666"\nACTION=="add", KERNEL=="uwibro", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="swmxctl", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="video0", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="video1", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="video2", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="s3c-jpg", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="s3c-mem", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="s3c-mfc", OWNER="media", GROUP="media", MODE="0660"\nACTION=="add", KERNEL=="modem_ctl", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="modem_fmt", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="modem_rfs", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="s3c2410_serial3", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="block/mtdblock5", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="mtd/mtd5ro", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="mtd/mtd5", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="akm8973", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="accelerometer", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="s3c2410_serial1", OWNER="gps", GROUP="gps", MODE="0600"\nACTION=="add", KERNEL=="null", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="zero", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="full", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="ptmx", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="tty", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="random", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="urandom", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="ashmem", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="binder", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="alog/*", OWNER="root", GROUP="log", MODE="0666"\nACTION=="add", KERNEL=="msm_hw3dc", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="diag", OWNER="system", GROUP="qcom_diag", MODE="0660"\nACTION=="add", KERNEL=="kgsl", OWNER="root", GROUP="root", MODE="0666"\nACTION=="add", KERNEL=="dri/*", OWNER="root", GROUP="graphics", MODE="0666"\nACTION=="add", KERNEL=="diag_arm9", OWNER="radio", GROUP="radio", MODE="0660"\nACTION=="add", KERNEL=="android_adb", OWNER="adb", GROUP="adb", MODE="0660"\nACTION=="add", KERNEL=="android_adb_enable", OWNER="adb", GROUP="adb", MODE="0660"\nACTION=="add", KERNEL=="ttyMSM0", OWNER="bluetooth", GROUP="bluetooth", MODE="0600"\nACTION=="add", KERNEL=="uhid", OWNER="system", GROUP="net_bt_stack", MODE="0660"\nACTION=="add", KERNEL=="uinput", OWNER="system", GROUP="net_bt_stack", MODE="0660"\nACTION=="add", KERNEL=="alarm", OWNER="system", GROUP="radio", MODE="0664"\nACTION=="add", KERNEL=="tty0", OWNER="root", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="graphics/*", OWNER="root", GROUP="graphics", MODE="0660"\nACTION=="add", KERNEL=="msm_hw3dm", OWNER="system", GROUP="graphics", MODE="0660"\nACTION=="add", KERNEL=="input/*", OWNER="root", GROUP="input", MODE="0660"\nACTION=="add", KERNEL=="eac", OWNER="root", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="cam", OWNER="root", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="pmem", OWNER="system", GROUP="graphics", MODE="0660"\nACTION=="add", KERNEL=="pmem_adsp*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="pmem_camera*", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="oncrpc/*", OWNER="root", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="adsp/*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="snd/*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="mt9t013", OWNER="system", GROUP="system", MODE="0660"\nACTION=="add", KERNEL=="msm_camera/*", OWNER="system", GROUP="camera", MODE="0660"\nACTION=="add", KERNEL=="akm8976_daemon", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="akm8976_aot", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="akm8973_daemon", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="akm8973_aot", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="bma150", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="cm3602", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="akm8976_pffd", OWNER="compass", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="lightsensor", OWNER="system", GROUP="system", MODE="0640"\nACTION=="add", KERNEL=="msm_pcm_out*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="msm_pcm_in*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="msm_pcm_ctl*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="msm_snd*", OWNER="system", GROUP="audio", MODE="0660"\n
ACTION=="add", KERNEL=="msm_mp3*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="audience_a1026*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="tpa2018d1*", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="msm_audpre", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="msm_audio_ctl", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="htc-acoustic", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="vdec", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="q6venc", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="snd/dsp", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="snd/dsp1", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="snd/mixer", OWNER="system", GROUP="audio", MODE="0660"\nACTION=="add", KERNEL=="smd0", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="qmi", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="qmi0", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="qmi1", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="qmi2", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="bus/usb/*", OWNER="root", GROUP="usb", MODE="0660"\nACTION=="add", KERNEL=="mtp_usb", OWNER="root", GROUP="mtp", MODE="0660"\nACTION=="add", KERNEL=="usb_accessory", OWNER="root", GROUP="usb", MODE="0660"\nACTION=="add", KERNEL=="tun", OWNER="system", GROUP="vpn", MODE="0660"\nACTION=="add", KERNEL=="ts0710mux*", OWNER="radio", GROUP="radio", MODE="0640"\nACTION=="add", KERNEL=="ppp", OWNER="radio", GROUP="vpn", MODE="0660"\n'| sudo tee mnt/usr/lib/lxc-android-config/70-crespo.rules >/dev/null
	echo "[INFO] Do you want to remove the examples (video/photos/music) inserted into the image? (y/n) [EXPERIMENTAL]"
	read answer
	if [ "$answer" = "y" -o "$answer" = "Y" ]; then
		sudo rm -rf mnt/usr/share/demo-assets/
		sudo rm mnt/usr/share/dbus-1/services/com.canonical.Unity.Scope.MockMusic.service
		sudo rm mnt/usr/share/dbus-1/services/com.canonical.Unity.Scope.MockVideos.service
		debug "Example content removed!"
	else
		debug "Leaving example contents"
	fi
}

cleanup(){
debug "-> Cleaning..."
sleep 5
sync
sudo umount mnt/
rmdir mnt
rm saucy-preinstalled-touch-armhf.tar.gz
}

if [ -d ubuntu ]; then
error "There is an 'ubuntu' folder in this dir. If you want to recreate the image, please move it or delete it. Exiting."
exit
fi
if [ -e "saucy-preinstalled-touch-armhf.tar.gz" ]; then
debug "Found Ubuntu Touch zip"
debug "Do you want to remove it? (y/n)"
read ans
if [ "$ans" = "y" -o "$ans" = "Y" ]; then
rm "saucy-preinstalled-touch-armhf.tar.gz"
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
