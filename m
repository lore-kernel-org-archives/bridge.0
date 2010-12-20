Message-ID: <4D0FB6AC.2020901@wanadoo.nl>
Date: Mon, 20 Dec 2010 21:03:56 +0100
From: Rolf Fokkens <rolf.fokkens@wanadoo.nl>
MIME-Version: 1.0
References: <4D0E868E.4010309@wanadoo.nl> <20101220103754.7d18de50@s6510>
In-Reply-To: <20101220103754.7d18de50@s6510>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Why should static MAC address match one of the port
 MAC addresses - bug?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

Hi,

I think that the bridge interface no longer sees unicast messages 
addressed to it, after changing the MAC address. I'll explain:

I chose a different MAC address, 02:77:00:00:01:02. This MAC address is 
absolutely not present on another interface. The MAC address of the 
Windows XP client is 02:00:00:00:00:01. The bridge interface br2 now 
only has one interface tap0 which links to the Windows XP client.

[root@home01 ~]# brctl show
bridge name    bridge id        STP enabled    interfaces
br0        8000.002215b81084    no        eth0.3
br1        8000.002215b81084    no        eth0.4
br2        8000.027700000102    no        tap0
br3        8000.002215b81084    no        eth0.1253

The IP address of the Windows XP guest is 192.168.252.1, the IP address 
of the bridge interface is 192.168.252.254, which is the default gateway 
address of the Windows XP guest.

Now let's look at the ARP entries. First the Windows XP guest:

C:\>arp -a

Interface 192.168.252.1 --- 0x2
   Internet Address   Physical Address      Type
   192.168.252.254   02-77-00-00-01-02   dynamic

Next on the Linux host:

[root@home01 ~]# arp -n
Address                  HWtype  HWaddress           Flags 
Mask            Iface
192.168.254.7            ether   00:18:f3:fd:09:7a   
C                     br1
192.168.254.18           ether   00:16:e8:29:bc:e3   
C                     br1
192.168.1.1              ether   00:0e:50:64:7f:74   
C                     br0
192.168.254.16           ether   90:84:0d:6f:26:1c   
C                     br1
192.168.1.128            ether   00:21:85:98:45:84   
C                     br0
192.168.252.1                    
(incomplete)                              br2
192.168.254.9            ether   18:a9:05:39:14:95   
C                     br1
[root@home01 ~]#

So now we see that the Windows XP guest is aware of the new MAC address 
of the bridge. However the Linux host is not aware of the guest's MAC 
address! Time to see what's happening when we use tcpdump:

[root@home01 ~]# tcpdump -n -e -i tap0 arp
tcpdump: WARNING: tap0: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on tap0, link-type EN10MB (Ethernet), capture size 65535 bytes

20:42:23.606319 02:00:00:00:00:01 > Broadcast, ethertype ARP (0x0806), 
length 42: Request who-has 192.168.252.254 tell 192.168.252.1, length 28
20:42:23.606359 02:77:00:00:01:02 > 02:00:00:00:00:01, ethertype ARP 
(0x0806), length 42: Reply 192.168.252.254 is-at 02:77:00:00:01:02, 
length 28

20:47:42.503536 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
20:47:42.504039 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
(0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, length 28
20:47:43.505541 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
20:47:43.506316 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
(0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, length 28
20:47:44.507539 02:77:00:00:01:02 > Broadcast, ethertype ARP (0x0806), 
length 42: Request who-has 192.168.252.1 tell 192.168.252.254, length 28
20:47:44.508319 02:00:00:00:00:01 > 02:77:00:00:01:02, ethertype ARP 
(0x0806), length 42: Reply 192.168.252.1 is-at 02:00:00:00:00:01, length 28

First we see an ARP request from the Windows XP guest to find the host's 
192.168.252.254. There is a fast ARP response, so this is consistent 
with the ARP table on the Windows XP guest.

Next we see an ARP request from the Linux host to find the guest's 
192.168.252.1. This is followed by a fast ARP response. Despite the 
response both the request and the response are repeated 3 times. This is 
consistent with the fact that the ARP table on the Linux host is missing 
the guest's MAC address.

So, apparently both interfaces (br2 and tap0) see the ethernet 
broadcast, but only the guest's interface (tap0) sees the unicast. This 
is confirmed by brctl's output:

[root@home01 ~]# brctl showmacs br2
port no mac addr           is local? ageing timer
   1     02:00:00:00:00:01  no        5.38
   1     82:7a:bf:ee:e8:5e  yes       0.00
[root@home01 ~]#

We see two interresting MAC addresses. the first one is the MAC address 
of the Windows XP guest, which indeed is not local. The second one is 
the MAC address of the tap0 interface on the host side, which apparently 
is local. But where's the mac address of br0 itself? It's missing.

This seems unintentional to me.

Rolf

On 12/20/2010 07:37 PM, Stephen Hemminger wrote:
> The address you change the address, it is like you changed the MAC address
> of a card on the network. Windows ARP cache is no longer valid and has
> to time out.
>
>

