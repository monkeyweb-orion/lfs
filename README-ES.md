# Linux From Scratch

> Este proyecto es una variante de [https://github.com/Yibo-Li/linuxfromscratch.git](https://github.com/Yibo-Li/linuxfromscratch.git), proyecto creado de LFS version 8. De autor Yibo-Li

---

Este es un proceso de construcción de [Vagrant](https://www.vagrantup.com/) para [Linux From Scratch](http://www.linuxfromscratch.org/lfs/).

Antes del recorrido por el edificio lfs, necesita instalar [VirtualBox](https://www.virtualbox.org/) y [Vagrant](https://www.vagrantup.com/) en su PC.

Clone o descargue este repositorio y cambie a la carpeta del repositorio en la línea de comando.

 
```bash
$ git clone https://github.com/Yibo-Li/linuxfromscratch.git
Cloning into 'linuxfromscratch'...
...
$ cd linuxfromscratch && ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

# Archivos fuente

Todos los archivos fuente (*.tar.xz | *.tar.gz | ...) se encuentran en el directorio fuente "./sources".

Or you can find the source files here [https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ](https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ) by downloading them to your project's "./sources" folder.

Todos los archivos fuente (*.tar.xz|*tar.gz|...) están en el directorio fuente, sin embargo, el archivo de lista de descargas de wget-list tiene 2 archivos que ya no se encuentran para descargar, a saber ( https:/ /prdownloads.sourceforge.net/expat/expat-2.4.8.tar.xz | https://zlib.net/zlib-1.2.12.tar.xz). El proyecto expat en la versión 2.4.8 tiene un fallo de seguridad y se recomienda la instalación de la versión 2.5.0.

El archivo wget-list se ha mantenido en su forma original, ya que los archivos fuente ya están disponibles para su compilación.

Ejecute `vagrant up` para iniciar y aprovisionar el entorno vagrant usando [debian/buster64](https://app.vagrantup.com/debian/boxes/buster64). El proceso puede tardar alrededor de diez minutos, debido a la descarga de la imagen del sistema operativo y el software esencial.

Usamos el complemento vagrant-disksize para vagrant para aumentar el tamaño del disco de la VM del sistema host.

# Instalación del complemento "Vagrant"

Para instalar el complemento de vagabundo, siga las instrucciones a continuación:

```bash
$ vagrant plugin install vagrant-disksize
```

En caso de que no sea necesario, puedes comentar el siguiente parámetro en el archivo (Vagrantfile)

```bash
...
config.vm.box = "debian/buster64"
# Comenta la línea a continuación si no has instalado vagrant-disksize
# config.disksize.size = "40GB"
...
```

# Creando la imagen con Vagrant

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

Cuando el entorno vagrant esté listo, inicie sesión como lfs y abra una sesión tmux para evitar que la terminal se cierre inesperadamente.

```bash
$ vagrant ssh
lfs@lfs:~$ tmux new -s work
...
```

Pruebe las variables de entorno `$LFS` y `$LFS_TGT` son `/mnt/lfs` y `x86_64-lfs-linux-gnu`, respectivamente. Además, el resultado del montaje es el mismo que el siguiente.

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

El siguiente son los comandos centrales para construir los lfs.

```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
...
```

Después de horas de construcción, apague el entorno "vagrant" y habrá un disco virtual llamado lfs.vdi, que contiene las particiones raíz y de intercambio de lfs.

```bash
lfs@lfs:~$ sudo shutdown -h now
...
$ ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

Finalmente, cree una nueva computadora virtual usando el archivo de disco virtual `lfs.vdi`.
Y encienda esta nueva computadora para iniciar sesión en el sistema lfs como root con una contraseña vacía.

En caso de que quieras crear una imagen ISO.
```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
```