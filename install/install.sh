#!/bin/bash

function set_firewall()
{
	echo "------------set_firewall------------"
	systemctl start firewalld
	systemctl enable firewalld
	firewall-cmd --list-ports
	firewall-cmd --add-port=666/tcp --permanent
	firewall-cmd --add-port=888/tcp --permanent
	firewall-cmd --reload
}

function pre_data()
{
	echo "------------pre_data------------"
	\cp -rf tool/nginx-1.15.1.tar.gz /home/nginx-1.15.1.tar.gz
	\cp -rf tool/nginx-http-flv-module.tar.gz /home/nginx-http-flv-module.tar.gz
	\cp -rf tool/nginx.conf /home/nginx.conf
	\cp -rf tool/index.html /home/index.html
	\cp -rf tool/nginx.service /home/nginx.service
}

function install_module()
{
	echo "--------------nginx-http-flv-module begin---------------"
	yum install -y gcc gcc-c++
	yum install -y pcre pcre-devel
	yum install -y zlib zlib-devel
	yum install -y openssl openssl-devel
	cd /home
	mkdir video
	chmod 777 video
	tar -zxvf nginx-1.15.1.tar.gz
	tar -zxvf nginx-http-flv-module.tar.gz
	cd nginx-1.15.1
	./configure --prefix=/usr/local/nginx  --add-module=../nginx-http-flv-module  --with-http_ssl_module
	make & make install
	\cp -rf /home/nginx.conf /usr/local/nginx/conf/nginx.conf
	
	echo "---------add systemd---------"
	\cp -rf /home/nginx.service /usr/lib/systemd/system/nginx.service
	cd /usr/lib/systemd/system/
	chmod 754 nginx.service
	systemctl daemon-reload
	systemctl enable nginx.service
	systemctl start nginx.service
	echo "--------------nginx-http-flv-module finish---------------"
}

function main()
{
echo "----------------------------------------------------"
echo "----------------------start-------------------------"
echo "----------------------------------------------------"
set_firewall
pre_data
install_module
echo "----------------------------------------------------"
echo "--------------------completed-----------------------"
echo "----------------------------------------------------"
}

main

##----- mian ---必须su账户下执行sh--------