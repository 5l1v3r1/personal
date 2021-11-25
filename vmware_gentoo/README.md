# vmware-gentoo

![Screenshot](https://wuseman.nr1.nu/archive/gentoo_stuff/vmware_screenshot.png)

# Nowadays (Releases from ~2020>)
This has been a really tricky thing to get installed on Gentoo back in the days but last year it have become really easy

Install the vmware bundle file by ./vmware-vxxx.bundle

Once done, setup everything and when you will power up the guest machine it probably will cry over of vmmon and vmnet is missed in kernel, you wont find any settings in /usr/src/linux/.config for this, instead, execute:

	vmware-modconfig --console --install-all§	

Wait until its done and you will have a working vmware workstation setup on your Gentoo Machine:

Starting VMware services:
   Virtual machine monitor                                             done
   Virtual machine communication interface                             done
   VM communication interface socket family                            done
   Virtual ethernet                                                    done
   VMware Authentication Daemon                                        done
   Shared Memory Available                                             done

Full output from the command above is found @ https://pastebin.com/raw/vPfv7u3s

Enjoy vmware, it pwnz with a Legit License! :) 


# Older Releases (Releases from <~2020)

N/A, will add this part later
