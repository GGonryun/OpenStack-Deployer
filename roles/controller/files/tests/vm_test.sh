## provider network:
source ~/admin.sh
openstack network create --share --external --provider-physical-network provider --provider-network-type flat provider
openstack subnet create --network provider --allocation-pool start=192.168.129.201,end=192.168.129.254 --dns-nameserver 8.8.8.8 --gateway 192.168.129.1 --subnet-range 192.168.129.0/24 provider
## self service network:
### create network
openstack network create selfservice
openstack subnet create --network selfservice --dns-nameserver 8.8.8.8 --gateway 172.16.2.1 --subnet-range 172.16.2.0/24 selfservice
### create router
openstack router create router
openstack router add subnet router selfservice
openstack router set router --external-gateway provider
### verify
ip netns
openstack port list --router router
ping -c 4 <router_ip>
## flavor:
openstack flavor create --id 0 --vcpus 1 --ram 64 --disk 1 m1.nano
## keys:
ssh-keygen -q -N ""
openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey
openstack keypair list
## rules:
openstack security group list
openstack security group rule create --proto icmp 62efe7b1-ef2f-4870-9974-e8db9122e966
openstack security group rule create --proto tcp --dst-port 22 62efe7b1-ef2f-4870-9974-e8db9122e966
openstack security group rule list
## get network data:
openstack flavor list
openstack image list
openstack network list
~/startup.sh
### create self service instances:
openstack server create --flavor m1.nano --image cirros --nic net-id=9399175a-13ef-4c0f-93fc-f5276bd39f95 --security-group 62efe7b1-ef2f-4870-9974-e8db9122e966 --key-name mykey ss-1
openstack server create --flavor m1.nano --image cirros --nic net-id=9399175a-13ef-4c0f-93fc-f5276bd39f95 --security-group 62efe7b1-ef2f-4870-9974-e8db9122e966 --key-name mykey ss-2
openstack server create --flavor m1.nano --image cirros --nic net-id=9399175a-13ef-4c0f-93fc-f5276bd39f95 --security-group 62efe7b1-ef2f-4870-9974-e8db9122e966 --key-name mykey ss-3
### verify:
openstack server list
# openstack console url show ss1