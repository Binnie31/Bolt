#! /bin/bash
# Requiresyum install jisql
# crontab:
# 0 12 * * 1-5  /root/monitor-refresh.sh > /dev/null 2>&1
ME=${0%.*}
# MAILLIST="PMXDevOps@bottomline.com"
MAILLIST="binamra.thapa@bottomline.com"
#MAILLIST="rliberti@bottomline.com"
SQLFILE="${ME}.sql"
OUTFILE="${ME}.out"
ERRFILE="${ME}.err"
DBUSER="apmo"
DBPASS="OBFUSCATED"
DBCONNSTR="jdbc:oracle:thin:@//pmx-td3-odb02.saas-p.com:1560/pmxtd3d2"
ENV="TD3"
echo "SELECT NAME FROM ALL_MVIEW_REFRESH_TIMES where trunc(LAST_REFRESH) < trunc(sysdate-2);" > ${SQLFILE}
#echo "SELECT NAME FROM ALL_MVIEW_REFRESH_TIMES where trunc(LAST_REFRESH) < trunc(sysdate);" > ${SQLFILE}
> ${OUTFILE}
> ${ERRFILE}
/usr/local/bin/jisql -user ${DBUSER} -password ${DBPASS} -cstring ${DBCONNSTR} -c ";" -noheader -input ${SQLFILE} > ${OUTFILE} 2> ${ERRFILE}
outlines=$(cat ${OUTFILE} | wc -l)
if [[ "${outlines}" != 0 ]]; then
  cat ${OUTFILE} | mailx  -s "${ME} on ${HOSTNAME} - Refresh Issue Encountered on ${ENV}" ${MAILLIST}
fi
errlines=$(cat ${ERRFILE} | wc -l)
if [[ "${errlines}" != 0 ]]; then
  cat ${ERRFILE} | mailx  -s "${ME} on ${HOSTNAME} - Configuration Error Encountered on ${ENV}" ${MAILLIST}
fi
exit 0