Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aa6aODpsX834V6oU0xZmiqy1nFlZHpElVbhhKZgOhDo=;
 b=sQEOZPXHoxZtbTNkHHooY4Pumi+oskz2F8ufdb3z6JrWAZa1A6Q72GLJxcN3nWax19
 vihTl5SF3JYm2heSXB8FQ+QsvGRblKrLsjSWXbJ3D4a3Jx56AIA/ojVZn10ynMIiq/+z
 gPrEYy752hlctVr60LlMKKuPUpp5v2EoWndmvDAzPKzzHrjNSYltG4+ZWM0oM8hTYAyc
 RSLASk9DytjL35qgc/9+F0YRWQya24EEjesNUYKL/vELEnZ2KMaRUL60vYConZ7lTUwH
 nN4zfmFbt0wck+AGDxFMMRYtINkv5fV3oxZG4ePmPGi8X3wOk5YX7FT7pW7Cnpg4+sYF
 x6sQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 13 Aug 2021 18:00:02 +0300
Message-Id: <20210813150002.673579-7-razor@blackwall.org>
In-Reply-To: <20210813150002.673579-1-razor@blackwall.org>
References: <20210813150002.673579-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 6/6] net: bridge: vlan: dump mcast ctx
	querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Use the new mcast querier state dump infrastructure and export vlans'
mcast context querier state embedded in attribute
BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br_vlan_options.c   | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index eceaad200bf6..f71a81fdbbc6 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -563,6 +563,7 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
 	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER,
 	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS,
+	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index b4fd5fa441b7..49dec53a4a74 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -299,7 +299,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_QUERIER,
 		       v_opts->br_mcast_ctx.multicast_querier) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ROUTER,
-		       v_opts->br_mcast_ctx.multicast_router))
+		       v_opts->br_mcast_ctx.multicast_router) ||
+	    br_multicast_dump_querier_state(skb, &v_opts->br_mcast_ctx,
+					    BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE))
 		goto out_err;
 
 	clockval = jiffies_to_clock_t(v_opts->br_mcast_ctx.multicast_last_member_interval);
@@ -379,6 +381,7 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(void)
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ROUTER */
+		+ br_multicast_querier_state_size() /* BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE */
 #endif
 		+ nla_total_size(sizeof(u16)); /* BRIDGE_VLANDB_GOPTS_RANGE */
 }
-- 
2.31.1

