#!/data/data/com.termux/files/usr/bin/bash


if [ -d "$PREFIX/bin/peerflix-server" ] ; then
	screen -dmS peerflix-server peerflix-server
	echo -e "\033[31m请用浏览器打开：http://localhost:5299\033[0m"

else
	echo "安装nodejs"
	pkg install nodejs -y
	echo "安装peerflix-server"
	npm install -g peerflix-server
	echo "使用推荐配置"	
	wget "https://raw.githubusercontent.com/zsxwz/zs-termux/master/config.json"
	mkdir .config/peerflix-server
	cp config.json ~/.config/peerflix-server/config.json
	screen -dmS peerflix-server peerflix-server
	echo -e "\033[31m请用浏览器打开：http://localhost:5299\033[0m"
	echo ""
fi
exit
