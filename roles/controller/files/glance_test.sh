cirros_pkg='cirros-0.4.0-x86_64-disk.img'

source ~/admin.sh 

rm -f cirros-0.4.0-x86_64-disk.img*
wget http://download.cirros-cloud.net/0.4.0/$cirros_pkg
glance image-create --name "cirros" --file $cirros_pkg --disk-format qcow2 --container-format bare --visibility public
glance image-list