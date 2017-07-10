
if [[ $# -lt 1 ]]; then
  echo "Usage: ./.sh object_store"
  exit
fi

bench="swift rados fio"
for b in $bench; do
  echo "$b 4096 4096"
  ./trace_exec.sh $b 4096 4096 $1
  if [[ $b == "rados" ]]; then
    echo "$b 4096 1048576"
    ./trace_exec.sh $b 4096 1048576 $1
  fi
  echo "$b 1048576 1048576"
  ./trace_exec.sh $b 1048576 1048576 $1
done


#
#echo "././trace_exec.sh swift"
#./trace_exec.sh swift $1
#echo "./trace_exec.sh rados"
#./trace_exec.sh rados $1
#echo "./trace_exec.sh fio"
#./trace_exec.sh fio $1
