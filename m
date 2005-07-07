Message-ID: <42CD5A33.10604@fokus.fraunhofer.de>
Date: Thu, 07 Jul 2005 18:37:07 +0200
From: Olaf Menzel <olaf.menzel@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Linux bridge on linksys WRT54GS running OpenWRT
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

I am experimenting with delivering IPv6 multicast traffic over the
WRT54GS, running OpenWRT. OpenWrt is currently running linux-2.4.30 for
the mipsel architecture and the OpenWRT distribution has bridged the 4
port LAN switch (vlan0) with the WLAN interface (eth1) by default.  On
the IP layer both devices are represented via the br0 interface. The
bridge work fine for IPv4 Unicast and Multicast and for IPv6 Unicast but
not for IPv6 multicast.

I went into a problem with forwarding the MLDv2_report message over the
bridge from a mobile client, connected over WLAN. The MLDv2 report
messages are received in in the eth1 (WLAN IF), but not in the eth0 nore
in the br0 interface. Does the bridge support IPv6 multicast compliant
MAC addresses, starting with 3333+LowByte(Ipv6 MulticastAddress) ?
Usually a bridge is working on L2 and should forward any ICMPv6 packages
.? The bridge  is forwarding any other IPv6 traffic without problems
e.g. ICMPv6 messages generated with ping6. MLDv2 report messages are a
subset of IPv6 ICMP messages with the link local IPv6 multicast address
FF02::16 ( all MLDv2 compliant router)  as destination address. The same
behavior I figured out with the MLDv2 query messages, sent by the
Multicast router to all nodes (FF02::1) on the local link. The MLD query
I have seen at the eth0  IF but not at the wireless link. Any other IPv6
link local multicast adresses are forwarded e.g. IPv6 router
advertisements or neighbour soicitation messages. Do you have any idea,
how to solve the problem ??


with best regards

Olaf


-- 
Dipl. Ing. Olaf Menzel - System Engineer
FOKUS - Fraunhofer Institute for Open Communication Systems:
- Competence Center for Advanced Satellite Communication
Schloss Birlinghoven, 53754 Sankt Augustin, Germany
Phone: +49-2241-14-3494 Mobile: +49-175-2616161 Fax:+49-2241-14-43494
email: olaf.menzel@fokus.fhg.de Internet: http://www.fokus.fhg.de/satcom


