Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ruKthvyRBdKBojJ9cI3HF+YHEwKh0vpzBB/A3CTMky8=;
 b=6Lxea4KtEreyzkvQXC0nXxpr8fx0jK/b9OrGY4V/fWEGgtpTyMivpumpy3aP/IakOl
 tqVLSodTNTYTpQ7nOYxeY3DWoUkI9LM4YNnXNIig8zMAbaaZ8LFKcq6lVH4Hg9WbSkwU
 jTRbFngE6hu3Xu3J2kVRxEMKESXUSZW3ey55pOVgGeAsnL8nsATeU2BIyhIJfSJ8A3aO
 Em6+F2H38vxyVEYmwaXQmrYtUnZ1AZrDD/rwvwLZfTCGD2vkgvjKhTrffJLfn4krZwcy
 pCIyS4zrwr7HuYVY2dX1o81fiyK0PS3A//+MMjEsSS4E+eOtJmNuC6vHi9ZM4oQVFR6V
 5cyQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sat,  9 Apr 2022 13:58:56 +0300
Message-Id: <20220409105857.803667-6-razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 5/6] net: bridge: fdb: add support for
	flush filtering based on ifindex
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

Add support for fdb flush filtering based on destination ifindex. The
ifindex must either match a port's device ifindex or the bridge's.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br_fdb.c            | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 4638d7e39f2a..67ee12586844 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -819,6 +819,7 @@ enum {
 	FDB_FLUSH_NDM_STATE_MASK,
 	FDB_FLUSH_NDM_FLAGS,
 	FDB_FLUSH_NDM_FLAGS_MASK,
+	FDB_FLUSH_PORT_IFINDEX,
 	__FDB_FLUSH_MAX
 };
 #define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 340a2ace1d5e..53208adf7474 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -628,6 +628,7 @@ static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
 	[FDB_FLUSH_NDM_FLAGS]	= { .type = NLA_U16 },
 	[FDB_FLUSH_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[FDB_FLUSH_NDM_FLAGS_MASK]	= { .type = NLA_U16 },
+	[FDB_FLUSH_PORT_IFINDEX]	= { .type = NLA_S32 },
 };
 
 int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
@@ -664,6 +665,12 @@ int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
 		ndm_flags_mask = nla_get_u16(fdb_flush_tb[FDB_FLUSH_NDM_FLAGS_MASK]);
 		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
 	}
+	if (fdb_flush_tb[FDB_FLUSH_PORT_IFINDEX]) {
+		int port_ifidx;
+
+		port_ifidx = nla_get_u32(fdb_flush_tb[FDB_FLUSH_PORT_IFINDEX]);
+		desc.port_ifindex = port_ifidx;
+	}
 
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
-- 
2.35.1

