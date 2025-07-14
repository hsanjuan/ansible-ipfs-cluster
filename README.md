# Ansible role for `kubo` and `ipfs-cluster`

This repository contains an Ansible role to install and run
[`kubo`](ihttps://github.com/ipfs/kubo) and
[`IPFS Cluster`](https://github.com/ipfs/ipfs-cluster).

They include a Systemd service file both.

## Requirements

- Ansible. you can install it by running `pip install ansible`
- [optional] Working moledule setup with docker for running the tests

## Installation

### Git
Use `git clone` or `git submodule add` to clone the ansible-ipfs-cluster role (`https://github.com/hsanjuan/ansible-ipfs-cluster.git`) into the `roles` folder of your playbook to pull the latest edge commit of the role from GitHub. 

## Usage

If you are familiar with Ansible, you can just re-use the modules in the way
that fits you best. Otherwise follow these steps:

- Fill in `inventory.yml` and place the hostnames of your nodes under the `[ipfs]` and `[ipfs-cluster]` groups.
- Create `group_vars/ipfs.yml` and `group_vars/ipfs_cluster.yml` files setting the right configuration values including generating an [IPFS Cluster secret](https://cluster.ipfs.io/documentation/guides/security/#the-cluster-secret) with `od -vN 32 -An -tx1 /dev/urandom | tr -d ' \n' ; echo`. More details in the [Group Vars](#group-vars) section.
- Add a file for each hostname (filename is the hostname), to the `host_vars` folder as outlined in [Host Vars](#host-vars), containing the necessary host-specific variables (example in the `molecule/default/molecule.yml` file).

Upon successful execution, both `kubo` and `ipfs-cluster` should be running in the nodes (they are installed under `/usr/local/bin` and run by a created `ipfs` system user).

You can use `systemctl status ipfs` and `systemctl status ipfs-cluster` to check the status of the new services.

Note that `ipfs` configuration has been generated using `profile=server`, thus will not automatically scan the local network.

### Host Vars

Add one file for each ipfs-cluster host. The filename should match a domain name from your inventory, i.e. `example.org`.

Each file should contain the following variables, updated for your cluster:

```yaml
ipfs_peer_id: "<ipfs_daemon_peer_id>"
ipfs_private_key: "<ipfs_daemon_private_key>"

ipfs_cluster_id: "<cluster_peer_id>"
ipfs_cluster_private_key: "<cluster_peer_private_key>"

ipfs_cluster_peer_addr: "/dns4/<hostname>/tcp/9096/ipfs/<ipfs_cluster_peer_id>"
```

To generate the `ipfs_peer_id`/`ipfs_private_key` and `ipfs_cluster_id`/`ipfs_cluster_private_key` key-pairs, use [`ipfs-key`]. Theymust be all different (no ID or Key can be shared between daemons).

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

`hostname`: with the host from your invetory that this file is for, e.g `example.org` `ipfs_cluster_peer_id`: with the peer id for this cluster node, that you just created.


You can also define `ipfs_cluster_peername` to name your cluster peer for conviniency. Otherwise, the hostname will be used.

[`ipfs-key`]: https://github.com/whyrusleeping/ipfs-key
[multiaddr]: https://multiformats.io/multiaddr/

### Group Vars

The `group_vars` file can be used to set variables to control the common configuration for of all ipfs and ipfs-cluster peers.

Create `ipfs.yml` and `ipfs-cluster.yml` files in this folder and set the appropiate values for the variables.

Note the cluster `service.json` template can be fully customized by defining the appropiate variables, and otherwise they will take sensisble defaults.

## Running the tests

Assumes you have a working molecule setup with docker, running `molecule test` should spin up a docker container and execute the test playbook declared in `molecule/default/converge.yml` as well as the verifications in `molecule/default/verify.yml`

```console
python 3 -m molecule test
```
