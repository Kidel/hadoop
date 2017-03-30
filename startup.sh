#!/usr/bin/env bash

export HADOOP_HOME=/hadoop
export PATH=$PATH:$HADOOP_HOME/bin

# starts the history server
/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver
jps