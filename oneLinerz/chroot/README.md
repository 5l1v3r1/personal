# Chroot

> **WARNING**: Remember that if you subsequently use the target machine directly at its keyboard, you'll be working outside of the chroot, and all your paths will be incorrect (e.g. the new system will still appear at /mnt/gentoo/). It's an easy mistake to make, hence the renaming of the prompts. Once the kernel is built and the machine rebooted, we'll be 'natively' inside the new system, at which point this path issue will disappear.

``` bash
#!/bin/bash

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run 
    
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"
``` 
![23213213](https://user-images.githubusercontent.com/26827453/168069798-7c238f62-d353-4fc2-a1cf-081524512981.png)



> Doing same things over and over and over again is boring, adding this part for myself so I can copy and paste when I installing Gentoo 
Doing this 1 time / month for different users/companies so if you reading this and installing gentoo. 
This is the last part beforing we we mounting the folders above and jumping in to our new enviroment/setup

``` bash
cp /mnt/usb/install/portage/make.conf /mnt/gentoo/etc/portage/
mkdir -p -v /mnt/gentoo/etc/portage/repos.conf 
cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
```

``` bash
printf '# Gentoo Kernel\n%s\n\n# Genkernel for initramfs \n%s\n\n# Grub:2 as bootloader\n%s\n\n' \
       'sys-kernel/gentoo-sources symlink' \
       'sys-kernel/genkernel cryptsetup' \
       'sys-boot/grub:2 device-mapper' \
       'app-arch/p7zip rar' > /etc/portage/package.use/elitebook_useflags 
``` 

![23213213](https://user-images.githubusercontent.com/26827453/168069798-7c238f62-d353-4fc2-a1cf-081524512981.png)

``` bash
emerge sys-kernel/gentoo-sources sys-kernel/genkernel sys-boot/grub:2 app-portage/gentoolkit app-editors/vim sys-apps/ripgrep-all sys-process/parallel  sys-fs/cryptsetup wpa_supplicant net-analyzer/netcat  app-arch/atool app-arch/p7zip
```

![Screenshot_20220512_122818](https://user-images.githubusercontent.com/26827453/168074931-ed69c98d-d842-4c2a-87c8-05e63aaa4954.png)


```bash
eix-update
eix-sync -a
emerge --oneshot sys-apps/portage
```
![21321](https://user-images.githubusercontent.com/26827453/168071643-19305b7a-d504-4a82-bd71-73ac59e73f89.png)

![3123213213](https://user-images.githubusercontent.com/26827453/168075079-5b49512d-8d33-4ea0-9ab0-18d36690728f.png)






