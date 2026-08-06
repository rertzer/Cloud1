# Doc

## Toolbx on Fedora

Built on top of podman

Allowsch toolbx container is an environment that you can enter from the command line. Inside each one, you will find:

- Your existing username and permissions.
- Access to your home directory and several other locations.
- Access to both system and session D-Bus, system journal and Kerberos.
- Common command lines tools, including a package manager (e.g., DNF on Fedora).the use of interactive command line environments whithout having to install software on the host.

### Starting toolbox

Creating a toolbox container

```sh
toolbox create <name>
toolbox enter <name>
```

### Running a command without entering

```sh
toolbox run -c <name> <cmd> <args>
```

### Listing toolboxes

```sh
toolbox list -i     # images
toolbox list -c     # containers
```

### Remove toolbox containers

```sh
toolbox rm <name>
toolbox rm --all
```

options:

- `--all ` or `-a`
- `--force` 0r `-f`

removing images: `toolbox rmi <name>`

## Install Ansible on Debian Trixie

| Installation method                                  | Approximate additional disk space |
| ---------------------------------------------------- | --------------------------------- |
| sudo dnf install ansible-core                        | 100–250 MB                        |
| sudo dnf install ansible (includes many collections) | 500 MB–1.5 GB                     |
| pip install --user ansible-core                      | 80–200 MB in your home directory  |

`ansible-core` is sufficient for most automation tasks. It includes:

- ansible
- ansible-playbook
- SSH support
- Jinja2
- Python dependencies

`ansible` is a larger meta-package that bundles many community collections, which significantly increases disk usage.

```sh
sudo apt install ansible-core
...<SNIP>...
Failed to fetch http://deb.debian.org/debian/pool/main/p/python-xmltodict/python3-xmltodict_0.13.0-1_all.deb  404  Not Found [IP: 151.101.2.132 80]
```

```sh
sudo apt --fix-broken install
sudo apt autoremove
sudo rm -rf /var/lib/apt/lists/*
sudo apt update
sudo apt upgrade
sudo apt install ansible-core
```

Now seems ok.
