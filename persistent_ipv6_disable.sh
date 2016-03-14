#! /bin/bash

cat myips.txt | while read LINE
do
	var1=$(echo $LINE | cut -f1 -d':')
	var2=$(echo $LINE | cut -f2 -d':')

#adding exception of default node
        var3=$(echo $LINE | cut -f3 -d':')
        if [ "$var3" == "default" ] ; then
                continue
        fi

#setting static IP
printf "
#persistent disable IP v6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
" $var2 | ssh root@${var1} 'cat >> /etc/sysctl.conf'

echo "${var1}-${var2}"

done

