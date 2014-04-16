#!/bin/bash
#
# (ↄ)2014 vanScheijen
#---------------------
# Simple and inefficient proof of work tool, using any hash/salt/proof.
#

hashbin=sha1sum
time_start=`date +%s`
salt="$1"
proof="${2-^00}"

if [[ -z $salt ]]; then
	echo "Usage: $0 <salt> [proof]"
	exit 1
fi

work=0
echo "Searching"
while true; do
   hash=`echo "${salt}${work}" | $hashbin`
   echo -n "."

   if [[ "$hash" =~ $proof ]]; then
		time_end=`date +%s`
		time_spent=$(($time_end - $time_start))
		echo "found!"
		echo "hashbin: $hashbin"
		echo "proof: $proof"
		echo "salt: $salt"
		echo "work: $work"
		echo "hash: $hash"
		echo "time spend: ${time_spent}s"
		echo "speed: $(($work / $time_spent)) hash/s"
		exit 0
   fi

   (( work++ ))
done

