Message-ID: <FC3C0DD86B79DF4FA423AF0379A547610155438B@mailguy2.nuvation.com>
From: Oliver King-Smith <oliver.king-smith@nuvation.com>
Subject: RE: [Bridge] Getting dynamic ip address for a bridge
Date: Fri, 27 Aug 2004 16:42:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

Stephen,

I am not sure I understand this.

> DHCP will work on the bridge interface (br0) but you need to have the
> bridge and ethernets up, and the forwarding delay has to expired.
> After that the eth0 will be in the forwarding state.


My script looks like this

ifconfig wlan0 0.0.0.0
ifconfig eth0 0.0.0.0
brctl addbr mybridge
brctl addif eth0
brctl addif wlan0
#ifconfig mybridge 192.168.1.136 netmask 255.255.255.0 up
ifconfig mybridge up

Should I be waiting before I run the ifconfig mybridge up?

Oliver
