Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C720261117
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAD61610FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1693914588; bh=y0Z8uS0jGL6JIldZzeA/+r6i6F/i5k0+Bi7Q1VDh2Tw=;
 h=From:Date:Subject:To:Cc:From;
 b=mYtk9pFkvK+PC4NOfBSh/p95Rr7q2/hadfRFx+N/DO+0ABB2jQnfFn6N3HpHe1/PX
 lHbYLopzvxPhASR8O3FvuHf8k1iJvjpt493oBEYodV4S6+UYI/puDiOX4D2abK7oZv
 UcF3z7+REb9NdmgY5x7fNeOVVa9lvFk90j2A05u0=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 05 Sep 2023 13:47:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-1-34bb124556d8@avm.de>
Subject: [Bridge] [PATCH iproute2-next v3] iplink: bridge: Add support for
 bridge FDB learning limits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Support setting the FDB limit through ip link. The arguments is:
 - fdb_max_learned_entries: A 32-bit unsigned integer specifying the
                            maximum number of learned FDB entries, with 0
                            disabling the limit.

Also support reading back the current number of learned FDB entries in
the bridge by this count. The returned value's name is:
 - fdb_n_learned_entries: A 32-bit unsigned integer specifying the
                          current number of learned FDB entries.

Example:

 # ip -d -j -p link show br0
[ {
...
        "linkinfo": {
            "info_kind": "bridge",
            "info_data": {
...
                "fdb_n_learned_entries": 2,
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
                "fdb_n_learned_entries": 2,
                "fdb_max_learned_entries": 1024,
...
            }
        },
...
    } ]

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
Changes since v2:
 - Properly split the net-next and iproute2-next threads. (from review)
 - Changed to *_n_* instead of *_cur_*. (from review)
 - Use strcmp() instead of matches(). (from review)
 - Made names in code and documentation consistent. (from review)
 - Various documentation fixes. (from review)

Changes since v1:
 - Sent out the first corresponding iproute2 patches.

net-next v3: https://lore.kernel.org/netdev/20230905-fdb_limit-v3-0-7597cd500a82@avm.de/

v2: https://lore.kernel.org/netdev/20230619071444.14625-1-jnixdorf-oss@avm.de/
v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/
---
 include/uapi/linux/if_link.h |  2 ++
 ip/iplink_bridge.c           | 21 +++++++++++++++++++++
 man/man8/ip-link.8.in        | 10 ++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index c2ca7a6add0e..51cf58e3171c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -508,6 +508,8 @@ enum {
 	IFLA_BR_VLAN_STATS_PER_PORT,
 	IFLA_BR_MULTI_BOOLOPT,
 	IFLA_BR_MCAST_QUERIER_STATE,
+	IFLA_BR_FDB_N_LEARNED_ENTRIES,
+	IFLA_BR_FDB_MAX_LEARNED_ENTRIES,
 	__IFLA_BR_MAX,
 };
 
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 7e4e62c81c0c..f08754618e0f 100644
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
+		} else if (strcmp(*argv, "fdb_max_learned_entries") == 0) {
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
 
+	if (tb[IFLA_BR_FDB_N_LEARNED_ENTRIES])
+		print_uint(PRINT_ANY,
+			   "fdb_n_learned_entries",
+			   "fdb_n_learned_entries %u ",
+			   rta_getattr_u32(tb[IFLA_BR_FDB_N_LEARNED_ENTRIES]));
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
index 7365d0c6b14f..184ae9183712 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1630,6 +1630,8 @@ the following additional arguments are supported:
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
 ] [
+.BI fdb_max_learned_entries " FDB_MAX_LEARNED_ENTRIES "
+] [
 .BI vlan_filtering " VLAN_FILTERING "
 ] [
 .BI vlan_protocol " VLAN_PROTOCOL "
@@ -1741,6 +1743,14 @@ or off
 When disabled, the bridge will not learn from link-local frames (default:
 enabled).
 
+.BI fdb_max_learned_entries " FDB_MAX_LEARNED_ENTRIES "
+- set the maximum number of learned FDB entries. If
+.RI ( FDB_MAX_LEARNED_ENTRIES " == 0) "
+the feature is disabled. Default is
+.BR 0 .
+.I FDB_MAX_LEARNED_ENTRIES
+is a 32bit unsigned integer.
+
 .BI vlan_filtering " VLAN_FILTERING "
 - turn VLAN filtering on
 .RI ( VLAN_FILTERING " > 0) "

---
base-commit: 865dd3ab1580092221c73317a844ee65f032c9e8
change-id: 20230905-fdb_limit-ace1467c6a84

Best regards,
-- 
Johannes Nixdorf <jnixdorf-oss@avm.de>

