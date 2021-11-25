# Hewlett-Packard Hacking

I spent days and nights last years for hacking all kind of elitebooks and powerbooks, here is everything I stored that could be useful if I got alzheimers or something

#### All kind of stuff

# This is my messy helpme for things to crack hp secure boot + bios password if you forgot, lost or just don't remember the password - SOrry for the mess but this is a reminder to myself and how to hack hp sure start and uefi passwords and get access to bios so I never forget :) :)
# Since HP wont give me access to my forgotton password to and offer a smc.bin file I spent days and nights for hack the hp sure start and bypass the bios password :) HP sucks.
# Below are a lot of stuff  I went through to succeed, toke months to go through all those stuff.

---------------------------------------------------------------------------------------------------
Instructions on CREATING the  MPM-Unlocking SMC.BIN USB Drive (this is from 2015, wont work on new laptops)
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
HP Developers has access to smc.bin tool from below URL but please notice that hacking accounts is illegal and all users are responsible for this, I just share the link to their over their own actions
https://hp.sharepoint.com/teams/cmitbiosrellab/Lists/SMC%20REQUEST/default.aspx
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Since we using linux we add this at top:
# HP FLASH and REPLICATED Setup Utilites for Linux
https://ftp.hp.com/pub/caps-softpaq/cmit/HP_LinuxTools.html
https://ftp.hp.com/pub/softpaq/sp111001-111500/sp111455.tgz
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
README for HP_LinuxTools:
https://ftp.hp.com/pub/caps-softpaq/cmit/whitepapers/HP_Linux_Tools_Users_Guide.pdf
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Worth to read from vinafix:
---------------------------------------------------------------------------------------------------
https://vinafix.com/threads/smc-bin-file-generator.31638/

---------------------------------------------------------------------------------------------------
HP's blog about everything developers need to know and updates for newer version of their tool:
https://developers.hp.com/community/blog/hp-client-management
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
My Digital Life Forum for HP stuff
https://forums.mydigitallife.net/threads/hp-probook-elitebook-bios-password-reset-utility.49497/page-3#post-860979
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
HP Client Management Script Library 1.5 released:
https://developers.hp.com/hp-client-management/blog/hp-client-management-script-library-15-released
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
### Understanding HP BIOS Settings and ALL settings you can use, from and descriptions for all commands can be found on -> https://developers.hp.com/hp-client-management/doc/client-management-script-library

---------------------------------------------------------------------------------------------------
### PowerShell commands from url above
Clear‐HPBIOSPowerOnPassword
Clear‐HPBIOSSetupPassword
Get‐HPBIOSAuthor
Get‐HPBIOSPowerOnPasswordIsSet
Get‐HPBIOSSetting
Get‐HPBIOSSettingValue
Get‐HPBIOSSettingsList
Get‐HPBIOSSetupPasswordIsSet
Get‐HPBIOSUUID
Get‐HPBIOSUpdates
Get‐HPBIOSVersion
Get‐HPDeviceAssetTag
Get‐HPDeviceBootInformation
Get‐HPDeviceDetails
Get‐HPDeviceManufacturer
Get‐HPDeviceModel
Get‐HPDevicePartNumber
Get‐HPDeviceProductID
Get‐HPDeviceSerialNumber
Get‐HPDeviceUUID
Get‐HPDeviceUptime
Set‐HPBIOSPowerOnPassword
Set‐HPBIOSSettingDefaults
Set‐HPBIOSSettingValue
Set‐HPBIOSSettingValuesFromFile
Set‐HPBIOSSetupPassword

# Firmware commands
Clear‐HPFirmwareBootLogo
Clear‐HPSureAdminKMSAccessToken
Convert‐HPSureAdminCertToQRCode
Get‐HPFirmwareAuditLog
Get‐HPFirmwareBootLogoIsActive
Get‐HPSecurePlatformState
Get‐HPSureAdminState
Get‐HPSureRecoverReimagingDeviceDetails
Get‐HPSureRecoverState
Get‐HPSureViewState
Invoke‐HPSureRecoverTriggerUpdate
New‐HPSecurePlatformDeprovisioningPayload
New‐HPSecurePlatformEndorsementKeyProvisioningPayload
New‐HPSecurePlatformSigningKeyProvisioningPayload
New‐HPSureAdminBIOSSettingValuePayload
New‐HPSureAdminBIOSSettingsListPayload
New‐HPSureAdminDisablePayload
New‐HPSureAdminEnablePayload
New‐HPSureAdminFirmwareUpdatePayload
New‐HPSureAdminLocalAccessKeyProvisioningPayload
New‐HPSureAdminSettingDefaultsPayload
New‐HPSureRecoverConfigurationPayload
New‐HPSureRecoverDeprovisionPayload
New‐HPSureRecoverImageConfigurationPayload
New‐HPSureRecoverSchedulePayload
New‐HPSureRecoverTriggerRecoveryPayload
Send‐HPSureAdminLocalAccessKeyToKMS
Set‐HPFirmwareBootLogo
Set‐HPSecurePlatformPayload
Set‐HPSureViewState
Test‐HPSureViewIsSupported
Update‐HPFirmware
Write‐HPFirmwarePasswordFile

# Softpaq Management
Clear‐SoftpaqCache
Get‐Softpaq
Get‐SoftpaqList
Get‐SoftpaqMetadata
Get‐SoftpaqMetadataFile
Install‐HPImageAssistant
Out‐SoftpaqField

# Softpaq Management
Clear‐SoftpaqCache
Get‐Softpaq
Get‐SoftpaqList
Get‐SoftpaqMetadata
Get‐SoftpaqMetadataFile
Install‐HPImageAssistant
Out‐SoftpaqField

# Retail
Get‐HPRetailSmartDockConfiguration
Set‐HPRetailSmartDockConfiguration

# Sinks
Get‐HPCMSLLogFormat
Register‐EventLogSink
Send‐ToEventLog
Send‐ToSyslog
Set‐HPCMSLLogFormat
Unregister‐EventLogSink
Write‐LogError
Write‐LogInfo
Write‐LogWarning
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Understanding HPBIOS-Settings
https://developers.hp.com/hp-client-management/doc/Understanding-HP-BIOS-Settings
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
### BiosConfigUtility.exe
https://ftp.hp.com/pub/caps-softpaq/cmit/HP_BCU.html
https://whp-aus2.cold.extweb.hp.com/pub/caps-softpaq/cmit/whitepapers/BIOS_Configuration_Utility_User_Guide.pdf
https://support.hp.com/us-en/product/hp-probook-4540s-notebook-pc/5229455/document/c03161127/
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
### Random STUFF from HP
---------------------------------------------------------------------------------------------------
### Driver Packs
https://www8.hp.com/us/en/ads/clientmanagement/drivers-pack.html

### HP Downloads
https://www8.hp.com/us/en/ads/clientmanagement/download.html

### Client Management Solutions
https://developers.hp.com/forums/client-management-solutions

### HP ImageDiags
https://ftp.hp.com/pub/caps-softpaq/cmit/support/HP_ImageDiags.html

### HP Manageability Integration Kit (Microsoft System Center Configuration Manager)
https://ftp.hp.com/pub/caps-softpaq/cmit/HPMIK.html

### HP Image Assistant (HPIA)
https://ftp.hp.com/pub/caps-softpaq/cmit/HPIA.html

### BIOS and Device functionality
https://developers.hp.com/hp-client-management/doc/Bios-and-Device

### SoftPaq functionality
https://developers.hp.com/hp-client-management/doc/SoftPaq-Management

### SoftPaq Repository functionality
https://developers.hp.com/hp-client-management/doc/SoftPaq-Repository

### Firmware functionality
https://developers.hp.com/hp-client-management/doc/Firmware

### Retail functionality
https://developers.hp.com/hp-client-management/doc/Retail

### Consent functionality
https://developers.hp.com/hp-client-management/doc/Consent

















---------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------
### Random stuff for bios reading and so on
dmidecode
ifdtool - https://github.com/coreboot/coreboot/tree/master/util/ifdtool
me_cleaner
https://github.com/LongSoft/UEFITool
https://github.com/corna/me_cleaner/wiki/How-to-apply-me_cleaner
intelmetool (https://github.com/zamaudio/intelmetool)
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
# Forums for bios and other stuff regarding this on elitebook and bios/uefi stuff
https://www.win-raid.com/
https://vinafix.com/
https://www.badcaps.net/
https://vinafix.com/tags/bios-hp-542/
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Using ch341 (yay, I got one so saving those here)
https://github.com/corna/me_cleaner/issues/98
https://thiccpad.blogspot.com/2018/12/neuter-intel-me-with-mecleaner.html
https://www.win-raid.com/t5811f13-HP-Elitebook-G-BIOS-problem.html
https://wiki.gentoo.org/wiki/User:Sakaki/Sakaki%27s_EFI_Install_Guide/Disabling_the_Intel_Management_Engine
https://github.com/corna/me_cleaner/issues/98
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
# Eeasy UEFI bios modding (uefi bios updater)
https://www.win-raid.com/t154f16-Tool-Guide-News-quot-UEFI-BIOS-Updater-quot-UBU.html
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
# Random Commands
biosdecode
dmidecode -t bios
sudo dmidecode --type 0
flashrom -r <outputfile>
dd if=/dev/mem bs=1k skip=768  count=256 2>/dev/null | strings -n 8
grep ROM /proc/iomem

# Secureboot from Ubuntu community
https://wiki.ubuntu.com/UEFI/SecureBoot
https://help.ubuntu.com/community/UEFI
https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface#Secure_boot

sudo update-secureboot-policy --enroll-key
sudo update-secureboot-policy --new-key

---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Random references
https://forums.mydigitallife.net/threads/13194-Tool-to-Insert-Replace-SLIC-in-Phoenix-Insyde-Dell-EFI-BIOSes (DEAD LINK)
https://www.insanelymac.com/forum/topic/285444-uefipatch-uefi-patching-utility/
https://www.insanelymac.com/forum/topic/299711-ozmtool-an-ozmosis-toolbox/
https://vinafix.com/forums/bios-laptop.16/
https://thiccpad.blogspot.com/2018/12/neuter-intel-me-with-mecleaner.html
https://github.com/coreboot/coreboot/tree/master/util/ifdtool
https://newsroom.intel.com/news/important-security-information-intel-manageability-firmware/
https://www.blackhat.com/eu-17/briefings/schedule/#how-to-hack-a-turned-off-computer-or-running-unsigned-code-in-intel-management-engine-8668
https://www.bleepingcomputer.com/news/hardware/intel-fixes-9-year-old-cpu-flaw-that-allows-remote-code-execution/
http://blog.ptsecurity.com/2017/08/disabling-intel-me.html
https://news.ycombinator.com/item?id=15444607
https://www.bleepingcomputer.com/news/hardware/researchers-find-a-way-to-disable-much-hated-intel-me-component-courtesy-of-the-nsa/
http://www.zdnet.com/article/researchers-say-intels-management-engine-feature-can-be-switched-off/
https://wiki.ubuntu.com/UEFI/SecureBoot/DKMS
https://www.coreboot.org/QEMU
https://www.coreboot.org/Build_HOWTO
https://www.welivesecurity.com/2018/09/27/lojax-first-uefi-rootkit-found-wild-courtesy-sednit-group/
https://www.eehelp.com/question/how-to-reset-the-hp-elitebook-8440p-bios-admin-password/
https://h30434.www3.hp.com/t5/Business-Notebooks/How-to-get-SMC-bin-file/td-p/6409806 (THIS IS NOT POSSIBLE ANYMORE, FUCK HP)




---------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------
# Good pages, read em all your newbie to understand what you are doing, I did. :)
---------------------------------------------------------------------------------------------------
http://breakstuffmajorly.blogspot.com/2012/04/remove-bios-password-on-probook-6560b.html ( It was this post that made me curious about all this :)

https://kuzb44091.blogspot.com/2020/03/smcbin-file-hp-download.html
http://manpages.ubuntu.com/manpages/eoan/man1/UEFITool.1.html
http://lxr.linux.no/linux+v3.13.5/arch/x86/include/asm/cpufeature.h
http://manpages.ubuntu.com/manpages/bionic/man8/biosdecode.8.html
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap
https://seabios.org/SeaBIOS
https://coreboot.org/
https://github.com/flashrom/flashrom
https://int10h.org/oldschool-pc-fonts/
https://github.com/rewtnull/amigafonts
https://github.com/Swordfish90/cool-retro-term
https://github.com/fcambus/bdf2sfd
https://github.com/alexmyczko/ree
https://www.cyberciti.biz/tips/querying-dumping-bios-from-linux-command-prompt.html
https://unix.stackexchange.com/questions/126132/how-to-dump-bios-data-to-a-file
https://github.com/corna/me_cleaner/issues/98
https://www.win-raid.com/t5811f13-HP-Elitebook-G-BIOS-problem.html
https://infosecwriteups.com/how-i-removed-my-forgotten-bios-administrator-password-8dca33844023?gi=af3abf636906
https://www.instructables.com/Bypass-BIOS-Boot-or-OS-Login-to-%22most%22-any-compute/
https://www.technibble.com/how-to-bypass-or-remove-a-bios-password/
https://www.bleepingcomputer.com/forums/t/617188/resetting-the-bios-supervisor-password-with-debug-command/
https://www.computerweekly.com/news/2240062077/BIOS-password-hacking
https://www.linux.org/threads/acpi-bios-error-and-suspend-dont-work-on-hp-elitebook-g7.30870/
https://www.happyassassin.net/posts/2014/01/25/uefi-boot-how-does-that-actually-work-then/
http://www.rodsbooks.com/linux-uefi/
http://www.rodsbooks.com/efi-bootloaders/secureboot.html#disable
https://www.bloovis.com/2020/12/11/hp-stream-uefi-boot-order.html
https://www.linux.org/threads/installing-linux-with-secure-boot-and-friends.29454/
https://askubuntu.com/questions/666631/how-to-get-grub-to-be-the-default-bootloader-instead-of-windows-boot-manager-on
https://vulcan.io/blog/boothole-vulnerability-cve-2020-10713/
https://www.blackhat.com/html/press.html
https://www.darkreading.com/vulnerabilities---threats/how-hackers-blend-attack-methods-to-bypass-mfa/a/d-id/1339370
https://www.repairwin.com/how-to-reset-bios-password-hp-probook-elitebook-pavilion-laptop/
https://forums.mydigitallife.net/threads/hp-elitebook-840-g3-bios-pw-bitlocker-encrypted.76047/
https://news.ycombinator.com/item?id=22410450




---------------------------------------------------------------------------------------------------
# PDFS:
http://legbacore.com/Research_files/HowManyMillionBIOSWouldYouLikeToInfect_Full2.pdf
https://hal.inria.fr/tel-02417644/document
http://kth.diva-portal.org/smash/get/diva2:1464454/FULLTEXT01.pdf
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# Stuff regarding OSX
https://github.com/kinoute/Hack-HP-EliteBook-850-G5---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
# Random commands from a linux enviroment:
ls /dev | grep mei
lspci | grep -i communi
cat /proc/bus/pci/devices
sudo dmesg | grep Error
---------------------------------------------------------------------------------------------------



-- me_cleaner_windows ---------------------------------------------------------------------------
### me_cleaner on windows, some guide i found in cyberspace:
# Short guide for Windows:
- Install Python and download me_cleaner
- Dump your BIOS
- Copy your dumped BIOS and me_cleaner.py in a folder of your choice

### Run one of the following command:
- To just set the MeAltDisable bit: me_cleaner.py -O cleaned_bios.bin -s dumped_bios.bin
- To clean the ME: me_cleaner.py -O cleaned_bios.bin dumped_bios.bin
- To clean the ME and set the MeAltDisable bit: me_cleaner.py -O cleaned_bios.bin -S dumped_bios.bin
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
# News regarding uefi and secureboot and rootkits and such shit

https://www.bleepingcomputer.com/news/security/trickbots-new-trickboot-module-infects-your-uefi-firmware/
https://www.bleepingcomputer.com/news/security/mosaicregressor-second-ever-uefi-rootkit-found-in-the-wild/
https://www.bleepingcomputer.com/news/security/apt28-uses-lojax-first-uefi-rootkit-seen-in-the-wild/
https://www.bleepingcomputer.com/news/security/intel-spi-flash-flaw-lets-attackers-alter-or-delete-bios-uefi-firmware/
https://www.bleepingcomputer.com/news/security/researchers-detail-two-new-attacks-on-tpm-chips/
https://www.bleepingcomputer.com/news/hardware/intel-plans-to-end-legacy-bios-support-by-2020/
https://www.bleepingcomputer.com/news/security/some-motherboards-plagued-by-bios-firmware-implementation-flaws/
https://www.bleepingcomputer.com/news/apple/many-up-to-date-macs-not-getting-efi-firmware-updates/ (OSX sucks)
https://www.bleepingcomputer.com/news/government/new-wikileaks-dump-provides-details-on-cias-mac-and-iphone-hacking-tools/
https://www.bleepingcomputer.com/news/security/gigabyte-firmware-flaws-allow-the-installation-of-uefi-ransomware/
https://www.bleepingcomputer.com/news/security/intel-security-mcafee-releases-rootkit-scanner-following-vault-7-cia-leak/
https://www.bleepingcomputer.com/news/security/-300-device-can-steal-mac-filevault2-passwords/
https://howtofix.guide/thunderbolt-pcs-can-be-hacked-in-less-than-5-minutes/
https://www.hp.com/us-en/shop/tech-takes/you-are-vulnerable-to-visual-hacking
https://threatpost.com/dell-hp-memory-access-bugskernel-privileges/152369/
https://www.techtimes.com/articles/249552/20200511/hacker-new-thunderspy-bug-how-to-check-if-your-pc-can-be-hacked-tips-on-how-to-avoid-getting-breached.htm
https://www.securityweek.com/devices-still-vulnerable-dma-attacks-despite-protections
https://www.bleepingcomputer.com/news/security/-300-device-can-steal-mac-filevault2-passwords/


---------------------------------------------------------------------------------------------------
Different videos regarding hacking and bios stuff:
---------------------------------------------------------------------------------------------------
https://www.youtube.com/watch?v=n_3eIFMR46Y&feature=emb_title
https://www.youtube.com/watch?v=pC-zgE3B28Q&feature=emb_title

# TFTPBOOT (very old, from 2010)
https://scarygliders.net/2010/02/23/hacking-around-the-japanese-buffalo-wzr-hp-g300n/



One day you will succeed in what you are trying to do, never ever give up and yo're will succeed. Happy hacking // wuseman
