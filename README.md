# Gentoo related stuff by wuseman

In this repository I will store everything that is related to my setups I using daily for servers, mobile and laptops. 

Warning: before using anything here, I really recommending to have goog knowledge about Gentoo and I really really recommending you to read handbook if you never touched Gentoo before. Use my stuff here when you you know what you are doing, change the files you use because they are customized to my settings and partitions and hard disks so for example if you you got an archive disk on /dev/sda and I have the same drive letter on my setups and you just runnning any script then you will lose your data and you wont be able to recover it after dd overwrited your drive via /dev/urandom. I have no intention of doing this repo for anyone other than myself, sharing to help anyone that is curios about this awesome distro and how I run my stuff. Gentoo power! You have been warned about NOT jus trun any script by copy-past FFS, then re-install windows or whatever distro you run, don't say you are a macosx user at least ,) :) 


### install.sh

*   Script for setup Gentoo, do not run this script before you modify it. It may fuck your current system, you have been warned.
   The script is almost just a copy-by-paste script for install gentoo untill chroot, this includes your setup to be fully
   encrypted by twofish-xts-plain64 cipher with a keyfile on ~8MB and require keyfile on boot via an removable device.

*   This script is not recommended to use for newbies, it has been created for myself whenever I would use this script again (there is better scrips/setups in this repo, if not stay tuned I will add more stuff to this repo - Added this text fyi: 2021-10-12) 

