Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81C7260C29
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D17A460AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=rA1J3wNnURwjVaQRzDPJJFo52izXeQrMGO3evzyuiQ0=;
 b=KxoD7xykKYyawuxkaTKHAsD+UHEKwbfX7XWCNBZe6i7Mgrw0YCsTjl+qKqObCTg6p0
 Act4uRMpeCSYfygeT7s2GPeEMjBiZx2NKzesoXaO38hnh+dFLYZeuerbOgD0h7aQpNpA
 BE4nMBe9E5K6ppuDhZupAYJkurPuEAOIjfUZ3+DIvrYkNz1HBb92lc8uK22slSLy1SkN
 K4enAfXoM/6wWBxcp/GQlLS2x0PwMU9qyFLWxt9HMB5rFG9TCu0npvbhSMJ6bSsDJQbL
 VAFQv4WIJnvs+PQX1jJ0r3ctc7FpQRnlvPxkuOLp2BkxE+s7ZRcARsOyU0XsW5DugsVW
 drZg==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 17 Sep 2022 16:17:57 -0400
Message-Id: <d6eaa0453446118ead2912bea6ef7b25c136b01c.1663445339.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 1/5] net: core: export
	call_netdevice_notifiers_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: aroulin@nvidia.com, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

The function call_netdevice_notifiers_info will be used by the vlan
module for sending link-type-specific information to other modules.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/dev.c            | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f0068c1ff1df..56b96b1e4c4c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2906,6 +2906,8 @@ netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
 }
 
 int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
+int call_netdevice_notifiers_info(unsigned long val,
+				  struct netdev_notifier_info *info);
 
 
 extern rwlock_t				dev_base_lock;		/* Device list lock */
diff --git a/net/core/dev.c b/net/core/dev.c
index d66c73c1c734..e233145d1452 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -160,8 +160,6 @@ struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 struct list_head ptype_all __read_mostly;	/* Taps */
 
 static int netif_rx_internal(struct sk_buff *skb);
-static int call_netdevice_notifiers_info(unsigned long val,
-					 struct netdev_notifier_info *info);
 static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
@@ -1927,7 +1925,7 @@ static void move_netdevice_notifiers_dev_net(struct net_device *dev,
  *	are as for raw_notifier_call_chain().
  */
 
-static int call_netdevice_notifiers_info(unsigned long val,
+int call_netdevice_notifiers_info(unsigned long val,
 					 struct netdev_notifier_info *info)
 {
 	struct net *net = dev_net(info->dev);
@@ -1944,6 +1942,7 @@ static int call_netdevice_notifiers_info(unsigned long val,
 		return ret;
 	return raw_notifier_call_chain(&netdev_chain, val, info);
 }
+EXPORT_SYMBOL_GPL(call_netdevice_notifiers_info);
 
 /**
  *	call_netdevice_notifiers_info_robust - call per-netns notifier blocks
-- 
2.34.1

