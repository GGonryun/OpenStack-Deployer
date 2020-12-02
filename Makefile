cluster:
	ansible-playbook -i inventory cluster.yaml --ask-pass

ping:
	ansible-playbook -i inventory util/ping.yaml --ask-pass 

startup:
	ansible-playbook -i inventory util/startup.yaml --ask-pass 