groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
mkdir /opt/tomcat
tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
cp /tmp/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
chgrp -R tomcat /opt/tomcat/conf
chmod g+wrx /opt/tomcat/conf
chmod g+r /opt/tomcat/conf/*
chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
cp /tmp/tomcat.service /etc/systemd/system/tomcat.service
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat
