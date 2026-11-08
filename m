Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153228;
	b=OB5x6hOtbXPLzti4wVBbuERKL2eRxaWYKK/hZGTJSuCe4NxUvUdGCNgvNvfIqlKySve5
	 Rb2tkptenR2NaopoLZMfP175LJ+FyqRTA0khEqRgXKVE6V/slDmnctcrWZIhf+Q0gesfy
	 ZJKKsS4nc3JfbYppgLAhi2G4Nag2sSRk3BwMCyWaJ76OHfNRXdAXFYr1UEMXa/IWE+/Ng
	 iISKupiZXAzmH5HExl+6yXgCoqPITQ16Itoqv54KzyFdScvqUCGUdPNKP/jPhHdqrVh34
	 9COQMhbfvpakoXY7f7FAbHvgDpzsgYJvR+JvhGCh04ylW7TqA/YcXImUCrXwLY41pGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
	b=dElMDm+UnSJU8fsHZb4N1g5Krc6dPhi/XAU4s3CqFYLQCMkbjaYcTmyTYhHhlicZ6vc6
	 cUHt49U02WKW07ZvJ/5MYutKMvQA1jOEzmuWYPGusNFB3tyJWo8wmTRxsxPZgOlrq4X7q
	 NtB/cC6ihDjBWUU8UUrePjbGcMCv8xtKT+54l7YXCtAZESWPlAR6EvIFS814LuRqMqELP
	 7qOQ841Va94mFeTtEQ8s9SluZrtV+zhV1sN5agsgdxff2aCA3yzlEjrZrjtgWxMGYK2sl
	 qHxwqlOf5BQqgzQRN/eCwguIA7dhOzvVhN39Gz5Apb644gmjwtGuxCljiA4rJ5JZWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=rVQyvwLI;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85007606A334
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 15:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85007606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=rVQyvwLI
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so270115a12.1
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 07:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794153226; x=1794758026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
        b=rVQyvwLIFlMQnMF2uac+RNSZnNdOkLPpBLZMHpeOBGHoHEr1OZ5dXUM6MHuHRxlK3+
         6nfikOZGLDko2tb7MyFXddMSmZgwKp89F8Iue9MFSE6va82vZVjrLyqvQLhn+J07r+BT
         PWRqtiJ2/5ciP0uVyp/6SrK4bGF2PbV95IrcL/8ZNkUM/psT6vp0xOm288wvBhWXM12k
         RL7jlANBt9+SLKSNuV/lQ1jtYARXUS7mI7XAKox9tg7dvVjN5NYVETDkeagVKIjn5fSS
         LmZMbefIQB8mTuEnoSPqB7NvlA162Uqub/bydtfeXdVu1PeByw0i/8urrf5HJY1s5N92
         yCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153226; x=1794758026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puOmjAIPgIiLDy8Ot4FwAIFzyOF16FeUvkFVhIy11VA=;
        b=DoAbs8BvcifPl4ezW2mKB0VvplzRHaLpPoV+YGdYp72HixflDaITYrWZtZz4CgCxGT
         AGxzkZRruUD5hhpcwR6IAMPai00qtEXcB9xx8RA1E19ZVEJcjPd0T7hyt655riaEO3/L
         bqT0qbZrcqDMnUFCG/aIHKGEUqn0Sx/SJ0XxDSBFE+6WgmexqPlZ0EMxiRKWgLI/RX+N
         5GOIEmC954/53hnZE028VlL2RQWzWALx9ZA+GuABaU7XBl8dSiIAoJIiasI8stWcrw1X
         0yy6LCFK5Gy84Bjg2KRtgrrIRrWaZ1U+yNarhfaZXwyCLyy1lcX27REB67vj8icP5Vyf
         44Vw==
X-Forwarded-Encrypted: i=1; AL+hErETpnriZUXX7SGnRv6AEvys0Xl7bQn36+6vZmdpC1a6nJ74i8VtO4m8Tz16I6xed/Kk11yas6o=@lists.linux.dev
X-Gm-Message-State: APuU4Z+JafIig4dzk3Mbh0TwnW68GAxKUYjew8xd4GYWZ42fFMZpoKVV
	zzUVCg+PCt1wXXqUT67HqbobW3lqe17ktkfatIJA9OJEM+f1xpM/bXWAs9BGJMLpUg==
X-Gm-Gg: AYBFou0UVAAmPN6ohYf0eX1frwlODfZbUlOLd8+8hSlf9XI14Dr2leyPEh4B5oRXOcA
	bnD0RHXSYhRaykwG6wJYEAFd02PASUk2Y/0LDS1B4+IRZA6Jn1bPIY8C3rvj7O2mVzizTOtXdJw
	t+bYbBW14dy38GXW7lk6GdgQFDtiN0qxF9xN/hd9MP0sjFNNEsEcMhDSNJQuNc+/OR+DhmobiLW
	pgCS3Yu29W0DXpA/YrwkCAM6NYym7mKPX/zjkwhysLnii8hHASKyHWPi6zHc7TPgBlpFr+bQWWY
	M6kECQN7yvPAx5+HE0N8/q8I33nafm1MIL9mKYaIBJAmb0fE89F9U+IE9L83V/HCBbV7qJWE40A
	8tSNFCyQv6TIW5q38Lh8igLJKKuqc8U0HDTgSUp902nUJn94pawiflTNrpPSJwHuJlXNcNQLgXO
	1/RmaCmyFPmB7lMLbpX5ICKmSZ2X3azVBTzuUei3OBCw99D1qdTbZi/XEIE64IKNwLh44+0ImZ4
	hnkEjP89H3Kcg7U2GL06aO52+aKM9pItTP/ihlTLfpeicl+/xus3o+FTk3/ja8QGOCwmafHHBm0
	GaiONrzB2m8IYIqLj6GojUnWtJXCA/Hg8ZXuNNugIni/0rMmspdx0UdnrybxKzJ2bRkxsTKAEnE
	7FX8nPLpWralfRE7bMaQVmPlae9rI8MtviNiHLGNkpnriRUAEPE3zyL18f7fxDseNOAcZ7uimue
	pRoyVkup7WFZqGma9hv7b8BqrUU7JUgYsS1mJbnl0QlpaDlMmKCyDf9PgRMMOqsNyaBHsWlGhGl
	50KqKawhqOmbko8mCqPD4Zx4PQ0rGYL0KmSwN5X/dNlZJtXTl+paFvKUDjHlskhwFDDf5q4Q3dn
	hteSjeN/OtahM1MbHVMxejsBWV3kQYCo8cHCpueh
X-Received: by 2002:a17:907:94cc:b0:c48:a838:c17e with SMTP id a640c23a62f3a-c4d5278459amr262933366b.14.1794153225978;
        Sun, 08 Nov 2026 07:53:45 -0800 (PST)
Received: from Desktop (p54aff56f.dip0.t-ipconnect.de. [84.175.245.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52f4bsm71648166b.8.2026.11.08.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:53:45 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH nf-next v9 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Sun,  8 Nov 2026 16:53:43 +0100
Message-ID: <20261108155344.35845-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108155344.35845-1-julius@bairaktaris.de>
References: <20261108155344.35845-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

A direct xmit flow that reaches a bridge port keeps sending to that port
when the host moves to another port of the bridge, and packets from the
other side keep the flow from timing out.

The gc now checks the fdb entry next to the dst check, through
nf_br_utils_hook, and tears the flow down when the entry points to
another port. An entry that aged out does not tear it down, because
offloaded packets do not refresh it.

One possibility to address this issue is to subscribe to
SWITCHDEV_FDB_DEL_TO_DEVICE event notifications, however, this requires
iterating over the whole flowtable whenever a fdb entry is removed.

The bridge port is found from out.ifidx through the vlan devices that
the forward path has below the port. The vid is the bridge vlan in the
encap stack, or the pvid of the port for an untagged port of a
vlan_filtering bridge.

Reported-by: Eric Woudstra <ericwouds@gmail.com>
Link: https://lore.kernel.org/netfilter-devel/20250925182623.114045-1-ericwouds@gmail.com/
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[julius@bairaktaris.de: find the bridge port below the vlan devices of the
 path, take the vid from a bridge vlan or the port pvid, keep a flow whose
 entry aged out, check the bridge the flow transmits on, follow struct
 net_bridge_dst, build br_nf_utils.o only with the flowtable]
Link: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/netfilter.h             |  7 +++++
 include/net/netfilter/nf_flow_table.h |  8 ++++-
 net/bridge/Makefile                   |  2 ++
 net/bridge/br.c                       |  2 ++
 net/bridge/br_nf_utils.c              | 38 ++++++++++++++++++++++
 net/bridge/br_private.h               | 13 ++++++++
 net/netfilter/core.c                  |  3 ++
 net/netfilter/nf_flow_table_core.c    | 45 +++++++++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c    | 20 ++++++++++--
 9 files changed, 133 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index e99afc1414cd3..be85d8f68b452 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -67,6 +67,13 @@ static inline void nf_inet_addr_mask(const union nf_inet_addr *a1,
 #endif
 }
 
+struct nf_br_utils {
+	bool (*fdb_valid_dst)(const struct net_device *dev,
+			      const unsigned char *addr, u16 vid);
+};
+
+extern const struct nf_br_utils __rcu *nf_br_utils_hook;
+
 int netfilter_init(void);
 
 struct sk_buff;
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 5b22d31cb1407..220ece9490e8e 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -153,6 +153,9 @@ struct flow_offload_tuple {
 					xmit_type:3,
 					encap_num:2,
 					needs_gso_segment:1,
+					bridge_path:1,
+					bridge_vlan:1,
+					port_vlans:2,
 					tun_num:2,
 					in_vlan_ingress:2;
 	u16				mtu;
@@ -235,7 +238,10 @@ struct nf_flow_route {
 			u32			hw_ifindex;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
-			u8			needs_gso_segment:1;
+			u8			needs_gso_segment:1,
+						bridge_path:1,
+						bridge_vlan:1,
+						port_vlans:2;
 		} out;
 		enum flow_offload_xmit_type	xmit_type;
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
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
index 0000000000000..300bce6c1b0b8
--- /dev/null
+++ b/net/bridge/br_nf_utils.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/netdevice.h>
+#include <linux/netfilter.h>
+
+#include "br_private.h"
+
+static bool nf_br_fdb_valid_dst(const struct net_device *dev,
+				const unsigned char *addr, u16 vid)
+{
+	const struct net_bridge_fdb_entry *f;
+	const struct net_bridge_port *p;
+
+	p = br_port_get_check_rcu(dev);
+	if (!p)
+		return false;
+
+	if (!vid && br_opt_get(p->br, BROPT_VLAN_ENABLED))
+		vid = br_get_pvid(nbp_vlan_group_rcu(p));
+
+	/* Offloaded packets do not refresh the entry, it can age out. */
+	f = br_fdb_find_rcu(p->br, addr, vid);
+
+	return !f || br_fdb_dst_port(f) == p;
+}
+
+static const struct nf_br_utils nf_br_utils = {
+	.fdb_valid_dst	= nf_br_fdb_valid_dst,
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
index 014d0b8db8c73..3b68f8d85672b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2165,6 +2165,19 @@ struct nf_br_ops {
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
index 44c856c1e621c..92e9852c80c0c 100644
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
index 0d72dc8ae47a1..113580adf10d3 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -5,6 +5,7 @@
 #include <linux/netfilter.h>
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
+#include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
 #include <net/netfilter/nf_tables.h>
@@ -139,6 +140,9 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		memcpy(flow_tuple->out.h_source, route->tuple[dir].out.h_source,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
+		flow_tuple->bridge_path = route->tuple[dir].out.bridge_path;
+		flow_tuple->bridge_vlan = route->tuple[dir].out.bridge_vlan;
+		flow_tuple->port_vlans = route->tuple[dir].out.port_vlans;
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
@@ -572,6 +576,43 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 	nf_ct_put(ct);
 }
 
+static bool nf_flow_dst_valid(struct nf_flowtable *flow_table,
+			      struct flow_offload *flow, int dir)
+{
+	struct flow_offload_tuple *other = &flow->tuplehash[!dir].tuple;
+	struct flow_offload_tuple *tuple = &flow->tuplehash[dir].tuple;
+	struct net *net = read_pnet(&flow_table->net);
+	const struct nf_br_utils *br_utils;
+	struct net_device *dev;
+	bool valid = true;
+	u16 vid = 0;
+	int i;
+
+	if (!nf_flow_dst_check(tuple))
+		return false;
+
+	if (!tuple->bridge_path)
+		return true;
+
+	rcu_read_lock();
+	br_utils = rcu_dereference(nf_br_utils_hook);
+	if (!br_utils)
+		goto out;
+
+	dev = dev_get_by_index_rcu(net, tuple->out.ifidx);
+	for (i = 0; dev && i < tuple->port_vlans; i++)
+		dev = __vlan_find_dev_deep_rcu(dev, other->encap[i].proto,
+					       other->encap[i].id);
+	if (tuple->bridge_vlan)
+		vid = other->encap[i].id;
+
+	valid = dev && br_utils->fdb_valid_dst(dev, tuple->out.h_dest, vid);
+out:
+	rcu_read_unlock();
+
+	return valid;
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
@@ -584,8 +625,8 @@ static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
-	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple) ||
-	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple) ||
+	    !nf_flow_dst_valid(flow_table, flow, FLOW_OFFLOAD_DIR_ORIGINAL) ||
+	    !nf_flow_dst_valid(flow_table, flow, FLOW_OFFLOAD_DIR_REPLY) ||
 	    nf_flow_custom_gc(flow_table, flow)) {
 		flow_offload_teardown(flow);
 		teardown = true;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 841f099434d98..cd3098c1d0de6 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -95,7 +95,10 @@ struct nft_forward_info {
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
 	u8 h_dest[ETH_ALEN];
-	bool needs_gso_segment;
+	u8 needs_gso_segment:1,
+	   bridge_path:1,
+	   bridge_vlan:1,
+	   port_vlans:2;
 	enum flow_offload_xmit_type xmit_type;
 };
 
@@ -107,7 +110,7 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 			     unsigned char *ha, struct nft_flowtable *ft)
 {
 	const struct net_device_path *path;
-	int i;
+	int i, n;
 
 	memcpy(info->h_dest, ha, ETH_ALEN);
 
@@ -149,6 +152,8 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 				info->encap[info->num_encaps].proto =
 					path->encap.proto;
 				info->num_encaps++;
+				if (info->bridge_path)
+					info->port_vlans++;
 			}
 			if (path->type == DEV_PATH_PPPOE) {
 				memcpy(info->h_dest, path->encap.h_dest, ETH_ALEN);
@@ -184,6 +189,14 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
 			}
+			info->bridge_path = 1;
+			info->port_vlans = 0;
+			n = info->num_encaps;
+			info->bridge_vlan = path->bridge.vlan_id && n &&
+					    info->encap[n - 1].id ==
+					    path->bridge.vlan_id &&
+					    info->encap[n - 1].proto ==
+					    path->bridge.vlan_proto;
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		default:
@@ -262,6 +275,9 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 	if (info.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT) {
 		memcpy(route->tuple[dir].out.h_source, info.h_source, ETH_ALEN);
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
+		route->tuple[dir].out.bridge_path = info.bridge_path;
+		route->tuple[dir].out.bridge_vlan = info.bridge_vlan;
+		route->tuple[dir].out.port_vlans = info.port_vlans;
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 	route->tuple[dir].out.needs_gso_segment = info.needs_gso_segment;
-- 
2.53.0

