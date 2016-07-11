BEGIN{
        FS=","
        JobStartTime = 0.0;
        JobEndTime = 0.0;
        JobDate = "";
	JobId = "";
	Endhr = 0;
	Endmin = 0;
}
{
   if($1 != "iteration"){
	JobDate = substr($7,5,8);
   	#print "JobDate is " JobDate;
	JobDt = substr(JobDate,7,2)"/"substr(JobDate,5,2)"/"substr(JobDate,1,4)
	#print "modified Job Date is " JobDt ;
	JobStartTime = substr($7,13,4);
	Strthr = substr(JobStartTime,1,2);
	Strtmin = substr(JobStartTime,3,2);
	JobStrtTime = Strthr ":" Strtmin;
	#print "JobStart Time is " JobStartTime "that is " JobStrtTime;
	#print "Job response time is "$10;
	Endhr= Strthr;  
	Endmin = int (Strtmin + $10);
	if (Endmin >= 60){
		Endhr = Strthr + int(Endmin/60);
		Endmin = int(Endmin % 60);
	}
	if (Endhr >= 24){
		Endhr = int(Endhr % 24);
                if (Endhr == 0)
			Endhr="00";
	}
	if (Endmin < 10){
		JobEndTime = Endhr":0"Endmin":00"
	#	print "JobEndTime is " JobEndTime;
	}
	else{
		JobEndTime = Endhr":"Endmin":00"
	#	print "JobEndTime is " JobEndTime;
	}
	print $1 "," JobDt "," JobStrtTime "," JobEndTime "," $2 ","$3"," $4"," $5 ","$6"," $7"," $8 ","$9"," $10"," $11"," $12"," $13"," $14"," $15 ","$16;
   	}
	else
	    print $1 ",JobDt,JobStrtTime,JobEndTime," $2 ","$3"," $4"," $5 ","$6"," $7"," $8 ","$9"," $10"," $11"," $12"," $13"," $14"," $15 ","$16;
	
}
END{
         
}

