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

unset OS_AUTH_URL OS_PASSWORD
openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name $testproject --os-username $testusername --os-password $testpassword token issue