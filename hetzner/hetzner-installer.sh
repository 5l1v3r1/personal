#!/bin/bash
################################################################################
################################################################################
####                                                                       #####
#### A notice to all nerds.                                                #####
#### If you will copy developers real work it will not make you a hacker.  #####
#### Resepect all developers, we doing this because it's fun!              #####
####                                                                       #####
################################################################################
################################ SOURCE CODE ###################################
################################################################################
################ ##### HDDKILLER WAS FOUNDED BY WUSEMAN ########################
################################################################################
####                                                                       #####
####  Hetzner - Setup gentoo on a rented server from hetzner               #####
####  Copyright (C) 2013-2019, wuseman                                     #####
####                                                                       #####
####  This program is free software; you can redistribute it and/or modify #####
####  it under the terms of the GNU General Public License as published by #####
####  the Free Software Foundation; either version 2 of the License, or    #####
####  (at your option) any later version.                                  #####
####                                                                       #####
####  This program is distributed in the hope that it will be useful,      #####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       #####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #####
####  GNU General Public License for more details.                         #####
####                                                                       #####
####  You must obey the GNU General Public License. If you will modify     #####
####  hetzner.. file(s), you may extend this exception to your version     #####
####  of the file(s), but you are not obligated to do so.  If you do not   #####
####  wish to do so, delete this exception statement from your version.    #####
####  If you delete this exception statement from all source files in the  #####
####  program, then also delete it here.                                   #####
####                                                                       #####
####  Contact:                                                             #####
####          IRC: Freenode @ wuseman                                      #####
####          Mail: wuseman <wuseman@nr1.nu>                               #####
####                                                                       #####
################################################################################
#### SCRIPT BEGINS BERE ########################################################
################################################################################

OK="\e[1;32m"
BAD="\e[1;31m"
END="\e[0m"
echo -e "$OK*$END - -----------------------------------------------------"
echo -e "$OK*$END - Gentoo installation for default hetzner server "
echo -e "$OK*$END - This script has been made of: wuseman <wuseman@nr1.nu>"
echo -e "$OK*$END - -----------------------------------------------------"
echo -e "$OK*$END - Script is running, please wait.."
for i in sda sdb sdc sdd; do parted -a optimal -s /dev/$i mklabel gpt;done
parted -a optimal -s /dev/sda "mkpart primary 1 2"                           
parted -a optimal -s /dev/sda "mkpart primary 2 150"              
parted -a optimal -s /dev/sda "mkpart primary 150 -1"
parted -a optimal -s /dev/sda "set 1 bios_grub on" 
parted -a optimal -s /dev/sda "set 2 boot on"
parted -a optimal -s /dev/sda "name 1 1"
parted -a optimal -s /dev/sda "name 2 2"               
parted -a optimal -s /dev/sda "name 3 3"      
dd if=/dev/urandom of=/dev/sda1 bs=256M                          &> /dev/null
dd if=/dev/urandom of=/dev/sda2 bs=256M                          &> /dev/null
CRYPTKEY="<key here>"
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sda3 -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdb  -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdc  -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdd  -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sda3 rootfs -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdb sdb     -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdc sdc     -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdd sdd     -d-
pvcreate /dev/mapper/rootfs                                      &> /dev/null
vgcreate hetzner /dev/mapper/rootfs                              &> /dev/null
lvcreate -l100%FREE -nrootfs hetzner                             &> /dev/null
vgchange -a y hetzner                                            &> /dev/null
pvcreate /dev/mapper/sdb                                         &> /dev/null
vgcreate hdd2 /dev/mapper/sdb                                    &> /dev/null
lvcreate -l100%FREE -narchive hdd2                               &> /dev/null
vgchange -a y hdd2                                               &> /dev/null
pvcreate /dev/mapper/sdc                                         &> /dev/null
vgcreate hdd3 /dev/mapper/sdc                                    &> /dev/null
lvcreate -l100%FREE -narchive hdd3                               &> /dev/null
vgchange -a y hdd3                                               &> /dev/null
pvcreate /dev/mapper/sdd                                         &> /dev/null
vgcreate hdd4 /dev/mapper/sdd                                    &> /dev/null
lvcreate -l100%FREE -narchive hdd4                               &> /dev/null
vgchange -a y hdd4                                               &> /dev/null
mkfs.ext4 /dev/sda2                                              &> /dev/null
mkfs.ext4 /dev/mapper/hetzner-rootfs                             &> /dev/null
mkfs.ext4 /dev/mapper/hdd2-archive                               &> /dev/null
mkfs.ext4 /dev/mapper/hdd3-archive                               &> /dev/null
mkfs.ext4 /dev/mapper/hdd4-archive                               &> /dev/null
mkdir -p /mnt/gentoo                                             &> /dev/null
mount /dev/mapper/hetzner-rootfs /mnt/gentoo                     &> /dev/null
mkdir -p /mnt/gentoo/boot                                        &> /dev/null
mount /dev/sda2 /mnt/gentoo/boot                                 &> /dev/null
wget -q https://linux.rz.ruhr-uni-bochum.de/download/gentoo-mirror/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20190703T214502Z.tar.xz -P /mnt/gentoo
cd /mnt/gentoo;tar xJpf stage3-amd64-*.tar.xz --xattrs-include='*.*' --numeric-owner
rm stage3-amd64-*.tar.xz /mnt/gentoo/etc/skel/.bashrc /mnt/gentoo/etc/portage/make.conf /mnt/gentoo/etc/fstab
mkdir -p /mnt/gentoo/mnt/{sda,sdb,sdc,sdd,feral,feralhome,nr1,nr1-home,nr1-www,thinkpad,thinkpad,dell,tmp,temp}
chmod -R 777 /mnt/gentoo/mnt/{sda,sdb,sdc,sdd,feral,feralhome,nr1,nr1-home,nr1-www,thinkpad,thinkpad,dell,tmp,temp}
mount /dev/mapper/hdd2-archive /mnt/gentoo/mnt/sdb
mount /dev/mapper/hdd3-archive /mnt/gentoo/mnt/sdc
mount /dev/mapper/hdd4-archive /mnt/gentoo/mnt/sdd
mount -t proc proc /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys 
mount --make-rslave /mnt/gentoo/dev 
mkdir -p /mnt/gentoo/etc/ssh /mnt/gentoo/etc/portage/package.{use,keywords,license,unmask,mask} /mnt/gentoo/etc/default/ /mnt/gentoo/mnt/sd{b,c,d} 
mkdir -p /mnt/gentoo/etc/portage/repos.conf /mnt/gentoo/etc/dropbear/ /mnt/gentoo/root/.ssh
cp -v /mnt/gentoo/etc/skel/.bash_profile /mnt/gentoo/root/ 
cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf 
cp -v -L /etc/resolv.conf /mnt/gentoo/etc/ 
curl -o /mnt/gentoo/etc/skel/.bashrc_profile                 -s https://nr1.nu/archive/hetzner-gentoo-setup/bashrc.txt
curl -o /mnt/gentoo/etc/portage/make.conf                    -s https://nr1.nu/archive/hetzner-gentoo-setup/make.conf.txt
curl -o /mnt/gentoo/etc/default/grub                         -s https://nr1.nu/archive/hetzner-gentoo-setup/grub.txt
curl -o /mnt/gentoo/etc/fstab                                -s https://nr1.nu/archive/hetzner-gentoo-setup/fstab.txt
curl -o /mnt/gentoo/etc/genkernel.conf                       -s https://nr1.nu/archive/hetzner-gentoo-setup/genkernel.conf.txt
curl -o /mnt/gentoo/etc/portage/package.use/use-flags        -s https://nr1.nu/archive/hetzner-gentoo-setup/use-flags.txt
curl -o /mnt/gentoo/etc/portage/package.license/licenses     -s https://nr1.nu/archive/hetzner-gentoo-setup/licenses.txt
curl -o /mnt/gentoo/root/.ssh/authorized_keys                -s https://nr1.nu/archive/hetzner-gentoo-setup/authorized_keys.txt 
curl -o /mnt/gentoo/etc/dropbear/authorized_keys             -s https://nr1.nu/archive/hetzner-gentoo-setup/authorized_keys.txt 
curl -o /mnt/gentoo/root/iptables.sh                         -s https://nr1.nu/archive/hetzner-gentoo-setup/iptables.sh.txt
curl -o /mnt/gentoo/root/unlock-drives.sh                    -s https://nr1.nu/archive/hetzner-gentoo-setup/unlock-drives.sh.txt
curl -o /mnt/gentoo/root/reboot.sh                           -s https://nr1.nu/archive/hetzner-gentoo-setup/reboot.sh.txt
curl -o /mnt/gentoo/etc/ssh/sshd_config                      -s https://nr1.nu/archive/hetzner-gentoo-setup/sshd_config.txt 
curl -o /mnt/gentoo/etc/sudoers                              -s https://nr1.nu/archive/hetzner-gentoo-setup/sudoers.txt             
chmod +x /mnt/gentoo/root/*.sh
CRYPTID="$(blkid|grep sda3|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
BOOTID="$(blkid|grep sda2|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
REALROOTID="$(blkid|grep hetzner-rootfs|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
sed -i "s/crypt_root=UUID=/crypt_root=UUID=$CRYPTID/g" /mnt/gentoo/etc/default/grub
sed -i "s/UUID=b/UUID=$BOOTID/g" /mnt/gentoo/etc/fstab
sed -i "s/UUID=r/UUID=$REALROOTID/g" /mnt/gentoo/etc/fstab
cat <<"EOF" > /mnt/gentoo/root/run-me-after-chroot.sh
#!/bin/bash
################################################################################
################################################################################
####                                                                       #####
#### A notice to all nerds.                                                #####
#### If you will copy developers real work it will not make you a hacker.  #####
#### Resepect all developers, we doing this because it's fun!              #####
####                                                                       #####
################################################################################
################################ SOURCE CODE ###################################
################################################################################
####                                                                       #####
####  Copyright (C) 2018-2019, wuseman                                     #####
####                                                                       #####
####  This program is free software; you can redistribute it and/or modify #####
####  it under the terms of the GNU General Public License as published by #####
####  the Free Software Foundation; either version 2 of the License, or    #####
####  (at your option) any later version.                                  #####
####                                                                       #####
####  This program is distributed in the hope that it will be useful,      #####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       #####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #####
####  GNU General Public License for more details.                         #####
####                                                                       #####
####  You must obey the GNU General Public License. If you will modify     #####
####  this file(s), you may extend this exception to your version          #####
####  of the file(s), but you are not obligated to do so.  If you do not   #####
####  wish to do so, delete this exception statement from your version.    #####
####  If you delete this exception statement from all source files in the  #####
####  program, then also delete it here.                                   #####
####                                                                       #####
####  Contact:                                                             #####
####          IRC: Freenode @ wuseman                                      #####
####          Mail: wuseman <wuseman@nr1.nu>                               #####
####                                                                       #####
################################################################################
### Created: 2019-07-07                                                    #####
################################################################################
OK="\e[1;32m"
BAD="\e[1;31m"
END="\e[0m"

## Give our root a password
   echo "root:<root pass>" | chpasswd

## Sync portage
   emerge-webrsync

## Install required packages
   emerge --ask gentoo-sources genkernel grub dropbear openssh dhcp dhcpcd app-misc/screen rtorrent mutt weechat znc tcllib dev-lang/tcl sudo cronie hddtemp lm_sensors smartmontools hdparm gentoolkit

## Create shortcut to net
   cd /etc/init.d
   ln -s net.lo net.eth0

## Add my private account with a homedir
   useradd -m wuseman
   echo "wuseman:<user pass>" | chpasswd
   for groups in wheel news audio cdrom cdrw usb input users portage man sshd cron crontab; do gpasswd -a wuseman $groups; done
   cp -r /root/.ssh/authorized_keys /mnt/gentoo/home/wuseman
   chmod 644 /etc/dropbear/authorized_keys /root/.ssh/authorized_keys /home/wuseman/.ssh/authorized_keys
   chown -R wuseman:wuseman /mnt/gentoo/home/wuseman

## Create cronjobs
cat <<'EOF' > /var/spool/cron/crontabs/root
# * * * * *  command to execute
# │ │ │ │ │
# │ │ │ │ │
# │ │ │ │ └───── day of week (0 - 6) (0 to 6 are Sunday to Saturday, or use names; 7 is Sunday, the same as 0)
# │ │ │ └────────── month (1 - 12)
# │ │ └─────────────── day of month (1 - 31)
# │ └──────────────────── hour (0 - 23)
# └───────────────────────── min (0 - 59)

@reboot /root/reboot.sh --wipekey
@reboot /root/iptables.sh
@reboot bash /root/unlock-drives.sh

'
\EOF

## Greate necessary dropbear keys for initramfs
   dropbearkey -t dss   -f /etc/dropbear/dropbear_dss_host_key
   dropbearkey -t rsa   -f /etc/dropbear/dropbear_rsa_host_key
   dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key

## Enter kernel dir
   cd /usr/src/linux

## Create kernel config and compile kernel
   make localyesconfig
   make -j8 -l9
   make modules_install 
   make install

## Adding stuff to runlevel (optional - edit it this for your own usage)
   for i in dropbear hostname keymaps lvm sshd net.eth0 cronie sshd; do 
         rc-update add $i
   done


## Create initramfs
  genkernel initramfs

# Configure and install grub
  grub-install /dev/sda
  grub-mkconfig -o /boot/grub/grub.cfg


echo -e '
,--------------------------------------------------------------------------------------------------------------,
|                                                                                                              |
| Gentoo Wiki:            -  Offical Gentoo Wiki                   - https://wiki.gentoo.org/wiki/Main_Page    |
| Gnu.org:                -  GNU has many good tutorials           - https://gnu.org                           |
| Nr1 Filehosting:        -  Share your logs and files via Nr1     - https://nr1.nu                            |
| Freenode IRC WebClient  -  Get in touch with Gentooers via iRC   - https://webchat.freenode.net/             |
|                                                                                                              |
|--------------------------------------------------------------------------------------------------------------|
|                                                                                                              |
| You are now ready to logout chroot, unmount all mounted folders and reboot your PC                           |
| and boot into your new Gentoo Linux enviroment for the first time                                            |
|                                                                                                              |
| Congratutlations to your new Gentoo setup and have fun!                                                      |
| This script has been created and is maintained by: wuseman <wuseman@nr1.nu>                                  |
|                                                                                                              |
|--------------------------------------------------------------------------------------------------------------|
|                                                                                                              |
| More projects from wuseman:                                                                                  |
|                                                                                                              |
| https://github.com/wuseman                                                                                   |
| https://wiki.gentoo.org/wiki/User:Wuseman                                                                    | 
| https://www.commandlinefu.com/commands/                                                                      |
|                                                                                                              |
 `-------------------------------------------------------------------------------------------------------------´

'
EOF
sed -i 's/\\EOF/EOF/g' /mnt/gentoo/root/run-me-after-chroot.sh

chmod +x /mnt/gentoo/root/run-me-after-chroot.sh
echo -e "$OK*$END - -----------------------------------------------------"
echo -e "$OK*$END - Install \e[1;31meverything\e[0m auto: (yes/no): "
echo -e "$OK*$END - -----------------------------------------------------"
read -p "Option: " WHATDOYOUW4NT

if [[ $WHATDOYOUW4NT = "yes" ]]; then
  echo "Entering chroot and continue installation.."
  echo '
     source /etc/profile
     export PS1="(chroot) $PS1 "
' >> /mnt/gentoo/root/.bashrc
     echo "Entering chroot"
     chroot /mnt/gentoo /bin/bash
     bash /root/run-me-after-chroot.sh

elif [[ $WHATDOYOUW4NT = "no" ]]; then
    echo "Have fun, enjoy your new gentoo installation :-)"
    exit 1
else
    echo "That's not a valid option, please run bash /root/run-me-after-chroot.sh or setup your gentoo install manually.."
    echo "Have fun! Bye"
    exit 1
fi























