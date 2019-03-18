# Setting up Host vars for each IPFS Cluster node

Add one file for each ipfs-cluster host. The filename should match a domain name from your inventory. e.g `example.org`

Each file should contain the following variables, updated for your cluster:

```yaml
ipfs_peer_id: "<ipfs_daemon_peer_id>"
ipfs_private_key: "<ipfs_daemon_private_key>"

ipfs_cluster_peer_id: "<cluster_peer_id>"
ipfs_cluster_private_key: "<cluster_peer_private_key>"

ipfs_cluster_peer_addr: "/dns4/<hostname>/tcp/9096/ipfs/<ipfs_cluster_peer_id>"
ipfs_cluster_peername: "peername"
```

To generate the `ipfs_peer_id`/`ipfs_private_key` and `ipfs_cluster_peer_id`/`ipfs_cluster_private_key` key-pairs, use [`ipfs-key`].

To install [`ipfs-key`], with Go installed, run:

```console
$ go get github.com/whyrusleeping/ipfs-key
```

then generate a key-pair:

```console
$ ipfs-key | base64 -w 0

# or on macos
$ ipfs-key | base64

Generating a 2048 bit RSA key...
Success!
ID for generated key: Qmat3Bk4SixhZdU5j5pf2uXcpUuTSxKHQu7whbWrdFwn5g
CAASqAkwggSkAgEAAoIBAQCUzxjdml2fORveg9PN98qqiENexLzoaSeNc6N7K8iVzneCU1aDZpM...
```

Where
- the value of `ID for generated key: <PeerId>` is your `ipfs_peer_id`
- the subsequent line is your `ipfs_private_key`, encoded as base64

Copy those values into your host config file. Then do the same again for the `ipfs_cluster_peer_id`/`ipfs_cluster_private_key` keys.

For `ipfs_cluster_peer_addr` you need to specify a valid [multiaddr] by taking the example below

```
"/dns4/<hostname>/tcp/9096/ipfs/<ipfs_cluster_peer_id>"
```
and replacing:

`hostname`: with the host from your invetory that this file is for, e.g `example.org`
`ipfs_cluster_peer_id`: with the peer id for this cluster node, that you just created.


For `ipfs_cluster_peername` you can set any friendly identifier you like to help you identify this node in your cluster. eg `london 001` or `whizzo`.



[`ipfs-key`]: https://github.com/whyrusleeping/ipfs-key
[multiaddr]: https://multiformats.io/multiaddr/
