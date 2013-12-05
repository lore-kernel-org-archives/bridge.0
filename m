Return-Path: <stephen@networkplumber.org>
Date: Thu, 5 Dec 2013 09:09:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20131205090947.364e30d7@nehalam.linuxnetplumber.net>
In-Reply-To: <20131130085440.GA11638@glanzmann.de>
References: <20131130085440.GA11638@glanzmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Packet reflection breaks Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Glanzmann <thomas@glanzmann.de>
Cc: gernoth@cs.fau.de, bridge@lists.linux-foundation.org

On Sat, 30 Nov 2013 09:54:40 +0100
Thomas Glanzmann <thomas@glanzmann.de> wrote:

> Hello,
> I want to use OpenVPN to extend a layer 2 segment over a routed
> connection. I was not able to ping a system on the same subnet, so I
> tried to reproduce it with a different network and was _not_ able to: It
> worked out of the box. It turned out that I had some Exchange sytem that
> sends every packet it gets (including broadcast packets) out again.
> After 3 hours of debugging with Michael Gernoth (on CC), it turned out
> that the bridge was thinking that the MAC address of the device was on
> eth1 instead of 'vpn' and the bridge in Linux was not forwarding any
> packet. We we're able to fight the symptoms by issuing the following
> command:
> 
> ebtables -t nat -A POSTROUTING -d ff:ff:ff:ff:ff:ff -o eth1 -j snat --to-source 00:50:56:98:0a:22
> 
> With this command we can access all systems using Layer 2, but not the
> two Exchange systems which replicate every packet they're seeing.
> 
> This is what the Linux box sends:
> 
> (miniwheezy64) [~] tcpdump -e -n -i vpn ether host 00:50:56:98:12:ed
> tcpdump: WARNING: vpn: no IPv4 address assigned
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on vpn, link-type EN10MB (Ethernet), capture size 65535 bytes
> 09:35:35.402501 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 35, length 64
> 09:35:36.410454 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 36, length 64
> 09:35:37.418526 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 37, length 64
> ^C
> 3 packets captured
> 3 packets received by filter
> 0 packets dropped by kernel
> 
> This is how it looks, after the Microsoft Exchange settings saw the
> package: As you can see, the packets are duplicated at least once,
> sometimes twice. This also happens with arp who-has and is-at packets
> which confused the Linux bridge because it thinks that the mac is now at
> another port:
> 
> (miniwheezy64) [~] tcpdump -e -n -i br0 ether host 00:50:56:98:12:ed
> tcpdump: WARNING: br0: no IPv4 address assigned
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on br0, link-type EN10MB (Ethernet), capture size 65535 bytes
> 09:35:42.458571 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 42, length 64
> 09:35:42.458693 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 42, length 64
> 09:35:42.459019 00:15:5d:67:ab:5f > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 42, length 64
> 09:35:42.459220 00:15:5d:67:ac:93 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 42, length 64
> 09:35:42.459340 00:15:5d:b1:45:71 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 42, length 64
> 09:35:43.466531 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 43, length 64
> 09:35:43.466758 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 43, length 64
> 09:35:43.467162 00:15:5d:67:ab:5f > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 43, length 64
> 09:35:43.467169 00:15:5d:67:ac:93 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 43, length 64
> 09:35:43.467366 00:15:5d:b1:45:71 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 43, length 64
> 09:35:44.474551 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 44, length 64
> 09:35:44.474774 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 2973, seq 44, length 64
> 09:35:44.475108 00:15:5d:67:ab:5f > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 44, length 64
> 09:35:44.475150 00:15:5d:b1:45:71 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 44, length 64
> 09:35:44.475160 00:15:5d:67:ac:93 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 2973, seq 44, length 64
> ^C
> 15 packets captured
> 19 packets received by filter
> 0 packets dropped by kernel
> (miniwheezy64) [~] brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.005056980a22       no              eth1
>                                                         vpn
> 
> (miniwheezy64) [~] brctl showmacs br0 | grep -i 00:50:56:98:12:ed
>   1     00:50:56:98:12:ed       no                 0.08
> 
> As you can see the mac address of the system is learned on port 1 but
> should be learned on port 2.
> 
> This is the setup:
> 
> Exchange and other systems - VLAN 103 - eth1 - br0 - vpn - OpenVPN - vpn - br0 - eth1 - virtual switch - client (00:50:56:98:12:ed)
> 
> It seems that the Linux bridge behaves different than a physical switch.
> Because with a physical switch it still forwards the packet. But the
> Linux bridge gets offbeat by the reflected arp who-has and is-at packets
> and thinks that the mac has moved to a different port even that it
> hasn't. So I wonder why does the linux bridge gets confused by that, but
> the physical switch not?
> 
> I found one other reference which confirms this problem.
> 
> http://serverfault.com/questions/518254/linux-container-bridge-filters-arp-reply
> 
> Also I wonder what else than source natting broadcast request we could
> do to fight the symptoms? For example I would like to drop all packets
> with the source mac address from 00:50:56:98:12:ed which are comming in
> via eth1. I tried this using ebtables, arptables and iptables but did
> not get the syntax right. Has someone, something I could try?
> 
> I'm running Debian wheezy with Linux minisqueeze 3.2.0-4-686-pae #1 SMP
> Debian 3.2.51-1 i686 GNU/Linux.
> 
> If I set the MAC adress of a system static on the system behind the
> layer 2 bridge, the system gets connectivity. If I remove OpenVPN from
> the equation and use a layer 2 gre tunnel or just another physical
> network card, I have the same behaviour.
> 
> Cheers,
>         Thomas


Bridging doesn't like loops, and you have created a loop.
If you are goin to mess around using ebtables, just write another rule
to drop the reflections.
