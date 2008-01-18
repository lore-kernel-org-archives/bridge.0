Date: Fri, 18 Jan 2008 22:35:59 +0100 (CET)
From: andreas@bunten.de
Message-ID: <Pine.LNX.4.62.0801182226450.20707@wadonga.seg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] trying to bridge eth0 & usb0 but arp requests go to the
	wrong network
Reply-To: andreas@bunten.de
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I'm trying to get bridging to work between eth0 and usb0:

192.168.13.2  <--->  br0:192.168.13.47  <---> 192.168.13.1
                      usb0         eth0

192.168.13.2:~ # ping 192.168.13.1
... 100 % packet loss

On 192.168.13.1 I do see the arp requests but no icmp packet :-/

Just like "No traffic gets trough (except ARP and STP)" in the
FAQ on http://www.linux-foundation.org/en/Net:Bridge

Except ...

I can ping 192.168.13.1 from the bridge (192.168.13.47)
Trying to ping 192.168.13.2 from the bridge does not work
I do see the arp requests for 192.168.13.2 on 192.168.13.1 (!)

I get the same result if if enable STP on the bridge.

What is going wrong here? :-/

Any hint appreciated!

Regards,
andreas


PS: The bridge system is a SUSE 10.2 with kernel 2.6.18.8-0.7-default 
(incl. suse patches) usb0 is a MosChip usb nic using the mcs7830 driver 
and eth0 is an on board intel nic. both work fine in non bridging mode.

my routing table (just ignore the vmnet stuff):

bibo:/proc/sys/net/ipv4 # route -n
Kernel IP routing table
Destination  Gateway      Genmask       Flags Metric Ref Use Iface
10.0.0.0     0.0.0.0      255.255.255.0 U     0      0     0 vmnet8
192.168.13.0 0.0.0.0      255.255.255.0 U     0      0     0 br0
10.0.10.0    0.0.0.0      255.255.255.0 U     0      0     0 vmnet1
127.0.0.0    0.0.0.0      255.0.0.0     U     0      0     0 lo
0.0.0.0      192.168.13.1 0.0.0.0       UG    0      0     0 br0

Filtering is not enabled as far as I can see:

   bibo:/proc/sys/net/bridge # ls
   bridge-nf-call-arptables  bridge-nf-call-iptables
   bridge-nf-call-ip6tables  bridge-nf-filter-vlan-tagged
   bibo:/proc/sys/net/bridge # cat *
   0
   0
   0
   0
   bibo:/proc/sys/net/bridge #

   # iptables -vnL
   Chain INPUT (policy ACCEPT 842 packets, 683K bytes)
   pkts bytes target     prot opt in     out     source  destination
   Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
   pkts bytes target     prot opt in     out     source  destination
   Chain OUTPUT (policy ACCEPT 885 packets, 98734 bytes)
   pkts bytes target     prot opt in     out     source  destination

How I set up the bridge:

   # ifconfig usb0 0.0.0.0 down
   # ifconfig eth0 0.0.0.0 down
   # brctl addbr br0
   # brctl addif br0 eth0
   # brctl addif br0 usb0
   # ifconfig br0 192.168.13.47 up
   # brctl show br0
   bridge name   bridge id               STP enabled     interfaces
   br0           8000.000d6080dcd6       no              eth0
                                                         usb0
