#! /bin/bash

#editing hosts file
hostsfile="127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n"
hostsfile="${hostsfile}::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n"

cat myips.txt | while read LINE
do
	var1=$(echo $LINE | cut -f1 -d':')
	var2=$(echo $LINE | cut -f2 -d':')

#adding exception of default node
        var3=$(echo $LINE | cut -f3 -d':')
        if [ "$var3" == "default" ] ; then
                continue
        fi

#setting hostname
ssh root@${var1} 'hostname ${var2}.localdomain' < /dev/null

#setting static IP
printf "NETWORKING=yes
#HOSTNAME=localhost.localdomain
HOSTNAME=%s.localdomain
GATEWAY=172.17.0.1
" $var2 | ssh root@${var1} 'cat > /etc/sysconfig/network'


#setting static IP
printf "DEVICE="eth0"
#BOOTPROTO="dhcp"
BOOTPROTO=static
IPV6INIT="yes"
MTU="1500"
NM_CONTROLLED="yes"
ONBOOT="yes"
IPADDR=%s
TYPE="Ethernet"
NETMAST=255.255.240.0
NAME='static eth0'
GATEWAY="172.17.0.1"
" $var1 | ssh root@${var1} 'cat > /etc/sysconfig/network-scripts/ifcfg-eth0';


cat myips.txt |
{
while read LINE
do
        var4=$(echo $LINE | cut -f1 -d':')
        var5=$(echo $LINE | cut -f2 -d':')
       hostsfile="${hostsfile}${var4}\t${var5}.localdomain\n"
done
echo -e "$hostsfile" | ssh root@${var1} 'cat > /etc/hosts'
}

#ssh root@${var1} '/sbin/reboot' < /dev/null

echo "${var1}-${var2}"
done
