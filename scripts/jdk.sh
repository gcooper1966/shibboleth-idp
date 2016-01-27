yum -y install /tmp/jdk-8u72-linux-x64.rpm
cat <<EOK > /etc/profile.d/java.sh
#!/bin/bash
JAVA_HOME=/usr/java/jdk1.8.0_72
PATH=$JAVA_HOME/bin:$PATH
JRE_HOME=/usr/java/jdk1.8.0_72/jre
PATH=$JRE_HOME/bin:$PATH
export JAVA_HOME
export JRE_HOME
export PATH
EOK
