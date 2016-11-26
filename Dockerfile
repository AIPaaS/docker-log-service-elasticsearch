FROM centos:7

#install jdk8
RUN yum install -y java-1.8.0-openjdk

#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone
  
RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN curl -LO https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.0.1.rpm
RUN sha1sum elasticsearch-5.0.1.rpm
RUN rpm -ivh elasticsearch-5.0.1.rpm
RUN rm -f elasticsearch-5.0.1.rpm
RUN yum clean all
RUN rm -f /var/log/yum.log

# plugins install
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin  install x-pack

# Copy configuration file  
#COPY .yml /etc/filebeat/

# Copy entrypoint script
COPY es_start.sh /
RUN chmod 777 es_start.sh


#ENTRYPOINT ["/fb_start.sh"]
CMD ["/es_start.sh"]