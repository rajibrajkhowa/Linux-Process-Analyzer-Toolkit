#! /usr/bin/env bash

PROC_ID=$1

if [ -d "/proc/$PROC_ID" ]; then

   cat /proc/$PROC_ID/status > temp.txt

  PROC_STATE=$(grep "State:" temp.txt | awk '{print $2,$3}')

  NUM_THREADS=$(grep "Threads:" temp.txt | awk '{print $2}')

  VOLUNTARY_CTXT_SWITCHES=$(grep -w "voluntary_ctxt_switches:" temp.txt | awk '{print $2}')

  NONVOLUNTARY_CTXT_SWITCHES=$(grep -w "nonvoluntary_ctxt_switches:" temp.txt | awk '{print $2}')

  echo "############## Start of report ##############"

  echo

  echo "The PID $PROC_ID is in $PROC_STATE state"

  echo

  echo "The PID $PROC_ID has $NUM_THREADS threads"

  echo

  echo "The PID $PROC_ID has had $VOLUNTARY_CTXT_SWITCHES voluntary context switches"

  echo

  echo "The PID $PROC_ID has had $NONVOLUNTARY_CTXT_SWITCHES non-voluntary context switches"

  echo

  echo "############### End of report ###############"


else

  echo "The process ID $PROC_ID must have exited"

fi
