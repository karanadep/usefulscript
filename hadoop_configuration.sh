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

#hadoop sh files
rsync -avz hadoopenvfiles/hadoop-env.sh root@${var1}:/etc/hadoop/conf/hadoop-env.sh
rsync -avz hadoopenvfiles/yarn-env.sh root@${var1}:/etc/hadoop/conf/yarn-env.sh

#creating required directories
ssh root@${var1} 'mkdir -p /data/1/dfs/{dn,nn}' < /dev/null
ssh root@${var1} 'mkdir -p /data/1/yarn/{local,logs}' < /dev/null
ssh root@${var1} 'chown -R hdfs:hdfs /data/1/dfs' < /dev/null
ssh root@${var1} 'chown -R yarn:yarn /data/1/yarn' < /dev/null

#xml files throughtout cluster
rsync -avz hadoopxmlfiles/core-site.xml root@${var1}:/etc/hadoop/conf/core-site.xml
rsync -avz hadoopxmlfiles/hdfs-site.xml root@${var1}:/etc/hadoop/conf/hdfs-site.xml
rsync -avz hadoopxmlfiles/mapred-site.xml root@${var1}:/etc/hadoop/conf/mapred-site.xml
rsync -avz hadoopxmlfiles/yarn-site.xml root@${var1}:/etc/hadoop/conf/yarn-site.xml

done
