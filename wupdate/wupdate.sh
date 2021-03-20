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
####  WUPdate - Facilitate the the work with portage                       #####
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
####  WUPdate file(s), you may extend this exception to your version       #####
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

DISTRO="$(cat /etc/os-release |grep NAME|head -n 1|cut -d= -f2 |tr '[A-Z]' '[a-z]')"

if [[ $DISTRO != "gentoo" ]]; then
   echo "This is not Gentoo, please go install Gentoo to be able to run this script.."
   exit 1
fi

COLUMNS="100"

banner() {

echo -e "\e[0;35m"
echo -e "██╗    ██╗██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗";
echo -e "██║    ██║██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝";
echo -e "██║ █╗ ██║██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗   author:  wuseman";
echo -e "██║███╗██║██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝   created: 2008-03-01 ";
echo -e "╚███╔███╔╝╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗";
echo -e " ╚══╝╚══╝  ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝";
echo -e "This tool is for facilitate the work with portage for Gentoo   "
echo -e "------------------------------------------------------------\e[0m";
}
banner

if [ $EUID != "0" ]; then
echo -e "\n            You must run this tool as root\n"
exit
fi

PS3="
Option: "
options=("Sync Portage Tree"
         "Upgrade Whole System"
         "Update Packages With New Useflags"
         "List Upgradeable Packages"
         "Add Packages That Wont Be Removed By Depclean"
         "Emerge All Packages In A Category"
         "Make Configuration File(s) Up To Date"
         "Preserved Rebuild"
         "Reverse Dynamic Library Dependency"
         "Fix Static Library"
         "Uninstall Useless Packages"
         "Remove All Distfiles"
         "List All Binarys In Portage Tree"
         "Re-emerge All Ebuilds With Missing Files"
         "List All Useflags Not In Use And In Use"
         "Calculates The Total Time I'd Compiled All Packages"
         "How Many Percents Of All Avaliable Packages In Tree Are Installed"
         "Search For Modules I Have Enabled In Kernel"
         "View Emerge Log By Date In A Human Friendly Way"
         "Compare Global Useflags With A Profile Useflag"
         "Get The Size Of All Installed Packets Sorted By Size"
         "Find Installed Packages That Are Not In The Portage Tree Anymore"
         "Find Wich Useflags A Specifik Package Use With Desc"
         "Find Wich Packages Belongs To A Package"
         "Find Installed Packages That Are Not In The Portage Tree Anymore"
         "Short Information About Loaded Kernel Modules"
         "Print A List Of Installed Perl Modules"
         "Upgrade All Perl Modules Via CPAN"
         "List All Available Python Modules"
         "Figure Out If A Command Is An Alias, Function Or Shell Builtin"
         "View Emerged Packages By Time From Bottom To Top"
         "Preview All Packages That Has Been Installed From An Overlay"
         "List All Overlays One By One To Get A Good Overview"
         "Find Out How Long Time It Toke To Build A Specifik Package"
         "Find all packages with a specifk useflag"
         "Print when you ran emerge last time"
#         "Rebuild all package Belongs to a tool # emerge -1a $(for i in $(equery -C g =$(qlist -ICv net-ftp/filezilla) | head -n -3 | awk '{print $3}'); do echo =$i; done)
         "Print All Options Again"
         "Quit")

select opt in "${options[@]}"
do
     case $opt in
                 "Sync Portage Tree")
                         echo -e "\nPlease wait, syncing portage...\n"
                         eix-update -a; eix-sync -a; echo -e "\nPortage has been succesfully update..\n"
                         exit ;;

                 "Upgrade Whole System")
                        echo -e "\nPlease wait, searching for new packages to upgrade...\n"
                        emerge -vuDN --with-bdeps y --keep-going world;
                        echo -e "\nPortage packages was successfully upgraded...\n\n"
                        exit ;;

                "Update Packages With New Useflags")
                         echo -e "\nPlease wait, search for packages wich need new use flags...\n"
                         emerge --exclude openssl --exclude cryptsetup --ask --changed-use --update --deep --newuse @world; 
                         echo -e "\nPortage packages was successfully upgraded...\n\n"
                         exit ;;

                "List Upgradeable Packages")
                  eix --installed --upgrade | grep -o '\[U].*' ;;

                "Add Packages That Wont Be Removed By Depclean")
                         read -p "Package That You Want Not To Be Replaced: " noreplacepackage
                        `emerge --noreplace $noreplacepackage`
                         exit ;;

                 "Emerge All Packages In A Category")
                         read -p  "Please Specify The Category You Want Install All Packages From (example: net-ftp): " categorytoinstall
                         for p in /usr/portage/$categorytoinstall/* ; do emerge --ask $categorytoinstall/$(basename $p); done
                         exit
                         ;;
                "Make Configuration File(s) Up To Date")
                         etc-update
                         dispatch-conf; exit ;;
                "Preserved Rebuild")
                        emerge @preserved-rebuild; exit ;;
                "Fix Static Library")
                        lafilefixer --justfixit | grep -v skipping; exit ;;
                "Uninstall Useless Packages")
                         emerge --ask --depclean ;;
                "Remove All Distfiles")
                         eclean -d distfiles ; exit;;
                "List All Binarys In Portage Tree")
                         echo -e "\nPlease wait while i searching for all binary packages...\n"
                         find /usr/portage/ -type d -a -iname "*-bin" | sort | cut -d'/' -f5
                         echo ""
                         exit
                         read -p "Binary Package To Compile: (ctrl + c for quit):  " compile
                         emerge --ask $compile
                         exit
                         ;;
                "Re-emerge all ebuilds with missing files")
                    emerge -av1 `qlist --installed --nocolor | uniq | while read cp; do qlist --exact $cp | while read file; do test -e $file || { echo $cp; echo "$cp: missing $file (and maybe more)" 1>&2; break; }; done; done`
                         ;;
                "List All Useflags Not In Use And In Use")
                         emerge -epv world | grep USE | cut -d '"' -f 2 | sed 's/ /\n/g' | sed '/[(,)]/d' | sed s/'*'//g | sort | uniq > use && grep ^- use | sed s/^-// | sed ':a;N;$!ba;s/\n/ /g' > notuse && sed -i /^-/d use && sed -i ':a;N;$!ba;s/\n/ /g' use; exit 
;;

                 "Calculates The Total Time I'd Compiled All Packages")
                       echo -e "\nPlease wait while I count...\n"
                       total_compile_time="$(qlist -I | xargs qlop -t | awk '{secs += $2} END { printf("%dh:%dm:%ds\n", secs / 3600, (secs % 3600) / 60, secs % 60); }')"
                       # qlist -I | xargs qlop -t | cut -f2 -d" " | awk '{s+=$1} END {print "secs="s}' > /tmp/btime && eval $(cat /tmp/btime) && printf '%dh:%dm:%ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60)) && rm /tmp/btime
                       echo -e "You have compiled packages in a total time of \e[1;32m$total_compile_time\e[0m.\n"; exit ;;
                       # 1) Calculating total sum excluding outliers defined by the user. I want everything bigger than 5400 seconds (1h30min) to be removed from calculation:
                       #   qlist -I | xargs qlop -t | awk '{ if ($2 < 5400) secs += $2} END { printf("%dh:%dm:%ds\n", secs / 3600, (secs % 3600) / 60, secs % 60); }'
                       # 2) Discovering the problematic build times (maybe report a bug?). I want to point out which packages build times are bigger than 5400 seconds (1h30min): 
                       # qlist -I | xargs qlop -t | awk '{ if ($2 > 5400) printf("%s  %dd:%dh:%dm:%ds\n", $1, $2 / 86400, ($2 % 86400) / 3600, ($2 % 3600) / 60, $2 % 60); }'
  

                "How Many Percents Of All Avaliable Packages In Tree Are Installed")
                       percent_gentoo="$(echo $((`eix --only-names -I | wc -l` * 100 / `eix --only-names | wc -l`))%)"
                       echo -e "\nYou have installed \e[1;32m$percent_gentoo\e[0m of all avaliable packages from portage tree.\n"; exit ;;

                "Search For Modules I Have Enabled In Kernel")
                       read -p "Search For Module: " module_kernel
                       echo -e "\nYou Builded Kernel With Following Modules: \n\n$(find /lib/modules/*/ -name '*$module_kernel*' | sed 's:.*/::')"
                       exit
                 ;;

                "View Emerge Log By Date In A Human Friendly Way")
                       cat /var/log/emerge.log | awk -F: '{print strftime("%Y-%m-%d -> %X --> ", $1),$2}'
                  ;;

                "Compare Global Useflags With A Profile Useflag")
#                      emerge --info | grep ^USE | cut -d'"' -f2 > global.useflags;cat /usr/portage/profiles/targets/desktop/plasma/make.defaults | tail -n 1 | awk -F'USE="' '{print $2}' | sed 's/"//g' > plasma.useflag; grep -vf global.useflags plasma.useflag ;;
                       echo "Please check config" ;;

                "Get The Size Of All Installed Packets Sorted By Size")
                      #read -p "Want To List Them All Or A Specifik Package?
                      GREEN='\033[01;32m' WHITE='\033[0;37m'; qsize | cut -d'/' -f2 | awk -v g=$GREEN -v w=$WHITE '{print w$1,g$6}' | sort -n -k 9; exit
                  ;;

                "Find Installed Packages That Are Not In The Portage Tree Anymore")
                      for f in $(qlist -IC); do stat /usr/portage/"$f" > /dev/null; done ;;

                "Find Wich Useflags A Specifik Package Use With Desc")
                   read -p "Package For View Useflags: " useflags_equeryu
                  equery u $useflags_equeryu; exit  ;;



                "Find Wich Packages Belongs To A Package")  $useflags_equeryb
                  read -p "Packge For View Packages Belongs To "
                  equery b $useflags_equeryb; exit ;;


               "Find Installed Packages That Are Not In The Portage Tree Anymore")
                   for f in $(qlist -IC); do stat /usr/portage/"$f" > /dev/null; done ; exit;;


               "Short Information About Loaded Kernel Modules")
                    modinfo $(cut -d' ' -f1 /proc/modules) | sed '/^dep/s/$/\n/; /^file\|^desc\|^dep/!d'; exit ;;

               "Print A List Of Installed Perl Modules")
               echo -e "\nPlease wait while I searching for installed perl modules\n"
                 perl -MExtUtils::Installed -e '$inst = ExtUtils::Installed->new(); @modules = $inst->modules(); print join("\n", @modules);'
                  echo ""; exit ;;

                "Upgrade All Perl Modules Via CPAN")
                  perl -MCPAN -e 'CPAN::Shell->install(CPAN::Shell->r)'; exit ;;

               "List All Available Python Modules")
                python -c "help('modules')"; exit ;;

              "Figure Out If A Command Is An Alias, Function Or Shell Builtin")
                   read -p "Command To Check: " command
                   file "$(type -P $command)" 2>/dev/null; exit ;;

              "View Emerged Packages By Time From Bottom To Top")
                      genlop -l; exit ;; 

              "Preview All Packages That Has Been Installed From An Overlay")
                     eix -c --installed-overlay; exit ;;

               "List All Overlays One By One To Get A Good Overview")
                    emerge --info --verbose | sed -n '/^Repo/,/^ABI/p' | head -n -1; exit ;;

                "Find Out How Long Time It Toke To Build A Specifik Package")
                    read -p "Package: " packagetime
                    $packagetime="$(qlist -I | xargs qlop -t | grep $packagetime | awk '{print $2}')"; echo $packagetime / 60 | bc
                    exit ;;
                "Find all packages with a specifk useflag") q use +$1 ;;
                "Print when you ran emerge last time")
                  echo "$(cat /var/log/emerge.log |grep "emerge on")"|cut -d: -f2,3,4,5,6|tr '[A-Z]' '[a-z]' |sed 's/ started/You ran/g'|sed '/$/p'|tail -n 1
                ;;

                "Print All Options Again")
                  wupdate  ;;
                "Quit") break ;;
                *) echo -e "\nEh are you kidding? \n\nPlease choose between \e[0;1m1\e[0m and \e[0;1m32\e[0m..\n"; break ;;


       esac
done
# find drivers
# find /lib/modules/*/ -name "*snd*"




# emerge --pretend @system
# The system set, also referred to as @system in Portage development, contains the software packages required for a standard Gentoo Linux installation to run properly.
# The system packages are defined by the Gentoo profiles (through the packages files). An end-user can easily see which packages are seen as part of the system set by running the following emerge command:
#firefox="$(qlist -I | xargs qlop -t | grep firefox | awk '{print $2}')"; echo $firefox / 60 | bc

# eix --print-all-useflags|grep -o "\-.*" | grep -v _ | grep -v + # PRINT ALL NOT IUN USE
