Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s2jkzw31rfRz/k9DcMuKTznzONYusXn07ORCMc42hSk=;
 b=Y0/saCT3p2F3jNeeNUQ5DmmY/+oty+yJdhMzI8AAkNptlg2goIT2Qmu/8ITBuKDVdC
 50ApMxf6at+JIlhbPnIVG4XRafnh+ts/mU1vy9C+qC260OVZUU5RN7mj5DxDSZJTNM3M
 EE9V0/eH8ulP0vOzQJGYCboCPycaYHDW24gNL4NvK1r5A1FOJ/gkG0kYrbYe7n/PBTrC
 VKnAWiCf04u1ednj5pg0foDHteVpT1R4t6a5l89ekxsqvUNFODYB6odafqzDEKMh1IJr
 hJSjDkemm+2Jd4zwRd861bjh+ipS1RKQQEBLWUXKktX63Nb91LGeVhDNxcI4XADHDelH
 aN/Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 12 Apr 2022 16:22:43 +0300
Message-Id: <20220412132245.2148794-7-razor@blackwall.org>
In-Reply-To: <20220412132245.2148794-1-razor@blackwall.org>
References: <20220412132245.2148794-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 6/8] net: rtnetlink: add ndm flags and
	state mask attributes
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
index 824963aa57b1..9118523b328f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4170,6 +4170,8 @@ EXPORT_SYMBOL(ndo_dflt_fdb_del);
 static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_VLAN]	= { .type = NLA_U16 },
 	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
+	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16  },
+	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
 
 static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.35.1

