osd_num=`ps aux | grep ceph | cut -d' ' -f28 | head -n 1`
ps aux | grep ceph
echo "osd_num = $osd_num"
systemctl stop ceph-osd@$osd_num
ps aux | grep ceph

sleep 3
umount /dev/xvdb1
fdisk /dev/xvdb

sleep 1
echo "rm keyrings.."
rm /var/lib/ceph/bootstrap-osd/ceph.keyring

echo "rm ceph-osds .."
rm -f /var/lib/ceph/osd/ceph-*

echo "rm /mnt/buddystore .."
rm -rf /mnt/buddystore

echo "create /mnt/buddystore .."
mkdir /mnt/buddystore
chown -R ceph:ceph /mnt/buddystore
