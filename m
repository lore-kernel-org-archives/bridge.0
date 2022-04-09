Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pI4juhDXvvHTh0rGKGfMfLE6PZX77VF+PfLCGPPEVPU=;
 b=7Xj6XrbUXlfjlBFZqVNm3ajjO3GpKvG9FGv29kYvmyM0tZ/j7ilBb7io1qOU53kWbb
 yr4jlrpYDe7dIV7kbQk282i9NwC2uFaWTAwGux3wcAoxVpIUddc1LVr6cnmHxOQjFDg6
 2F+mew77iqtO4+3ht4Rg+43B0GcBiFyMyrPW48qVeHUcd9HilQp0FDei3LEkYybW7O5J
 DvEPuEddTG1Drn3hMrsH005CeJXzgYaJVV2Hj6HDEHi/oWo3/wtq2EXzirUHJY9gXFXg
 +tiwAyrWhoZLoa+lCuh2d4yTc+zkPlGPKWTRSE7hbtm4R2MuL9Wev4RwFd/GpTMEpdgi
 c91A==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sat,  9 Apr 2022 13:58:57 +0300
Message-Id: <20220409105857.803667-7-razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 6/6] net: bridge: fdb: add support for
	flush filtering based on vlan id
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

Add support for fdb flush filtering based on vlan id.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br_fdb.c            | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 67ee12586844..7f6730812916 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -820,6 +820,7 @@ enum {
 	FDB_FLUSH_NDM_FLAGS,
 	FDB_FLUSH_NDM_FLAGS_MASK,
 	FDB_FLUSH_PORT_IFINDEX,
+	FDB_FLUSH_VLAN_ID,
 	__FDB_FLUSH_MAX
 };
 #define FDB_FLUSH_MAX (__FDB_FLUSH_MAX - 1)
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 53208adf7474..bc8b5cbde8ed 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -626,6 +626,7 @@ static const struct nla_policy br_fdb_flush_policy[FDB_FLUSH_MAX + 1] = {
 	[FDB_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
 	[FDB_FLUSH_NDM_STATE]	= { .type = NLA_U16 },
 	[FDB_FLUSH_NDM_FLAGS]	= { .type = NLA_U16 },
+	[FDB_FLUSH_VLAN_ID]	= { .type = NLA_U16 },
 	[FDB_FLUSH_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[FDB_FLUSH_NDM_FLAGS_MASK]	= { .type = NLA_U16 },
 	[FDB_FLUSH_PORT_IFINDEX]	= { .type = NLA_S32 },
@@ -671,6 +672,11 @@ int br_fdb_flush_nlattr(struct net_bridge *br, struct nlattr *fdb_flush_attr,
 		port_ifidx = nla_get_u32(fdb_flush_tb[FDB_FLUSH_PORT_IFINDEX]);
 		desc.port_ifindex = port_ifidx;
 	}
+	if (fdb_flush_tb[FDB_FLUSH_VLAN_ID]) {
+		desc.vlan_id = nla_get_u16(fdb_flush_tb[FDB_FLUSH_VLAN_ID]);
+		if (!br_vlan_valid_id(desc.vlan_id, extack))
+			return -EINVAL;
+	}
 
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
-- 
2.35.1

