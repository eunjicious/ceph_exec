

if [[ $# -lt 1 ]]; then
	echo "Usage: .sh gdb0" 
	echo "Enter the osd node"
	exit
fi
osd=$1


echo "ceph-deploy --overwrite-conf osd create --zap-disk gdb0:/dev/xvdb"
ceph-deploy --overwrite-conf osd create --zap-disk $osd:/dev/xvdb

ceph-deploy admin $osd gdb3
sudo ceph -s
