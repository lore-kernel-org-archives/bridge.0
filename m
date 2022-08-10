Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22EE360FA8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E261E60C2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=jHImZVkI//te5SMl1xxH/2vTsjBJiQGrltsOXeaVLiI=;
 b=qyr6zLW6SssRFEFqPcOIUy5mytX++/xNFFW8KTB/D8XOB26CCWcxROaVbSBwKd7SJY
 yNt4b3rzSSJ/6qpZgkMOy8AcvPRP/vHFIvVm9k7nLkfbkCqnkt/Y1rHeeDF3ePZUIpNK
 +D0rXnBDU94s7DlKNGF1AuejkuGRaCd1WNG10KY5gYmybHVgazQ08i3IwkBXrCa7QRwf
 81ASdXIRNRYWQ/leISfXEf9wlqf29Z/9pQrLipXgMhesfhyLrNjHRIwLV/RJ0d0jOwwW
 kwi+UiSG3e/7gspP+UYg2v8H+IzEYjKHcJwrsyQliM1MO0JsHMgTh4FunrhPsJkTFwgS
 7DBg==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Tue,  9 Aug 2022 23:11:19 -0400
Message-Id: <b5f740fac8d95cd663a2a21e8ac2ab9ffd06d3c0.1660100506.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 1/3] net: core: export
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

When a bridge binding flag is changed for a vlan interface, the
vlan_dev_change_flags function in the 8021q module is called. Currently, this
function only sets the flag for the vlan interface and returns, which results in
a buggy behavior; it also needs to let the bridge module module know that upper
device for the bridge has changed by propagating NETDEV_CHANGEUPPER event. This
event can be triggered using call_netdevice_notifiers_info function, so export
this function.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/dev.c            | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2563d30736e9..d17ef56c8a06 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2898,6 +2898,8 @@ netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
 }
 
 int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
+int call_netdevice_notifiers_info(unsigned long val,
+				  struct netdev_notifier_info *info);
 
 
 extern rwlock_t				dev_base_lock;		/* Device list lock */
diff --git a/net/core/dev.c b/net/core/dev.c
index 30a1603a7225..50e7483946e0 100644
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
@@ -1927,8 +1925,8 @@ static void move_netdevice_notifiers_dev_net(struct net_device *dev,
  *	are as for raw_notifier_call_chain().
  */
 
-static int call_netdevice_notifiers_info(unsigned long val,
-					 struct netdev_notifier_info *info)
+int call_netdevice_notifiers_info(unsigned long val,
+				  struct netdev_notifier_info *info)
 {
 	struct net *net = dev_net(info->dev);
 	int ret;
@@ -1944,6 +1942,7 @@ static int call_netdevice_notifiers_info(unsigned long val,
 		return ret;
 	return raw_notifier_call_chain(&netdev_chain, val, info);
 }
+EXPORT_SYMBOL(call_netdevice_notifiers_info);
 
 /**
  *	call_netdevice_notifiers_info_robust - call per-netns notifier blocks
-- 
2.25.1

