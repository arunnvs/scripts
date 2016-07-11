BEGIN{
        FS=" "
        JobStartTime = 0.0;
        JobEndTime = 0.0;
        MapKilledTasks = 0;
        MapFailedTasks = 0;
        RedKilledTasks = 0;
        RedFailedTasks = 0;
        JobFinishTime = 0
        MapTime[""] = 0.0;
	ReduceTime[""] = 0.0;
        JobcompletionTime = 0.0;
        TotalMapTime = 0.0;
	NumberofMaps = 0;
	AvgMapTime = 0.0;
        TotalRedTime = 0.0;
	NumberofReds = 0;
	AvgRedTime = 0.0;
	NumberofFailedMaps = 0;
	NumberofFailedReds = 0;
	JobId = "";
	ShuffleTime[""] = 0.0;
	SortTime[""] = 0.0;
	RedCalTime[""] = 0.0;
	TotalShuffleTime = 0.0;
	TotalSortTime = 0.0;
	TotalRedCalTime = 0.0;
	
}
{
   if($2 == "JOBID" && $11 == "SUBMIT_TIME"){
      #   print $14 " is Job start time";
	 JobStartTime = $13;
    }
   else if($5 == "TASK_TYPE" && $7 == "MAP" && $8 == "START_TIME"){
         MAPID = $4;
	 MapTime[MAPID] = $10;
	}
   else if($7 == "MAP" && $10 == "SUCCESS" && $11 == "FINISH_TIME"){
         MAPID = $4;
         MapTime[MAPID] = $13 - MapTime[MAPID];
	 TotalMapTime = TotalMapTime + MapTime[MAPID];
         NumberofMaps = NumberofMaps + 1;
	}
   else if($5 == "TASK_TYPE" && $7 == "REDUCE" && $8 == "START_TIME"){
         REDID = $4;
	 ReduceTime[REDID] = $10;
	 ShuffleTime[REDID] = $10;
	}
   else if($4 == "REDUCE" && $13 == "SUCCESS" && $14 == "SHUFFLE_FINISHED" ){
        REDID = $7;
	ShuffleTime[REDID] = $16 - ShuffleTime[REDID];
	SortTime[REDID] = $19 - $16;
	RedCalTime[REDID] = $22 - $19;
	TotalShuffleTime = TotalShuffleTime + ShuffleTime[REDID];
	TotalSortTime = TotalSortTime + SortTime[REDID];
	TotalRedCalTime = TotalRedCalTime + RedCalTime[REDID];
	}
   else if($7 == "REDUCE" && $10 == "SUCCESS" && $11 == "FINISH_TIME"){
         REDID = $4;
	 ReduceTime[REDID] = $13 - ReduceTime[REDID];
	 TotalRedTime = TotalRedTime + ReduceTime[REDID];
         NumberofReds = NumberofReds + 1;
	}
   else if($4 == "MAP" && $11 == "TASK_STATUS" && $13 == "KILLED"){
         MapKilledTasks = MapKilledTasks + 1;
	}
   else if($4 == "REDUCE" && $11 == "TASK_STATUS" && $13 == "KILLED"){
         RedKilledTasks = RedKilledTasks + 1;
	}
   else if($4 == "MAP" && $11 == "TASK_STATUS" && $13 == "FAILED"){
         MapFailedTasks = MapFailedTasks + 1;
	}
   else if($4 == "REDUCE" && $11 == "TASK_STATUS" && $13 == "FAILED"){
         RedFailedTasks = RedFailedTasks + 1;
	}
   else if($2 == "JOBID" && $5 == "FINISH_TIME" && $10 == "SUCCESS"){
         JobCompletionTime = $7 - JobStartTime;
	 JobEndTime = $7
	 NumberofFailedMaps = $19;
	 NumberofFailedReds = $22;
	# print $7 " is the job completion time";
	 JobId = $4;
	}
}
END{
        print JobId "," JobStartTime "," JobEndTime "," JobCompletionTime/60000 "," (TotalMapTime/NumberofMaps)/60000 "," (TotalRedTime/NumberofReds)/60000 "," MapKilledTasks "," RedKilledTasks "," MapFailedTasks "," RedFailedTasks "," (TotalShuffleTime/NumberofReds)/60000 "," (TotalSortTime/NumberofReds)/60000 "," (TotalRedCalTime/NumberofReds)/60000
}

