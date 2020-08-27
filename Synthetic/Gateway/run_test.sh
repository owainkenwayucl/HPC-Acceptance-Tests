#!/bin/bash
SSH_CONFIG=${1:-./ssh_config}

if [ ! -f ./test_data ]
then
	echo "Generating 10G test file, this takes a long time ..."
	dd bs=1024 count=10485760 </dev/urandom > ./test_data
fi

for HOST in $(awk '/^Host .*.tunnel$/{print $2}' ./ssh_config)
do
	echo $HOST
	scp -F ${SSH_CONFIG} -i ./ccear86_id_rsa ./test_data $HOST:
        echo
done
