Message-ID: <42CDA29F.80904@fokus.fraunhofer.de>
Date: Thu, 07 Jul 2005 23:46:07 +0200
From: Olaf Menzel <olaf.menzel@fokus.fraunhofer.de>
MIME-Version: 1.0
Subject: Re: [Bridge] Linux bridge on linksys WRT54GS running OpenWRT
References: <42CD5A33.10604@fokus.fraunhofer.de>
	<20050707105957.36d5098e@dxpl.pdx.osdl.net>
In-Reply-To: <20050707105957.36d5098e@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Hugo Santos <hsantos@av.it.pt>, bridge@lists.osdl.org

Hello again,

see my comments inline


Stephen Hemminger wrote:

>On Thu, 07 Jul 2005 18:37:07 +0200
>Olaf Menzel <olaf.menzel@fokus.fraunhofer.de> wrote:
>
>  
>
>>Hello,
>>
>>I am experimenting with delivering IPv6 multicast traffic over the
>>WRT54GS, running OpenWRT. OpenWrt is currently running linux-2.4.30 for
>>the mipsel architecture and the OpenWRT distribution has bridged the 4
>>port LAN switch (vlan0) with the WLAN interface (eth1) by default.  On
>>the IP layer both devices are represented via the br0 interface. The
>>bridge work fine for IPv4 Unicast and Multicast and for IPv6 Unicast but
>>not for IPv6 multicast.
>>
>>I went into a problem with forwarding the MLDv2_report message over the
>>bridge from a mobile client, connected over WLAN. The MLDv2 report
>>messages are received in in the eth1 (WLAN IF), but not in the eth0 nore
>>in the br0 interface. Does the bridge support IPv6 multicast compliant
>>MAC addresses, starting with 3333+LowByte(Ipv6 MulticastAddress) ?
>>    
>>
>
>The bridge handles IEEE multicast mac addresses
>
For IPv6 Multicast the RFC 2464 
(http://www.rfc-editor.org/rfc/rfc2464.txt) describes,
how an IPv6 multicast compliant MAC address will be created.
I hope this RFC is compatible with the IEEE multicast mac standard.

> 
>(ie. least significant bit of first byte of address is set).
>What is a an example Ethernet MAC address of a MLDv2 message?
>  
>
a MLD report has the IPv6 link local multicast destination aaddress:
FF02::16(all mldv2 router) and will map to 33:33:00:00:00:16,
while a MLD query with FF02::1 (all local nodes) has to be mapped to
33:33:00:00:00:01.



I will attach the whole Packet tethereal dump:


1. MLDv2 query:

Ethernet II, Src: 00:0d:88:fc:c7:6c, Dst: 33:33:00:00:00:01
    Destination: 33:33:00:00:00:01 (IPv6-Neighbor-Discovery_00:00:00:01)
    Source: 00:0d:88:fc:c7:6c (D-Link_fc:c7:6c)
    Type: IPv6 (0x86dd)
Internet Protocol Version 6
    Version: 6
    Traffic class: 0x00
    Flowlabel: 0x00000
    Payload length: 36
    Next header: IPv6 hop-by-hop option (0x00)
    Hop limit: 1
    Source address: fe80::20d:88ff:fefc:c76c (fe80::20d:88ff:fefc:c76c)
    Destination address: ff02::1 (ff02::1)
Hop-by-hop Option Header
    Next header: ICMPv6 (0x3a)
    Length: 0 (8 bytes)
    Router alert: MLD (4 bytes)
    PadN: 2 bytes
Internet Control Message Protocol v6
    Type: 130 (Multicast listener query)
    Code: 0
    Checksum: 0x26de (correct)
    Maximum response delay[ms]: 2000
    Multicast Address: ::
    S Flag: OFF
    Robustness: 0
    QQI: 0


2. MLDv2 report:

Ethernet II, Src: 00:13:10:1f:b1:ad, Dst: 33:33:00:00:00:16
    Destination: 33:33:00:00:00:16 (IPv6-Neighbor-Discovery_00:00:00:16)
    Source: 00:13:10:1f:b1:ad (Cisco-Li_1f:b1:ad)
    Type: IPv6 (0x86dd)
Internet Protocol Version 6
    Version: 6
    Traffic class: 0x00
    Flowlabel: 0x00000
    Payload length: 96
    Next header: IPv6 hop-by-hop option (0x00)
    Hop limit: 1
    Source address: fe80::213:10ff:fe1f:b1ad (fe80::213:10ff:fe1f:b1ad)
    Destination address: ff02::16 (ff02::16)
Hop-by-hop Option Header
    Next header: ICMPv6 (0x3a)
    Length: 0 (8 bytes)
    Router alert: MLD (4 bytes)
    PadN: 2 bytes
Internet Control Message Protocol v6
    Type: 143 (Multicast Listener Report Message v2)
    Code: 0 (Should always be zero)
    Checksum: 0xfc03 (correct)
    Exclude: ff02::d (ff02::d)
        Mode: Exclude
        Aux data len: 0
        Multicast Address: ff02::d
    Exclude: ff02::1:ff00:0 (ff02::1:ff00:0)
        Mode: Exclude
        Aux data len: 0
        Multicast Address: ff02::1:ff00:0
    Exclude: ff02::2 (ff02::2)
        Mode: Exclude
        Aux data len: 0
        Multicast Address: ff02::2
    Exclude: ff02::1:ff1f:b1ad (ff02::1:ff1f:b1ad)
        Mode: Exclude
        Aux data len: 0
        Multicast Address: ff02::1:ff1f:b1ad



>  
>
>>Usually a bridge is working on L2 and should forward any ICMPv6 packages
>>.? The bridge  is forwarding any other IPv6 traffic without problems
>>e.g. ICMPv6 messages generated with ping6. MLDv2 report messages are a
>>subset of IPv6 ICMP messages with the link local IPv6 multicast address
>>FF02::16 ( all MLDv2 compliant router)  as destination address. The same
>>behavior I figured out with the MLDv2 query messages, sent by the
>>Multicast router to all nodes (FF02::1) on the local link. The MLD query
>>I have seen at the eth0  IF but not at the wireless link. Any other IPv6
>>link local multicast adresses are forwarded e.g. IPv6 router
>>advertisements or neighbour soicitation messages. Do you have any idea,
>>how to solve the problem ??
>>    
>>
>
>The bridge intentionally knows nothing about higher level protocols.
>But if you are using ebtables/iptables perhaps a filtering rule is getting
>in the way.
>  
>

Olaf

