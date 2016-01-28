wget -O /tmp/shibboleth-identity-provider-3.2.1.tar.gz https://shibboleth.net/downloads/identity-provider/latest/shibboleth-identity-provider-3.2.1.tar.gz
mkdir /home/vagrant/shibboleth-idp3
tar -xf /tmp/shibboleth-identity-provider-3.2.1.tar.gz -C /home/vagrant/shibboleth-idp3 --strip-components=1
wget https://build.shibboleth.net/nexus/service/local/repositories/thirdparty/content/javax/servlet/jstl/1.2/jstl-1.2.jar
mkdir /opt/shibboleth-idp
cd /home/vagrant/shibboleth-idp3
./bin/install.sh -Didp.target.dir=/opt/shibboleth-idp -Didp.keystore.password=vagrant -Didp.sealer.password=vagrant
mv /tmp/idp.xml /opt/tomcat/conf/Catalina/localhost/idp.xml
mv jsttl1-1.2.jar /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/
cd /opt/shibboleth-idp
./bin/install.sh