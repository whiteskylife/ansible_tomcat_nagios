#!/bin/bash
           
#snapshot file dir
dataDir=/data/zookeeper-3.4.6/bin/snapshot/version-2
#tran log dir
dataLogDir=/data/zookeeper-3.4.6/bin/snapshot/version-2
#zk log dir
#Leave 30 files
count=30
count=$[$count+1]
ls -t $dataLogDir/log.* | tail -n +$count | xargs rm -f
ls -t $dataDir/snapshot.* | tail -n +$count | xargs rm -f
