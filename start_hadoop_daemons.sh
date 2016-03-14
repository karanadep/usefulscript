#! /bin/bash

##############################
#############################
# hdfs_namenode
# hdfs_secondary_namenode
# resource_manager
# mapreduce_history_server
# yarn_node_manager
# hdfs_datanode
# mapreduce
# client
###############################
###############################


cat hadoop_daemons_to_node_mapping.txt | while read LINE
do
	var1=$(echo $LINE | cut -f1 -d':')
	var2=$(echo $LINE | cut -f2 -d':')

#installs daemons on all nodes
case $var2 in
	hdfs_namenode)
			echo -e  "${var1}hdfs_namenode\n"
			ssh root@${var1} 'service hadoop-hdfs-namenode start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
      			;;
        hdfs_secondary_namenode)
                        echo -e "${var1}hdfs_secondary_namenode\n"
			ssh root@${var1} 'service hadoop-hdfs-secondarynamenode start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
                        ;;
        resource_manager)
                        echo -e "${var1}resource_manager\n"
			ssh root@${var1} 'service hadoop-yarn-resourcemanager start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
                        ;;
        mapreduce_history_server)
                        echo -e "${var1}mapreduce_history_server\n"
			ssh root@${var1} 'service hadoop-mapreduce-historyserver start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
                        ;;
        yarn_node_manager)
                        echo -e "${var1}yarn_node_manager\n"
			ssh root@${var1} 'service hadoop-yarn-nodemanager start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
                        ;;
        hdfs_datanode)
                        echo -e "${var1}hdfs_datanode\n"
			ssh root@${var1} 'service hadoop-hdfs-datanode start' < /dev/null
			ssh root@${var1} '/usr/java/jdk*/bin/jps' < /dev/null
                        ;;
        mapreduce)
                        echo -e "${var1}mapreduce\n"
                        ;;
        client)
                        echo -e "${var1}client\n"
                        ;;
esac

done
