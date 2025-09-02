#! /usr/bin/env bash

PROC_ID=$1

if [ -d "/proc/$1" ]; then

	cat /proc/$PROC_ID/schedstat > temp.txt

	PROC_CPU_TIME=$(awk '{print $1}' temp.txt)

	PROC_WAIT_TIME=$(awk '{print $2}' temp.txt)

	PROC_LATENCY=$(echo "$PROC_CPU_TIME + $PROC_WAIT_TIME" | bc)

	echo "############## Start of report ##############"

	echo

	echo "Total on-CPU time for PID $PROC_ID is $PROC_CPU_TIME nanoseconds"

	echo

	echo "Total wait time in run queue for PID $PROC_ID is $PROC_WAIT_TIME nanoseconds"

	echo

	echo "The total process latency for PID $PROC_ID is $PROC_LATENCY nanoseconds"

	echo

	if [ $PROC_CPU_TIME -gt $PROC_WAIT_TIME ]; then

		echo "The PID $PROC_ID spent most of the time on CPU"

	else
		echo "The PID $PROC_ID spent most of the time waiting in run queue"
	fi
	
	echo

	echo "############### End of report ###############"

else

  echo "The process ID $PROC_ID must have exited"

fi
