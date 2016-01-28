# shibboleth-idp
Vagrant/Packer/VirtualBox setup of shibboleth-idp on Centos7
Creates a VirtualBox backed vagrant VM with apache httpd, tomcat 8, java jdk, shibboleth idp, and openldap installed and configured.

== Steps: ==
* Download jdk8 from www.oracle.com/technetwork/java/javase/downloads/ separately to agree to the license and update the *.rpm referenced in scripts/jkd.sh
* Set packer debugging by setting environment variables at prompt:
** set PACKER_LOG=1 (on Windows)
** set PACKER_LOG_PATH=packerlog.txt (on Windows)

Currently a work in progress with openldap to be completed.
