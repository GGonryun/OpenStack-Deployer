testpassword='password1234'
testusername='testusername'
testproject='myproject'
testrole='myrole'

source ~/admin.sh 

openstack domain create --description "An Example Domain" example
openstack project create --domain default --description "Demo Project" $testproject
openstack user create --domain default --password $testpassword $testusername
openstack role create $testrole
openstack role add --project $testproject --user $testusername $testrole