# Linux From Scratch

> Este projeto é um fork de [https://github.com/Yibo-Li/linuxfromscratch.git](https://github.com/Yibo-Li/linuxfromscratch.git), projeto cria uma versão LFS 8. Repositório de Yibo-Li

---

Este é um processo de construção do [Vagrant](https://www.vagrantup.com/) para o [Linux From Scratch](http://www.linuxfromscratch.org/lfs/).

Antes do tour pelo prédio do lfs, você precisa instalar o [VirtualBox](https://www.virtualbox.org/) e o [Vagrant](https://www.vagrantup.com/) no seu PC.

Clone ou baixe este repositório e mude para a pasta do repositório na linha de comando.

 
```bash
$ git clone https://github.com/Yibo-Li/linuxfromscratch.git
Cloning into 'linuxfromscratch'...
...
$ cd linuxfromscratch && ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

# Arquivos Fonte

Todos os arquivos de origem (*.tar.xz | *.tar.gz | ... ) são encontrados no diretório de origem "./sources".

Or you can find the source files here [https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ](https://mega.nz/folder/6REB3aZR#H7kaORZTl25si_TY3PVhYQ) by downloading them to your project's "./sources" folder.

Todos os arquivos fonte (*.tar.xz|*tar.gz|...) estão no diretório fonte, porém o arquivo da lista de download wget-list possui 2 arquivos que não são mais encontrados para download, a saber ( https:/ /prdownloads.sourceforge.net/expat/expat-2.4.8.tar.xz | https://zlib.net/zlib-1.2.12.tar.xz). O projeto expat na versão 2.4.8 possui uma falha de segurança, sendo recomendada a instalação da versão 2.5.0.

O arquivo wget-list foi mantido em sua forma original, pois os arquivos fonte já estão disponíveis para compilação.

Execute `vagrant up` para iniciar e provisionar o ambiente vagrant usando [debian/buster64](https://app.vagrantup.com/debian/boxes/buster64). O processo pode levar muito tempo, cerca de décadas, devido ao download da imagem do sistema operacional e do software essencial.

Usamos o plugin vagrant-disksize para vagrant para aumentar o tamanho do disco VM do sistema host.

# Instalação do plug-in Vagrant

Para instalar o plugin do vagrant siga as instruções abaixo:

```bash
$ vagrant plugin install vagrant-disksize
```

Caso não seja necessário, você pode comentar o seguinte parâmetro no arquivo (Vagrantfile)

```bash
...
config.vm.box = "debian/buster64"
# Comente a linha abaixo se você não instalou o vagrant-disksize
# config.disksize.size = "40GB"
...
```

# Criando a imagem com Vagrant

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

Quando o ambiente vagrant estiver pronto, faça login como lfs e abra uma sessão tmux para evitar que o terminal feche inesperadamente.

```bash
$ vagrant ssh
lfs@lfs:~$ tmux new -s work
...
```

Teste as variáveis de ambiente `$LFS` e `$LFS_TGT` são `/mnt/lfs` e `x86_64-lfs-linux-gnu`, respectivamente. Além do resultado da montagem ser o mesmo abaixo.

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

O próximo são os comandos centrais para construir o lfs.

```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
...
```

Após horas de construção, desligue o ambiente vagrant e haverá um disco virtual chamado lfs.vdi, que contém a raiz do lfs e as partições swap.

```bash
lfs@lfs:~$ sudo shutdown -h now
...
$ ls .
config  docs  lfs.vdi  README.md  scripts  sources  Vagrantfile  vagrant.sh
```

Por fim, crie um novo computador virtual usando o arquivo de disco virtual `lfs.vdi`.
E ligue este novo computador para efetuar login no sistema lfs como root com uma senha vazia.

No caso de você desejar criar uma imagem ISO.
```bash
lfs@lfs:~$ $LFS/scripts/run-all.sh
```