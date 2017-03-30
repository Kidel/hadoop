#
#  Author: Gaetano Bonofiglio
#  Date: 03/2017
#  Thanks to Hari Sekhon for the centOS image and the starting point
#
#  http://www.gaetanobonofiglio.com
#  https://www.linkedin.com/in/bonofiglio
#
#  https://github.com/Kidel/hadoop

FROM harisekhon/centos-github:latest
MAINTAINER Gaetano Bonofiglio (http://www.gaetanobonofiglio.com)

ARG HADOOP_VERSION=2.8.0
ARG TAR=hadoop-$HADOOP_VERSION.tar.gz
ARG SOURCE=http://it.apache.contactlab.it/hadoop/common/hadoop-$HADOOP_VERSION/$TAR

LABEL description="Hadoop"
LABEL version="$HADOOP_VERSION"

WORKDIR /

RUN \
    yum install -y openssh-server openssh-client wget tar hostname && \
    echo "downloading $SOURCE" && \
    echo "please wait..." && \
    wget -t 100 --retry-connrefused -O "$TAR" "$SOURCE" && \
    echo "downloaded, unpacking..." && \
    tar zxf "$TAR" && \
    echo "done." && \
    ln -sv hadoop-$HADOOP_VERSION hadoop && \
    rm -fv "$TAR" && \
    /hadoop/bin/hdfs namenode -format && \
    yum autoremove -y && \
    yum clean all

COPY cmd.sh /
COPY startup.sh /
COPY conf/core-site.xml /hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /hadoop/etc/hadoop/
COPY conf/yarn-site.xml /hadoop/etc/hadoop/
COPY conf/mapred-site.xml /hadoop/etc/hadoop/
COPY profile.d/hadoop.sh /etc/profile.d/

EXPOSE 50010 50020 50070 50075 50090 8020 9000 10020 19888 8030 8031 8032 8033 8040 8042 8088 49707 2122

CMD "/cmd.sh"