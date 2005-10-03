Message-ID: <4340F179.3000704@inaphone.com>
Date: Mon, 03 Oct 2005 10:53:13 +0200
From: Baldur Norddahl <bbn@inaphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] combining vlan tagging and spanning tree
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I am configuring some servers in a high availability setup. The servers
are connected to two switches with two LAN cards in each server. The two
switches are connected directly to each other.

The servers are configured to bridge eth0 and eth1 with spanning tree.
Usually this makes sure eth1 is disabled, unless something happens to
eth0. This way I can have one IP address on each server.

Now I also want to use vlan tagging on some of the servers.

I am unsure if I am supposed to bridge before or after applying vlan
tagging. That is, if the bridge should be between eth0 and eth1, or
between eth0.2 and eth1.2. I suppose it would also be possible to have a
br0.2.

I managed to get it working sort of. But as soon I enable spanning tree,
I lose contact on the bridge device. Tcpdump still shows traffic on the
underlying device.

I am using gentoo linux 2.6.12.

Thanks,

Baldur
