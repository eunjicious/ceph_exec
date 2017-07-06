log=/var/log/ceph/ceph-osd.0.log


echo "ceph 4K4K ..."
../restart_with_log_reset.sh
./rados.sh write 4096 4096
sleep 1
cp $log ceph-4K4K.log
./rados_cleanup.sh

sleep 1
echo "ceph 4K4M ..."
../restart_with_log_reset.sh
./rados.sh write 4096 4194304
sleep 1
cp $log ceph-4K4M.log
./rados_cleanup.sh

sleep 1
echo "ceph 4M4M ..."
../restart_with_log_reset.sh
./rados.sh write 4194304 4194304
sleep 1
cp $log ceph-4M4M.log
./rados_cleanup.sh
