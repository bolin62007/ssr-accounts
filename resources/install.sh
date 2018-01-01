#!/bin/bash

## install dependencies
yum install -y vim gcc gcc-c++ wget unzip net-tools openssl-devel python jq qrencode
tar xzf rarlinux*; (cd rar; make)

## install nginx
./install-nginx.sh


## configure nginx
jquery_path=/usr/local/nginx/html/ajax/libs/jquery/1.11.3
mkdir -p $jquery_path
cp jquery.min.js $jquery_path

ip_addr=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)
sed -i "/#epochtimes#/a\\\\t\\t\\tsub_filter www.epochtimes.com $ip_addr;" nginx.conf
sed -i "/#epochtimes#/a\\\\t\\t\\tsub_filter i.epochtimes.com $ip_addr;" nginx.conf
sed -i "/#epochtimes#/a\\\\t\\t\\tsub_filter https://ajax.googleapis.com http://$ip_addr;" nginx.conf
sed -i "/#falundafa#/a\\\\t\\t\\tsub_filter www.falundafa.org $ip_addr:8000;" nginx.conf
sed -i "/#falundafa#/a\\\\t\\t\\tsub_filter www.minghui.org $ip_addr:8080;" nginx.conf
sed -i "/#minghui#/a\\\\t\\t\\tsub_filter www.minghui.org $ip_addr:8080;" nginx.conf
sed -i "/#minghui#/a\\\\t\\t\\tsub_filter stats.minghui.org $ip_addr:8080;" nginx.conf
sed -i "/#minghui#/a\\\\t\\t\\tsub_filter gb.falundafa.org $ip_addr:8000;" nginx.conf
sed -i "/#google#/a\\\\t\\t\\tsub_filter https://www.google.com http://$ip_addr:8888;" nginx.conf
sed -i "/#google#/a\\\\t\\t\\tsub_filter https://id.google.com http://$ip_addr:8888;" nginx.conf
mv nginx.conf /usr/local/nginx/conf/nginx.conf
mv nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chkconfig nginx on
service nginx start

## set links
page_path=/usr/local/nginx/html/info
mkdir -p $page_path
sed "s/localhost/$ip_addr/g" link.html > $page_path/ss.html
sed -i "s/type/ss/" $page_path/ss.html

sed "s/localhost/$ip_addr/g" link.html > $page_path/ssr.html
sed -i "s/type/ssr/" $page_path/ssr.html

jquery_path=/usr/local/nginx/html/ajax/libs/jquery/1.11.3
mkdir -p $jquery_path
mv jquery.min.js $jquery_path

## install ssr & bbr
unzip shadowsocksr.zip
mv shadowsocksr /usr/local/shadowsocksr
chmod +x ssr.sh && bash ssr.sh
chmod +x bbr.sh && bash bbr.sh

## enable ssr service
mv ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start

## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off


