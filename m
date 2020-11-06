Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701123;
 bh=ThvhNKOFOFHaosgCVt+39Sx4lXYGht1uFMD73kyaQRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tOpWDXH+Q4KDyV6w6IsyuUCJZc32wNUWOBB5dV0/RF2bumxz7FCAS61KdEn3vv6c9
 uTdaPXXMZpVpamKG8qDdM5nAn3bsGbuv50ORc0NJX0ZBSyFEJIvWwimdvvzp2nH/UO
 hOQyMJXMJzIiQm7Pnckg1zl6/nSOujSrtWGsXAdA=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:32 +0100
Message-Id: <20201106221743.3271965-18-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 17/28] qeth: use ndo_siocdevprivate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

qeth has both standard MII ioctls and custom SIOCDEVPRIVATE ones,
all of which work correctly with compat user space.

Move the private ones over to the new ndo_siocdevprivate callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/net/qeth_core.h      |  2 ++
 drivers/s390/net/qeth_core_main.c | 35 ++++++++++++++++++++++---------
 drivers/s390/net/qeth_l3_main.c   |  6 +++---
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f73b4756ed5e..67da90dea919 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1118,6 +1118,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			unsigned int offset, unsigned int hd_len,
 			int elements_needed);
 int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+int qeth_siocdevprivate(struct net_device *dev, struct ifreq *rq,
+			void __user *data, int cmd);
 void qeth_dbf_longtext(debug_info_t *id, int level, char *text, ...);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 93c9b30ab17a..7d785ddffcc0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6474,21 +6474,42 @@ struct qeth_card *qeth_get_card_by_busid(char *bus_id)
 }
 EXPORT_SYMBOL_GPL(qeth_get_card_by_busid);
 
-int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+int qeth_siocdevprivate(struct net_device *dev, struct ifreq *rq, void __user *data, int cmd)
 {
 	struct qeth_card *card = dev->ml_priv;
-	struct mii_ioctl_data *mii_data;
 	int rc = 0;
 
 	switch (cmd) {
 	case SIOC_QETH_ADP_SET_SNMP_CONTROL:
-		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
+		rc = qeth_snmp_command(card, data);
 		break;
 	case SIOC_QETH_GET_CARD_TYPE:
 		if ((IS_OSD(card) || IS_OSM(card) || IS_OSX(card)) &&
 		    !IS_VM_NIC(card))
 			return 1;
 		return 0;
+	case SIOC_QETH_QUERY_OAT:
+		rc = qeth_query_oat_command(card, data);
+		break;
+	default:
+		if (card->discipline->do_ioctl)
+			rc = card->discipline->do_ioctl(dev, data, cmd);
+		else
+			rc = -EOPNOTSUPP;
+	}
+	if (rc)
+		QETH_CARD_TEXT_(card, 2, "ioce%x", rc);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qeth_siocdevprivate);
+
+int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct qeth_card *card = dev->ml_priv;
+	struct mii_ioctl_data *mii_data;
+	int rc = 0;
+
+	switch (cmd) {
 	case SIOCGMIIPHY:
 		mii_data = if_mii(rq);
 		mii_data->phy_id = 0;
@@ -6501,14 +6522,8 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			mii_data->val_out = qeth_mdio_read(dev,
 				mii_data->phy_id, mii_data->reg_num);
 		break;
-	case SIOC_QETH_QUERY_OAT:
-		rc = qeth_query_oat_command(card, rq->ifr_ifru.ifru_data);
-		break;
 	default:
-		if (card->discipline->do_ioctl)
-			rc = card->discipline->do_ioctl(dev, rq, cmd);
-		else
-			rc = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 	if (rc)
 		QETH_CARD_TEXT_(card, 2, "ioce%x", rc);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b1c1d2510d55..546bebd264f2 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1532,7 +1532,7 @@ static int qeth_l3_arp_flush_cache(struct qeth_card *card)
 	return rc;
 }
 
-static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, void __user *data, int cmd)
 {
 	struct qeth_card *card = dev->ml_priv;
 	struct qeth_arp_cache_entry arp_entry;
@@ -1552,13 +1552,13 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 			rc = -EPERM;
 			break;
 		}
-		rc = qeth_l3_arp_query(card, rq->ifr_ifru.ifru_data);
+		rc = qeth_l3_arp_query(card, data);
 		break;
 	case SIOC_QETH_ARP_ADD_ENTRY:
 	case SIOC_QETH_ARP_REMOVE_ENTRY:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		if (copy_from_user(&arp_entry, rq->ifr_data, sizeof(arp_entry)))
+		if (copy_from_user(&arp_entry, data, sizeof(arp_entry)))
 			return -EFAULT;
 
 		arp_cmd = (cmd == SIOC_QETH_ARP_ADD_ENTRY) ?
-- 
2.27.0

