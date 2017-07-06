
if [[ $# -lt 1 ]]; then
  echo "Usage: ./sh bench store"
  echo "bench = [ swift rados fio ] [ fs ms bs bl ]"
  echo "./sh swift ms"
  exit
fi



CEPH_LOG=/var/log/ceph/ceph-osd.0.log
## restart 
systemctl stop ceph-osd@0.service
rm $CEPH_LOG
systemctl start ceph-osd@0
sleep 3
ps aux | grep ceph


bench=$1
trace_log="$1"_"$2".log


echo "EUNJI_TRACE $bench start" >> $CEPH_LOG


if [[ $bench == "swift" ]]; then
  echo "swift-bench -c 64 -s 4096 -n 1000 -g 100 swift.conf ..."
  swift-bench -c 64 -s 4096 -n 100 -g 100 swift.conf
fi 

if [[ $bench == "rados" ]]; then
  echo "rados_al.sh ..."
  ./rados_all.sh write 4096 4096
fi

if [[ $bench == "fio" ]]; then
  echo "./rbd_map.sh"
  ./rbd_map.sh
  echo "fio rbd.fio"
  fio rbd.fio 
fi

echo "EUNJI_TRACE $bench end" >> $CEPH_LOG
cp $CEPH_LOG $trace_log
cat $CEPH_LOG | grep EUNJI_TRACE
