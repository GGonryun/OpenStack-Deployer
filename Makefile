BRANCH=main
# takes a CSV of tags to skip: ex: 'basic, mariadb'
SKIP=none

update:
	git fetch -t -p
	git pull origin $(BRANCH)

TEST_CLUSTER:
	# ansible-playbook -i inventory util/gather-facts.yaml --extra-vars "ansible_ssh_pass=root"
	ansible-playbook -i test.inventory cluster.yaml --extra-vars "ansible_ssh_pass=root" --skip-tag $(SKIP) --flush-cache

PRODUCTION_CLUSTER:
	# ansible-playbook -i inventory util/gather-facts.yaml --extra-vars "ansible_ssh_pass=root"
	ansible-playbook -i prod.inventory cluster.yaml --extra-vars "ansible_ssh_pass=root" --skip-tag $(SKIP) --flush-cache

PRODUCTION_PING:
	ansible-playbook -i prod.inventory util/ping.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

TEST_PING:
	ansible-playbook -i test.inventory util/ping.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

startup:
	ansible-playbook -i prod.inventory util/startup.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache