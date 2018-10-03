FROM centos:7


#BASIC CONFIG

RUN yum -y update && yum clean all

RUN yum install -y rpm wget curl

RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

#Install MySQL

RUN wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

RUN yum localinstall -y mysql57-community-release-el7-8.noarch.rpm

RUN yum install -y mysql-community-server

#Install Nginx

RUN yum install -y nginx

RUN systemctl start nginx.service
RUN systemctl enable nginx.service


#Install JDK

RUN yum -y install java-1.8.0-openjdk*

#Install Tomcat

RUN yum -y install tomcat

RUN echo "JAVA_HOME=/usr/lib/jvm/java \
PATH=$PATH:$JAVA_HOME/bin \
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
CATALINA_BASE=/usr/share/tomcat \
CATALINA_HOME=/usr/share/tomcat \
export JAVA_HOME PATH CLASSPATH CATALINA_BASE CATALINA_HOME " >> ~/.bashrc 

RUN source .bashrc



CMD systemctl enable mysqld && systemctl daemon-reload && systemctl start tomcat.service && grep 'temporary password' /var/log/mysqld.log 
