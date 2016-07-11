#!/bin/bash

DataVar="randomwrite"
HADOOP_HOME="/usr/local/hadoop2"
user="hduser2"
cp /home/hduser2/scripts/hdfs-site.xml_orig /home/hduser2/scripts/hdfs-site.xml
cp /home/hduser2/scripts/yarn-site.xml_orig  /home/hduser2/scripts/yarn-site.xml


for compress in true false #8 6 4 2 1
do

  for block in 32 64 # 128 256 512 1024
  do
	blocksize=$(($block * 1048576))

    for reducemem in 512 1024 #2048
    do

	for mapmem in 512 1024 #2048
	do

	  for mapvcore in 1 2 #3 4 
	  do

	    for redvcore in 1 2 #3 4
	    do

		for replication in 1 2 
		do
		  sed -e "/mapreduce.map.cpu.vcores/{n;s/.*/\<value\>$mapvcore\<\/value\>/}" -e "/mapreduce.reduce.cpu.vcores/{n;s/.*/\<value\>$redvcore\<\/value\>/}" -e "/mapreduce.map.memory.mb/{n;s/.*/\<value\>$mapmem\<\/value\>/}" -e "/mapreduce.reduce.memory.mb/{n;s/.*/\<value\>$reducemem\<\/value\>/}" -e "/mapreduce.map.output.compress/{n;s/.*/\<value\>$compress\<\/value\>/}" yarn-site.xml
		  sed -e "/dfs.replication/{n;s/.*/\<value\>$replication\<\/value\>/}" -e "/dfs.block.size/{n;s/.*/\<value\>$blocksize\<\/value\>/}"  hdfs-site.xml


		  for datavol in 5 10 #15 20
		  do
		     	inDataVol=$(($datavol * 1073741824))

			for jobname in randomwriter_sort
			do

				Job1=`echo $jobname |cut -d '_' -f 1`
				Job2=`echo $jobname |cut -d '_' -f 2`

				Job1logdir="/home/hduser2/job_log/"$Job1"_cmprs-"$compress"_block-"$block"MB_redmem-"$reducemem"_mapmem-"$mapmem"_mapvcore-"$mapvcore"_redvcore-"$redvcore"_repln-"$replication"_datavol-"$datavol"GB"
				Job2logdir="/home/hduser2/job_log/"$Job2"_cmprs-"$compress"_block-"$block"MB_redmem-"$reducemem"_mapmem-"$mapmem"_mapvcore-"$mapvcore"_redvcore-"$redvcore"_repln-"$replication"_datavol-"$datavol"GB"

				echo Job1logdir=$Job1logdir
				echo Job2logdir=$Job2logdir

#                               mkdir -p $Job1logdir
#                               chmod 775 $Job1logdir

#                               mkdir -p $Job2logdir 
#                               chmod 775 $Job2logdir
#				cat >> $Job1logdir/inputvariables.txt <<EOF

cat >> /home/hduser2/scripts/variables.txt << EOF
Compression-$compress
Block_size-$block MB
ReducerMemory-$reducemem MB
MapMemory-$mapmem MB
MapVCore-$mapvcore
ReducerVCore-$redvcore
Replication-$replication
InputDataVolume-$datavol GB
--------
EOF

#				cp -rf $Job1logdir/inputvariables.txt $Job2logdir/inputvariables.txt
#				$HADOOP_HOME/sbin/stop-all.sh
#				sleep 10

#### Different Slaves, un-comment this section and comment the following set of copying..
#### Un-comment Start ####
# 				for slaves in `cat /home/hduser2/scripts/node_list`
#				do

#				ssh $user@$slaves rm -rf "/app/hadoop2/tmp/*"
#				scp /home/$user/scripts/hdfs-site.xml $user@$slaves:$HADOOP_HOME/etc/hadoop/hdfs-site.xml
#				scp /home/$user/scripts/yarn-site.xml $user@$slaves:$HADOOP_HOME/etc/hadoop/yarn-site.xml
#				done
#### Un-comment End ###

#				rm -rf /app/hadoop2/tmp/*
#                               cp -rf /home/$user/scripts/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
#                               cp -rf /home/$user/scripts/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
 

#				$HADOOP_HOME/bin/hadoop namenode -format -force
#				rm -rf /usr/local/hadoop2_store/hdfs/datanode
#				sleep 15
#				$HADOOP_HOME/sbin/start-all.sh
#				sleep 1m

#				$HADOOP_HOME/bin/hadoop dfs -rmr /user/$user/out*
#				$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-*examples*.jar $Job1 -Dtest.$DataVar.total_bytes=$inDataVol /user/$user/output_RandomWriter
#                               sleep 1m
				today=`date +%F | sed 's|-|/|g'`
				part="done"
				filename=`hadoop fs -ls /mapred/history/$part/$today/000000/ | grep .jhist | awk {'print $8'}`
				echo filename=$filename
#				$HADOOP_HOME/bin/mapred job -history $filename > $Job1logdir/$Job1.hist.out

#				$HADOOP_HOME/bin/hadoop dfs -rmr /mapred/history/$part/2015
#                               $HADOOP_HOME/bin/hadoop dfs -rmr /mapred/history/$part_intermediate/$user

#				$HADOOP_HOME/bin/hadoop dfs -rmr /user/$user/Sort*
#				$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-*examples*.jar $Job2 /user/$user/output_RandomWriter /user/$user/Sort_output
#                               sleep 1m
				filename=`hadoop fs -ls /mapred/history/$part/$today/000000/ | grep .jhist | awk {'print $8'}`
#                                echo filename=$filename
#				$HADOOP_HOME/bin/mapred job -history $filename > $Job2logdir/$Job2.hist.out

			done
		  done
		done
	    done
	 done
	done
    done
  done
done
