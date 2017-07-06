
if [[ $# -lt 1 ]]; then
	echo "Usage: .sh gdb3" 
	echo "Enter the monitor node"
	exit
fi
mon=$1
echo "ceph-deploy purge $mon"
ceph-deploy purge $mon
echo "ceph-deploy purgedata $mon"
ceph-deploy purgedata $mon
echo "ceph-deploy forgetkeys"
ceph-deploy forgetkeys 
