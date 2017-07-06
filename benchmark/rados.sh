if [[ $# -lt 3 ]]; then
	echo "Usage: ./this.sh write 4096 4194304"
	echo "workload write_size obj_size"
	exit
fi

workload=$1
write_size=$2
obj_size=$3


ceph osd lspools
ceph osd pool create scbench 100 100 
echo 

if [[ $workload == "write" ]]; then
	echo "rados bench -p scbench 10 write --no-cleanup -b $write_size -o $obj_size"
	rados bench -p scbench 10 write --no-cleanup -b $write_size -o $obj_size
fi
#echo "rados bench -p scbench 10 seq"
#rados bench -p scbench 10 seq
#echo "rados bench -p scbench 10 rand"
#rados bench -p scbench 10 rand 
#
#echo "cleanup ..." 
#rados -p scbench cleanup

