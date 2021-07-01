Return-Path: <w.bumiller@proxmox.com>
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Thu,  1 Jul 2021 14:28:30 +0200
Message-Id: <20210701122830.2652-2-w.bumiller@proxmox.com>
In-Reply-To: <20210701122830.2652-1-w.bumiller@proxmox.com>
References: <20210701122830.2652-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 1/1] net: bridge: sync fdb to new unicast-filtering
	ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, bridge@lists.linux-foundation.org, Thomas Lamprecht <t.lamprecht@proxmox.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Since commit 2796d0c648c9 ("bridge: Automatically manage
port promiscuous mode.")
bridges with `vlan_filtering 1` and only 1 auto-port don't
set IFF_PROMISC for unicast-filtering-capable ports.

Normally on port changes `br_manage_promisc` is called to
update the promisc flags and unicast filters if necessary,
but it cannot distinguish between *new* ports and ones
losing their promisc flag, and new ports end up not
receiving the MAC address list.

Fix this by calling `br_fdb_sync_static` in `br_add_if`
after the port promisc flags are updated and the unicast
filter was supposed to have been filled.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
 net/bridge/br_if.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index f7d2f472ae24..183e72e7b65e 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -652,6 +652,18 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	list_add_rcu(&p->list, &br->port_list);
 
 	nbp_update_port_count(br);
+	if (!br_promisc_port(p) && (p->dev->priv_flags & IFF_UNICAST_FLT)) {
+		/* When updating the port count we also update all ports'
+		 * promiscuous mode.
+		 * A port leaving promiscuous mode normally gets the bridge's
+		 * fdb synced to the unicast filter (if supported), however,
+		 * `br_port_clear_promisc` does not distinguish between
+		 * non-promiscuous ports and *new* ports, so we need to
+		 * sync explicitly here.
+		 */
+		if (br_fdb_sync_static(br, p))
+			netdev_err(dev, "failed to sync bridge addresses to this port\n");
+	}
 
 	netdev_update_features(br->dev);
 
-- 
2.32.0


