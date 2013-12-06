Return-Path: <thomas@glanzmann.de>
Date: Fri, 6 Dec 2013 05:33:47 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
Message-ID: <20131206043347.GC11878@glanzmann.de>
References: <20131130085440.GA11638@glanzmann.de> <52A0EBEA.4020808@pandora.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52A0EBEA.4020808@pandora.be>
Subject: Re: [Bridge] Packet reflection breaks Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Stephen Hemminger <stephen@networkplumber.org>, gernoth@cs.fau.de, bridge@lists.linux-foundation.org

Hello Bart,

> > http://serverfault.com/questions/518254/linux-container-bridge-filters-arp-reply

> The author answered his own question stating it was an issue in his
> network :-)

that is true. 

> ebtables -t nat -A PREROUTING -s 00:50:56:98:12:ed -i eth1 -j DROP
> Use PREROUTING so that the Linux bridge fdb isn't updated.

Thank you a lot for this line. I just tried it and it works:

(miniwheezy64) [~]           ebtables -t nat -A PREROUTING -s 00:50:56:98:12:ed -i eth1 -j DROP
(miniwheezy64) [~] tcpdump -e -n -i vpn ether host 00:50:56:98:12:ed
tcpdump: WARNING: vpn: no IPv4 address assigned
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on vpn, link-type EN10MB (Ethernet), capture size 65535 bytes
05:27:59.786228 00:50:56:98:12:ed > 03:bf:0a:40:67:2a, ethertype IPv4 (0x0800), length 98: 10.64.103.250 > 10.64.103.42: ICMP echo request, id 14490, seq 29, length 64
05:27:59.786768 00:15:5d:b1:45:71 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 14490, seq 29, length 64
05:27:59.786787 00:15:5d:67:ac:93 > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 14490, seq 29, length 64
05:27:59.787041 00:15:5d:67:ab:5f > 00:50:56:98:12:ed, ethertype IPv4 (0x0800), length 98: 10.64.103.42 > 10.64.103.250: ICMP echo reply, id 14490, seq 29, length 64
...

As you can see the system is totally broken. It even sends its unicast packets
three times back. A wonder that anything works in this broadcast domain. And
the MAC is learned on the rigth port:

(miniwheezy64) [~] brctl showmacs br0 | grep -i 00:50:56:98:12:ed
  2     00:50:56:98:12:ed       no                 0.28

> A better solution is probably to fix your network.

I agree. The problem is that it is _not_ _my_ network. I identified two
Microsoft Exchange servers which are part of two different load
balancing clusters running on Hyper-V as the culprit. They do not only
reflect all broadcast packets that they see, but also the unicast
packets. So when I do a unicast connection to them using ICMP or TCP,
all packets get reflected. So what I'm looking for now is a workaround
to carry out the migration. Because of the feedback provided by Michael,
Stephen and you, now I have three:

        - SNAT the broadcast packets that come from the far side of the
          bridge, and SNAT the unicast packets going to the systems
          which do reflect all packages that they can see.

                ebtables -t nat -F
                ebtables -t nat -A POSTROUTING -d ff:ff:ff:ff:ff:ff -o eth1 -j snat --to-source 00:50:56:98:0a:22
                ebtables -t nat -A POSTROUTING -d 03:bf:0a:40:67:80 -o eth1 -j snat --to-source 00:50:56:98:0a:22
                ebtables -t nat -A POSTROUTING -d 03:bf:0a:40:67:2a -o eth1 -j snat --to-source 00:50:56:98:0a:22

        - Use the newest code and pin the mac address of the far side
          machines to the right interface.

        - Use the ebtables PREROUTING statement to filter the packets
          out before they reach the bridge:

          ebtables -t nat -A PREROUTING -s 00:50:56:98:12:ed -i eth1 -j DROP

Far side I call systems behind the OpenVPN bridge on the virtual
network.

I agree that the above is fighting the symptoms and not resolving the
real problem. I don't like that. However I'm not allowed to reconfigure
the Exchange Microsoft Cluster, so I work with that. I have informed the
people reasonable for it and the network administrators and hope that
they take care of the problem.

Cheers,
        Thomas
