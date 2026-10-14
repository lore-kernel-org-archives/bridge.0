Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902284E324E
	for <bridge@lists.linux.dev>; Wed, 14 Oct 2026 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022195; cv=none; b=DYvRgf3gMVpK/o1HJsq3Mpc4sO3q0m7MASZkVVe3hsFAc/6lYZwSQo2oIzZA9n3NeB6WThvJsyhrQ6Bw4vgFMYHtpJit5st4vsnILaLjKKk30M9ZvRC5WtiDjyhVWK3nObQhvznzLFOvrY9Cn/1c43JdcVI5wWhn2a1VDNfRE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022195; c=relaxed/simple;
	bh=Sb69TLS+ArkIR+g/zrrpcGCjX6DQJq8Fio93AJ3bmuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTmgElMTs2NSiGAm4Lr6narTbS6obNbFFWmbfuat1TxkCooZsnETpZn+JH9ycgoIXQnJXgJUUj1cn2GlSuEx43kMGhAkQ7PI/hg/e8wvzDEyvo/7JTSByKSr1IZI62DKLbijEXPGhjGynGbfZFdPluIp/ItWLgEyIHkOpIwTePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=DY3Ody8M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="DY3Ody8M"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso3565415a12.0
        for <bridge@lists.linux.dev>; Wed, 14 Oct 2026 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792022192; x=1792626992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51IDFOKytDPr/+Fu8HuSAVvo7OtTDAU+Sn9hNB7a9cA=;
        b=DY3Ody8MCO5pB9r2FWayRV/+n9+81aq/bTRD8hshpXcURhM/04GXwaEn584TqMhp/K
         erF0jCLxLS4HbBRDijNc6gMhZsRPO5MVopele3O1nI3dggzufl1amk9aV7iFx4cIEv+i
         HI0n9jVnGdqsT5wOUEtI7keNrnB0Kx/oh+M5Ocb7gBkcPJAhSjfre+AqUSJgg74Gz9BZ
         4ISqu/zQwdpDgxWikWI+GXucrykFC4a113sCxzFOvBOl8Q7sm3d4Q/8rMQ1H15YmIfRr
         /KtHWJJvJ9Slt69KvUasVaCGRlzb+W/0St8WvWXJjG3Y2aVOfqPA7O0ptZHubPQWh2RC
         0u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022192; x=1792626992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=51IDFOKytDPr/+Fu8HuSAVvo7OtTDAU+Sn9hNB7a9cA=;
        b=JhsEIU3tDQuLVbckRUEyjlKbVjWfaQaom/HkgQ0xPSg/faID5Xzl66zK0sAfqCA0HP
         DNzBb8efXR2YT1LhsDfSyaq4lHaeK75wUFkiy01xiCccqKNmd794xKR9NBJRlIF5k6DX
         iP61mcre7YhUhJu4qi5yuzPPv+N7MlfmGVXo62Da3+Wlx0PlqsgQRR4h0stTzYBDxRqp
         fZ6XUYiUpZLiVj6IJFZALfI9wbBrgs1AlTNdNIRYn+rt/J15dVKO6xXtMhkwrSAdnOwH
         MmYghrC2fXcMu82aWicC7ESAkjFmPGGHt3N4XjsWRA9UvkZjETtdFBuXWfxTQu0NrNAv
         gdrg==
X-Forwarded-Encrypted: i=1; AKwUvBxHAYzrJXaPG52OzclY07TZnK6Y/W2lQ+XQdXZivgNYfhrCqWGdK58k+gxfDRok6ZHdvhdHTlM=@lists.linux.dev
X-Gm-Message-State: AFq9FYK0OLQnqCzEHHiXKI6b8X4jCxc+XCtcjs+oLpszVnn1jQWd1sjq
	4Tv2BtinO/JLevku5j9oTrcoq5mo9JBt0yrzv9Y9EOkpIEVVTZF4I8EoS/04RmINNA==
X-Gm-Gg: AYBFou0iLhKT0zKHUr7mAvUZGSiPKeZ12tmNUq5Q5i2hyblLjTNnVvC4rT1BAXSZvLY
	KQXW+FoweXhLKAbFL5OM4d3yjvoKxGXdLH9mL45uYsVT/WwwSjLtjXUPdK9/RrpibywPkDgUJEc
	5O9mavT01el2e+8dIUVNmCWgrL7HVsSOpaOp28XHbRvLvDRiBeH3RcWRVf4bWyP002M3Bb1OvJP
	11ERwI3UFgXDmDQ8Z8VGb9+MnY7dcRuTiG61gO+4IqR//kAYY89lXMVfZHEOPd2lfLOqW2ujnRc
	sPqI2YnB2e9FGBcxqDPHch58Y13MSTxeOYYyyymiLO/FFL5GmNNEJ8kq/eqUnOZ/dBrJ/S3brx2
	4gYTl++vXSERoIq1zq25qPuZQp3kMM10rpaZjVMlmW6ILfCWD5GmuYh7hqOsPq9liG1e41CQPGk
	uVdnMgYcxTqYcymuMNLgE8d/i04hJu89v1wrom1hiihyWx9nTtCUHXLk+NBd2T2H2psCgxi8qAj
	7N/amblEDbbgTtL3pctBt4U7DAwruehK7+qWFRXjCYajqQxI6tyizVpdgNLAnMkYZCxZFzdJmXQ
	dwhXE/26Dd6Lh7M4uYQJp03opXvMkmn+rVlkC+e29K8PLDEFRX2EAyyg/fq/WhWIvR3RWGHQjr3
	qCcEP+6b+dhv46Pa+3xlcPY31vh8JcbIm1QmwFW+9rt/Mnx73BN7d/etwdvsVkAnWZkFP18s6Ge
	aFRVJTDHxTMpiM8eyB9JPXpqQ=
X-Received: by 2002:a17:907:961a:b0:c31:7a83:bd78 with SMTP id a640c23a62f3a-c31a70d32bemr1562128066b.27.1792022191900;
        Wed, 14 Oct 2026 16:56:31 -0700 (PDT)
Received: from Desktop (p54affd5a.dip0.t-ipconnect.de. [84.175.253.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3edab12007sm46101666b.82.2026.10.14.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:56:31 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v7 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Thu, 15 Oct 2026 01:56:26 +0200
Message-ID: <20261014235628.197976-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014235628.197976-1-julius@bairaktaris.de>
References: <20261014235628.197976-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A direct xmit flow stores the bridge port the fdb resolved when the flow
was created. When the host moves to another port of the bridge, the flow
keeps sending to the old port, and packets from the other side keep it
from timing out. A hardware offloaded flow behaves the same.

The gc now asks the bridge, through nf_br_utils_hook, which port the fdb
entry points to, and tears the flow down when it is another port. The
hook keeps the flowtable independent of the bridge module. An entry that
aged out leaves the flow alone, because offloaded packets do not refresh
it.

The bridge port and the vid of the fdb lookup are saved when the flow is
created. The port is not out.ifidx when it is a vlan device, and the vid
is not in the encap stack for an untagged port of a vlan_filtering
bridge.

Co-developed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/netfilter.h             |  8 ++++++
 include/net/netfilter/nf_flow_table.h |  4 +++
 net/bridge/Makefile                   |  2 ++
 net/bridge/br.c                       |  2 ++
 net/bridge/br_nf_utils.c              | 40 +++++++++++++++++++++++++++
 net/bridge/br_private.h               | 13 +++++++++
 net/netfilter/core.c                  |  3 ++
 net/netfilter/nf_flow_table_core.c    | 27 ++++++++++++++++++
 net/netfilter/nf_flow_table_path.c    |  9 ++++++
 9 files changed, 108 insertions(+)
 create mode 100644 net/bridge/br_nf_utils.c

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index e99afc1414cd3..b79626137579f 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -67,6 +67,14 @@ static inline void nf_inet_addr_mask(const union nf_inet_addr *a1,
 #endif
 }
 
+/* The bridge fills this in for the flowtable, which must not depend on it. */
+struct nf_br_utils {
+	bool (*fdb_moved)(struct net *net, int ifindex,
+			  const unsigned char *addr, u16 vid);
+};
+
+extern const struct nf_br_utils __rcu *nf_br_utils_hook;
+
 int netfilter_init(void);
 
 struct sk_buff;
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 5b611efaa3cd1..fb3786220a652 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -164,6 +164,8 @@ struct flow_offload_tuple {
 		};
 		struct {
 			u32		ifidx;
+			u32		bridge_ifidx;
+			u16		bridge_vid;
 			u8		h_source[ETH_ALEN];
 			u8		h_dest[ETH_ALEN];
 		} out;
@@ -232,6 +234,8 @@ struct nf_flow_route {
 		struct {
 			u32			ifindex;
 			u32			hw_ifindex;
+			u32			bridge_ifindex;
+			u16			bridge_vid;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
 			u8			needs_gso_segment:1;
diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 1203dc19e15c9..fc53c332246de 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -14,6 +14,8 @@ bridge-$(CONFIG_SYSFS) += br_sysfs_if.o br_sysfs_br.o
 
 bridge-$(subst m,y,$(CONFIG_BRIDGE_NETFILTER)) += br_nf_core.o
 
+bridge-$(subst m,y,$(CONFIG_NF_FLOW_TABLE)) += br_nf_utils.o
+
 br_netfilter-y := br_netfilter_hooks.o
 br_netfilter-$(subst m,y,$(CONFIG_IPV6)) += br_netfilter_ipv6.o
 obj-$(CONFIG_BRIDGE_NETFILTER) += br_netfilter.o
diff --git a/net/bridge/br.c b/net/bridge/br.c
index d9a39ff98868d..c0618ef6dac5c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -458,6 +458,7 @@ static int __init br_init(void)
 		goto err_out6;
 
 	brioctl_set(br_ioctl_stub);
+	br_nf_utils_init();
 
 #if IS_MODULE(CONFIG_BRIDGE_NETFILTER)
 	pr_info("bridge: filtering via arp/ip/ip6tables is no longer available "
@@ -486,6 +487,7 @@ static int __init br_init(void)
 
 static void __exit br_deinit(void)
 {
+	br_nf_utils_fini();
 	stp_proto_unregister(&br_stp_proto);
 	br_netlink_fini();
 	unregister_switchdev_blocking_notifier(&br_switchdev_blocking_notifier);
diff --git a/net/bridge/br_nf_utils.c b/net/bridge/br_nf_utils.c
new file mode 100644
index 0000000000000..dac08ff6346d6
--- /dev/null
+++ b/net/bridge/br_nf_utils.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/netdevice.h>
+#include <linux/netfilter.h>
+
+#include "br_private.h"
+
+/* True if the bridge now sends to @addr through another port than @ifindex.
+ * An entry that aged out is not a move: packets the flowtable forwards do
+ * not pass the bridge, so they do not refresh it. Called under RCU.
+ */
+static bool nf_br_fdb_moved(struct net *net, int ifindex,
+			    const unsigned char *addr, u16 vid)
+{
+	const struct net_bridge_fdb_entry *f;
+	const struct net_bridge_port *p;
+	struct net_device *dev;
+
+	dev = dev_get_by_index_rcu(net, ifindex);
+	p = dev ? br_port_get_check_rcu(dev) : NULL;
+	if (!p)
+		return true;
+
+	f = br_fdb_find_rcu(p->br, addr, vid);
+
+	return f && br_fdb_dst_port(f) != p;
+}
+
+static const struct nf_br_utils nf_br_utils = {
+	.fdb_moved	= nf_br_fdb_moved,
+};
+
+void br_nf_utils_init(void)
+{
+	rcu_assign_pointer(nf_br_utils_hook, &nf_br_utils);
+}
+
+void br_nf_utils_fini(void)
+{
+	RCU_INIT_POINTER(nf_br_utils_hook, NULL);
+}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 05921192ebda1..22c9e17d76175 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2164,6 +2164,19 @@ struct nf_br_ops {
 };
 extern const struct nf_br_ops __rcu *nf_br_ops;
 
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+void br_nf_utils_init(void);
+void br_nf_utils_fini(void);
+#else
+static inline void br_nf_utils_init(void)
+{
+}
+
+static inline void br_nf_utils_fini(void)
+{
+}
+#endif
+
 /* br_netfilter.c */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 int br_nf_core_init(void);
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 940dea2663e95..914f0934f6da3 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -814,6 +814,9 @@ static struct pernet_operations netfilter_net_ops = {
 	.exit = netfilter_net_exit,
 };
 
+const struct nf_br_utils __rcu *nf_br_utils_hook;
+EXPORT_SYMBOL_GPL(nf_br_utils_hook);
+
 int __init netfilter_init(void)
 {
 	int ret;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 0d72dc8ae47a1..5f49e1f8e7c80 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -139,6 +139,9 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		memcpy(flow_tuple->out.h_source, route->tuple[dir].out.h_source,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
+		flow_tuple->out.bridge_ifidx =
+			route->tuple[dir].out.bridge_ifindex;
+		flow_tuple->out.bridge_vid = route->tuple[dir].out.bridge_vid;
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
@@ -572,9 +575,31 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	nf_ct_put(ct);
 }
 
+static bool nf_flow_bridge_port_moved(struct net *net,
+				      const struct flow_offload_tuple *tuple)
+{
+	const struct nf_br_utils *br_utils;
+	bool moved = false;
+
+	if (tuple->xmit_type != FLOW_OFFLOAD_XMIT_DIRECT ||
+	    !tuple->out.bridge_ifidx)
+		return false;
+
+	rcu_read_lock();
+	br_utils = rcu_dereference(nf_br_utils_hook);
+	if (br_utils)
+		moved = br_utils->fdb_moved(net, tuple->out.bridge_ifidx,
+					    tuple->out.h_dest,
+					    tuple->out.bridge_vid);
+	rcu_read_unlock();
+
+	return moved;
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
+	struct net *net = read_pnet(&flow_table->net);
 	bool teardown;
 
 	if (test_bit(NF_FLOW_PENDING, &flow->flags))
@@ -586,6 +611,8 @@ static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 	    nf_ct_is_dying(flow->ct) ||
 	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple) ||
 	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple) ||
+	    nf_flow_bridge_port_moved(net, &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple) ||
+	    nf_flow_bridge_port_moved(net, &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple) ||
 	    nf_flow_custom_gc(flow_table, flow)) {
 		flow_offload_teardown(flow);
 		teardown = true;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index d90013685bf12..f1efe5095f07b 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -89,6 +89,8 @@ struct nft_forward_info {
 		__be16	proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
 	u8 num_encaps;
+	u32 bridge_ifidx;
+	u16 bridge_vid;
 	struct flow_offload_tunnel tun;
 	struct dst_entry *tun_dst;
 	u8 num_tuns;
@@ -183,6 +185,11 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
 			}
+			/* dev_fill_forward_path() adds the bridge port after
+			 * the bridge.
+			 */
+			info->bridge_ifidx = stack->path[i + 1].dev->ifindex;
+			info->bridge_vid = path->bridge.vlan_id;
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		default:
@@ -260,6 +267,8 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 	if (info.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT) {
 		memcpy(route->tuple[dir].out.h_source, info.h_source, ETH_ALEN);
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
+		route->tuple[dir].out.bridge_ifindex = info.bridge_ifidx;
+		route->tuple[dir].out.bridge_vid = info.bridge_vid;
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 	route->tuple[dir].out.needs_gso_segment = info.needs_gso_segment;
-- 
2.53.0

