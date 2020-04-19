FROM centos:centos6.10

MAINTAINER ginger uniwjj@gmail.com

LABEL Description="Java + CentOS (OpenJDK)"

ARG JAVA_VERSION=8
ARG JAVA_RELEASE=JDK

RUN set -euxo pipefail && \
    pkg="java-1.$JAVA_VERSION.0-openjdk" && \
    if [ "$JAVA_RELEASE" = "JDK" ]; then \
        pkg="$pkg-devel"; \
    else \
        pkg="$pkg-headless"; \
    fi; \
    yum install -y "$pkg" && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY profile.d/java.sh /etc/profile.d/

ENV JAVA_HOME=/usr

CMD /bin/bash

