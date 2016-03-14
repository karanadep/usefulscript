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

#appending ulimit to /etc/security/limits.conf
printf "hdfs  -       nofile  32768
hdfs  -       nproc   2048
hbase -       nofile  32768
hbase -       nproc   2048
" | ssh root@${var1} 'cat >> /etc/security/limits.conf'

echo "${var1}-${var2}"

done
