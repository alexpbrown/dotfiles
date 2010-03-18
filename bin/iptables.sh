#! /bin/bash

# ----------------------------------------------------------------------------
#
# script to set the iptables firewall
#
#	http://wiki.archlinux.org/index.php/Simple_stateful_firewall_HOWTO
#
# :: blocks bruteforce attacks (useful for securing SSH servers)
#
# ----------------------------------------------------------------------------


# allow local connections (disable for testing purposes only)
allow_lo="yes";


# ----------------------------------------------------------------------------
# interfaces (confirm)


localnet="lo";
internet="eth0";	# the ending '+' is a wildcard for matching patterns
# ----------------------------------------------------------------------------




# stop the iptables
/etc/rc.d/iptables stop


#  reset iptables rules
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X


# create the chains
iptables -N open
iptables -N interfaces
iptables -N BRUTEGUARD


# >> INPUT chain
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -j interfaces
iptables -A INPUT -j open
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -P INPUT DROP


# set the default policies for OUTPUT and FORWARD chains
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP


# ----------------------------------------------------------------------------
# >> interfaces chain :: allow all connections from these interfaces
#
[[ "${allow_lo}" == "yes" ]] && iptables -A interfaces -i ${localnet} -j ACCEPT


# ----------------------------------------------------------------------------
# the 'open' chain :: rules for accept incoming external connections (daemons)
#
#iptables -A open -p tcp -m tcp --dport 80 -j ACCEPT	# apache/http
#iptables -A open -p tcp -m tcp --dport 113 -j ACCEPT	# oidentd/auth


   # accept ssh and avoid bruteforcings with BRUTEGUARD chain
iptables -A open -p tcp -m tcp --dport 2222 -j BRUTEGUARD
iptables -A open -p tcp -m tcp --dport 2222 -m state --state  NEW,RELATED,ESTABLISHED -j ACCEPT


 # the BRUTEGUARD chain :: block excessive connections (and bruteforcings)
iptables -A BRUTEGUARD -m recent --set --name BF
iptables -A BRUTEGUARD -m recent --update --seconds 1800 --hitcount 8 --name BF -j LOG \
                                 --log-level info --log-prefix "[BRUTEFORCE ATTEMPT] "
iptables -A BRUTEGUARD -m recent --update --seconds 1800 --hitcount 8 --name BF -j DROP
 

# ----------------------------------------------------------------------------
# Protection against common attacks
#
 

 # allow only SYN packets
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
 # force fragments packets check
iptables -A INPUT -f -j DROP
 # drop incoming malformed XMAS packets
iptables  -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
 # drop all NULL packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP


 

# ----------------------------------------------------------------------------
# Hide the computer						# (optional) #
#


 # block reserved private networks incoming from the internet
iptables -I INPUT -i ${internet} -s 10.0.0.0/8 -j DROP
iptables -I INPUT -i ${internet} -s 172.16.0.0/12 -j DROP
iptables -I INPUT -i ${internet} -s 192.168.0.0/16 -j DROP
iptables -I INPUT -i ${internet} -s 127.0.0.0/8 -j DROP


 # block PING request
iptables -A INPUT -i ${internet} -p icmp --icmp-type echo-request -j DROP


 # ICMP type match blocking
iptables -I INPUT -p icmp --icmp-type redirect -j DROP
iptables -I INPUT -p icmp --icmp-type router-advertisement -j DROP
iptables -I INPUT -p icmp --icmp-type router-solicitation -j DROP
iptables -I INPUT -p icmp --icmp-type address-mask-request -j DROP
iptables -I INPUT -p icmp --icmp-type address-mask-reply -j DROP


# ----------------------------------------------------------------------------
# the end

iptables -A open -p tcp --dport 1412 -j ACCEPT

/etc/rc.d/iptables save


/etc/rc.d/iptables start


# print the iptables
iptables -L;




exit 0;

