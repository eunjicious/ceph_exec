
if [[ $# -lt 2 ]]; then
	echo "Usage: put.sh filename node"
	echo "e.g.: put.sh admin.secret gdb1"
	exit
fi


file=$1
node=$2

scp -i aws-keypair.pem $file ubuntu@$node:/home/ubuntu/ceph_exec/benchmark
