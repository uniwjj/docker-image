FROM uniwjj/hadoop:2.9.2

MAINTAINER ginger uniwjj@gmail.com


ARG HIVE_VERSION=2.3.7
LABEL Description="Hive $HIVE_VERSION, MySQL AS MetaStore"

RUN yum clean all && \
    rpm --rebuilddb &&  \
    yum install -y wget && \
    # install hive metastore
    yum install -y mysql-server mysql-connector-java && \
    echo -e '[mysqld]\nbind-address=0.0.0.0\n' > /etc/my.cnf && \
    service mysqld start && \
    mysql -e'GRANT ALL PRIVILEGES ON *.* TO hive@"%" IDENTIFIED BY "hive"; flush privileges;' && \
    mysql -e'GRANT ALL PRIVILEGES ON *.* TO hive@"localhost" IDENTIFIED BY "hive"; flush privileges;' && \
    # install hive
    curl -s https://mirror.bit.edu.cn/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz | \
    tar -xz -C /usr/local/ && \
    cd /usr/local && \
    mv apache-hive-$HIVE_VERSION-bin hive-$HIVE_VERSION && \
    ln -s hive-$HIVE_VERSION hive && \
    mv hive/conf/hive-log4j2.properties.template hive-log4j2.properties && \
    ln -s /usr/share/java/mysql-connector-java.jar hive/lib && \
    # clear
    # yum autoremove -y && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY hive-site.xml /usr/local/hive/conf
COPY hive-start.sh /root/hive-start.sh

RUN service mysqld start && \
    /usr/local/hive/bin/schematool -dbType mysql -initSchema -verbose

ENV HIVE_HOME /usr/local/hive
ENV PATH $HIVE_HOME/bin:$PATH

# MySQL ports
EXPOSE 3306 

# Hive ports
EXPOSE 9083 10000 10002

CMD ["sh", "/root/hive-start.sh", "-d"]

