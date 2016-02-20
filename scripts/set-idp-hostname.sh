hostnamectl set-hostname idp.lotj.com.au
#primaryip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.01')
gateway=$(ip route show | grep -Eo 'via ([0-9]*\.){3}[0-9]*')
if [ -z "$primaryip" || -z "$gateway" ]
	then
		echo "Unable to locate primary IP or gateway"
		exit 1
fi
sed -i "s/BOOTPROTO.*/BOOTPROTO=static/" /etc/sysconfig/network-scripts/ifcfg-enp0s3
echo "IPADDR=10.0.2.101" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
echo "GATEWAY=$gateway" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
echo "set static IP and gateway"