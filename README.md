# Linux From Scratch

> This Project is a fork from [https://github.com/Yibo-Li/linuxfromscratch.git](https://github.com/Yibo-Li/linuxfromscratch.git), project create a LFS version 8. Repository by Yibo-Li

---

This is a [Vagrant](https://www.vagrantup.com/) building process for [Linux From Scratch](http://www.linuxfromscratch.org/lfs/).

Before the tour of lfs building, you need install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) on your PC.

Clone or download this repository and change to the repository folder in the command line.

 
```bash
$ git clone https://github.com/fernandofbp/lfs.git
Cloning into 'lfs'...
...
$ cd lfs && ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

# Source Files

All of the source files  (*.tar.xz | *.tar.gz | ... ) it's found on the source directory "./sources".

Or you can find the source files here [https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ](https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ) by downloading them to your project's "./sources" folder.

All the source files (*.tar.xz|*tar.gz|...) are in the source directory, however the wget-list download list file has 2 files that are no longer found for download, namely ( https://prdownloads.sourceforge.net/expat/expat-2.4.8.tar.xz | https://zlib.net/zlib-1.2.12.tar.xz). The expat project in version 2.4.8 has a security flaw, and the installation of version 2.5.0 is recommended.

The wget-list file has been kept in its original form, as the source files are already available for compilation.

Run `vagrant up` to start and provision the vagrant environment using [debian/buster64](https://app.vagrantup.com/debian/boxes/buster64). The process may spend a long time around decade minutes, because of downloading the os image and essential software.

We used the vagrant-disksize plugin for vagrant to increase the host system VM disk size.

# Vagrant Plugin Install

To install the vagrant's plugin follow the instructions bellow:

```bash
$ vagrant plugin install vagrant-disksize
```

In case it is not necessary, you can comment out the following parameter in the file (Vagrantfile)

```bash
...
config.vm.box = "debian/buster64"
# Comment the line below if you haven't installed vagrant-disksize
# config.disksize.size = "40GB"
...
```

# Creating the image with Vagrant

```bash
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'debian/buster64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'debian/buster64' is up to date...
==> default: Setting the name of the VM: lfs
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
...
```

When the vagrant environment is ready, log in as lfs and open a tmux session to prevent terminal close unexpectedly. 

```bash
$ vagrant ssh
lfs@lfs:~$ tmux new -s work
...
```

Test the environment variables `$LFS` and `$LFS_TGT` are `/mnt/lfs` and `x86_64-lfs-linux-gnu`, respectively. Besides the mount result is same as bellow.

```bash
lfs@lfs:~$ echo $LFS
/mnt/lfs
lfs@lfs:~$ echo $LFS_TGT
x86_64-lfs-linux-gnu
lfs@lfs:~$ lsblk
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda      8:0    0  10G  0 disk
`-sda1   8:1    0  10G  0 part /
sdb      8:16   0  10M  0 disk
sdc      8:32   0  40G  0 disk
|-sdb1   8:33   0  32G  0 part /mnt/lfs
`-sdb2   8:34   0   8G  0 part [SWAP]
```

The next is central commands to build the lfs.

```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
...
```

After hours of building shut down the vagrant environment and there is a virtual disk named lfs.vdi, which contains the lfs root and swap partitions.

```bash
lfs@lfs:~$ sudo shutdown -h now
...
$ ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

Finally, create a new virtual box computer using the `lfs.vdi` virtual disk file.
And power on this new computer to log in the lfs system as root with an empty password.

In case you want to create an ISO image.
```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
```