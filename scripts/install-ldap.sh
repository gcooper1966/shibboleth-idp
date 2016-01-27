yum -y install openldap openldap-clients openldap-servers
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG
systemctl start slapd
systemctl enable slapd
# create a password hash and store it in passphrase.txt
slappasswd -s vagrant > passphrase.txt
passwd=$(cat passphrase.txt)
# add the password hash to the ldif file for changing the root password
sed -i "s,olcRootPW:.*,olcRootPW: $passwd," /tmp/chrootpw.ldif
# run ldapadd to change the root password
ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/chrootpw.ldif
# add common schemas used for storing people
# cosine schema is a dependency of most other schemas
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
# nis swchema is a network schema which is a depemndency of inetorgperson
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
# inetorperson is the main schema for storing personal details
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
rm passphrase.txt
# recreate a password hash for the domain password and store it in passphrase.txt
slappasswd -s vagrant > passphrase.txt
passwd=$(cat passphrase.txt)
# set the password hash in the chdomain file that is used to set up the domain manager
sed -i "s,olcRootPW:.*,olcRootPW: $passwd," /tmp/chdomain.ldif
# setup the default domain across the config
ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/chdomain.ldif
# setup the base domain for the schema
ldapadd -x -D cn=Manager,dc=server,dc=world -w vagrant -f /tmp/basedomain.ldif
