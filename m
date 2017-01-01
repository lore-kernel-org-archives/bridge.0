Return-Path: <cakturk@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:subject:message-id:mime-version:content-disposition
	:user-agent; bh=eBpIUNs6HbvQ8UzY5KTApmcQfEBl7irz+19BG4/iMWE=;
	b=N3/x9GY+sVfuVMKZ6XJ9qT4+gGtY1A4EQ4fK0i8CC3gjimpCR6Lm2l7dLSswk0ccCx
	+E5F09GA0G2C4cEt6XTHpk1EFJlRMiS/I4MB4i4HC279BSKfA8dKOK1Az+VJzqqRMabe
	xpz+n8PbI8r51Y0LcMOP/jo95n9/PmUSWVtpQZYn0BllzFV9bxx2dCKsmyIWShx3wXoR
	7Rovs3ZQrexQxDdATNEULD5Wmxp+JhHyxIv6DfTfeP+qlFOq6dOP19Qq2L6WKL4pt1AC
	8WInlACYhvYMC+4PVdbv43qAUghMY0Wj/LMMUOrLupTdXivn/xUjScZLaAORIsj6WDgw
	76rg==
Date: Sun, 1 Jan 2017 18:37:49 +0300
From: Cihangir Akturk <cakturk@gmail.com>
Message-ID: <20170101153749.GA1639@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Bridge forwards ARP packets but not forwards IP datagrams
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

First of all, I would like to wish you a happy new year.

I am trying to write a toy network stack in userspace. In order
to test my code I am using a tap interface as a virtual ethernet
device. My setup is as follows;

        br0 : bridge       eth0 (public network interface)
        / \
       /   \
      /     \
   eth1      tap0 (My program reads/writes to/from this interface)
 (enslaved)

The above setup is runing in a KVM virtual machine. I implemented
ARP request/reply mechanism and looking at "arp -n" output I can
confirm that it runs as expected.

Now the problem I am experiencing is that br0 bridge forwards ARP
packets but not IP datagrams when they are sent from the host box.
When I say "host box", I mean the machine on which my test VM runs.
It seems that ARP packets are forwarded no matter which host (host
or guest box) they come from. But when it comes to IP datagrams,
they are forwarded to tap0 as expected if I send them from the same
host as tap0 interface (guest VM). If I send them from the host
box (I mean the computer on which my VM runs), IP datagrams reach
br0 bridge, but somehow they are not forwarded to tap0 interface,
I can see this with tcpdump.

I know the bridging functionality is independent of layer 3
protocols, and it should forward packets according to their layer
2 addresses, in this case their mac addresses.

VM mac addresses:
br0: fe:58:34:6b:8c:06
eth0: 52:54:00:99:c7:f2
eth1: 52:54:00:04:c7:f8
tap0: 46:22:c9:8a:16:ba

Host mac address:
virbr2: fe:54:00:04:c7:f8

Also please ignore the length field in the tcpdump output, because
it is possible that I might have sent a different input to netcat.

* When I try to send a UDP datagram from the host machine I get the
following results:

Host box;
[cakturk@portege unet]$ echo "foobar" | nc -u 172.28.128.44 33333

Guest VM, tcpdump listening on tap0
[root@unet-devel vagrant]# tcpdump -i tap0 -nnevv arp or udp
tcpdump: listening on tap0, link-type EN10MB (Ethernet), capture size 262144 bytes
12:32:32.172272 fe:54:00:04:c7:f8 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Ethernet (l
en 6), IPv4 (len 4), Request who-has 172.28.128.44 tell 172.28.128.1, length 28
12:32:32.172446 46:22:c9:8a:16:ba > fe:54:00:04:c7:f8, ethertype ARP (0x0806), length 42: Ethernet (l
en 6), IPv4 (len 4), Reply 172.28.128.44 is-at 46:22:c9:8a:16:ba, length 28

Guest VM, tcpdump listening on br0
[root@unet-devel vagrant]# tcpdump -i br0 -nnevv arp or udp
tcpdump: listening on br0, link-type EN10MB (Ethernet), capture size 262144 bytes
13:02:46.643782 fe:54:00:04:c7:f8 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Ethernet (len 6), IPv4 (len 4), Request who-has 172.28.128.44 tell 172.28.128.1, length 28
13:02:46.643996 46:22:c9:8a:16:ba > fe:54:00:04:c7:f8, ethertype ARP (0x0806), length 42: Ethernet (len 6), IPv4 (len 4), Reply 172.28.128.44 is-at 46:22:c9:8a:16:ba, length 28
13:02:46.646676 fe:54:00:04:c7:f8 > 46:22:c9:8a:16:ba, ethertype IPv4 (0x0800), length 49: (tos 0x0, ttl 64, id 27172, offset 0, flags [DF], proto UDP (17), length 35)
    172.28.128.1.40327 > 172.28.128.44.33333: [udp sum ok] UDP, length 7

* But sending packets from the host machine to the guest VM I get the
following results:

Host machine;
[cakturk@portege unet]$ echo "foobar" | nc -u 172.28.128.44 33333

Guest VM tcpdump listening on tap0
[root@unet-devel vagrant]# tcpdump -i tap0 -nnevv arp or udp
tcpdump: listening on tap0, link-type EN10MB (Ethernet), capture size 262144 bytes
12:29:58.542681 fe:58:34:6b:8c:06 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Ethernet (l
en 6), IPv4 (len 4), Request who-has 172.28.128.44 tell 172.28.128.14, length 28
12:29:58.542928 46:22:c9:8a:16:ba > fe:58:34:6b:8c:06, ethertype ARP (0x0806), length 42: Ethernet (l
en 6), IPv4 (len 4), Reply 172.28.128.44 is-at 46:22:c9:8a:16:ba, length 28
12:29:58.544910 fe:58:34:6b:8c:06 > 46:22:c9:8a:16:ba, ethertype IPv4 (0x0800), length 51: (tos 0x0,
ttl 64, id 1397, offset 0, flags [DF], proto UDP (17), length 37)
    172.28.128.14.42506 > 172.28.128.44.33333: [udp sum ok] UDP, length 9

3 packets captured
3 packets received by filter
0 packets dropped by kernel

As can be clearly seen, when packets come from the host machine
ARP requests reach tap0, but IP/UDP datagrams are not forwarded to the
tap0 interface.

Can anyone give me any pointers on this?

Some additional information on my test environment:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Routing table, iptables and ebtables information for the guest VM.
-----------------------------------------------------------------
[root@unet-devel vagrant]# netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.121.1   0.0.0.0         UG        0 0          0 eth0
0.0.0.0         172.28.128.1    0.0.0.0         UG        0 0          0 br0
172.28.128.0    0.0.0.0         255.255.255.0   U         0 0          0 br0
172.28.128.1    0.0.0.0         255.255.255.255 UH        0 0          0 br0
192.168.121.0   0.0.0.0         255.255.255.0   U         0 0          0 eth0
[root@unet-devel vagrant]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

[root@unet-devel vagrant]# ebtables -L
Bridge table: filter

Bridge chain: INPUT, entries: 0, policy: ACCEPT

Bridge chain: FORWARD, entries: 0, policy: ACCEPT

Bridge chain: OUTPUT, entries: 0, policy: ACCEPT

Routing table, iptables and ebtables information for the host machine
---------------------------------------------------------------------
[cakturk@portege unet]$ netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG        0 0          0 wlp2s0
172.28.128.0    0.0.0.0         255.255.255.0   U         0 0          0 virbr2
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 wlp2s0
192.168.121.0   0.0.0.0         255.255.255.0   U         0 0          0 virbr1
192.168.124.0   0.0.0.0         255.255.255.0   U         0 0          0 virbr0
[cakturk@portege unet]$ sudo iptables -L
[sudo] password for cakturk:
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootps
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootps
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootps
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             anywhere
INPUT_direct  all  --  anywhere             anywhere
INPUT_ZONES_SOURCE  all  --  anywhere             anywhere
INPUT_ZONES  all  --  anywhere             anywhere
DROP       all  --  anywhere             anywhere             ctstate INVALID
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             172.28.128.0/24      ctstate RELATED,ESTABLISHED
ACCEPT     all  --  172.28.128.0/24      anywhere
ACCEPT     all  --  anywhere             anywhere
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
ACCEPT     all  --  anywhere             192.168.121.0/24     ctstate RELATED,ESTABLISHED
ACCEPT     all  --  192.168.121.0/24     anywhere
ACCEPT     all  --  anywhere             anywhere
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
ACCEPT     all  --  anywhere             192.168.124.0/24     ctstate RELATED,ESTABLISHED
ACCEPT     all  --  192.168.124.0/24     anywhere
ACCEPT     all  --  anywhere             anywhere
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             anywhere
FORWARD_direct  all  --  anywhere             anywhere
FORWARD_IN_ZONES_SOURCE  all  --  anywhere             anywhere
FORWARD_IN_ZONES  all  --  anywhere             anywhere
FORWARD_OUT_ZONES_SOURCE  all  --  anywhere             anywhere
FORWARD_OUT_ZONES  all  --  anywhere             anywhere
DROP       all  --  anywhere             anywhere             ctstate INVALID
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootpc
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootpc
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootpc
OUTPUT_direct  all  --  anywhere             anywhere

Chain FORWARD_IN_ZONES (1 references)
target     prot opt source               destination
FWDI_FedoraWorkstation  all  --  anywhere             anywhere            [goto]
FWDI_FedoraWorkstation  all  --  anywhere             anywhere            [goto]

Chain FORWARD_IN_ZONES_SOURCE (1 references)
target     prot opt source               destination

Chain FORWARD_OUT_ZONES (1 references)
target     prot opt source               destination
FWDO_FedoraWorkstation  all  --  anywhere             anywhere            [goto]
FWDO_FedoraWorkstation  all  --  anywhere             anywhere            [goto]

Chain FORWARD_OUT_ZONES_SOURCE (1 references)
target     prot opt source               destination

Chain FORWARD_direct (1 references)
target     prot opt source               destination

Chain FWDI_FedoraWorkstation (2 references)
target     prot opt source               destination
FWDI_FedoraWorkstation_log  all  --  anywhere             anywhere
FWDI_FedoraWorkstation_deny  all  --  anywhere             anywhere
FWDI_FedoraWorkstation_allow  all  --  anywhere             anywhere
ACCEPT     icmp --  anywhere             anywhere

Chain FWDI_FedoraWorkstation_allow (1 references)
target     prot opt source               destination

Chain FWDI_FedoraWorkstation_deny (1 references)
target     prot opt source               destination

Chain FWDI_FedoraWorkstation_log (1 references)
target     prot opt source               destination

Chain FWDO_FedoraWorkstation (2 references)
target     prot opt source               destination
FWDO_FedoraWorkstation_log  all  --  anywhere             anywhere
FWDO_FedoraWorkstation_deny  all  --  anywhere             anywhere
FWDO_FedoraWorkstation_allow  all  --  anywhere             anywhere

Chain FWDO_FedoraWorkstation_allow (1 references)
target     prot opt source               destination

Chain FWDO_FedoraWorkstation_deny (1 references)
target     prot opt source               destination

Chain FWDO_FedoraWorkstation_log (1 references)
target     prot opt source               destination

Chain INPUT_ZONES (1 references)
target     prot opt source               destination
IN_FedoraWorkstation  all  --  anywhere             anywhere            [goto]
IN_FedoraWorkstation  all  --  anywhere             anywhere            [goto]

Chain INPUT_ZONES_SOURCE (1 references)
target     prot opt source               destination

Chain INPUT_direct (1 references)
target     prot opt source               destination

Chain IN_FedoraWorkstation (2 references)
target     prot opt source               destination
IN_FedoraWorkstation_log  all  --  anywhere             anywhere
IN_FedoraWorkstation_deny  all  --  anywhere             anywhere
IN_FedoraWorkstation_allow  all  --  anywhere             anywhere
ACCEPT     icmp --  anywhere             anywhere

Chain IN_FedoraWorkstation_allow (1 references)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:sunrpc ctstate NEW
ACCEPT     udp  --  anywhere             anywhere             udp dpt:sunrpc ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:mountd ctstate NEW
ACCEPT     udp  --  anywhere             anywhere             udp dpt:mountd ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:nfs ctstate NEW
ACCEPT     udp  --  anywhere             224.0.0.251          udp dpt:mdns ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh ctstate NEW
ACCEPT     udp  --  anywhere             anywhere             udp dpt:netbios-ns ctstate NEW
ACCEPT     udp  --  anywhere             anywhere             udp dpt:netbios-dgm ctstate NEW
ACCEPT     udp  --  anywhere             anywhere             udp dpts:blackjack:65535 ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpts:blackjack:65535 ctstate NEW

Chain IN_FedoraWorkstation_deny (1 references)
target     prot opt source               destination

Chain IN_FedoraWorkstation_log (1 references)
target     prot opt source               destination

Chain OUTPUT_direct (1 references)
target     prot opt source               destination

[cakturk@portege unet]$ sudo ebtables -L
Bridge table: filter

Bridge chain: INPUT, entries: 1, policy: ACCEPT
-j INPUT_direct

Bridge chain: FORWARD, entries: 1, policy: ACCEPT
-j FORWARD_direct

Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
-j OUTPUT_direct

Bridge chain: INPUT_direct, entries: 0, policy: RETURN

Bridge chain: OUTPUT_direct, entries: 0, policy: RETURN

Bridge chain: FORWARD_direct, entries: 0, policy: RETURN

Arp entries in host machine:
[cakturk@portege unet]$ arp -n
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.1.24             ether   34:36:3b:ca:ed:74   C                     wlp2s0
172.28.128.14            ether   fe:58:34:6b:8c:06   C                     virbr2
192.168.1.1              ether   24:df:6a:fc:8d:32   C                     wlp2s0
172.28.128.44            ether   46:22:c9:8a:16:ba   C                     virbr2
192.168.121.53           ether   52:54:00:99:c7:f2   C                     virbr1

Arp entries in guest VM:
[vagrant@unet-devel ~]$ arp -n
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.121.1            ether   fe:54:00:99:c7:f2   C                     eth0
172.28.128.1             ether   fe:54:00:04:c7:f8   C                     br0
172.28.128.44            ether   46:22:c9:8a:16:ba   C                     br0

Cihangir.
