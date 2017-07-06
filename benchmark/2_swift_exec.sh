CEPH_LOG=/var/log/ceph/ceph-osd.0.log
## restart 
systemctl stop ceph-osd@0.service
rm $CEPH_LOG
systemctl start ceph-osd@0
sleep 3
ps | grep ceph
echo "EUNJI_TRACE swift-bench start" >> $CEPH_LOG
echo "swift-bench -c 64 -s 4096 -n 1000 -g 100 swift.conf ..."
swift-bench -c 64 -s 4096 -n 100 -g 100 swift.conf
echo "EUNJI_TRACE swift-bench end" >> $CEPH_LOG
cp $CEPH_LOG swift_trace.log
cat $CEPH_LOG | grep EUNJI_TRACE
