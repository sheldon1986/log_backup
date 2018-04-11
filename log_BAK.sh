#!/bin/sh
## Set day & Conf
#Daily_Log_Rotation=10
Daily_Backup_Rotation=2
DAY_AGO1=`date '+%Y-%m-%d' -d "1 day ago"`
DAY2_AGO1=`date '+%Y%m%d' -d "1 day ago"`
#RM_AGO=`date '+%Y-%m-%d' -d "$Daily_Log_Rotation day ago"`
#RM2_AGO=`date '+%Y%m%d' -d "$Daily_Log_Rotation day ago"`
TARGZ="Source_Full-`hostname`_`date '+%Y-%m-%d'`.tgz"
RM_BACKUP="Source_Full-`hostname`_`date '+%Y-%m-%d' -d "$Daily_Backup_Rotation day ago"`.tgz"
## Set Directories
BACKUP_LIST=/tmp/backup_list.txt
BACKUP_DIR=/applications/Backup
#TOMCAT_account_LOG="/weblogs/was/partner-account"
#TOMCAT_els_LOG="/weblogs/was/partner-els"
#TOMCAT_withnet_LOG="/weblogs/was/partner-withnet"
LOG="/var/log"
## Backup List
#echo "`ls $TOMCAT_account_LOG/*$DAY_AGO1* 2> /dev/null`" > $BACKUP_LIST
echo "`ls $LOG/*$DAY_AGO1* 2> /dev/null`" > $BACKUP_LIST
#echo "`ls $TOMCAT_account_LOG/*$DAY2_AGO1* 2> /dev/null`" >> $BACKUP_LIST
#echo "`ls $TOMCAT_els_LOG/*$DAY_AGO1* 2> /dev/null`" >> $BACKUP_LIST
#echo "`ls $TOMCAT_els_LOG/*$DAY2_AGO1.log 2> /dev/null`" >> $BACKUP_LIST
#echo "`ls $TOMCAT_withnet_LOG/*$DAY_AGO1* 2> /dev/null`" >> $BACKUP_LIST
#echo "`ls $TOMCAT_withnet_LOG/*$DAY2_AGO1* 2> /dev/null`" >> $BACKUP_LIST

## Check Backup Directory.
if [ ! -d $BACKUP_DIR ]; then
       mkdir -p $BACKUP_DIR
fi

## Backup
tar -cvpzf $BACKUP_DIR/$TARGZ `cat $BACKUP_LIST` &> /dev/null

## Remove Backup & log files
rm -f $BACKUP_DIR/$RM_BACKUP 2> /dev/null
