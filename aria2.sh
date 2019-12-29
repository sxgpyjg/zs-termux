if [ -x "$(command -v aria2c)" ] ; then
	cd ~
	screen -dmS aria2 aria2c --enable-rpc --rpc-listen-all
	screen -dmS aria3 aria3c --enable-rpc --rpc-listen-all --conf-path=/data/data/com.termux/files/home/.config/aria2/aria3.conf
	screen -ls
	echo "aria2双开已完成，screen -r aria2即可查看，screen -r aria3查看另一个。"
else
	pkg install aria2 screen
	cd /data/data/com.termux/files/usr/bin
	cp aria2c aria3c
	cd ~
	mkdir .config
	cd .config
	mkdir aria2
	cd aria2
	echo "rpc-listen-port=6800" > aria2.conf
	echo "rpc-listen-port=6801" > aria3.conf
	cd ~
	screen -dmS aria2 aria2c --enable-rpc --rpc-listen-al
	screen -dmS aria3 aria3c --enable-rpc --rpc-listen-all --conf-path=/data/data/com.termux/files/home/.config/aria2/aria3.conf
	screen -ls
	echo "aria2双开已完成，screen -r aria2即可查看，screen -r aria3查看另一个。"
fi
exit
