Message-ID: <3F1F45A8.4080003@krellan.com>
Date: Wed, 23 Jul 2003 19:34:16 -0700
From: JoSH Lehan <krellan@krellan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] How to blindly pass IPX packets between LAN's?
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Bridge@lists.osdl.org

I have an Internet connection with 5 static IP addresses (a /29 subnet), 
using a DSL modem, and also a LAN with private IP addresses.

I have a standard 3-NIC Linux firewall box.  No PPPoE or USB is needed, 
it just connects to a basic Ethernet DSL modem that does its job.  This 
Linux setup is great.  My uptime is over 460 days!

eth0 = DSL modem to the Internet
eth1 = public static IP addresses (our DMZ)
eth2 = private IP addresses (behind NAT provided by the Linux box)
br0  = eth0 + eth1

Our Internet connection has a gateway on the same subnet as our static 
IP addresses!  (Like many people, we don't have a proper /30 routing 
subnet, because of the IP address shortage.  So, the untrusted gateway 
is on the same subnet that contains our production machines.  This "fox 
in the henhouse" problem necessitates the use of a bridging firewall.)

So, I've bridged eth0 and eth1 into br0.  This works well.  I have 
firewall rules set up to be very careful about what traffic is allowed 
onto our DMZ network (the public /29 subnet).  From the DSL modem's 
point of view, all machines are on the same subnet, so routing and ARP 
works great.  The Linux box acts as a filter for what packets are 
actually allowed to reach my other machines, though, which is good.

The Linux box also provides NAT for other machines not on the DMZ, via 
private IP addresses.  Everything's routed through the Linux box.  So, 
we have 2 LAN's: one for the public IP addresses, and another for the 
private IP addresses.

Both DMZ machines and private machines are able to reach each other via 
TCP/IP, and it works great.  There's no connectivity issues here at all. 
  Even Windows network neighborhood, with Samba running a WINS server 
and Linux serving it via DHCP, works great and all machines can be seen, 
even across these two LAN's.  All machines can see the Internet, of course.

I'm running a 2.2 kernel.  (I haven't upgraded to 2.4 yet, because I 
hear there's still some problems with bridging firewalls like this.)

I do have a slight problem, though.

Some people want to play a multiplayer game that only speaks IPX.  It 
needs to run between the DMZ machines and the private machines.

I don't have any Novell software runnning, and I don't want to have to 
set up an IPX program on my Linux box to handle IPX packets.  What I 
would love to do is blindly pass IPX packets back and forth.  I don't 
want to do any processing whatsoever on IPX packets.  I just want to be 
a transparent bridge for them.

Is this possible?  My understanding of IPX is limited, but it is very 
good at just finding other machines on the network automatically via 
broadcast, without needing any configuration whatsoever.  This makes it 
useful for multiplayer games, and was heavily used back in the days of 
DOS, before TCP/IP became mainstream.

I already have a TCP/IP bridge running between eth0 and eth1.  Would it 
also be possible to run an IPX bridge between eth1 and eth2, without 
disrupting the first bridge?  Is is possible for bridges to coexist like 
this, using the protocol to separate them, so that they don't overlap 
with each other?  What I want to very much avoid having to do is to have 
all 3 NIC's bound together in one huge bridge.  This would lead to many 
routing problems, it would seem.

Advice is appreciated :)
Thanks!
Josh


