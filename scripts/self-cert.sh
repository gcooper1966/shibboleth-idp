mv /tmp/self-cert-config.txt /home/vagrant
openssl req  -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout idp-ssl.key -out idp-ssl.crt -config self-cert-config.txt
mv idp-ssl.crt /etc/ssl/certs/idp-ssl.crt
mv idp-ssl.key /etc/ssl/certs/idp-ssl.key
cp /tmp/idp-host.conf /etc/httpd/conf.d/idp-host.conf
systemctl stop httpd
systemctl start httpd
