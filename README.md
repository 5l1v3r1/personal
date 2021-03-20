# Gentoo Install

_Various scripts that I have created for my gentoo setups since 2008, some are outdated and certain are current. Feel free to do whatever you want with the tools, maybe it will help someone_

_Please!! Do not report issues or bugs for anything in this repository, this repos exists for fun and all tools have been created for my own setups and and they can work differently on your setup_

| Script/Tool        | Description    | Author | License |
| :----------------- | :------------- | :------- | :---------: | :--------- | 
| install.sh         | Install gentoo with an encrypted root with keyfile required                | 
| chroot             | Chroot script, place it on your usb and you wont need chroot manually      | wuseman | GPL 3.0 |
| wupdate            | This tool is for faciliate the work with portage for Gentoo Linux          | wuseman | GPL 3.0 |
| Hetzner            | Install gentoo with fully encrypted enviroment on a server form hetzner.de | wuseman | GPL 3.0 |
| create-bootx64.efi | setup yorur efi partition when using efibootmmgr


# HOWTO

     Edit below lines at top:
     ROOT_PARTITION=""
     BOOT_PARTITION="" 
     KEYFILE=""
     MOUNT_DIR=""

# KEYFILE

### DO NOT FORGET TO COPY YOUR KEYFILE TO A USB OR WHEREVER YOU WANNA STORE IT

    mv /root/keyfile.txt /boot/
