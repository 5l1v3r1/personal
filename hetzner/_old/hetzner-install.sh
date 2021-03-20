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


echo -e "$OK*$END - -----------------------------------------------------"
echo -e "$OK*$END - Gentoo instasllation for default hetzner server "
echo -e "$OK*$END - This script has been made of: wuseman <wuseman@nr1.nu>"
echo -e "$OK*$END - -----------------------------------------------------"
OK="\e[1;32m"
BAD="\e[1;31m"
END="\e[0m"

for i in sda sdb sdc sdd; do parted -a optimal /dev/$i print;done
for i in sda sdb sdc sdd; do parted -a optimal -s /dev/$i mklabel gpt;done

parted -a optimal -s /dev/sda "mkpart primary 1 2"              
parted -a optimal -s /dev/sda "mkpart primary 2 150"              
parted -a optimal -s /dev/sda "mkpart primary 150 -1"
parted -a optimal -s /dev/sda "set 1 bios_grub on" 
parted -a optimal -s /dev/sda "set 2 boot on"
parted -a optimal -s /dev/sda "name 1 1"
parted -a optimal -s /dev/sda "name 2 2"               
parted -a optimal -s /dev/sda "name 3 3"      

# dd if=/dev/urandom of=/dev/sda1 bs=256M
# dd if=/dev/urandom of=/dev/sda2 bs=256M
# for i in {1..7};do dd if=/dev/urandom of=/dev/sda1 bs=256M status=progress;done
# for i in {1..7};do dd if=/dev/urandom of=/dev/sda2 bs=256M status=progress;done


CRYPTKEY=nO|g;"y_2X%OkYiEwisq%['T-#wii9w8@;_X_$3D5#u1P'2#U1$Yn;bl9Z-(VEWi}3|krTM1rRjIJ=]RQw9qum0rCj;UHN+5BYtOqYCZ)BqoF|}Ks2m}t}4`,m{f7b>z9vQ*H{<3&)*XGC=f,ve4lj:"t]c^QPiNg=iH*5+h7:3yZkL2idwsIjw("
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sda3 -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdb  -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdc  -d-
echo $CRYPTKEY|cryptsetup --iter-time 5000 --use-random --hash sha512 --key-size 512 --cipher twofish-xts-plain64 luksFormat /dev/sdd  -d-
echo ""

echo $CRYPTKEY|cryptsetup luksOpen /dev/sda3 rootfs -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdb sdb     -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdc sdc     -d-
echo $CRYPTKEY|cryptsetup luksOpen /dev/sdd sdd     -d-
echo ""

pvcreate /dev/mapper/rootfs
vgcreate hetzner /dev/mapper/rootfs
lvcreate -l100%FREE -nrootfs hetzner
vgchange -a y hetzner

pvcreate /dev/mapper/sdb
vgcreate hdd2 /dev/mapper/sdb
lvcreate -l100%FREE -narchive hdd2
vgchange -a y hdd2

pvcreate /dev/mapper/sdc
vgcreate hdd3 /dev/mapper/sdc
lvcreate -l100%FREE -narchive hdd3
vgchange -a y hdd3

pvcreate /dev/mapper/sdd
vgcreate hdd4 /dev/mapper/sdd
lvcreate -l100%FREE -narchive hdd4
vgchange -a y hdd4
ls /dev/mapper/
echo ""

mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/mapper/hetzner-rootfs 
mkfs.ext4 /dev/mapper/hdd2-archive
mkfs.ext4 /dev/mapper/hdd3-archive
mkfs.ext4 /dev/mapper/hdd4-archive
echo ""


mount /dev/mapper/hetzner-rootfs /mnt/gentoo
mkdir -p /mnt/gentoo/boot
mount /dev/sda2 /mnt/gentoo/boot
echo ""

wget -q https://linux.rz.ruhr-uni-bochum.de/download/gentoo-mirror/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20190703T214502Z.tar.xz -P /mnt/gentoo
cd /mnt/gentoo;tar xvJpf stage3-amd64-*.tar.xz --xattrs-include='*.*' --numeric-owner
rm stage3-amd64-*.tar.xz /mnt/gentoo/etc/skel/.bashrc /mnt/gentoo/etc/portage/make.conf /mnt/gentoo/etc/fstab
echo ""



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
echo ""

cp -v /mnt/gentoo/etc/skel/.bash_profile /mnt/gentoo/root/ 
cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf 
cp -v -L /etc/resolv.conf /mnt/gentoo/etc/ 
echo ""

curl -o /mnt/gentoo/etc/skel/.bashrc                         -s https://nr1.nu/archive/hetzner-gentoo-setup/bashrc.txt
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




echo ""
clear
echo -e "  __ \e[1;36;4m/mnt/gentoo/etc/skel/.bashrc\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/skel/.bashrc|sed 's/^/ |    /g'   
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;35;4m/mnt/gentoo/etc/portage/make.conf\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"  
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/portage/make.conf|sed 's/^/ |    /g'  
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;34;4me[1;36;4m/mnt/gentoo/etc/default/grub\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##," 
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/default/grub|sed 's/^/ |  /g'                               
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;33;4me[1;36;4m/mnt/gentoo/etc/fstab\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/fstab|sed 's/^/ |  /g'                                      
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;32;4me[1;36;4m/mnt/gentoo/etc/genkernel.conf\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/genkernel.conf|sed 's/^/ |  /g'                             
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;31;4me[1;36;4m/mnt/gentoo/etc/portage/package.use/use-flags\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/portage/package.use/use-flags|sed 's/^/ |  /g'              
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[0;36;4me[1;36;4m/mnt/gentoo/etc/portage/package.license/licenses\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/portage/package.license/licenses|sed 's/^/ |  /g'           
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[0;36;4me[1;36;4m/mnt/gentoo/root/.ssh/authorized_keys\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/root/.ssh/authorized_keys|sed 's/^/ |  /g'                      
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[0;36;4me[1;36;4m/mnt/gentoo/root/.ssh/authorized_keys\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/dropbear/authorized_keys|sed 's/^/ |  /g'                   
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e " |"
echo -e " |"
cat /mnt/gentoo/root/run_after_chroot.sh.txt|sed 's/^/ |  /g'                  
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[0;36;4me[1;36;4m/mnt/gentoo/root/iptables.sh\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/root/iptables.sh|sed 's/^/ |  /g'                               
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[0;36;4me[1;36;4m/mnt/gentoo/root/unlock-drives.sh\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"echo -e " |"
echo -e " |"
cat /mnt/gentoo/root/unlock-drives.sh|sed 's/^/ |  /g'                          
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read -p " |" 
echo -e " '-> [ \e[1;32mOK \e[0m]"
echo -e " "
sleep 2;
clear
echo -e "  __ \e[1;36;4me[1;36;4m/mnt/gentoo/etc/ssh/sshd_config\e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/ssh/sshd_config|sed 's/^/ |  /g'                            
echo -e " |                                                                                                                      "
echo -e " |                                                                                                                      "
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
printf "%50s\n" | tr ' ' '-'  
read 
echo -e "   PERFECT $(whoami|tr '[a-z]' '[A-Z]') !!!  =)"
sleep 2;
clear
echo -e "  __ \e[1;36;4me[1;36;4m/mnt/gentoo/etc/sudoers\e[0m\e[0m \e[0m _____________________________________________________________________________________________________________________________________ ## \e[1;32;4mSTART\e[0m ##,"
echo -e " |"
echo -e " |"
cat /mnt/gentoo/etc/sudoers|sed 's/^/  |  /g'
echo -e " |"                                                                                     
echo -e " |"                                                                                                                     
echo -e " |"                         
echo -e " ',_ \e[1;31;4mIF\e[0m \e[1;32;4mFILE\e[0m \e[0;37;4mIS\e[0m \e[1;33;4mOK\e[0m \e[1;36;4mHIT\e[0m \e[1;4;35;5mENTER\e[0m ______________________________________________________________________________________________________________________________________________ ## \e[1;32;4mEND\e[0m ##"
read 
echo -e "   PERFECT $(whoami|tr '[a-z]' '[A-Z]') !!!  =)"
sleep 2;
clear
printf "%50s\n" | tr ' ' '-'
echo -e " | THIS WAS THE LAST ONE, GOOD JOB!! MOVING ON"
printf "%50s\n" | tr ' ' '-'
echo ""

cp ./run-me-after-chroot.sh /mnt/gentoo/root/
chmod +x /mnt/gentoo/root/*.sh
echo ""

CRYPTID="$(blkid|grep sda3|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
BOOTID="$(blkid|grep sda2|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
REALROOTID="$(blkid|grep hetzner-rootfs|awk -F'UUID="' '{print $2}'|cut -d'"' -f1)"
sed -i "s/crypt_root=UUID=/crypt_root=UUID=$CRYPTID/g" /mnt/gentoo/etc/default/grub
sed -i "s/UUID=b/UUID=$BOOTID/g" /mnt/gentoo/etc/fstab
sed -i "s/UUID=r/UUID=$REALROOTID/g" /mnt/gentoo/etc/fstab
echo ""



echo -e "ENTERING CHROOT IN 5 SECONDS"
echo "--------------------------------------------------"
sleep 5
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"

read -p "Do you want script to install \e[1;31meverything\e[0m or do you want to setup everything manually (auto/manual): " $WHATDOYOUW4NT
if [[ $WHATDOYOUW4NT = "auto" ]]; then
	bash /root/run-me-after-chroot.sh
elif [[ $WHATDOYOUW4NT = "manual" ]]; then
    echo "Have fun, enjoy your new gentoo installation :-)"
    exit 1
else
    echo "That's not a valid option, please run bash /root/run-me-after-chroot.sh or setup your gentoo install manually.."
    echo "Have fun! Bye"
fi
ln -s /etc/skel/.bashrc .




















