From: "Jeremy Jones" <jjones@djc.state.id.us>
Date: Wed, 24 Mar 2004 19:50:33 -0700
Message-ID: <000301c41213$f4a6d7b0$f80210ac@djc.state.id.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridging vlans...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

<I apologize if this arrives twice...  I sent it first from an
non-subscribed address, don't know if that'll get to the list or not --JJ>

Hi folks,

I have an implementation question regarding bridging on a linux box between
a catalyst trunk port and a cisco 26something w/802.1q subinterfaces.

So right now, there's no vlan trunking going on on the link my bridging
firewall sits on, but I'm going to need to bridge two vlans, 4 and 51.  My
question is this:  should the vlan interfaces on the linux firewall be
created first, then bridged; or should the bridge interface be created, then
vlans bound to that?

Here's the first:

ip link set eth0 up
ip link set eth1 up
vconfig set_bind_mode PER_DEVICE
vconfig set_name_type DEV_PLUS_VID_NO_PAD
vconfig add eth0 4
vconfig add eth1 4
vconfig add eth0 51
vconfig add eth1 51
ip link set eth0.4 up
ip link set eth1.4 up
ip link set eth0.51 up
ip link set eth1.51 up
brctl addbr br0 
brctl addif br0 eth0.4
brctl addif br0 eth1.4
brctl stp br0 off
ip link set br0 up
brctl addbr br1 
brctl addif br1 eth0.51
brctl addif br1 eth1.51
brctl stp br1 off
ip link set br1 up

And the second:

ip link set eth0 up
ip link set eth1 up
brctl addbr br0 
brctl addif br0 eth0
brctl addif br0 eth1
brctl stp br0 off
ip link set br0 up
vconfig set_bind_mode PER_KERNEL
vconfig set_name_type DEV_PLUS_VID_NO_PAD
vconfig add br0 4
vconfig add br0 51
ip link set br0.4 up
ip link set br0.51 up

I lean towards the first, as it gives me more interfaces to filter, and thus
more flexibility with my iptables rules.  Just looking for the wisdom of
experience...

Thanks,
Jeremy Jones



