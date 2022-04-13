Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8mqGi6nmRQtdTy+PDFk54YLdSIt8nb+5grez+iJIyIQ=;
 b=QHcMActsk48o/Ali36FVmGtylPwMSvJWtiSShrN1MSayZJSwLjSyNfvMr1a/CihU8/
 2aXGBVDTXJEhEfHtDrgXEk+QpsK2Cx4T4Hormg5IXfa5i7gjdzWnri3JQwscS/gVMcnD
 GGGvjmMqLSPo9vTCpDa9ve0rNHD4LZGUAEHGtRNMmAea5QAlDDGTDAzsmRMUjIOB6DU5
 HfEpjDEkLhD2p344keqn11DJkh51F/QHmYJ+Rj2XzRvBqwshtROJqFzcgM1CCWSJwSkp
 /F8UPaDME5EQHHfpDQcjPBzB3OZPNe5tcA09tTNzqcAdjmyD+auXM0JHVM6KTLqSS/QB
 FT3w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 13 Apr 2022 13:52:00 +0300
Message-Id: <20220413105202.2616106-11-razor@blackwall.org>
In-Reply-To: <20220413105202.2616106-1-razor@blackwall.org>
References: <20220413105202.2616106-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 10/12] net: rtnetlink: add ndm flags
	and state mask attributes
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

Add ndm flags/state masks which will be used for bulk delete filtering.
All of these are used by the bridge and vxlan drivers. Also minimal attr
policy validation is added, it is up to ndo_fdb_del_bulk implementers to
further validate them.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/neighbour.h | 2 ++
 net/core/rtnetlink.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index db05fb55055e..39c565e460c7 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -32,6 +32,8 @@ enum {
 	NDA_NH_ID,
 	NDA_FDB_EXT_ATTRS,
 	NDA_FLAGS_EXT,
+	NDA_NDM_STATE_MASK,
+	NDA_NDM_FLAGS_MASK,
 	__NDA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 520d50fcaaea..ab7fb9a16da9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4172,6 +4172,8 @@ EXPORT_SYMBOL(ndo_dflt_fdb_del);
 static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_VLAN]	= { .type = NLA_U16 },
 	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
+	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16  },
+	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
 
 static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.35.1

