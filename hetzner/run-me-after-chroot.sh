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
   echo "root:odemnn" | chpasswd

## Sync portage
   emerge-webrsync

## Install required packages
   emerge --ask gentoo-sources genkernel grub dropbear openssh dhcp dhcpcd app-misc/screen rtorrent mutt weechat znc tcllib dev-lang/tcl sudo cronie hddtemp lm_sensors smartmontools hdparm gentoolkit

## Create shortcut to net
   cd /etc/init.d
   ln -s net.lo net.eth0

## Add my private account with a homedir
   useradd -m wuseman
   echo "wuseman:odemnn" | chpasswd
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
EOF

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
