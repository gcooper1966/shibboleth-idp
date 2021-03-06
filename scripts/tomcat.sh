wget -O /tmp/apache-tomcat-8.0.30.tar.gz http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz
groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
mkdir /opt/tomcat
tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
cp /tmp/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
cp /tmp/server.xml /opt/tomcat/conf/server.xml
chgrp -R tomcat /opt/tomcat/conf
chmod g+wrx /opt/tomcat/conf
chmod g+r /opt/tomcat/conf/*
chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
cp /tmp/tomcat.service /etc/systemd/system/tomcat.service
systemctl daemon-reload
systemctl enable tomcat
