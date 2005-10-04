Message-ID: <4342DF3D.7000103@siennax.com>
Date: Tue, 04 Oct 2005 21:59:57 +0200
From: mark ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] combining vlan tagging and spanning tree
References: <4340F1B3.6000401@inaphone.com>
In-Reply-To: <4340F1B3.6000401@inaphone.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Baldur Norddahl <bbn-bridge@inaphone.com>
Cc: bridge@lists.osdl.org

Baldur Norddahl wrote:

>Hi,
>
>I am configuring some servers in a high availability setup. The servers
>are connected to two switches with two LAN cards in each server.
>
Are the switches Cisco switches?
For now I will assume they are.

> The two
>switches are connected directly to each other.
>
>The servers are configured to bridge eth0 and eth1 with spanning tree.
>Usually this makes sure eth1 is disabled, unless something happens to
>eth0. This way I can have one IP address on each server.
>
>Now I also want to use vlan tagging on some of the servers.
>
>I am unsure if I am supposed to bridge before or after applying vlan
>tagging. That is, if the bridge should be between eth0 and eth1, or
>between eth0.2 and eth1.2. I suppose it would also be possible to have a
>br0.2.
>  
>
You have to setup de bridge between the vlan interfaces.
Example:

#!/bin/sh
VCONFIG=/sbin/vconfig
BRCTL=/usr/local/sbin/brctl
BRIDGEPRIO=0 # Set to 1 on the other bridge.

# Bridge vlan 5 to vlan 15
$VCONFIG add eth0 5
$VCONFIG add eth2 15
ifconfig eth0.5 0.0.0.0 up
ifconfig eth1.15 0.0.0.0 up

$BRCTL addbr MYBR
$BRCTL addif MYBR eth0.5
$BRCTL addif MYBR eth1.15
$BRCTL stp MYBR on
$BRCTL setbridgeprio MYBR $BRIDGEPRIO

ifconfig MYBR up

You would probable expect this to work. But... it will not.
What happens is that the Cisco switches will 'see' (r)stp traffic from
vlan 5 arrive in vlan 15 and visa versa.

The bridge we created is working like a patch cable and your switches 
are not going to like it.
To protect you against a loop in the network they will disable one or 
more ports connected to the Linux bridges.

The solution is not to allow stp or rstp packets on the Cisco interfaces 
connected to the linux bridges.
So in the cisco interface configuration:

---
conf t
interface GigabitEthernetX/XX
spanning-tree bpdufilter enable
---

This will fix the problem of the Cisco switch disabling your bridge uplinks.
But now we have created a new problem. stp traffic from one linux bridge 
to the other won't pass
the Cisco switch ports because of the bpdufilter. Both the Linux bridges 
will go into forwarding mode
and a nice network loop is created. :-(

You can fix this by changing the bridge_ula in br_input.c
See the example below:
----
linux-2.6.x/net/bridge/br_input.c ( Note : At least 2.6.8.1 or higher or 
it will not work).
Change:
//const unsigned char bridge_ula[6] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 }
;
const unsigned char bridge_ula[6] = { 0x03, 0x00, 0x00, 0x01, 0x00, 0x00 };
----
The Cisco switch now let's the linux bridge stp traffic pass the ports 
with the bpdufilter.
This is a hack. But it works well and reliable. And as far as I know 
this is the only way to get it
to work in a 'Cisco vlan' environment.

>I managed to get it working sort of. But as soon I enable spanning tree,
>I lose contact on the bridge device. Tcpdump still shows traffic on the
>underlying device.
>
>I am using gentoo linux 2.6.12.
>
>Thanks,
>
>Baldur
>
>_______________________________________________
>Bridge mailing list
>Bridge@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/bridge
>  
>
I hope this helps,

Mark Ruijter
