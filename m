Date: Mon, 13 Apr 2009 10:38:48 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090413083848.GB23734@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090413083729.GA23734@psychotron.englab.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090413083729.GA23734@psychotron.englab.brq.redhat.com>
Subject: [Bridge] [PATCH 1/4] net: introduce dev_mac_address_changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

Introducing function dev_mac_address_changed which can be called from driver
which changed his mac address to force notifiers to be called.

Signed-off-by: Jiri Pirko <jpirko@redhat.com>
---
 include/linux/netdevice.h |    1 +
 net/core/dev.c            |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2e7783f..ff8db51 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1461,6 +1461,7 @@ extern int		dev_change_net_namespace(struct net_device *,
 extern int		dev_set_mtu(struct net_device *, int);
 extern int		dev_set_mac_address(struct net_device *,
 					    struct sockaddr *);
+extern void		dev_mac_address_changed(struct net_device *);
 extern int		dev_hard_start_xmit(struct sk_buff *skb,
 					    struct net_device *dev,
 					    struct netdev_queue *txq);
diff --git a/net/core/dev.c b/net/core/dev.c
index 91d792d..1adc89b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3833,6 +3833,18 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa)
 	return err;
 }
 
+/**
+ *	dev_mac_address_changed - Notify Media Access Control Address changed
+ *	@dev: device
+ *
+ *	Notifies the change of the hardware (MAC) address of the device
+ */
+void dev_mac_address_changed(struct net_device *dev)
+{
+	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
+}
+EXPORT_SYMBOL(dev_mac_address_changed);
+
 /*
  *	Perform the SIOCxIFxxx calls, inside read_lock(dev_base_lock)
  */
-- 
1.6.0.6

