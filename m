From: "kingz" <jzhang@cienettechnologies.com>
Date: Thu, 2 Dec 2004 20:10:58 -0800
Message-ID: <004c01c4d8ee$1be82030$6c01a8c0@kingz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 
	My configuration in Bridge, 802.1Q VLAN, and hotmail login,
	Thanks to all
Reply-To: jzhang@cienettechnologies.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: vlan@lanforge.com, ebtables-user@lists.sourceforge.net, bridge@lists.osdl.org
Cc: stuge-vlan@cdy.org, greearb@candelatech.com, bdschuym@pandora.be, shemminger@osdl.org, 'Derek Storvik' <it@consultech.net>

Hi All,

For my issue, first thanks to ALL, I have some idea of it.
Also Thank Peter for his kind remind, I would become one good guy in
this list.

Most mentioned MTU, but how I assure that the problem is just MTU, how I
debug it?
Here is my bridge configuration:
Internet
       |
       |
  Gateway
       |
       |   eth0
Ethernet Bridge
       |   eth1
       |
     H u b    ( one normal hub or switch , no VLAN settings)
      |   \
      |     \
  D-Link  802.1Q VLAN Switches (their uplink port-port 1  connected to
the upper hub are tagged, those ports connected with PCs are untagged).

Bridge configuration:
Linux 2.4.26 ( kernel built in bridge function)
Eth0   RTL8139 driver
Eth1   Intel e100 NIC with eepro100 driver

With VLAN tag, I met the hotmail login error, if without VLAN tag, all
are OK!

Peter and Ben suggested me use intel NICs, I have one intel e100 NIC and
e1000 NIC, e1000 NIC is OK, but I cannt use the e100 card with the e100
driver( from both Linux 2.4.26 and Intel site e100-3.2.3), so I only use
eepro100 driver.
How I can use the e100 with e100 driver? Can I use e100 and e1000
together( use them as eth0,1)?
Any one can help me?

Thanks!

Kingz


