echo "ceph osd pool create cephfs_data 100 .."
ceph osd pool create cephfs_data 100
echo "ceph osd pool create cephfs_metadata 100 .."
ceph osd pool create cephfs_metadata 100
ceph osd lspools

echo "ceph fs new cephfs cephfs_metadata cephfs_data ..."
ceph fs new cephfs cephfs_metadata cephfs_data
ceph fs ls

ceph mds stat
