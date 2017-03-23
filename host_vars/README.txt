Add in this folder one file for each ipfs/ipfs-cluster host with
the local variables like:

ipfs_peer_id: <ipfs peer id>
ipfs_private_key: <ipfs private key>
ipfs_cluster_peer_id: <ipfs-cluster peer id>
ipfs_cluster_private_key: <ipfs-cluster private key>

You can use:

$ ipfs-key | base64 -w 0

to generate ids and keys. See https://github.com/whyrusleeping/ipfs-key.
