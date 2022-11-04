# GIPS-VM

[![Build GIPS VM](https://github.com/maxkratz/gips-vm/actions/workflows/vagrant-up.yml/badge.svg?branch=main&event=push)](https://github.com/maxkratz/gips-vm/actions/workflows/vagrant-up.yml)

This repository is used to automatically build a [GIPS](https://github.com/Echtzeitsysteme/gips) virtual machine (VM).


## Packages/Configuration

- [Ubuntu 20.04](https://app.vagrantup.com/gusztavvargadr/boxes/ubuntu-desktop)
- [OpenJDK 17](https://openjdk.org/projects/jdk/17/)
- [Graphviz](https://graphviz.org/)
- [GIPS Eclipse build](https://github.com/maxkratz/gips-eclipse-build) (variant: *eclipse-gips-linux-user*)


## Usage/Installation

- Download the latest version from the [release page](https://github.com/maxkratz/gips-vm/releases/latest).
- Install [VirtualBox](https://www.virtualbox.org/) (or another Hypervisor compatible to `OVA` files).
- Import the `OVA` file as new VM in VirtualBox. (More detailed description can be found [here](https://docs.oracle.com/cd/E26217_01/E26796/html/qs-import-vm.html).)
- Use the credentials `vagrant:vagrant` to login.
- Use the Eclipse icon on the desktop to start [GIPS](https://github.com/Echtzeitsysteme/gips).


## Runner requirements

There are two ways to provide this project with runners.

### GitHub-hosted macOS-based runners

Unfortunately, only the macOS-based GitHub-hosted action runners do support nested virtualization: https://github.com/actions/runner-images/issues/433

Therefore, we've adapted the CI-configuration to provision the **GIPS-VM** on a macOS-based runner until nested virtualization support gets added to the Linux-based runners.

### Self-hosted Linux-based runners

Currently, all actions must be run by a self-hosted GitHub runner, because GitHub-hosted runners do not provide the VT-x flag:
```bash
[...]
==> ubuntu: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "594c50ca-4ec6-4ff6-b785-2c6ba627bffd", "--type", "headless"]

Stderr: VBoxManage: error: VT-x is not available (VERR_VMX_NO_VMX)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole
Error: Process completed with exit code 1.
```

In order to run the "GitHub Actions" pipeline on a self-hosted runner, you must ensure that you have at least one properly configured Linux-based runner added to this GitHub project.

Required packages (at least):
- `curl`
- `wget`
- `grep`
- `VirtualBox`
- `vagrant`

**Please keep in mind that your runner (VM) needs the virtualization flag enabled and at least 6 GB of RAM!**
