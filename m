Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE62A61025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0039660E16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XGSeSqpbeKmuOlOmAqvCcULsRstgABL80DNrjXF1a4=;
 b=Ah0OzJUKlNTCInhibvKo7PQ1eaAIyVJJYkQffymbeDqlkC5fq3rqGjtPPpbBylZxJf/rOuk3NEaNKt4RscDng9Uio9Dn0gIpR7jTHgIpFZtFluC5yZ/5O6xCC80zmcNnUU6jHJodJCmInvvD2DfgYzYBQTjk8FkZ3EXq8l5oHXJqo+8XAA6wGg6dsflu1bfkwe7hnCZc7cOsBWBwEv/DNQfdYrGt8nAh3WrJ6Q86R091XKwiPTEitTW2OQWym26ENWYK4sqywntot/pFXpPP4eX55ccQkXhl3/JvtK6wkkP6Kr9ViXcmeAACIZcDJjRDIpf1eSlWWNcqzDsWgk3Hnw==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:14 +0100
Message-ID: <ed2e2e305dd49423745b62c0152a0b85bc84a767.1674752051.git.petrm@nvidia.com>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 06/16] net: bridge: Add a tracepoint for
	MDB overflows
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
	 dev v2 af 2 src 192.0.2.1/:: grp 239.1.1.1/::/00:00:00:00:00:00 vid 0
	 dev v2 af 10 src 0.0.0.0/2001:db8:1::1 grp 0.0.0.0/ff0e::1/00:00:00:00:00:00 vid 0
	 dev v2 af 2 src 192.0.2.1/:: grp 239.1.1.1/::/00:00:00:00:00:00 vid 10
	 dev v2 af 10 src 0.0.0.0/2001:db8:1::1 grp 0.0.0.0/ff0e::1/00:00:00:00:00:00 vid 10

CC: Steven Rostedt <rostedt@goodmis.org>
CC: linux-trace-kernel@vger.kernel.org
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/trace/events/bridge.h | 67 +++++++++++++++++++++++++++++++++++
 net/core/net-traces.c         |  1 +
 2 files changed, 68 insertions(+)

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index 6b200059c2c5..00d5e2dcb3ad 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -122,6 +122,73 @@ TRACE_EVENT(br_fdb_update,
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
+		__array(__u8, src4, 4)
+		__array(__u8, src6, 16)
+		__array(__u8, grp4, 4)
+		__array(__u8, grp6, 16)
+		__array(__u8, grpmac, ETH_ALEN) /* For af == 0. */
+	),
+
+	TP_fast_assign(
+		__assign_str(dev, dev->name);
+		__entry->vid = group->vid;
+
+		if (!group->proto) {
+			__entry->af = 0;
+
+			memset(__entry->src4, 0, sizeof(__entry->src4));
+			memset(__entry->src6, 0, sizeof(__entry->src6));
+			memset(__entry->grp4, 0, sizeof(__entry->grp4));
+			memset(__entry->grp6, 0, sizeof(__entry->grp6));
+			memcpy(__entry->grpmac, group->dst.mac_addr, ETH_ALEN);
+		} else if (group->proto == htons(ETH_P_IP)) {
+			__be32 *p32;
+
+			__entry->af = AF_INET;
+
+			p32 = (__be32 *) __entry->src4;
+			*p32 = group->src.ip4;
+
+			p32 = (__be32 *) __entry->grp4;
+			*p32 = group->dst.ip4;
+
+			memset(__entry->src6, 0, sizeof(__entry->src6));
+			memset(__entry->grp6, 0, sizeof(__entry->grp6));
+			memset(__entry->grpmac, 0, ETH_ALEN);
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			struct in6_addr *in6;
+
+			__entry->af = AF_INET6;
+
+			in6 = (struct in6_addr *)__entry->src6;
+			*in6 = group->src.ip6;
+
+			in6 = (struct in6_addr *)__entry->grp6;
+			*in6 = group->dst.ip6;
+
+			memset(__entry->src4, 0, sizeof(__entry->src4));
+			memset(__entry->grp4, 0, sizeof(__entry->grp4));
+			memset(__entry->grpmac, 0, ETH_ALEN);
+#endif
+		}
+	),
+
+	TP_printk("dev %s af %u src %pI4/%pI6c grp %pI4/%pI6c/%pM vid %u",
+		  __get_str(dev), __entry->af, __entry->src4, __entry->src6,
+		  __entry->grp4, __entry->grp6, __entry->grpmac, __entry->vid)
+);
 
 #endif /* _TRACE_BRIDGE_H */
 
diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index ee7006bbe49b..805b7385dd8d 100644
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

