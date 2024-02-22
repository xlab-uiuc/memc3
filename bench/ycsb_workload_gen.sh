#!/bin/bash
# Please change this according to your ycsb installation
# so that, ${YCSB_HOME}/bin/ycsb is the binary 

set -ex

YCSB_HOME=/home/jinghao/ycsb-0.17.0

for setting in kv1M_op1M_zipf.dat
do
    echo using predefined workloadb to create transaction records for $setting with 5% updates
    echo generateing $setting.load, the insertions used before benchmark
    ${YCSB_HOME}/bin/ycsb.sh load basic -P ${YCSB_HOME}/workloads/workloadb -P ./ycsb_workload_settings/$setting > $setting.load
    echo generateing $setting.run, the lookup queries used before benchmark
    ${YCSB_HOME}/bin/ycsb.sh run basic -P ${YCSB_HOME}/workloads/workloadb -P ./ycsb_workload_settings/$setting > $setting.run

    echo using predefined workloadc to create transaction records for $setting with reads only 
    echo generateing $setting.load, the insertions used before benchmark
    ${YCSB_HOME}/bin/ycsb.sh load basic -P ${YCSB_HOME}/workloads/workloadc -P ./ycsb_workload_settings/$setting > $setting.load
    echo generateing $setting.run, the lookup queries used before benchmark
    ${YCSB_HOME}/bin/ycsb.sh run basic -P ${YCSB_HOME}/workloads/workloadc -P ./ycsb_workload_settings/$setting > $setting.run
done
