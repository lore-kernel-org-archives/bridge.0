Message-ID: <49D6682E.1040403@navigue.com>
Date: Fri, 03 Apr 2009 15:49:02 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Interesting fragmentation behavior with gretap interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I'm trying to bridge a mix of 802.1q tagged and untagged Ethernet frames
through the new Ethernet over GRE functionality in kernel 2.6.28

The hosts handling the tunnel (192.168.200.6, 192.168.200.2) are
connected together through with a simple cross cable through their eth1
interface.  The switches are connected to their respective eth0
interface, which is bridged with their respective gretap interface.

The setup works quite well except when it comes to MTU.  Oddly enough,
802.1q tagged frames get properly fragmented and defragmented, allowing
for a maximum MTU of 1500 (1504 with the tag, I assume).  Untagged
frames larger than 1462 bytes will not make it through the GRE tunnel setup.

                     192.168.200.6       192.168.200.2
(802.1q switch1)<->(eth0-br0-gretap)<->(gretap-br0-eth0)<->(802.1q switch2)


10.0.0.0/12 is my 'untagged' subnet. (default vlan 1, untagged)
192.168.7.0/32 is my tagged subnet. (vlan 800, tagged)

The host I use to test has a NIC in each subnet and is hooked to
switch1, it is pinging hosts on switch2.

First, tagged packets:

$ ping -c 3 -M do -s 1472 192.168.7.175
PING 192.168.7.175 (192.168.7.175) 1472(1500) bytes of data.
1480 bytes from 192.168.7.175: icmp_seq=1 ttl=250 time=36.9 ms
1480 bytes from 192.168.7.175: icmp_seq=2 ttl=250 time=52.1 ms
1480 bytes from 192.168.7.175: icmp_seq=3 ttl=250 time=44.5 ms

--- 192.168.7.175 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 36.994/44.569/52.160/6.191 ms

Normal as can be...  Now untagged:

$ ping -c 3 -M do -s 1472 10.8.1.1
PING 10.8.1.1 (10.8.1.1) 1472(1500) bytes of data.

--- 10.8.1.1 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 1999ms

Same result all the way down to 1462 bytes, where it actually works:

$ ping -c 3 -M do -s 1434 10.8.1.1
PING 10.8.1.1 (10.8.1.1) 1434(1462) bytes of data.
1442 bytes from 10.8.1.1: icmp_seq=1 ttl=30 time=4.02 ms
1442 bytes from 10.8.1.1: icmp_seq=2 ttl=30 time=4.54 ms
1442 bytes from 10.8.1.1: icmp_seq=3 ttl=30 time=4.22 ms

--- 10.8.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 4.028/4.266/4.547/0.220 ms

It looks suspiciously like this bug:

http://kerneltrap.org/mailarchive/linux-kernel/2007/5/26/96070/thread

Could it be that there now is a special case (as per the suggested
patch) to handle vlan tagged frames, but the special case of
gre-encapsulated non-vlan frames isn't being handled properly?

Hope this makes sense to someone in here...

Jonathan
