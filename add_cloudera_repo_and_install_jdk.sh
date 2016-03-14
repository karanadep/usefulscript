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

#Add cloudera repository to yum
printf "
[cloudera-cdh5]
# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat or CentOS 6 x86_64
name=Cloudera's Distribution for Hadoop, Version 5
baseurl=http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/
gpgkey = http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera   
gpgcheck = 1
" | ssh root@${var1} 'cat >> /etc/yum.repos.d/cloudera.repo'


#install jdk
ssh root@${var1} 'wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.rpm -O jdk-7u45-linux-x64.rpm' < /dev/null
  
# update the installed java as the latest version using alternatives
#alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_45/bin/java 200000

ssh root@${var1} 'rpm -ivh jdk-7u45-linux-x64.rpm' < /dev/null

echo "${var1}-${var2}"

done
