all: ipfs ipfs-cluster
ipfs:
	ansible-playbook -i inventory.yml ipfs.yml
ipfs-cluster:
	ansible-playbook -i inventory.yml ipfs-cluster.yml
.PHONY = all ipfs ipfs-cluster
