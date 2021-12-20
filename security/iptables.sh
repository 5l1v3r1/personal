#!/bin/bash

# - iNFO -----------------------------------------------------------------------------
#
#        Author: wuseman <wuseman@nr1.nu>
#      FileName: iptables.sh
#       Version: 1.0
#
#       Created: 2021-12-20 (03:28:18)
#      Modified: 2021-12-20 (03:37:09)
#
#           iRC: wuseman (Libera/EFnet/LinkNet) 
#       Website: https://www.nr1.nu/
#        GitHub: https://github.com/wuseman/
#
# - LiCENSE -------------------------------------------------------------------------
#
#      Copyright (C) 2021, wuseman                                     
#                                                                       
#      This program is free software; you can redistribute it and/or modify 
#      it under the terms of the GNU General Public License as published by 
#      the Free Software Foundation; either version 3 of the License, or    
#      (at your option) any later version.                                  
#                                                                       
#      This program is distributed in the hope that it will be useful,      
#      but WITHOUT ANY WARRANTY; without even the implied warranty of       
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        
#      GNU General Public License for more details.                         
#                                                                       
#      You must obey the GNU General Public License. If you will modify     
#      the file(s), you may extend this exception to your version           
#      of the file(s), but you are not obligated to do so.  If you do not   
#      wish to do so, delete this exception statement from your version.    
#      If you delete this exception statement from all source files in the  
#      program, then also delete it here.                                   
#
#      You should have received a copy of the GNU General Public License
#      along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# iNFO --------------------------------------------------------------------------
#
#      Whether you’re a novice user or a system administrator, 
#      iptables is a mandatory knowledge!
#
#      iptables is the userspace command line program used to configure 
#      the Linux 2.4.x and later packet filtering ruleset.
#      When a connection tries to establish itself on your system,
#      iptables looks for a rule in its list to match it to.
#      If it doesn’t find one, it resorts to the default action.
#
# How IPtables Works --------------------------------------------------------------
#
#       iptables uses three different chains to allow or block traffic: 
#
#            - input, output and forward
#
#            - Input    – This chain ontrol the behavior for incoming connections.
#            - Output   – This chain is used for outgoing connections.
#            - Forward  – This chain is used for incoming connections that aren’t 
#                         actually being delivered locally like routing and NATing.
#
#       By default all chains are configured to the accept rule, so during the 
#       hardening process I really recommend to begin from other side wich means
# 
#        - deny all configuration and then open only needed ports
#
# - Tips and tricks ----------------------------------------------------------------
# 
#        Read logs in realtime
#
#           tail -f /var/log/messagesgrep --color 'IP SPOOF' /var/log/messages
#
# - End of Header --------------------------------------------------------------------

### Default
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT ACCEPT

### Allow Loopback Connections
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

### Allow Established and Related Incoming Connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

### Allow Established Outgoing Connections
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Internal to External
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

### Drop Invalid Packets
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

### Block an IP Address
#iptables -A INPUT -s $IP -j DROP

### Block and IP Address and Reject
#iptables -A INPUT -s 192.168.1.10 -j REJECT

### Block Connections to a Network Interface
#iptables -A INPUT -i eth0 -s 192.168.1.10 -j DROP

### Allow All Incoming SSH
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow Incoming SSH from Specific IP address or subnet
iptables -A INPUT -p tcp -s 192.168.1.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow Outgoing SSH
iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Block Outgoing SMTP Mail
iptables -A OUTPUT -p tcp --dport 25 -j REJECT

### Allow All Incoming SMTP
#iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 143 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow All Incoming IMAP
#iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 143 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow All Incoming IMAPS
#iptables -A INPUT -p tcp --dport 993 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 993 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow All Incoming POP3
#iptables -A INPUT -p tcp --dport 110 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 110 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Allow All Incoming POP3S
#iptables -A INPUT -p tcp --dport 995 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 995 -m conntrack --ctstate ESTABLISHED -j ACCEPT

### Drop Private Network Address On Public Interface
#iptables -A INPUT -i eth1 -s 192.168.1.0/24 -j DROP
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP

### Drop Private Network Address On Public Interface
#iptables -A INPUT -i eth1 -s 192.168.1.0/24 -j DROP
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP

### Drop All Outgoing to Facebook Networks
###
##### Get Facebook AS:
#####
##### - whois -h v4.whois.cymru.com " -v $(host facebook.com | grep "has address" | cut -d " " -f4)" | tail -n1 | awk '{print $1}'
#####
##### Then drop:
#for i in $(whois -h whois.radb.net -- '-i origin AS1273' | grep "^route:" | cut -d ":" -f2 | sed -e 's/^[ \t]*//' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 | cut -d ":" -f2 | sed 's/$/;/') ; do  
#	iptables -A OUTPUT -s "$i" -j REJECT
#done


### Log and Drop Packets
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j LOG --log-prefix "IP_SPOOF A: "
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP


### Log and Drop Packets with Limited Number of Log Entries
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -m limit --limit 5/m --limit-burst 7 -j LOG --log-prefix "IP_SPOOF A: "
#iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP

### Drop or Accept Traffic From Mac Address
# iptables -A INPUT -m mac --mac-source 00:0F:EA:91:04:08 -j DROP
# iptables -A INPUT -p tcp --destination-port 22 -m mac --mac-source 00:0F:EA:91:04:07 -j ACCEPT


### Block or Allow ICMP Ping Request
#iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
#iptables -A INPUT -i eth1 -p icmp --icmp-type echo-request -j DROP

### Specifying Multiple Ports with multiport
#iptables -A INPUT -i eth0 -p tcp -m state --state NEW -m multiport --dports ssh,smtp,http,https -j ACCEPT

### Load Balancing with random* or nth*
# _ips=("172.31.250.10" "172.31.250.11" "172.31.250.12" "172.31.250.13")for ip in "${_ips[@]}" ; do  iptables -A PREROUTING -i eth0 -p tcp --dport 80 -m state --state NEW -m nth --counter 0 --every 4 --packet 0 \    -j DNAT --to-destination ${ip}:80done

### Restricting the Number of Connections with limit and iplimit*
#iptables -A FORWARD -m state --state NEW -p tcp -m multiport --dport http,https -o eth0 -i eth1 -m limit --limit 20/hour --limit-burst 5 -j ACCEPT

### Maintaining a List of recent Connections to Match Against
#iptables -A FORWARD -m recent --name portscan --rcheck --seconds 100 -j DROPiptables -A FORWARD -p tcp -i eth0 --dport 443 -m recent --name portscan --set -j DROP

### Matching Against a string* in a Packet’s Data Payload
#iptables -A FORWARD -m string --string '.com' -j DROP
#iptables -A FORWARD -m string --string '.exe' -j DROP


### Time-based Rules with time*
#iptables -A FORWARD -p tcp -m multiport --dport http,https -o eth0 -i eth1 -m time --timestart 21:30 --timestop 22:30 --days Mon,Tue,Wed,Thu,Fri -j ACCEPT

### Packet Matching Based on TTL Values
# iptables -A INPUT -s 1.2.3.4 -m ttl --ttl-lt 40 -j REJECT



on against port scanning
#iptables -N port-scanningiptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURNiptables -A port-scanning -j DROP

### SSH brute-force protection
#iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --setiptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

### Syn-flood protection
#iptables -N syn_floodiptables -A INPUT -p tcp --syn -j syn_floodiptables -A syn_flood -m limit --limit 1/s --limit-burst 3 -j RETURN
#iptables -A syn_flood -j DROPiptables -A INPUT -p icmp -m limit --limit  1/s --limit-burst 1 -j ACCEPT
#iptables -A INPUT -p icmp -m limit --limit 1/s --limit-burst 1 -j LOG --log-prefix PING-DROP:
#iptables -A INPUT -p icmp -j DROPiptables -A OUTPUT -p icmp -j ACCEPT

### Mitigating SYN Floods With SYNPROXY
#iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
#iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
#iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

### Block New Packets That Are Not SYN
#iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

### Force Fragments packets check
#iptables -A INPUT -f -j DROP

### XMAS packets
#iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

### Drop all NULL packets
#iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

### Block Uncommon MSS Values
#iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP



### Block Packets With Bogus TCP Flags
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
#iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP


### Block Packets From Private Subnets (Spoofing)
#_subnets=("224.0.0.0/3" "169.254.0.0/16" "172.16.0.0/12" "192.0.2.0/24" "192.168.0.0/16" "10.0.0.0/8" "0.0.0.0/8" "240.0.0.0/5")
#for _sub in "${_subnets[@]}" ; do  
#	iptables -t mangle -A PREROUTING -s "$_sub" -j DROP
#done
#iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP


### Saving Rules (On Debian Based systems:)
#netfilter-persistent save


