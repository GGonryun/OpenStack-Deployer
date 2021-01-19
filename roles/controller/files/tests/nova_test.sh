testpassword='password1234'
testusername='testusername'
testproject='myproject'
testrole='myrole'

source ~/admin.sh 

openstack compute service list
openstack catalog list
nova-status upgrade check
