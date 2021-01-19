BRANCH=main
# takes a CSV of tags to skip: ex: 'basic, mariadb'
SKIP=none
INVENTORY=test.inventory

update:
	git fetch -t -p
	git pull origin $(BRANCH)

cluster:
	# ansible-playbook -i inventory util/gather-facts.yaml --extra-vars "ansible_ssh_pass=root"
	ansible-playbook -i $(INVENTORY) cluster.yaml --extra-vars "ansible_ssh_pass=root" --skip-tag $(SKIP) --flush-cache

ping:
	ansible-playbook -i $(INVENTORY) util/ping.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

startup:
	ansible-playbook -i $(INVENTORY) util/startup.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

scripts:
	ansible-playbook -i $(INVENTORY) util/classroom-builder.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

teardown:
	#ansible-playbook -i $(INVENTORY) util/block-teardown.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache
	ansible-playbook -i $(INVENTORY) util/compute-teardown.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache
	ansible-playbook -i $(INVENTORY) util/controller-teardown.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

logging:
	ansible-playbook -i $(INVENTORY) util/logging-server-logging.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache
	ansible-playbook -i $(INVENTORY) util/controller-logging.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache
	#ansible-playbook -i $(INVENTORY) util/compute-logging.yaml --extra-vars "ansible_ssh_pass=root" --flush-cache

