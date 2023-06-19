Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0128260D4C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5A3F60B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1687158917; bh=spw1yFudJVNbLjJ2XmY8xfK19c3QY7SZsgYE96aOcGc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mAI0qzS2tEaShvuJM6ctmYosY5vJGcx3BIJYnQEy2y60v9JopLIKrnB9FbAzlKI7a
 rfvBw9HkikmoZ2Voe+4D2m8WwraN/QWgQMz1Ns1RzqfJaLsOgCzsWcR8UuC+kzEUo9
 5TvZbBsrAXRlWyiHlPEe8lWUoUqfZbkrqyhlGzls=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 19 Jun 2023 09:14:44 +0200
Message-Id: <20230619071444.14625-5-jnixdorf-oss@avm.de>
In-Reply-To: <20230619071444.14625-1-jnixdorf-oss@avm.de>
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2-next 1/1] iplink: bridge: Add support for
	bridge FDB learning limits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

Support setting the FDB limit through ip link. The arguments is:
 - fdb_max_learned_entries: A 32-bit unsigned integer specifying the
                            maximum number of learned FDB entries, with 0
                            disabling the limit.

Also support reading back the current number of learned FDB entries in
the bridge by this count. The returned value's name is:
 - fdb_cur_learned_entries: A 32-bit unsigned integer specifying the
                             current number of learned FDB entries.

Example:

 # ip -d -j -p link show br0
[ {
...
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
...
                "fdb_cur_learned_entries": 2,
                "fdb_max_learned_entries": 0,
...
            }
        },
...
    } ]
 # ip link set br0 type bridge fdb_max_learned_entries 1024
 # ip -d -j -p link show br0
[ {
...
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
...
                "fdb_cur_learned_entries": 2,
                "fdb_max_learned_entries": 1024,
...
            }
        },
...
    } ]

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 include/uapi/linux/if_link.h |  2 ++
 ip/iplink_bridge.c           | 21 +++++++++++++++++++++
 man/man8/ip-link.8.in        |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 94fb7ef9e226..5ad1e2727e0d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -508,6 +508,8 @@ enum {
 	IFLA_BR_VLAN_STATS_PER_PORT,
 	IFLA_BR_MULTI_BOOLOPT,
 	IFLA_BR_MCAST_QUERIER_STATE,
+	IFLA_BR_FDB_CUR_LEARNED_ENTRIES,
+	IFLA_BR_FDB_MAX_LEARNED_ENTRIES,
 	__IFLA_BR_MAX,
 };
 
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 7e4e62c81c0c..68ed3c251945 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -34,6 +34,7 @@ static void print_explain(FILE *f)
 		"		  [ group_fwd_mask MASK ]\n"
 		"		  [ group_address ADDRESS ]\n"
 		"		  [ no_linklocal_learn NO_LINKLOCAL_LEARN ]\n"
+		"		  [ fdb_max_learned_entries FDB_MAX_LEARNED_ENTRIES ]\n"
 		"		  [ vlan_filtering VLAN_FILTERING ]\n"
 		"		  [ vlan_protocol VLAN_PROTOCOL ]\n"
 		"		  [ vlan_default_pvid VLAN_DEFAULT_PVID ]\n"
@@ -168,6 +169,14 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				bm.optval |= no_ll_learn_bit;
 			else
 				bm.optval &= ~no_ll_learn_bit;
+		} else if (matches(*argv, "fdb_max_learned_entries") == 0) {
+			__u32 fdb_max_learned_entries;
+
+			NEXT_ARG();
+			if (get_u32(&fdb_max_learned_entries, *argv, 0))
+				invarg("invalid fdb_max_learned_entries", *argv);
+
+			addattr32(n, 1024, IFLA_BR_FDB_MAX_LEARNED_ENTRIES, fdb_max_learned_entries);
 		} else if (matches(*argv, "fdb_flush") == 0) {
 			addattr(n, 1024, IFLA_BR_FDB_FLUSH);
 		} else if (matches(*argv, "vlan_default_pvid") == 0) {
@@ -544,6 +553,18 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BR_GC_TIMER])
 		_bridge_print_timer(f, "gc_timer", tb[IFLA_BR_GC_TIMER]);
 
+	if (tb[IFLA_BR_FDB_CUR_LEARNED_ENTRIES])
+		print_uint(PRINT_ANY,
+			   "fdb_cur_learned_entries",
+			   "fdb_cur_learned_entries %u ",
+			   rta_getattr_u32(tb[IFLA_BR_FDB_CUR_LEARNED_ENTRIES]));
+
+	if (tb[IFLA_BR_FDB_MAX_LEARNED_ENTRIES])
+		print_uint(PRINT_ANY,
+			   "fdb_max_learned_entries",
+			   "fdb_max_learned_entries %u ",
+			   rta_getattr_u32(tb[IFLA_BR_FDB_MAX_LEARNED_ENTRIES]));
+
 	if (tb[IFLA_BR_VLAN_DEFAULT_PVID])
 		print_uint(PRINT_ANY,
 			   "vlan_default_pvid",
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index bf3605a9fa2e..a29595858a51 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1620,6 +1620,8 @@ the following additional arguments are supported:
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
 ] [
+.BI fdb_max_entries " FDB_MAX_ENTRIES "
+] [
 .BI vlan_filtering " VLAN_FILTERING "
 ] [
 .BI vlan_protocol " VLAN_PROTOCOL "
@@ -1731,6 +1733,13 @@ or off
 When disabled, the bridge will not learn from link-local frames (default:
 enabled).
 
+.BI fdb_max_learned_entries " FDB_MAX_LEARNED_ENTRIES "
+- set the maximum number of learned FDB entries linux may create. If
+.RI ( FDB_MAX_LEARNED_ENTRIES " == 0) "
+the feature is disabled.
+.I FDB_MAX_LEARNED_ENTRIES
+is a 32bit unsigned integer.
+
 .BI vlan_filtering " VLAN_FILTERING "
 - turn VLAN filtering on
 .RI ( VLAN_FILTERING " > 0) "
-- 
2.40.1

