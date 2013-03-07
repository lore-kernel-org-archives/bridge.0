Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed,  6 Mar 2013 21:31:25 -0500
Message-Id: <1362623485-18209-4-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1362623485-18209-1-git-send-email-vyasevic@redhat.com>
References: <1362623485-18209-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [RFC PATCH net-next 3/3] bridge: Implement IFF_UNICAST_FLT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, bridge@lists.linux-foundation.org

Implement IFF_UNICAST_FLT on the bridge.  Unicast addresses added
to the bridge device are synched to the uplink devices.  This
allows for uplink devices to change while preserving mac assignment.

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_device.c |    9 ++++++++-
 net/bridge/br_fdb.c    |    6 ++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c525e36..61514c1 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -106,6 +106,13 @@ static int br_dev_open(struct net_device *dev)
 
 static void br_dev_set_multicast_list(struct net_device *dev)
 {
+	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge_port *uplink;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(uplink, &br->uplink_list, uplink_list)
+		dev_uc_sync(uplink->dev, dev);
+	rcu_read_unlock();
 }
 
 static int br_dev_stop(struct net_device *dev)
@@ -384,7 +391,7 @@ void br_dev_setup(struct net_device *dev)
 	SET_ETHTOOL_OPS(dev, &br_ethtool_ops);
 	SET_NETDEV_DEVTYPE(dev, &br_type);
 	dev->tx_queue_len = 0;
-	dev->priv_flags = IFF_EBRIDGE;
+	dev->priv_flags = IFF_EBRIDGE | IFF_UNICAST_FLT;
 
 	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
 			NETIF_F_GSO_MASK | NETIF_F_HW_CSUM | NETIF_F_LLTX |
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b0812c9..ef7b51e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -677,6 +677,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_port_vlans *pv;
 	unsigned short vid = VLAN_N_VID;
 
+	if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
+		return ndo_dflt_fdb_add(ndm, tb, dev, addr, nlh_flags);
+
 	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE))) {
 		pr_info("bridge: RTM_NEWNEIGH with invalid state %#x\n", ndm->ndm_state);
 		return -EINVAL;
@@ -774,6 +777,9 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_port_vlans *pv;
 	unsigned short vid = VLAN_N_VID;
 
+	if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
+		return ndo_dflt_fdb_del(ndm, tb, dev, addr);
+
 	if (tb[NDA_VLAN]) {
 		if (nla_len(tb[NDA_VLAN]) != sizeof(unsigned short)) {
 			pr_info("bridge: RTM_NEWNEIGH with invalid vlan\n");
-- 
1.7.7.6

