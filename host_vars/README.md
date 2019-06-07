# Setting up `host_vars` for each IPFS Cluster node

Add one file for each ipfs-cluster host. The filename should match a domain
name from your inventory, i.e. `example.org`.

Each file should contain the following variables, updated for your cluster:

```yaml
ipfs_peer_id: "<ipfs_daemon_peer_id>"
ipfs_private_key: "<ipfs_daemon_private_key>"

ipfs_cluster_id: "<cluster_peer_id>"
ipfs_cluster_private_key: "<cluster_peer_private_key>"

ipfs_cluster_peer_addr: "/dns4/<hostname>/tcp/9096/ipfs/<ipfs_cluster_peer_id>"
```

To generate the `ipfs_peer_id`/`ipfs_private_key` and
`ipfs_cluster_id`/`ipfs_cluster_private_key` key-pairs, use [`ipfs-key`]. They
must be all different (no ID or Key can be shared between daemons).

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

Where:

- the value of `ID for generated key: <PeerId>` is your `ipfs_peer_id` or `ipfs_cluster_id`
- the subsequent line is your `ipfs_private_key` or `ipfs_cluster_private_key`, encoded as base64

Copy those values into your host config file.

For `ipfs_cluster_peer_addr` you need to specify a valid [multiaddr] by taking the example below

```
"/dns4/<hostname>/tcp/9096/ipfs/<ipfs_cluster_peer_id>"
```
and replacing:

`hostname`: with the host from your invetory that this file is for, e.g
`example.org` `ipfs_cluster_peer_id`: with the peer id for this cluster node,
that you just created.


You can also define `ipfs_cluster_peername` to name your cluster peer for
conviniency. Otherwise, the hostname will be used.

[`ipfs-key`]: https://github.com/whyrusleeping/ipfs-key
[multiaddr]: https://multiformats.io/multiaddr/
