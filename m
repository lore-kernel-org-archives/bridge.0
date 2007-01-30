From: Daniele Palumbo <daniele@retaggio.net>
Date: Tue, 30 Jan 2007 14:08:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701301408.22029.daniele@retaggio.net>
Subject: [Bridge] tagged vlan + bridge: good with xen bad otherwise
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

hi.

first of all, this is not xen-related, but i found the problem managing with 
xen.
so, knowledge of xen is only suggested.

the problem:
i want two type of bridge:
xenbr1 (with eth1 and other interfaces added later)
xenbr1.14 (with eth1.14 and other interfaces added later)

xenbr1 must have all the traffic tagged.
xenbr1.14 must have untagged traffic for vlan 14.

i did the following (with eth1 unconfigured)
brctl addbr xenbr1
brctl addif xenbr1 eth1
ifconfig xenbr1 up
ifconfig eth1 up

and xenbr1 is working.
but, when i do a
vconfig add eth1 14
xenbr1 stop working.

if i build up xenbr1.14, with eth1.14, xenbr1.14 works and xenbr1 no.

i have found this: http://ebtables.sourceforge.net/brnf-faq.html
but also setting bridge-nf-filter-vlan-tagged to 0 doesn't help.

but, if i do a xend start, same parameter as my manual config, both xenbr1 and 
xenbr1.14 is working.

there are two notable difference (better, that i noted) between the setup:
- xen rename the interface eth1 in peth1, than it create bridge xenbr1 with 
peth1 and vif0.1, that is a loopback connected to a new interface called eth1 
(that is virtual, not real). 
to understand xen networking: 
http://wiki.xensource.com/xenwiki/XenNetworking?highlight=%28network%29#head-602e26cd4a03b992f3938fe1bea03fa0fea0ed8b
anyway, /proc seems the same between my and xen config, and ifconfig, 
brctl, ... also seems the same.

- in xenbr1, when i setup vconfig add eth1 14, after a while, seems to send 
eth1 in "disabled" mode (brctl showstp xenbr1)

many thank you in advance!

bye
d.
