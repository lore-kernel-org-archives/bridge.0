Message-Id: <200506060623.j566Nilo025218@thewayout.net>
From: "Osama Abu Elsorour" <osama@wayout.net>
Subject: RE: [Bridge] ARP weirdness
Date: Tue, 7 Jun 2005 09:22:02 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1118043051.2066.14.camel@juptop>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Actually

Giving it more thought I think the bridge is behaving, in a way, correctly.

From the bridge standpoint, there is no way for it to know that the
broadcast contains an ARP packet with the IP address of the br interface.
This is why it makes sense to flood.

However, VLANs should be, or at least optionally be, in a different
broadcast domain. The reason is, as I explained before, VLANs are an
exception in the sense of being logical interfaces shared on one physical
interface.

So, as in my setup case, it really confuses the switches directly connected
to the Linux box.

To solve the problem, I have made a small modification in the bridge code to
add a proc-controlled flag (/proc/sys/net/bridge/br*/no_vlan_nonlocal_flood)
to optionally put VLANs of a certain bridge in different broadcast domains.
What it does is it checks if this flag is set and the interface net_device
is VLAN and the source MAC address is not the br MAC. If all is true it does
not flood on this specific port. However, if the source MAC of the broadcast
is local (i.e. the br is, for example, sending ARP who-has) it is allowed.

I have tested the patch and it solved my switch-MAC confusion issue below.

If the above makes sense, I would be happy to clean up and post the patch.

Regards

-----Original Message-----
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of Oz
Sent: Monday, June 06, 2005 10:32 AM
To: bridge@lists.osdl.org
Subject: [Bridge] ARP weirdness

All

I have the following setup:

4 VLAN interfaces enslaved in a bridge interface. All VLAN interfaces
don't have IP address. The bridge interface has 192.168.1.1/24.

Now, when I try to ping from one of the VLAN interfaces, through a host
connected to a VLAN switch, while dumping the traffic, the following
happens:
- Host sends ARP who-has broadcast to the VLAN interface (tagged
correctly, originating from the host MAC)
- Linux receives the who-has and does 2 things:
	- It floods all VLAN interfaces with the same ARP who-has request
	- It responds with a unicast is-at on the correct VLAN interface

The question is: why does it flood while the ARP is destined to the
bridge interface?

The problem: I have a another switch connected passively between the
Linux box and the VLAN switch. When the bridge floods (which naturally
happens from the source of the originating box), it causes the switch to
be confused on where to find this specific MAC address and hence
dropping the frame.

Please advice.


