From: "Andrew Athan" <aathan-linux-bridge-1524@cloakmail.com>
Subject: RE: [Bridge] Bridge + tc filter
Date: Thu, 8 Jul 2004 21:13:27 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJKEDHEEAA.aathan-linux-bridge-1524@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJIEDHEEAA.aathan-linux-bridge-1524@cloakmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


Just an additional blurb on this for anyone looking into it...

If ip_forward is on, the tc rules don't fire ... at least, not all the time.
I managed to get some of them to fire.  Perhaps only when the received
packets were not considered for forwarding (??? dest ip = this machine's ip,
and/or originating locally ???)  Even when transfering 500K via TCP, only
about 50-100 packets would fall into this category with ip_forwarding on.

I tested this by adding a rule

.... u32 match u8 0x00 0x00 at 0 classid 1:10

only a few packets ended up in 1:10 and the rest ended up in the top level
htb.

A.

-----Original Message-----
From: Andrew Athan [mailto:aathan-linux-bridge-1524@cloakmail.com]
Sent: Thursday, July 08, 2004 9:08 PM
To: bridge@lists.osdl.org
Subject: RE: [Bridge] Bridge + tc filter



All:

It seems that Fedora Core 2 (Linux Kernel 2.6)

echo "1" > /proc/sys/net/ipv4/ip_forward

will cause tc filter rules not to work.  I am not sure if this is unique to
cases of bridging or if turning ip forwarding on also breaks tc filter rules
on "true", non-promiscuous, non-bridged (e.g., eth0) interfaces.  I would
assume it would but don't have time to test this case right now (i.e., this
is probably not specific to bridging).

A.

-----Original Message-----
From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org]On Behalf Of Andrew Athan
Sent: Wednesday, July 07, 2004 4:42 PM
To: bridge@lists.osdl.org
Subject: [Bridge] Bridge + tc filter



Folks:

I am having trouble making linux-2.6.5-1.358 (Fedora Core 2) configured as a
bridge work.  See below.  Wether I set the tc filter's parent as 1: or 1:1
or rename 1: to 1:0 and use 1:0 etc I never get any traffic classified in
the htb.  If I set a default class, all the traffic ends up in the default
class.

This leads me to believe that the u32 classifier simply never matches,
although it probably gets the packets.  Perhaps there is a wrong offset or
mismatched struct somewhere?  I'd be glad to investigate if pointed in the
right direction, I will start by diffing cls_u32.c between linux-2.4.26 and
linux-2.6.5 (people have reported there are no issues with packet
classification + bridging under linux-2.4).

A.


# lspci
00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory
Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset
Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev
02)
01:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev
78)

#!/bin/bash
#
# qos Add traffic shaping to eth0
#
# chkconfig: 2345 86 14
# description: Add traffic shaping to eth0
#
# processname: none

WAN=br0       # external interface
LAN=eth1       # internal interface
TC=/usr/local/tc

CMD="$1"
if [ "$CMD" == "stop" ]
then
       TCOP="del"
       IPTOP="-D"
       #iptables -t mangle -D POSTROUTING -o $WAN -j MYSHAPER-OUT 2>
/dev/null > /dev/null
       #iptables -t mangle -F MYSHAPER-OUT 2> /dev/null > /dev/null
       #iptables -t mangle -X MYSHAPER-OUT 2> /dev/null > /dev/null
       $TC qdisc del dev ${WAN} root handle 1: htb
fi

if [ "$CMD" == "start" ]
then
    brctl addbr br0
    brctl addif br0 eth0
    brctl addif br0 eth1
    ifconfig eth0 0.0.0.0
    ifconfig eth1 0.0.0.0
    ifconfig br0 up
    ifconfig br0 10.100.82.252 netmask 255.255.255.0 broadcast 10.100.82.255
up
    echo "1" > /proc/sys/net/ipv4/ip_forward
    route add default gw 10.100.82.1

    sysctl -w net.core.rmem_max=8388608
    sysctl -w net.core.wmem_max=8388608
    sysctl -w net.core.rmem_default=65536
    sysctl -w net.core.wmem_default=65536
    sysctl -w net.ipv4.tcp_rmem='4096 87380 8388608'
    sysctl -w net.ipv4.tcp_wmem='4096 65536 8388608'
    sysctl -w net.ipv4.tcp_mem='8388608 8388608 8388608'
    sysctl -w net.ipv4.route.flush=1

    TCOP="add"
    IPTOP="-A"
    #iptables -t mangle -N MYSHAPER-OUT
    ##iptables -t mangle -I POSTROUTING -d $LIMITNETSPEC -j MYSHAPER-OUT
    #iptables -t mangle -I POSTROUTING -o $WAN -j MYSHAPER-OUT


    #          +---------+
    #          | root 1: |
    #          +---------+
    #               |
    # +----------------------------+
    # |         class 1:1          |
    # +----------------------------+
    #   |           |           |
    # +----+      +----+      +----+
    # |1:10|      |1:20|      |1:30|
    # +----+      +----+      +----+
    #               |
    #      +--------+--------+
    #      |        |        |
    #   +-----+  +-----+  +-----+
    #   |1:100|  |1:101|  |1:102|
    #   +-----+  +-----+  +-----+

    # 1:10 is the class for VOIP traffic, ACKs, SYNs, etc (pfifo qdisc)
    # 1:20 is for bulk traffic (htb, leaves use sfq)
    # 1:30 is the class that interactive traffic which must never get
snuffed out completely goes to (sfq)

    # 1:20 is further split up into different kinds of bulk traffic: web,
mail and
    # everything else.  1:100-102 fight amongst themselves for their slice
of excess
    # bandwidth, and in turn 1:10,20 and 30 then fight for any excess above
their
    # minimum rates.

    # ceil is 90% of max rate (768kbps)
    # rate is 80% of max rate
    # we don't let it go to 100% because we don't want the WAN provider to
buffer
    CEIL=4500kbit
    RATE1=1000kbit
    RATE2=3000kbit
    RATE3=500kbit
    APPRATE1=1500kbit
    APPRATE2=750kbit
    APPRATE3=250kbit

    $TC qdisc ${TCOP} dev ${WAN} root handle 1: htb
    $TC class ${TCOP} dev ${WAN} parent 1:   classid 1:1 htb rate ${CEIL}
ceil ${CEIL}

    $TC class ${TCOP} dev ${WAN} parent 1:1  classid 1:10 htb rate ${RATE1}
ceil ${CEIL} prio 1
    $TC class ${TCOP} dev ${WAN} parent 1:1  classid 1:20 htb rate ${RATE2}
ceil ${CEIL} prio 2
    $TC class ${TCOP} dev ${WAN} parent 1:1  classid 1:30 htb rate ${RATE3}
ceil ${CEIL} prio 3

    $TC class ${TCOP} dev ${WAN} parent 1:20 classid 1:100 htb rate
${APPRATE1} ceil ${CEIL} prio 4
    $TC class ${TCOP} dev ${WAN} parent 1:20 classid 1:101 htb rate
${APPRATE2} ceil ${CEIL} prio 5
    $TC class ${TCOP} dev ${WAN} parent 1:20 classid 1:102 htb rate
${APPRATE3} ceil ${CEIL} prio 6

    $TC qdisc ${TCOP} dev ${WAN} parent 1:10  handle 10:  pfifo
    $TC qdisc ${TCOP} dev ${WAN} parent 1:100 handle 100: sfq perturb 10
    $TC qdisc ${TCOP} dev ${WAN} parent 1:101 handle 101: sfq perturb 10
    $TC qdisc ${TCOP} dev ${WAN} parent 1:102 handle 102: sfq perturb 10
    $TC qdisc ${TCOP} dev ${WAN} parent 1:30  handle 30:  sfq perturb 10


#---------------------------------------------------------------------------

    #phones
    $TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 match ip
dst 10.50.30.0/24 flowid 1:10

    ##trading
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dst 207.251.101.0/24 flowid 1:100
    ##non-critical
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dst 10.50.20.0/24 flowid 1:101
    #
    #
    ##ACK
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #      match ip protocol 0x6 0xff \
    #      match u8 0x05 0x0f at 0 \
    #      match u8 0x10 0xff at 33 \
    #      match u16 0x0000 0xffc0 at 2 \
    #      flowid 1:10
    #
    ##SYN-ACK
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #      match ip protocol 0x6 0xff \
    #      match u8 0x05 0x0f at 0 \
    #      match u8 0x12 0x12 at 33 \
    #      match u16 0x0000 0xffc0 at 2 \
    #      flowid 1:10
    #
    ##FIN
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #      match ip protocol 0x6 0xff \
    #      match u8 0x05 0x0f at 0 \
    #      match u8 0x01 0x01 at 33 \
    #      match u16 0x0000 0xffc0 at 2 \
    #      flowid 1:10
    #
    ##RST
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #      match ip protocol 0x6 0xff \
    #      match u8 0x05 0x0f at 0 \
    #      match u8 0x04 0x04 at 33 \
    #      match u16 0x0000 0xffc0 at 2 \
    #      flowid 1:10
    #
    ## ICMP
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #   match ip protocol 1 0xff flowid 1:10
    #
    ## DNS
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 1 u32 \
    #      match ip protocol 0x11 0xff \
    #      match ip dport 53 0xffff \
    #      flowid 1:100
    #
    ##telnet and AOL
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
sport 22 0xffff flowid 1:30
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dport 22 0xffff flowid 1:30
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
sport 5190 0xffff flowid 1:30
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dport 5190 0xffff flowid 1:30
    #
    ##web
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
sport 80 0xffff flowid 1:102
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dport 80 0xffff flowid 1:102
    ##ftp
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
sport 21 0xffff flowid 1:102
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dport 21 0xffff flowid 1:102
    ##tftp
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
sport 69 0xffff flowid 1:102
    #$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match ip
dport 69 0xffff flowid 1:102
    ##dhcp?
    ##$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match
ip dst 0.0.0.0/0 flowid 1:10
    ##$TC filter ${TCOP} dev ${WAN} protocol ip parent 1: prio 1 u32 match
ip dst 0.0.0.0/0 flowid 1:10
    #
    #$TC filter ${TCOP} dev ${WAN} parent 1: prio 2 protocol ip handle 10 fw
flowid 1:10
    #$TC filter ${TCOP} dev ${WAN} parent 1: prio 2 protocol ip handle 100
fw flowid 1:100
    #$TC filter ${TCOP} dev ${WAN} parent 1: prio 2 protocol ip handle 101
fw flowid 1:101
    #$TC filter ${TCOP} dev ${WAN} parent 1: prio 2 protocol ip handle 102
fw flowid 1:102
    #$TC filter ${TCOP} dev ${WAN} parent 1: prio 2 protocol ip handle 30 fw
flowid 1:30
    #
    ##TOS min delay
    #$TC filter ${TCOP} dev ${WAN} parent 1: protocol ip prio 3 u32 \
    #      match ip tos 0x10 0xff  \
    #      flowid 1:30
    #
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --dport 5190 -j
MARK --set-mark 30   # aol instant messenger
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --dport ssh -j
MARK --set-mark 30    # secure shell
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --sport ssh -j
MARK --set-mark 30    # secure shell
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --dport x11 -j
MARK --set-mark 30    # secure shell
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --sport 0:1024 -j
MARK --set-mark 101 # Default for low port traffic
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --dport 0:1024 -j
MARK --set-mark 101 # ""
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --sport http -j
MARK --set-mark 102   # Web
    ##iptables -t mangle -A MYSHAPER-OUT -p tcp --sport https -j
MARK --set-mark 102   # Web
    ##iptables -t mangle -A MYSHAPER-OUT -m mark --mark 0 -j MARK --set-mark
102      # redundant- mark any unmarked packets as 26 (low prio)
fi

if [ "$CMD" = "status" ]
then
        echo "[qdisc-$WAN]"
        $TC -s qdisc show dev $WAN
        echo "[class-$WAN]"
        $TC -s class show dev $WAN
        echo "[filter-$WAN]"
        $TC -s filter show dev $WAN
        echo "[iptables]"
        iptables -t mangle -L MYSHAPER-OUT -v -x 2> /dev/null
        exit
fi


_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/bridge



