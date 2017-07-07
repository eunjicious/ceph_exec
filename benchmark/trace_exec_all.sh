
if [[ $# -lt 1 ]]; then
  echo "Usage: ./.sh ms"
  exit
fi

echo "./trace_exec.sh swift"
./trace_exec.sh swift $1
echo "./trace_exec.sh rados"
./trace_exec.sh rados $1
echo "./trace_exec.sh fio"
./trace_exec.sh fio $1
