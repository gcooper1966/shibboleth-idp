wget -O /tmp/shibboleth-identity-provider-3.2.1.tar.gz https://shibboleth.net/downloads/identity-provider/latest/shibboleth-identity-provider-3.2.1.tar.gz
mkdir /home/vagrant/shibboleth-idp3
echo "Created shibboleth source directory"
tar -xf /tmp/shibboleth-identity-provider-3.2.1.tar.gz -C /home/vagrant/shibboleth-idp3 --strip-components=1
echo "Created installation sources"
echo "Replacing build.xml to allow unattended installation."
cp /tmp/build.xml /home/vagrant/shibboleth-idp3/bin/build.xml
wget -O /tmp/jstl-1.2.jar https://build.shibboleth.net/nexus/service/local/repositories/thirdparty/content/javax/servlet/jstl/1.2/jstl-1.2.jar
mkdir /opt/shibboleth-idp
chown -R vagrant. /home/vagrant/shibboleth-idp3
chown -R tomcat. /opt/shibboleth-idp
if [ -d /opt/shibboleth-idp ]
	then
		echo "Created shibboleth target directory at /opt/shibboleth-idp."
fi
/home/vagrant/shibboleth-idp3/bin/install.sh -Didp.property.file='/tmp/idpbuild.properties'
if [ -d /opt/shibboleth-idp/bin ]
	then
		echo "Installed shibboleth idp to /opt/shibboleth-idp"
	else
		exit 3
fi
if [ $? -eq 0 ]
	then
		echo "Added shibboleth-idp war location to Tomcat"
	else
		exit 4
fi
mv /tmp/jstl-1.2.jar /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/
if [ $? -eq 0 ]
	then
		echo "Adding JSP support to shibboleth-idp ..."
		/opt/shibboleth-idp/bin/build.sh
		if [ $? -eq 0 ]
			then
				echo "Included jsp support in shibboleth idp"
			else
				exit 3
		fi
	else
		exit 4
fi
find /opt/shibboleth-idp/conf -type f -exec chmod 644 {} +
echo "Updated shibboleth permissions"
cp /tmp/idp.xml /opt/tomcat/conf/Catalina/localhost/idp.xml
chown tomcat. /opt/tomcat/conf/Catalina/localhost/idp.xml
echo "...Successfully completed shibboleth installation!"
exit 0