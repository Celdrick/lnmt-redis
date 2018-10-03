FROM centos:7

#BASIC CONFIG
ENTRYPOINT /usr/sbin/init
RUN yum -y update && yum clean all
RUN yum install -y curl wget initscripts

#Oneinstack
RUN wget http://mirrors.linuxeye.com/oneinstack-full.tar.gz && tar xzf oneinstack-full.tar.gz && ./oneinstack/install.sh --nginx_option 1 --tomcat_option 2 --jdk_option 2 --db_option 2 --dbinstallmethod 1 --dbrootpwd abcabc --redis
