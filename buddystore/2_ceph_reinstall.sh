if [[ $# -lt 1 ]]; then
	echo "Usage: .sh gdb3" 
	echo "Enter the monitor node"
	exit
fi
mon=$1

sudo apt-get install ceph
ceph-deploy new $mon
cat ceph.conf.buddystore >> ceph.conf
cat ceph.conf

ceph-deploy --overwrite-conf mon create-initial
ps aux | grep ceph
ceph-deploy admin $mon
