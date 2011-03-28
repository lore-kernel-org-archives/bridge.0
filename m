From: igor serebryany <igor47@moomers.org>
Date: Mon, 28 Mar 2011 17:54:29 +0000 (UTC)
Message-ID: <loom.20110328T194703-472@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 802.1q tagging broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

it appears that 802.1q tagging is broken in 2.6.38 when combined with bridging.
here is how to reproduce the problem:

i set up an interface for the machine running 2.6.38 on my cisco router, and
assign a subnet to that interface. i am using ping from the router to do the
testing. i am getting all the data here with 'tcpdump -e -n' from the machine.

i ping the machine from the router, and i see properly-tagged ARP requests
coming in on eth0:

12:12:05.052465 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q
(0x8100), length 64: vlan 234, p 0, ethertype ARP, Request who-has 10.0.0.206
tell 10.0.0.205, length 46

i then create a vlan interface on the machine:

vconfig add eth0 234
ifconfig eth0.234 up

i tcpdump the newly-created interface, and i see the arp packets appearing on
it, now properly untagged

12:14:33.549939 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806),
length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46

if i assign an ip to this interface, i can see pings being exchanged on eth0.234

12:17:12.681079 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806),
length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46
12:17:12.681090 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype ARP (0x0806),
length 42: Reply 10.0.0.206 is-at 00:30:48:fd:98:d8, length 28
12:17:14.682076 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype IPv4 (0x0800),
length 114: 10.0.0.205 > 10.0.0.206: ICMP echo request, id 24, seq 1, length 80
12:17:14.682088 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype IPv4 (0x0800),
length 114: 10.0.0.206 > 10.0.0.205: ICMP echo reply, id 24, seq 1, length 80

now, i want to assign eth0 to a bridge

brctl addbr xenbr0
ifconfig xenbr0 up
brctl addif xenbr0 eth0

i now attempt to ping the machine again. watching tcpdump on eth0.234, i don't
see any of my packets anymore!

instead, if i watch xenbr0 with tcpdump, i can see the tagged packets being
dumped straight into xenbr0, without the vlan tags stripped out!

12:20:53.041487 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype 802.1Q
(0x8100), length 118: vlan 234, p 0, ethertype IPv4, 10.0.0.205 > 10.0.0.206:
ICMP echo request, id 26, seq 2, length 80

obviously there are no icmp replies because there is no listening interface on
xenbr0. 

i tried doing something really silly:

vconfig add xenbr0 234
ifconfig xenbr0.234 10.0.0.206 netmask 255.255.255.252

when watching this unusual interface with tcpdump, i would see properly-untagged
packets making their way there. but arp requests couldn't make their way back
out again:

12:44:29.952443 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype IPv4 (0x0800),
length 114: 10.0.0.205 > 10.0.0.206: ICMP echo request, id 30, seq 4, length 80
12:44:29.954549 00:30:48:fd:98:d8 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806),
length 42: Request who-has 10.0.0.205 tell 184.154.127.206, length 28

so, that doesn't work...

this is a pretty severe bug for me. my virtual machine setup depends on being
able to assign VMs to vlans and forward packets to them, and this totally breaks
my networking model, taking some of my vms offline. of course, any vm using the
native vlan on the port is unaffected.

