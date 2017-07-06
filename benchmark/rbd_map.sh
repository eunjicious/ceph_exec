echo "ceph osd pool create rbdbench 100 100"
ceph osd pool create rbdbench 100 100
echo "rbd create image01 --size 1024 --pool rbdbench --image-feature layering"
rbd create image01 --size 1024 --pool rbdbench --image-feature layering
echo "rbd map image01 --pool rbdbench --name client.admin"
rbd map image01 --pool rbdbench --name client.admin

