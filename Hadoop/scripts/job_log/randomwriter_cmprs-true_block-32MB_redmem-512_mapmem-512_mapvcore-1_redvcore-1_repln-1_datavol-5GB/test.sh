#!/bin/bash

#echo -n "Enter log file path: "
#read  log


awk 'BEGIN {} FNR == 5 {print "------"; print "JobName: "$2 } FNR ==8 {print "Date: "$3; print "StartTime: " $4} FNR ==9 {print "EndTime: " $4} FNR ==10 {print "Status: " $2}'  $1


#awk '/Task Summary/{y=1;next}y'  random.log | awk 'NR<8' | awk ' FNR ==5 {print "Total_Map " $2 } FNR ==5 {print "Sucessful_Map " $3}'

#awk '/Task Summary/{y=1;next}y'  $log | awk 'NR<8' | awk ' FNR ==5 {print "Total_Map: " $2; print "Sucessful_Map: " $3; print "Map_Failed: " $4; print "Map_Killed: " $5}  FNR ==6 {print "Total_Reduce: " $2; print "Sucessful_Reduce: " $3; print "Reduce_Failed: " $4; print "Reduce_Killed: " $5}'

awk '/Task Summary/{y=1;next}y'  $1  | awk 'NR<8' | awk ' FNR ==5 {print "Total_Map: " $2; print "Sucessful_Map: " $3; print "Map_Failed: " $4; print "Map_Killed: " $5; print "Map_StartTime: " $7; print "Map_FinishTime: " $9, $10 $11}  FNR ==6 {print "Total_Reduce: " $2; print "Sucessful_Reduce: " $3; print "Reduce_Failed: " $4; print "Reduce_Killed: " $5; print "Reduce_StartTime: " $7; print "Reduce_FinishTime: " $9, $10 $11}'
