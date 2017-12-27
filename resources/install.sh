#!/bin/bash

## install dependencies
yum install -y vim gcc wget unzip net-tools python jq qrencode

## install nginx
tar xf nginx.tar.gz
cd nginx-*
./configure --without-http_rewrite_module --without-http_gzip_module --with-http_sub_module \
    && make \
    && make install
cd ..

## configure nginx
ip_addr=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)
sed -i "/sub_filter_types/a\\        sub_filter www.epochtimes.com $ip_addr;" nginx.conf
sed -i "/sub_filter_types/a\\        sub_filter i.epochtimes.com $ip_addr;" nginx.conf
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

