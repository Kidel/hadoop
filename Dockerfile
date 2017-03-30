#
#  Author: Gaetano Bonofiglio
#  Date: 03/2017
#
#  http://www.gaetanobonofiglio.com
#  https://www.linkedin.com/in/bonofiglio
#
#  https://github.com/Kidel/hadoop

FROM ubuntu:16.10
MAINTAINER Gaetano Bonofiglio (http://www.gaetanobonofiglio.com)

ARG HADOOP_VERSION=2.8.0
ARG TAR=hadoop-$HADOOP_VERSION.tar.gz
ARG SOURCE=http://it.apache.contactlab.it/hadoop/common/hadoop-$HADOOP_VERSION/$TAR

LABEL description="Hadoop"
LABEL version="$HADOOP_VERSION"

WORKDIR /

RUN \
    apt update -y && \
    apt install -y default-jdk

RUN \
    apt install -y openssh-server openssh-client wget tar hostname && \
    ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    cat /root/.ssh/authorized_keys

RUN \
    echo "downloading $SOURCE" && \
    echo "please wait..." && \
    wget -t 100 --retry-connrefused -O "$TAR" "$SOURCE" && \
    echo "downloaded, unpacking..." && \
    tar zxf "$TAR" && \
    echo "done." && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    rm -fv "$TAR"


COPY entrypoint.sh /
COPY hadoop-env.sh /usr/local/hadoop/etc/hadoop/
COPY conf/core-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/yarn-site.xml /usr/local/hadoop/etc/hadoop/
COPY conf/mapred-site.xml /usr/local/hadoop/etc/hadoop/

EXPOSE 50010 50020 50070 50075 50090 8020 9000 10020 19888 8030 8031 8032 8033 8040 8042 8088 49707 2122

#CMD "/entrypoint.sh"