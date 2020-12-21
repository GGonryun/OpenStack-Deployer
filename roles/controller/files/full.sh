testpassword='password1234'
testusername='testusername'
testproject='myproject'
testrole='myrole'
cirros_pkg='cirros-0.4.0-x86_64-disk.img'

source ~/admin.sh 

openstack domain create --description "An Example Domain" example
openstack project create --domain default --description "Demo Project" $testproject
openstack user create --domain default --password $testpassword $testusername
openstack role create $testrole
openstack role add --project $testproject --user $testusername $testrole

unset OS_AUTH_URL OS_PASSWORD
openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name $testproject --os-username $testusername --os-password $testpassword token issue

source ~/admin.sh 

rm -f $cirros_pkg*
wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
glance image-create --name "cirros" --file cirros-0.4.0-x86_64-disk.img --disk-format qcow2 --container-format bare --visibility public
glance image-list

placement-status upgrade check
# curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
# python get-pip.py
# pip install osc-placement
# openstack --os-placement-api-version 1.2 resource class list --sort-column name
# openstack --os-placement-api-version 1.6 trait list --sort-column name


openstack compute service list
openstack catalog list
nova-status upgrade check

openstack extension list --network
openstack network agent list

curl -I -L -X get http://192.168.128.77/dashboard/auth/login

openstack volume service list


