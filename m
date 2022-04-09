Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=guCQtZJSW+6tAwRjn+xEzfBeefFkGekLuh0Y+O3VkjU=;
 b=bbLtwEAsjB9MTLVpVYrxb3AsIdDdsAXY/PaSdP03vlHL8c/dcfd+Et0gbMMg0K6fR/
 eDjuxvcHs8D/c0Usg9KTbOCYM9jDquU/oVvK/okxHcSF+121z2zgMf1rR0JU6n1cD2U3
 sMSbMW4pQu+USvN+a/xOlLxQR3h+KH3q3Oc4XdI7bEdEq4PRobUoXPDsYMvej1mHljdY
 DxNb8Kfw3DBLUwvrKztbdw2m4qBAauU8M/v1ap3yHlT0ZkZfU0W4scTbVMJregvx3PqO
 tuVR8vRzq0hkxLTBoP7IlBOXp+tuv2ZtAEm+5HlUZSkH1nQORIdvMue809+Qe4wxCQG5
 wQ8A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sat,  9 Apr 2022 13:58:55 +0300
Message-Id: <20220409105857.803667-5-razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 4/6] net: bridge: fdb: add support for
	flush filtering based on ndm flags and state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Add support for fdb flush filtering based on ndm flags and state. The
new attributes allow users to specify a mask and value which are mapped
to bridge-specific flags. NTF_USE is used to represent added_by_user
flag since it sets it on fdb add and we don't have a 1:1 mapping for it.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h |  4 +++
 net/bridge/br_fdb.c            | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 2f3799cf14b2..4638d7e39f2a 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -815,6 +815,10 @@ enum {
 /* embedded in BRIDGE_FLUSH_FDB */
 enum {
 	FDB_FLUSH_UNSPEC,
+	FDB_FLUSH_NDM_STATE,
+	FDB_FLUSH_NDM_STATE_MASK,
+	FDB_FLUSH_NDM_FLAGS,
+	FDB_FLUSH_NDM_FLAGS_MASK,
 	__FDB_FLUSH_MAX
 };
 #define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 62f694a739e1..340a2ace1d5e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -594,8 +594,40 @@ void br_fdb_flush(struct net_bridge *br,
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
+static unsigned long __ndm_flags_to_fdb_flags(u16 ndm_flags)
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
 static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
 	[FDB_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
+	[FDB_FLUSH_NDM_STATE]	= { .type = NLA_U16 },
+	[FDB_FLUSH_NDM_FLAGS]	= { .type = NLA_U16 },
+	[FDB_FLUSH_NDM_STATE_MASK]	= { .type = NLA_U16 },
+	[FDB_FLUSH_NDM_FLAGS_MASK]	= { .type = NLA_U16 },
 };
 
 int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
@@ -610,6 +642,29 @@ int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
 	if (err)
 		return err;
 
+	if (fdb_flush_tb[FDB_FLUSH_NDM_STATE]) {
+		u16 ndm_state = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_STATE]);
+
+		desc.flags |= __ndm_state_to_fdb_flags(ndm_state);
+	}
+	if (fdb_flush_tb[FDB_FLUSH_NDM_STATE_MASK]) {
+		u16 ndm_state_mask;
+
+		ndm_state_mask = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_STATE_MASK]);
+		desc.flags_mask |= __ndm_state_to_fdb_flags(ndm_state_mask);
+	}
+	if (fdb_flush_tb[FDB_FLUSH_NDM_FLAGS]) {
+		u16 ndm_flags = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_FLAGS]);
+
+		desc.flags |= __ndm_flags_to_fdb_flags(ndm_flags);
+	}
+	if (fdb_flush_tb[FDB_FLUSH_NDM_FLAGS_MASK]) {
+		u16 ndm_flags_mask;
+
+		ndm_flags_mask = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_FLAGS_MASK]);
+		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
+	}
+
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
 
-- 
2.35.1

