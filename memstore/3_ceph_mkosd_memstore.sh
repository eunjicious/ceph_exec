

if [[ $# -lt 1 ]]; then
	echo "Usage: .sh gdb0" 
	echo "Enter the osd node"
	exit
fi
osd=$1


ceph-deploy --overwrite-conf admin $osd
sudo chmod a+r /etc/ecph/ceph.client.admin.keyring

ceph-deploy osd prepare $osd:/mnt/memstore
ceph-deploy osd activate $osd:/mnt/memstore
sudo ceph -s
