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
			ssh root@${var1} 'yum clean all; yum install -y hadoop-hdfs-namenode' < /dev/null
      			;;
        hdfs_secondary_namenode)
                        echo -e "${var1}hdfs_secondary_namenode\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-hdfs-secondarynamenode' < /dev/null
                        ;;
        resource_manager)
                        echo -e "${var1}resource_manager\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-yarn-resourcemanager' < /dev/null
			''
                        ;;
        mapreduce_history_server)
                        echo -e "${var1}mapreduce_history_server\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-mapreduce-historyserver' < /dev/null
                        ;;
        yarn_node_manager)
                        echo -e "${var1}yarn_node_manager\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-yarn-nodemanager' < /dev/null
                        ;;
        hdfs_datanode)
                        echo -e "${var1}hdfs_datanode\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-hdfs-datanode' < /dev/null
                        ;;
        mapreduce)
                        echo -e "${var1}mapreduce\n"
			ssh root@${var1} 'yum clean all; yum install -y hadoop-mapreduce' < /dev/null
                        ;;
        client)
                        echo -e "${var1}client\n"
			ssh root@${var1} 'sudo yum clean all; sudo yum install -y hadoop-client' < /dev/null
                        ;;
esac

done
