FROM sequenceiq/hadoop-docker:2.7.1

MAINTAINER ginger uniwjj@gmail.com

# Hadoop环境变量
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH

# MySQL for Hive metastore
RUN yum install -y mysql-server mysql-connector-java
RUN echo -e '[mysqld]\nbind-address=0.0.0.0\n' > /etc/my.cnf && \
    service mysqld start && \
    mysql -e'GRANT ALL PRIVILEGES ON *.* TO hive@"%" IDENTIFIED BY "hive"; flush privileges;' && \
    mysql -e'GRANT ALL PRIVILEGES ON *.* TO hive@"localhost" IDENTIFIED BY "hive"; flush privileges;'

# Hive安装
ARG HIVE_VERSION=2.3.6
RUN curl -s https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz | \
    tar -xz -C /usr/local/ && \
    cd /usr/local && \
    mv apache-hive-$HIVE_VERSION-bin hive-$HIVE_VERSION && \
    ln -s hive-$HIVE_VERSION hive && \
    mv hive/conf/hive-log4j2.properties.template hive-log4j2.properties

ENV HIVE_HOME /usr/local/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HIVE_CONF_DIR $HIVE_HOME/conf

COPY hive-site.xml $HIVE_CONF_DIR

RUN ln -s /usr/share/java/mysql-connector-java.jar $HIVE_HOME/lib
RUN service mysqld start && \
    schematool -dbType mysql -initSchema -verbose
COPY hive-start.sh /etc/hive-start.sh

# MySQL ports
EXPOSE 3306 

# Hive ports
EXPOSE 9083 10000 10002

CMD ["sh", "/etc/hive-start.sh", "-d"]

