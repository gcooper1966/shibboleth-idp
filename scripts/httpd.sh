yum -y install httpd
yum -y install mod_ssl
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
cp /tmp/proxy.conf /etc/httpd/conf.d/
systemctl daemon-reload
systemctl enable httpd
