Message-ID: <AD8D39C727CBD411BB2C0090273A72740CBF1DB3@mortimer.law.uconn.edu>
From: "Hurley, Michael" <MHurley@law.uconn.edu>
Date: Thu, 2 Dec 2004 15:11:18 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bridge] One NIC not bridging?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@osdl.org'" <bridge@osdl.org>

Hello,

I'm having a problem getting two (working) NICs enslaved to a bridge to both
work in the bridge.

The setup is just for testing and looks like this:

(NETWORK)-------|bridge|---------|test PC|

I'm building a bridge from an old Dell Optiplex GX1 desktop. Using
kernel-2.6.9-gentoo-r4, with bridging and ebtables compiled into the kernel;
the two PCI NICs are Intel, and the e100 module compiled, installed, and
works fine (tested both NICs with DHCP and got network access w/o a
problem). Also installed the bridge-tools with emerge. (FWIW, The test PC is
also an old Dell Optiplex GX1, running Fedora 3.)

So far so good. I create the bridge:

brctl addbr br0
brctl stp br0 off
brctl addif eth0
brctl addif eth1
ifconfig eth0 0.0.0.0 down
ifconfig eth1 0.0.0.0 down
ifconfig eth0 0.0.0.0 up
ifconfig eth1 0.0.0.0 up
ifconfig br0 up

'brctl show' shows there is an interface br0 with eth0 and eth1 enslaved to
it. ebtables (& iptables) rules are all set to ACCEPT packets/frames across
the bridge.

Now, the Problem:
I connect the eth1 interface to the network side, and the eth0 interface to
the testPC side. The eth1 NIC lights go green and it's connected to the
network. eth0, connected to my test PC, does NOTHING. On the test PC, I
'ifdown eth0' and 'ifup eth0' but get the result: "no link present. Check
cable?" The test PC eth0 is configged to get an IP via DHCP, and does so
without a problem without the bridge in between.

A quick look at dmesg on the bridge shows the following:

device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
br0: port2(eth1) entering learning state
br0: topology change detected, propogating
br0: port2(eth1) entering forwarding state

All that looks fine for eth1. But after eth0 enters promiscuous mode, it
never enters a learning state, and never a forwading state.

What I've tried so far:
* echo "1" > /proc/sys/net/ipv4/ip_forward
* Checked for IRQ conflicts w/ the NICs.
* Moved NICs to different PCI slots
* switched cable so network side is in eth0, local side on eth1. Same
results as above but reversed, i.e. eth1 then has the problem, and eth0
connects to the network, but eth1 just sits there.

Totally stumped on this especially since I've set up a bridge before with
similar hardware.

Any help is *greatly* appreciated.

Thanks

-Mike

Michael Hurley
Webmaster/SysAdmin
University of Connecticut School of Law
mhurley@law.uconn.edu
(860) 570-5233
