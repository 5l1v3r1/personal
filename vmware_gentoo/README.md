# vmware-gentoo

![Screenshot](https://wuseman.nr1.nu/archive/gentoo_stuff/vmware_screenshot.png)

# Nowadays (Releases from ~2020>)
This has been a really tricky thing to get installed on Gentoo back in the days but last year it have become really easy

Install the vmware bundle file by ./vmware-vxxx.bundle

Once done, setup everything and when you will power up the guest machine it probably will cry over for vmmon and vmnet is not enabled in kernel config.
Since recently ou wont find any settings in /usr/src/linux/.config for this, instead, execute below command for get everything installed:

	vmware-modconfig --console --install-all

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
### This is how I got vmware-workstation working on v12.5.9

Once you installed everything and things just hassles for you about modules and shit, it toke ages to figure out below: 

```sh
VMWARE_VERSION=workstation-12.5.9
TMP_FOLDER=/tmp/patch-vmware
rm -fdr $TMP_FOLDER
mkdir -p $TMP_FOLDER
cd $TMP_FOLDER
git clone https://github.com/mkubecek/vmware-host-modules.git
cd $TMP_FOLDER/vmware-host-modules
git checkout $VMWARE_VERSION
git fetch
make
sudo make install
sudo rm /usr/lib/vmware/lib/libz.so.1/libz.so.1
sudo ln -s /lib/x86_64-linux-gnu/libz.so.1 
/usr/lib/vmware/lib/libz.so.1/libz.so.1
```

You will now have a working vmware setup, but ey. Use the latest versions to avoid all the trouble with the above shit.
