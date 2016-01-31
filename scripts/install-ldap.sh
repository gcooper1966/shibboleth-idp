yum -y install openldap-clients openldap-servers
systemctl start slapd
systemctl enable slapd
# run ldapadd to change the root password to vagrant
ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/chrootpw.ldif
# add common schemas used for storing people
# cosine schema is a dependency of most other schemas
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
# nis swchema is a network schema which is a dependency of inetorgperson
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
# inetorperson is the main schema for storing personal details
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
# eduPerson201310 is a schema used to identify attributes of people in education facilities
ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/eduPerson201310.ldif
# setup the default domain
ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/chdomain.ldif
# add the base organization unit
ldapadd -x -w vagrant -D cn=Manager,dc=lotj,dc=com,dc=au -f /tmp/base.ldif
# add the people organization unit
ldapmodify -H ldapi:/// -x -w vagrant -D cn=Manager,dc=lotj,dc=com,dc=au -f /tmp/people.ldif
# add some people to the directory
#ldapmodify -H ldapi:/// -x -w vagrant -D cn=Manager,dc=lotj,dc=com,dc=au -f /tmp/sample.ldif