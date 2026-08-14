# Vagrant training target

## Setup

~/.vagrant.d/boxes is a symlink to external hard drive

## Start

On school computer

- start the Ansible machine in Virtualbox
- vagrant up a generic Ubuntu + copy ed25519.pub

Get vagrant VM address:

```sh
vagrant ssh -c "hostname -I"

10.0.2.15
```

Get ssh config:

```sh
vagrant ssh-config
```

Virtualbox host only network

```
VBoxManage list hostonlyifs
VBoxManage list hostonlynetworks
```

Now try:

```sh
ssh vagrant@127.0.0.1:2222 -i .vagrant/machines/default/virtualbox/private_key
```

Virtualbox: ->settings->network->Adapter2 - Enable Network Adapter - Attached to: Host-only Adapter - Name will be vboxnet0

You can leave its existing NAT adapter enabled as Adapter 1. That's often the best configuration:

Adapter 1: NAT → Internet access
Adapter 2: Host-only → Communication with Vagrant VM

# Take down NAT interface

ip addr del 10.0.2.15/24 dev enp0s3

# Static IP for the Host-Only interface

ip addr add 192.168.87.101/24 dev enp0s8

# Flush arp cache

sudo ip -s -s neigh flush all

# Make host's arp discover where 192.168.87.101 is

ping 192.168.87.1

## ssh key management

add private key to ssh:
ssh -i ./private_key vagrant@192.168.56.10
