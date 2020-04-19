FROM uniwjj/centos-java:8

MAINTAINER ginger uniwjj@gmail.com


ARG HADOOP_VERSION=2.9.2
LABEL Description="Hadoop $HADOOP_VERSION"

RUN yum clean all && \
    rpm --rebuilddb &&  \
    yum install -y initscripts which tar openssh-server openssh-clients && \
    ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N "" && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 0400 /root/.ssh/authorized_keys && \
    /usr/sbin/sshd-keygen || : && \
    yum install -y curl && \
    curl -s https://mirror.bit.edu.cn/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | \
    tar -xz -C /usr/local && \
    cd /usr/local && \
    ln -s hadoop-$HADOOP_VERSION hadoop && \
    rm -rf hadoop/share/doc && \
    hadoop/bin/hdfs namenode -format && \
    # yum autoremove -y && \
    # yum install -y hostname && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY conf/core-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/yarn-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/mapred-site.xml /usr/local/hadoop/etc/hadoop/
COPY profile.d/hadoop.sh /etc/profile.d/
COPY hadoop-start.sh /root
COPY ssh/config /root/.ssh/config

RUN chmod 600 /root/.ssh/config && \
    chown root:root /root/.ssh/config

ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH

WORKDIR /root

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090
# MapReduce ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

CMD ["sh", "/root/hadoop-start.sh", "-d"]
