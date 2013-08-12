#!/bin/bash

ALL_DUBBO_LOG_DIR="/ROOT/logs/dubbo";
ALL_DUBBO_SERVICES=`ls -l ${ALL_DUBBO_LOG_DIR} | awk '{print $9}'`;

for DUBBO_SERVICE in ${ALL_DUBBO_SERVICES}
do
        echo "Dubbo service is: "${DUBBO_SERVICE};
        YEAR=`date +%Y`;
        DUBBO_LOG_DAYS=`ls -l ${ALL_DUBBO_LOG_DIR}/${DUBBO_SERVICE} | awk '{print $9}' | grep -v tar.gz | grep ${YEAR}`;
        for DUBBO_LOG_DAY in ${DUBBO_LOG_DAYS}
        do
                echo "Dubbo log is: "${DUBBO_LOG_DAY};
                cd ${ALL_DUBBO_LOG_DIR}/${DUBBO_SERVICE}/
                if [[ ! -e ${ALL_DUBBO_LOG_DIR}/${DUBBO_SERVICE}/${DUBBO_LOG_DAY}.tar.gz ]]
                then
                        tar -zcvf ${DUBBO_LOG_DAY}.tar.gz ${DUBBO_LOG_DAY}
                        rm -rf ${DUBBO_LOG_DAY}
                else
                        echo "${ALL_DUBBO_LOG_DIR}/${DUBBO_SERVICE}/${DUBBO_LOG_DAY}.tar.gz is exist!!!";
                        continue;
                fi
        done;
done;
