#!/bin/bash

HOSTS="node1 node2 node3"
RETENTION_TIME=14

echo "$(date) - Log Cleaner - $RETENTION_TIME days - $HOSTS" >> /var/log/hadoop_log_cleaner.log

for host in $HOSTS
do
    ssh root@$host << ENDSSH

find /var/log/ambari-server \( -name "ambari-server.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/ambari-agent \( -name "ambari-agent.log.*" -o -name "ambari-alerts.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/ambari-metrics-collector \( -name "hbase-root-master-*.out.*" -o -name "hbase-ams-zookeeper-*.out.*" -o -name "hbase-ams-regionserver-*.log.*" -o -name "hbase-ams-regionserver-*.out.*" -o -name "hbase-ams-master-*.log.*" -o -name "hbase-ams-master-*.out.*" -o -name "ambari-metrics-collector.log.*" -o -name "gc.log-*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hadoop/hdfs \( -name "hadoop-hdfs-namenode-*.log.*" -o -name "hadoop-hdfs-namenode-*.out.*" -o -name "hadoop-hdfs-journalnode-*.out.*" -o -name "SecurityAuth.audit.*" -o -name "hadoop-hdfs-zkfc-*.out.*" -o -name "hadoop-hdfs-zkfc-*.log.*" -o -name "gc.log-*" -o -name "hdfs-audit.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hadoop-mapreduce/mapred \( -name "mapred-mapred-historyserver-*.out.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hadoop-yarn/yarn \( -name "yarn-yarn-resourcemanager-*.out.*" -o -name "yarn-yarn-timelineserver-*.out.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hive \( -name "hiveserver2.log.*" -o -name "hivemetastore.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/oozie \( -name "oozie-ops.log.*" -o -name "oozie.log.*" -o -name "oozie-jpa.log.*" -o -name "oozie-instrumentation.log.*" -o -name "oozie-audit.log.*" -o -name "manager.*.log" -o -name "localhost.*.log" -o -name "host-manager.*.log" -o -name "catalina.*.log" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/falcon \( -name "falcon.out.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/kafka \( -name "server.log.*" -o -name "state-change.log.*" -o -name "controller.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/knox \( -name "gateway.log.*" -o -name "gateway-audit.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/ranger/admin \( -name "xa_portal.log.*" -o -name "ranger_db_patch.log.*" -o -name "access_log.*.log" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/ranger/usersync \( -name "usersync.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/spark \( -name "spark-spark-org.apache.spark.deploy.history.HistoryServer-1-*.out.*" -o -name "spark-spark-org.apache.spark.sql.hive.thriftserver.HiveThriftServer2-1-*.out.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/atlas \( -name "metadata.*.err" -o -name "metadata.*.out" -o -name "audit.log.*" -o -name "application.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hst \( -name "hst-server.log.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm
find /var/log/hbase \( -name "gc.log-.*" \) -mtime +$RETENTION_TIME -type f 2> /dev/null | xargs --no-run-if-empty rm


ENDSSH
done
