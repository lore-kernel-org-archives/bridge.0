From: Amerigo Wang <amwang@redhat.com>
Date: Thu, 19 May 2011 18:24:17 +0800
Message-Id: <1305800661-4081-1-git-send-email-amwang@redhat.com>
In-Reply-To: <1305794393-20775-1-git-send-email-amwang@redhat.com>
References: <1305794393-20775-1-git-send-email-amwang@redhat.com>
Subject: [Bridge] [Patch] bridge: call NETDEV_ENSLAVE notifiers when adding
	a slave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Neil Horman <nhorman@redhat.com>, bridge@lists.linux-foundation.org, WANG Cong <amwang@redhat.com>, netdev@vger.kernel.org, Jay Vosburgh <fubar@us.ibm.com>, akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>

In the previous patch I added NETDEV_ENSLAVE, now
we can notify netconsole when adding a device to a bridge too.

By the way, s/netdev_bonding_change/call_netdevice_notifiers/ in
bond_main.c, since this is not bonding specific.

Signed-off-by: WANG Cong <amwang@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>

---
 drivers/net/bonding/bond_main.c |    2 +-
 net/bridge/br_if.c              |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b9c70c5..765fdcf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1640,7 +1640,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev)
 		}
 	}
 
-	netdev_bonding_change(slave_dev, NETDEV_ENSLAVE);
+	call_netdevice_notifiers(NETDEV_ENSLAVE, slave_dev);
 
 	/* If this is the first slave, then we need to set the master's hardware
 	 * address to be the same as the slave's. */
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 5dbdfdf..b44fae5 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -338,6 +338,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
+	call_netdevice_notifiers(NETDEV_ENSLAVE, dev);
+
 	err = dev_set_promiscuity(dev, 1);
 	if (err)
 		goto put_back;
