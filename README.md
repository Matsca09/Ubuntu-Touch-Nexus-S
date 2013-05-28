This repo contains some scripts for my port of Ubuntu Touch on Nexus S.

Some descriptions:
	-> get-ubuntu-image.sh: Download the latest Ubuntu Touch daily image from the Ubuntu server, add screen configuration for the Nexus, and create a ~1,7GB image with the all system into it.
	INSTRUCTONS:
	REALLY IMPORTANT: Make sure you run the script with the Bash shell! (You can see what shell you're using by typing echo $SHELL)	
		1) Download the repo as zip or use git
		2) Unpack it (if you have downloaded the zip)
		3) Enter into the directory
		4) Type:
			chmod +x get-ubuntu-image.sh
		5) Type:
			./get-ubuntu-shell.sh
		6) At some point it'll ask if you want the demo contacts and message. Type in your decision and press enter. Wait until it finish.
		7) Copy the 'ubuntu' folder into the root of the Nexus S storage
		8) Flash the base system you can find on my topic on XDA: http://forum.xda-developers.com/showthread.php?t=2162735
	Everything done! Now Ubuntu Touch will run on your phone :D

Troubleshooting:
	If the script end with an error like:

		umount: <your directory>/mnt : device is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))

	Type "sudo umount mnt" (without quotes) BEFORE copying the 'ubuntu' folder.


Matsca09
