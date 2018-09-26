Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2ChPOyWYEpjs32VpmvSHVhLAZOTZnmRRwL5GV37pu+I=;
	b=fnwh/zO16kmwG8ifRUGpEvv61X0QH+/cSJm2ykmY9c54YtCu99pTGI1XatGpOeUnEP
	csXib+e/XMseaRVMnmi6ZzIDUrRTlWYRwZ7pJ6FplPVyMUl41w7B6dmaYjyrOYFs2q5z
	+wNLQRAOHMOEa1c8UGCxZD9Qig5ZjAqQNMAqk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 15:17:56 +0300
Message-Id: <20180926121802.27851-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 3/9] net: bridge: convert nf call options
	to bits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

No functional change, convert of nf_call_[ip|ip6|arp]tables to bits.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netfilter_hooks.c |  7 ++++---
 net/bridge/br_netlink.c         | 12 ++++++------
 net/bridge/br_private.h         |  6 +++---
 net/bridge/br_sysfs_br.c        | 12 ++++++------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 6e0dc6bcd32a..e0a3b038d052 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -487,14 +487,15 @@ static unsigned int br_nf_pre_routing(void *priv,
 	br = p->br;
 
 	if (IS_IPV6(skb) || IS_VLAN_IPV6(skb) || IS_PPPOE_IPV6(skb)) {
-		if (!brnf_call_ip6tables && !br->nf_call_ip6tables)
+		if (!brnf_call_ip6tables &&
+		    !br_opt_get(br, BROPT_NF_CALL_IP6TABLES))
 			return NF_ACCEPT;
 
 		nf_bridge_pull_encap_header_rcsum(skb);
 		return br_nf_pre_routing_ipv6(priv, skb, state);
 	}
 
-	if (!brnf_call_iptables && !br->nf_call_iptables)
+	if (!brnf_call_iptables && !br_opt_get(br, BROPT_NF_CALL_IPTABLES))
 		return NF_ACCEPT;
 
 	if (!IS_IP(skb) && !IS_VLAN_IP(skb) && !IS_PPPOE_IP(skb))
@@ -636,7 +637,7 @@ static unsigned int br_nf_forward_arp(void *priv,
 		return NF_ACCEPT;
 	br = p->br;
 
-	if (!brnf_call_arptables && !br->nf_call_arptables)
+	if (!brnf_call_arptables && !br_opt_get(br, BROPT_NF_CALL_ARPTABLES))
 		return NF_ACCEPT;
 
 	if (!IS_ARP(skb)) {
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6a53caff2d31..521893df0c2a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1271,19 +1271,19 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_NF_CALL_IPTABLES]) {
 		u8 val = nla_get_u8(data[IFLA_BR_NF_CALL_IPTABLES]);
 
-		br->nf_call_iptables = val ? true : false;
+		br_opt_toggle(br, BROPT_NF_CALL_IPTABLES, !!val);
 	}
 
 	if (data[IFLA_BR_NF_CALL_IP6TABLES]) {
 		u8 val = nla_get_u8(data[IFLA_BR_NF_CALL_IP6TABLES]);
 
-		br->nf_call_ip6tables = val ? true : false;
+		br_opt_toggle(br, BROPT_NF_CALL_IP6TABLES, !!val);
 	}
 
 	if (data[IFLA_BR_NF_CALL_ARPTABLES]) {
 		u8 val = nla_get_u8(data[IFLA_BR_NF_CALL_ARPTABLES]);
 
-		br->nf_call_arptables = val ? true : false;
+		br_opt_toggle(br, BROPT_NF_CALL_ARPTABLES, !!val);
 	}
 #endif
 
@@ -1470,11 +1470,11 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 #endif
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	if (nla_put_u8(skb, IFLA_BR_NF_CALL_IPTABLES,
-		       br->nf_call_iptables ? 1 : 0) ||
+		       br_opt_get(br, BROPT_NF_CALL_IPTABLES) ? 1 : 0) ||
 	    nla_put_u8(skb, IFLA_BR_NF_CALL_IP6TABLES,
-		       br->nf_call_ip6tables ? 1 : 0) ||
+		       br_opt_get(br, BROPT_NF_CALL_IP6TABLES) ? 1 : 0) ||
 	    nla_put_u8(skb, IFLA_BR_NF_CALL_ARPTABLES,
-		       br->nf_call_arptables ? 1 : 0))
+		       br_opt_get(br, BROPT_NF_CALL_ARPTABLES) ? 1 : 0))
 		return -EMSGSIZE;
 #endif
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0abb632283ff..d8eadab09d7d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -309,6 +309,9 @@ static inline struct net_bridge_port *br_port_get_rtnl_rcu(const struct net_devi
 enum net_bridge_opts {
 	BROPT_VLAN_ENABLED,
 	BROPT_VLAN_STATS_ENABLED,
+	BROPT_NF_CALL_IPTABLES,
+	BROPT_NF_CALL_IP6TABLES,
+	BROPT_NF_CALL_ARPTABLES,
 };
 
 struct net_bridge {
@@ -331,9 +334,6 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
-	bool				nf_call_iptables;
-	bool				nf_call_ip6tables;
-	bool				nf_call_arptables;
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 9f1f3866c833..0f8545c94948 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -678,12 +678,12 @@ static ssize_t nf_call_iptables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->nf_call_iptables);
+	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IPTABLES));
 }
 
 static int set_nf_call_iptables(struct net_bridge *br, unsigned long val)
 {
-	br->nf_call_iptables = val ? true : false;
+	br_opt_toggle(br, BROPT_NF_CALL_IPTABLES, !!val);
 	return 0;
 }
 
@@ -699,12 +699,12 @@ static ssize_t nf_call_ip6tables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->nf_call_ip6tables);
+	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_IP6TABLES));
 }
 
 static int set_nf_call_ip6tables(struct net_bridge *br, unsigned long val)
 {
-	br->nf_call_ip6tables = val ? true : false;
+	br_opt_toggle(br, BROPT_NF_CALL_IP6TABLES, !!val);
 	return 0;
 }
 
@@ -720,12 +720,12 @@ static ssize_t nf_call_arptables_show(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct net_bridge *br = to_bridge(d);
-	return sprintf(buf, "%u\n", br->nf_call_arptables);
+	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_NF_CALL_ARPTABLES));
 }
 
 static int set_nf_call_arptables(struct net_bridge *br, unsigned long val)
 {
-	br->nf_call_arptables = val ? true : false;
+	br_opt_toggle(br, BROPT_NF_CALL_ARPTABLES, !!val);
 	return 0;
 }
 
-- 
2.11.0

