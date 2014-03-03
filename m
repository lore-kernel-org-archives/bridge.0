Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sa0oFH1OlWwRRd9Hr72Mvag/WbPY5J7EwK3xXl51pFs=;
	b=sI7XD8e3pPOP3DsthwM3AeBzBV5iOpwzKKrJcob9FYjfHAAV51uUKMCl58zamyzyFO
	zcd5Ewe25AYe/L2hrg/tMC6rTXrEM8aku/Ulu2c66aEQ2tnLlYSlWhXlrPI+CTI1cpqn
	7RfYl4TCaFgFGRhuF13aJ+eveP6mFGOgjX2fF1LTySGsbfCR4a36TpOnyhNh3jLKQNLK
	gPEsQD4wiwvd+YgCNZFiUqUqeST3B5hE5cZnxzU3/N9s2RImapirQdRUrrQgxCrMI89O
	ncyQMG92+dGTsOMB8WMEl+idZ+wp7SpQbdO0+ImoGjNbjcApkpOMw7oBNXKrxF12gHlA
	1Bag==
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon,  3 Mar 2014 14:47:03 -0800
Message-Id: <1393886825-24323-5-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1393886825-24323-1-git-send-email-mcgrof@do-not-panic.com>
References: <1393886825-24323-1-git-send-email-mcgrof@do-not-panic.com>
Subject: [Bridge] [RFC v3 4/6] bridge: enable root block during device
	registration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, mcgrof@suse.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

root block support was added via 1007dd1a on v3.8 but toggling
this flag is only allowed after a device has been registered and
added to a bridge as its a bridge *port* primitive, not a *net_device*
feature. There are work arounds possible to account for the lack
of netlink tools to toggle root_block, such as using the root_block
syfs attribute [0] or using udev / the driver to set the MAC address
to something high such as FE:FF:FF:FF:FF:FF, but neither of these
ensure root block is respected _from_the_start_ through device
initialization.

In order to support the root_block feature from the start since device
initialization and in order to avoid having to require userspace
work arounds to existing deployments this exposes a private
net_device flag which enables drivers that know they want to
start with the root_block feature enabled form the start. The
only caveat with this is topologies that require STP or non-root
will either have to use sysfs [0] or netlink tools like the
iproute2 bridge util to toggle the flag off after initialization.
This is an accepted compromise.

This flag is required given that ndo_add_slave() currently does not
allow specifying any other parameters other than the net_device. We
could extend this but in order to do that properly we'd need to
evaluate all other types of master device implementations.

[0] echo 1 > /sys/devices/vif-2-0/net/vif2.0/brport/root_block

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: kvm@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 include/linux/netdevice.h | 7 +++++++
 net/bridge/br_if.c        | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1a86948..b17643a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1181,6 +1181,11 @@ struct net_device_ops {
  * @IFF_LIVE_ADDR_CHANGE: device supports hardware address
  *	change when it's running
  * @IFF_MACVLAN: Macvlan device
+ * @IFF_BRIDGE_ROOT_BLOCK: don't consider this net_device for root port
+ *	when this interface is added to a bridge. This makes use of the
+ *	root_block mechanism but since its a bridge port primitive this
+ *	flag can be used to instantiate the preference to have root block
+ *	enabled from the start since initialization.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1205,6 +1210,7 @@ enum netdev_priv_flags {
 	IFF_SUPP_NOFCS			= 1<<19,
 	IFF_LIVE_ADDR_CHANGE		= 1<<20,
 	IFF_MACVLAN			= 1<<21,
+	IFF_BRIDGE_ROOT_BLOCK		= 1<<22,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1229,6 +1235,7 @@ enum netdev_priv_flags {
 #define IFF_SUPP_NOFCS			IFF_SUPP_NOFCS
 #define IFF_LIVE_ADDR_CHANGE		IFF_LIVE_ADDR_CHANGE
 #define IFF_MACVLAN			IFF_MACVLAN
+#define IFF_BRIDGE_ROOT_BLOCK		IFF_BRIDGE_ROOT_BLOCK
 
 /*
  *	The DEVICE structure.
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 54d207d..4bee748 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -228,6 +228,8 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
 	br_init_port(p);
 	p->state = BR_STATE_DISABLED;
 	br_stp_port_timer_init(p);
+	if (dev->priv_flags & IFF_BRIDGE_ROOT_BLOCK)
+		p->flags |= BR_ROOT_BLOCK;
 	br_multicast_add_port(p);
 
 	return p;
-- 
1.9.0

