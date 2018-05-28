# Host vars

Add one file for each ipfs/ipfs-cluster host to this folder with the local variables like:

    ipfs_peer_id: "<ipfs_daemon_peer_id>"
    ipfs_private_key: "<ipfs_daemon_private_key>"
    ipfs_cluster_peer_addr: "</dns4/<hostname>/tcp/9096/<peerID>"
    ipfs_cluster_peer_id: "<cluster_peer_id>"
    ipfs_cluster_peername: "peername"
    ipfs_cluster_private_key: "<cluster_peer_private_key>"

You can use:

    $ ipfs-key | base64 -w 0

to generate ids and keys. See https://github.com/whyrusleeping/ipfs-key.
