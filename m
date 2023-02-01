Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 284526109C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 252EE610B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtyG76Sjp31H3X92EqJlwwB5OXXJLBKMJptF4lhixlo=;
 b=U32P2LhkbERxLqqG7f/zSaTOXFNLhyZKMtSdcaxZThQYkmBpFIeiVMzEJ+RpiWOllEZCyDtRG0uLyVt5RXXyICUnw/cXXLvF3gV8RKSXvuDpoT4tlsUxMrkpZb3QmNHRmTur89SXSLO8BlXWnmkvlvsqovKQNnOS193aRw1qpXlqkqUQw9ug9gxAeiOH5whZJUR67zoxbm2Ot+Y5rsMKlK/A9J4bSO+r2eoMD+5YRL5DPholAFvJjlLQLElaYUvrDvnzbMW7t1hdbHI5aiZZ6NgxqrAnDlP5K7fSKxEQC5/JfybhQDUpFzcWcbNgBqlCWneTs2OkUjbrxnNOEiz5ng==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:39 +0100
Message-ID: <008620de41985a3a757c7099bc712ae75739db27.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 06/16] net: bridge: Add a
	tracepoint for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org

The following patch will add two more maximum MDB allowances to the global
one, mcast_hash_max, that exists today. In all these cases, attempts to add
MDB entries above the configured maximums through netlink, fail noisily and
obviously. Such visibility is missing when adding entries through the
control plane traffic, by IGMP or MLD packets.

To improve visibility in those cases, add a trace point that reports the
violation, including the relevant netdevice (be it a slave or the bridge
itself), and the MDB entry parameters:

	# perf record -e bridge:br_mdb_full &
	# [...]
	# perf script | cut -d: -f4-
	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00 vid 0
	 dev v2 af 10 src :: grp ff0e::112/00:00:00:00:00:00 vid 0
	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00 vid 10
	 dev v2 af 10 src 2001:db8:1::1 grp ff0e::1/00:00:00:00:00:00 vid 10
	 dev v2 af 2 src ::ffff:192.0.2.1 grp ::ffff:239.1.1.1/00:00:00:00:00:00 vid 10

CC: Steven Rostedt <rostedt@goodmis.org>
CC: linux-trace-kernel@vger.kernel.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Report IPv4 as an IPv6-mapped address through the IPv6 buffer
      as well, to save ring buffer space.

 include/trace/events/bridge.h | 58 +++++++++++++++++++++++++++++++++++
 net/core/net-traces.c         |  1 +
 2 files changed, 59 insertions(+)

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index 6b200059c2c5..a6b3a4e409f0 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -122,6 +122,64 @@ TRACE_EVENT(br_fdb_update,
 		  __entry->flags)
 );
 
+TRACE_EVENT(br_mdb_full,
+
+	TP_PROTO(const struct net_device *dev,
+		 const struct br_ip *group),
+
+	TP_ARGS(dev, group),
+
+	TP_STRUCT__entry(
+		__string(dev, dev->name)
+		__field(int, af)
+		__field(u16, vid)
+		__array(__u8, src, 16)
+		__array(__u8, grp, 16)
+		__array(__u8, grpmac, ETH_ALEN) /* For af == 0. */
+	),
+
+	TP_fast_assign(
+		struct in6_addr *in6;
+
+		__assign_str(dev, dev->name);
+		__entry->vid = group->vid;
+
+		if (!group->proto) {
+			__entry->af = 0;
+
+			memset(__entry->src, 0, sizeof(__entry->src));
+			memset(__entry->grp, 0, sizeof(__entry->grp));
+			memcpy(__entry->grpmac, group->dst.mac_addr, ETH_ALEN);
+		} else if (group->proto == htons(ETH_P_IP)) {
+			__entry->af = AF_INET;
+
+			in6 = (struct in6_addr *)__entry->src;
+			ipv6_addr_set_v4mapped(group->src.ip4, in6);
+
+			in6 = (struct in6_addr *)__entry->grp;
+			ipv6_addr_set_v4mapped(group->dst.ip4, in6);
+
+			memset(__entry->grpmac, 0, ETH_ALEN);
+
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			__entry->af = AF_INET6;
+
+			in6 = (struct in6_addr *)__entry->src;
+			*in6 = group->src.ip6;
+
+			in6 = (struct in6_addr *)__entry->grp;
+			*in6 = group->dst.ip6;
+
+			memset(__entry->grpmac, 0, ETH_ALEN);
+#endif
+		}
+	),
+
+	TP_printk("dev %s af %u src %pI6c grp %pI6c/%pM vid %u",
+		  __get_str(dev), __entry->af, __entry->src, __entry->grp,
+		  __entry->grpmac, __entry->vid)
+);
 
 #endif /* _TRACE_BRIDGE_H */
 
diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index c40cd8dd75c7..c6820ad2183f 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -41,6 +41,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_add);
 EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_external_learn_add);
 EXPORT_TRACEPOINT_SYMBOL_GPL(fdb_delete);
 EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_update);
+EXPORT_TRACEPOINT_SYMBOL_GPL(br_mdb_full);
 #endif
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
-- 
2.39.0

