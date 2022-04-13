Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nLzD5ZvuNGbT0XhKBua9fX6TvMHLlvf+6Ft78xLIFCA=;
 b=m38OBvuHHfPfmkqotdW5ajttO/ICTZzAXVPObUzxr6h97LiGtwqe/Gy/sYV0nvf/zz
 SKnbpal2+iL0BH92l664EYrT6FVn3DiffZNLekIc6jZyBnXh62+HDrphJGjzGvlEr8mA
 uA9OaeJujdz7XIByGk0R54D3pUtBnMPx60DvTXogOipDYQeTMnNjfSV2ogjoMIHI3QlK
 PsddNAjAvo220hS11uS2vPV1C4ppVGea8mGn6f7R9qpiKVwnfIOt1CjBmT/oRVPR7LTC
 Q5PHPIXQMaZi7+3MiiGi3USq4gqb3G7YJnH1ApZBYmbAaMCiMWhekcf/j7kyx3cZ3Cgt
 BTUw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:52:01 +0300
Message-Id: <20220413105202.2616106-12-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 11/12] net: bridge: fdb: add support
	for flush filtering based on ndm flags and state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Add support for fdb flush filtering based on ndm flags and state. NDM
state and flags are mapped to bridge-specific flags and matched
according to the specified masks. NTF_USE is used to represent
added_by_user flag since it sets it on fdb add and we don't have a 1:1
mapping for it. Only allowed bits can be set, NTF_SELF and NTF_MASTER are
ignored.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: ignore NTF_USE/NTF_MASTER and reject unknown flags
v3: NDFA -> NDA attributes

 net/bridge/br_fdb.c     | 58 ++++++++++++++++++++++++++++++++++++++---
 net/bridge/br_private.h |  5 ++++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 45d02f2264db..74d759d09f94 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -594,13 +594,40 @@ void br_fdb_flush(struct net_bridge *br,
 	rcu_read_unlock();
 }
 
+static unsigned long __ndm_state_to_fdb_flags(u16 ndm_state)
+{
+	unsigned long flags = 0;
+
+	if (ndm_state & NUD_PERMANENT)
+		__set_bit(BR_FDB_LOCAL, &flags);
+	if (ndm_state & NUD_NOARP)
+		__set_bit(BR_FDB_STATIC, &flags);
+
+	return flags;
+}
+
+static unsigned long __ndm_flags_to_fdb_flags(u8 ndm_flags)
+{
+	unsigned long flags = 0;
+
+	if (ndm_flags & NTF_USE)
+		__set_bit(BR_FDB_ADDED_BY_USER, &flags);
+	if (ndm_flags & NTF_EXT_LEARNED)
+		__set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &flags);
+	if (ndm_flags & NTF_OFFLOADED)
+		__set_bit(BR_FDB_OFFLOADED, &flags);
+	if (ndm_flags & NTF_STICKY)
+		__set_bit(BR_FDB_STICKY, &flags);
+
+	return flags;
+}
+
 int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		       struct net_device *dev, u16 vid,
 		       struct netlink_ext_ack *extack)
 {
-	struct net_bridge_fdb_flush_desc desc = {
-		.flags_mask = BR_FDB_STATIC
-	};
+	u8 ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
+	struct net_bridge_fdb_flush_desc desc = {};
 	struct net_bridge_port *p = NULL;
 	struct net_bridge *br;
 
@@ -615,6 +642,31 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		br = p->br;
 	}
 
+	if (ndm_flags & ~FDB_FLUSH_ALLOWED_NDM_FLAGS) {
+		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm flag bits set");
+		return -EINVAL;
+	}
+	if (ndm->ndm_state & ~FDB_FLUSH_ALLOWED_NDM_STATES) {
+		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm state bits set");
+		return -EINVAL;
+	}
+
+	desc.flags |= __ndm_state_to_fdb_flags(ndm->ndm_state);
+	desc.flags |= __ndm_flags_to_fdb_flags(ndm_flags);
+	if (tb[NDA_NDM_STATE_MASK]) {
+		u16 ndm_state_mask = nla_get_u16(tb[NDA_NDM_STATE_MASK]);
+
+		desc.flags_mask |= __ndm_state_to_fdb_flags(ndm_state_mask);
+	}
+	if (tb[NDA_NDM_FLAGS_MASK]) {
+		u8 ndm_flags_mask = nla_get_u8(tb[NDA_NDM_FLAGS_MASK]);
+
+		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
+	}
+
+	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
+		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
+
 	br_fdb_flush(br, &desc);
 
 	return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4d2a809546fb..353dd4a6da7c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -762,6 +762,11 @@ static inline void br_netpoll_disable(struct net_bridge_port *p)
 #endif
 
 /* br_fdb.c */
+#define FDB_FLUSH_IGNORED_NDM_FLAGS (NTF_MASTER | NTF_SELF)
+#define FDB_FLUSH_ALLOWED_NDM_STATES (NUD_PERMANENT | NUD_NOARP)
+#define FDB_FLUSH_ALLOWED_NDM_FLAGS (NTF_USE | NTF_EXT_LEARNED | \
+				     NTF_STICKY | NTF_OFFLOADED)
+
 int br_fdb_init(void);
 void br_fdb_fini(void);
 int br_fdb_hash_init(struct net_bridge *br);
-- 
2.35.1

