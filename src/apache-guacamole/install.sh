#! /usr/bin/env bash

echo "installing required dependencies"
sudo apt -y install libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev ffmpeg libpango1.0-dev libwebp-dev libvorbis-dev libssl-dev libvncserver-dev libssh2-1-dev libwebsockets-dev

echo downloading apache guacamole server
wget https://apache.org/dyn/closer.lua/guacamole/1.5.5/source/guacamole-server-1.5.5.tar.gz?action=download
mv guacamole-server-1.5.5.tar.gz?action=download gs.tar.gz
tar -xcf gs.tar.gz
cd gs
./configure --with-init-dir=/etc/init.d
make
make install
ldconfig

wget https://apache.org/dyn/closer.lua/guacamole/1.5.5/binary/guacamole-1.5.5.war?action=download
mv guacamole-1.5.5.war?action=download guacamole.war
cp guacamole.war ~/.sdkman/candidates/tomcat/11.0.5/webapps
chmod +x ~/.sdkman/candidates/tomcat/11.0.5/bin/*
catalina.sh restart
/etc/init.d/guacd start

sudo touch /usr/local/share/initGuac.sh
cat << EOM >/usr/local/share/initGuac.sh
echo 'Start Tomcat and Guacamole'
catalina.sh start
/etc/init.d/guacd start
EOM
