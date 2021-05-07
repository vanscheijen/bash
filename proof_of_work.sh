#!/bin/bash
## Bash Proof of Work
## ©2012-2021 vanScheijen
## Usage of the works is permitted provided that this instrument is retained with the works, so that any entity that uses the works is notified of this instrument.
## DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.
## ----
## Simple and *inefficient* proof of work implementation in bash. Uses any hash binary, salt, or proof.
## https://en.wikipedia.org/wiki/Proof_of_work

#hashbin=md5sum
#hashbin=sha1sum
hashbin=sha256sum

salt="$1"
proof="${2:-^00}"

if [[ -z $salt ]]; then
    echo "Usage: $0 <salt> [proof]"
    exit 1
fi

work=0
echo "Searching"
time_start=`date +%s`
while :; do
    hash=`echo -n "${salt}${work}" | $hashbin`
    echo -n "."

    if [[ "$hash" =~ $proof ]]; then
        time_end=`date +%s`
        time_spent=$((time_end - time_start))
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

