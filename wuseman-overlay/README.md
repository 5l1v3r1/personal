# README

   This is my personal Gentoo overlay for packages not added in portage tree and ebuilds I have not been able to find anywhere else. All ebuilds have been commited by 'repoman -dx commit'..

# HOWTO

    Create wuseman-overlay.conf into /etc/portage/repos.conf/

    cat << "EOF" > /etc/portage/repos.conf/wuseman-overlay.conf
    [wuseman-overlay]
    # Simple example 'overlaid' ebuild repository
    location = /usr/local/portage/wuseman-overlay
    priority = 0
    auto-sync = no
    #masters-gentoo
    EOF
    mkdir -p /usr/local/portage/{wuseman-overlay,metadata}
    echo "masters = gentoo" > /usr/local/portage/metadata/layout.conf
    echo 'LOCAL_PORTDIR="/usr/local/portage"' >> /etc/portage/make.conf
    cd /usr/local/portage
    git clone https://github.com/wuseman/wuseman-overlay
    which eix &> /dev/null; [[ $? -eq 0 ]] && eix-sync; eix-update || emerge --sync


# References

    https://github.com/gentoo/gentoo
    https://github.com/pentoo/pentoo-overlay
    

# CONTACT

     If you have problems, questions, ideas or suggestions please contact
     us by posting to wuseman@nr1.nu

# WEB SITE

     Visit our homepage for the latest info and updated tools

     https://nr1.nu & https://github.com/wuseman/

### END!

