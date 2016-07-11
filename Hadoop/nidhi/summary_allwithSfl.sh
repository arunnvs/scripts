#!/bin/bash
homedir="/home/hduser/Downloads/infy_clusterfiles/B19Cluster/xslaves_logs/14May14_SflTm"
echo "start log processing"
for frqdirnm in `ls -l $homedir |egrep '^d'|awk '{print $9}'`
do
echo "freq dir name "$frqdirnm
freq=`echo $frqdirnm | sed -e "s/_/./g"`
echo "freq1 " $freq
freq=`echo $freq |  sed -e "s/GHz//g"`
echo "freq = "$freq 
fredirpth=$homedir"/"$frqdirnm
for jbdirnm in `ls -l $fredirpth/CHNG_MS |egrep '^d'|awk '{print $9}'`
do
echo "job dir name "$jbdirnm
sumfile=$homedir"/"$frqdirnm"_ChngMS_SflTm_"$jbdirnm
echo "summary file is "$sumfile
echo "iteration,freq,JobName,InputDataSize,MapSlots,ReduceSlots,JobId,JobStartTime,JobEndTime,JobResponseTime,AvgMapTime,AvgReduceTime,No_KilledMapTasks,No_KilledRedTasks,No_FailedMaps,NoFailedReduceTasks,ShuffleTime,SortTime,ReduceCalcTime">$sumfile
MSdirpth=$fredirpth"/CHNG_MS/"$jbdirnm
echo "slots dir path is "$MSdirpth
for slotdirnm in `ls -l $MSdirpth |egrep '^d'|awk '{print $9}'`
do
echo "slot dir name is "$slotdirnm
slots=`echo $slotdirnm | sed -e "s/MS//g" | sed -e "s/RS//g"`
echo $slots
Mapslots=`echo $slots | cut -d '_' -f 1`
Reduceslots=`echo $slots | cut -d '_' -f 2`
Inputdata=`echo $slots | cut -d '_' -f 3`
slotdirpth=$MSdirpth"/"$slotdirnm
let itr=0
for filenm in `ls $slotdirpth`
do
echo "processing "$filenm" file"
let "itr = itr + 1"
file=$slotdirpth"/"$filenm
echo "filename is "$file
sed -i "s/word count/wordcount/g" $file
tmp1=$homedir"/tmp1_"$filenm
tmp2=$homedir"/tmp2_"$filenm
echo "temp file getting created "$tmp1
cat $file | sed 's/=/ = /g' >$tmp1
cat $tmp1 | sed 's/"//g' >$tmp2
echo $itr","$freq","$jbdirnm","$Inputdata","$Mapslots","$Reduceslots","`awk -f scanSfl_HMR_log.awk $tmp2`>>$sumfile
rm $tmp1 $tmp2
echo "removed temp files"
done
done
done
done
