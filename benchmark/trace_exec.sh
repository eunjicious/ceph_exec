if [[ $# -lt 4 ]]; then
  echo "Usage: ./sh bench wsize osize objectstore"
  echo "bench = [ swift rados fio ] [4096] [4096] [ fs ms bs bl ]"
  echo "./sh swift ms"
  exit
fi



#### parse args 
bench=$1
size=$2
osize=$3
os=$4
trace_log="$bench"_"$size"_"$osize"_"$os".log
CEPH_LOG=/var/log/ceph/ceph-osd.0.log


######### init ##########
function init_ceph(){
  echo "init_ceph ..."
  systemctl stop ceph-osd@0.service
  rm $CEPH_LOG
  echo "restart ceph-osd ..."
  systemctl start ceph-osd@0
  echo "sleep 10 ..."
  sleep 10
  ps aux | grep ceph
}


######### swift ##########

function swift_exec(){
  echo "swift_exec ..."
  iosize=$1
  echo "swift-bench -c 64 -s 4096 -n 1000 -g 1000 swift.conf ..."
  swift-bench -c 64 -s $iosize -n 1000 -g 1000 swift.conf
}

######### rados ##########
function rados_exec(){
  echo "rados_exec ..."
  iosize=$1
  osize=$2
  ceph osd lspools
  ceph osd pool create scbench 100 100 

  # write 
  echo "rados bench -p scbench 10 write --no-cleanup -b $iosize -o $osize"
  rados bench -p scbench 10 write --no-cleanup -b $iosize -o $osize
  echo "rados -p scbench cleanup"
  rados -p scbench cleanup 
}

######### fio ##########
function fio_exec(){
  echo "fio_exec ..."
  iosize=$1
  osize=$2
  ceph osd pool create rbdbench 100 100

  if ! [ -b /dev/rbd0 ];then 
    rbd create image01 --size 1024 --pool rbdbench --image-feature layering
    rbd map image01 --pool rbdbench --name client.admin
  fi

  fio rbd.fio.$iosize 
}



init_ceph

######### start tracing #########
echo "EUNJI_TRACE $trage_log start" >> $CEPH_LOG

exec_func="$bench"_exec
echo "$exec_func $size $osize ..."
$exec_func $size $osize

echo "EUNJI_TRACE $trace_log end" >> $CEPH_LOG
cp $CEPH_LOG $trace_log
cat $CEPH_LOG | grep EUNJI_TRACE









