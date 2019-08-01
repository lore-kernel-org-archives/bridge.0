Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 1 Aug 2019 14:51:27 +0200
Message-ID: <1564663887-27854-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [iproute2,rfc] bridge: mdb: Extend with with LLADDR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, idosch@mellanox.com, andrew@lunn.ch, allan.nielsen@microchip.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>, tglx@linutronix.de, davem@davemloft.net

Extend bridge mdb command to accept as group also link layer multicast
addresss. The old behaviour is not change.

To add new mdb entry:
bridge mdb add dev br0 port eth0 grp 11:22:33:44:55:66 permanent vid 1

To display existing entries:
bridge mdb
dev br0 port eth4 grp 01:00:00:00:00:01 permanent offload vid 1

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 bridge/mdb.c                   | 29 ++++++++++++++++++++++++-----
 include/uapi/linux/if_bridge.h |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 928ae56..057c0b6 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -138,9 +138,21 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
 	print_string(PRINT_ANY, "port", " port %s",
 		     ll_index_to_name(e->ifindex));
 
-	print_color_string(PRINT_ANY, ifa_family_color(af),
-			    "grp", " grp %s",
-			    inet_ntop(af, src, abuf, sizeof(abuf)));
+	if (e->addr.proto == htons(ETH_P_IP) ||
+	    e->addr.proto == htons(ETH_P_IPV6)) {
+		print_color_string(PRINT_ANY, ifa_family_color(af),
+				   "grp", " grp %s",
+				   inet_ntop(af, src, abuf, sizeof(abuf)));
+	} else {
+		const char *lladdr;
+		SPRINT_BUF(b1);
+
+		lladdr = ll_addr_n2a(e->addr.u.mac, ETH_ALEN, 0, b1,
+				     sizeof(b1));
+
+		print_color_string(PRINT_ANY, COLOR_MAC, "grp", " grp %s",
+				   lladdr);
+	}
 
 	print_string(PRINT_ANY, "state", " %s",
 			   (e->state & MDB_PERMANENT) ? "permanent" : "temp");
@@ -380,6 +392,7 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 	};
 	struct br_mdb_entry entry = {};
 	char *d = NULL, *p = NULL, *grp = NULL;
+	char abuf[ETH_ALEN];
 	short vid = 0;
 
 	while (argc > 0) {
@@ -422,8 +435,14 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 
 	if (!inet_pton(AF_INET, grp, &entry.addr.u.ip4)) {
 		if (!inet_pton(AF_INET6, grp, &entry.addr.u.ip6)) {
-			fprintf(stderr, "Invalid address \"%s\"\n", grp);
-			return -1;
+			if (sscanf(grp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+				   abuf, abuf+1, abuf+2, abuf+3, abuf+4,
+				   abuf+5) != 6) {
+				fprintf(stderr, "Invalid address \"%s\"\n", grp);
+				return -1;
+			}
+			memcpy(entry.addr.u.mac, abuf, ETH_ALEN);
+			entry.addr.proto = 0;
 		} else
 			entry.addr.proto = htons(ETH_P_IPV6);
 	} else
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 04f763c..88aad9c 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -243,6 +243,7 @@ struct br_mdb_entry {
 		union {
 			__be32	ip4;
 			struct in6_addr ip6;
+			__u8	mac[ETH_ALEN];
 		} u;
 		__be16		proto;
 	} addr;
-- 
2.7.4

