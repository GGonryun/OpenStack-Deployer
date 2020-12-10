BRANCH=main
update:
	git fetch -t -p
	git pull origin $(BRANCH)

cluster:
	ansible-playbook -i inventory util/gather-facts.yaml --extra-vars "ansible_ssh_pass=root"
	ansible-playbook -i inventory cluster.yaml --extra-vars "ansible_ssh_pass=root"

ping:
	ansible-playbook -i inventory util/ping.yaml --extra-vars "ansible_ssh_pass=root"

startup:
	ansible-playbook -i inventory util/startup.yaml --extra-vars "ansible_ssh_pass=root"