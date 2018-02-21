# Ansible roles for `go-ipfs` and `ipfs-cluster`

This repository contains Ansible roles to install and run [`go-ipfs`](https://github.com/ipfs/go-ipfs) and [`ipfs-cluster`](https://github.com/ipfs/ipfs-cluster).

They include Systemd service files for both.

## Usage

If you are familiar with Ansible, you can just re-use the modules in the way that fits you best. Otherwise follow these steps:

0. Make sure you have ansible installed: `pip install ansible`.
1. Fill in `inventory.yml` and place the hostnames of your nodes under the `[ipfs]` group.
2. Edit the `group_vars/ipfs.yml` file setting the right configuration values, including generating an [IPFS Cluster secret](https://github.com/ipfs/ipfs-cluster/blob/master/docs/ipfs-cluster-guide.md#the-configuration-file) with `od  -vN 32 -An -tx1 /dev/urandom | tr -d ' \n' ; echo`
3. Add a file for each hostname (filename is the hostname), to the `host_vars` folder as outlined in [`host_vars/README.md`](host_vars/README.txt), containing the necessary host-specific variables (example in the `host_vars` README).
4. Run `make`.

`make` will run ansible for the `ipfs` and the `ipfs-cluster` roles, which apply to the `[ipfs]` inventory group. Upon successful, both `go-ipfs` and `ipfs-cluster` should be running in the nodes (they are installed under `/usr/local/bin` and run by a created `ipfs` system user).

You can use `systemctl status ipfs` and `systemctl status ipfs-cluster` to check the status of the new services.

Note that `ipfs` configuration has been generated using `profile=server`, thus will not automatically scan the local network.
