Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6724A40B90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDF5E4016F
From: Hans Schultz <netdev@kapio-technology.com>
Date: Thu, 29 Sep 2022 17:21:36 +0200
Message-Id: <20220929152137.167626-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2-next 1/2] bridge: link: enable MacAuth/MAB
	feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Hans Schultz <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, Florent Fourcot <florent.fourcot@wifirst.fr>

The MAB feature can be enabled on a locked port with the command:
bridge link set dev <DEV> mab on

Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
---
 bridge/fdb.c                   | 17 +++++++++++++++--
 bridge/link.c                  | 21 ++++++++++++++++++---
 include/uapi/linux/if_link.h   |  1 +
 include/uapi/linux/neighbour.h |  7 ++++++-
 ip/iplink_bridge_slave.c       | 16 +++++++++++++---
 man/man8/bridge.8              | 10 ++++++++++
 man/man8/ip-link.8.in          |  8 ++++++++
 7 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 5f71bde0..0fbe9bd3 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -93,7 +93,7 @@ static int state_a2n(unsigned int *s, const char *arg)
 	return 0;
 }
 
-static void fdb_print_flags(FILE *fp, unsigned int flags)
+static void fdb_print_flags(FILE *fp, unsigned int flags, __u8 ext_flags)
 {
 	open_json_array(PRINT_JSON,
 			is_json_context() ?  "flags" : "");
@@ -116,6 +116,9 @@ static void fdb_print_flags(FILE *fp, unsigned int flags)
 	if (flags & NTF_STICKY)
 		print_string(PRINT_ANY, NULL, "%s ", "sticky");
 
+	if (ext_flags & NTF_EXT_LOCKED)
+		print_string(PRINT_ANY, NULL, "%s ", "locked");
+
 	close_json_array(PRINT_JSON, NULL);
 }
 
@@ -144,6 +147,7 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 	struct ndmsg *r = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
 	struct rtattr *tb[NDA_MAX+1];
+	__u32 ext_flags = 0;
 	__u16 vid = 0;
 
 	if (n->nlmsg_type != RTM_NEWNEIGH && n->nlmsg_type != RTM_DELNEIGH) {
@@ -170,6 +174,9 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 	parse_rtattr(tb, NDA_MAX, NDA_RTA(r),
 		     n->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
+	if (tb[NDA_FLAGS_EXT])
+		ext_flags = rta_getattr_u32(tb[NDA_FLAGS_EXT]);
+
 	if (tb[NDA_VLAN])
 		vid = rta_getattr_u16(tb[NDA_VLAN]);
 
@@ -266,7 +273,7 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 	if (show_stats && tb[NDA_CACHEINFO])
 		fdb_print_stats(fp, RTA_DATA(tb[NDA_CACHEINFO]));
 
-	fdb_print_flags(fp, r->ndm_flags);
+	fdb_print_flags(fp, r->ndm_flags, ext_flags);
 
 
 	if (tb[NDA_MASTER])
@@ -414,6 +421,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	char *endptr;
 	short vid = -1;
 	__u32 nhid = 0;
+	__u32 ext_flags = 0;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -527,6 +535,11 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (dst_ok)
 		addattr_l(&req.n, sizeof(req), NDA_DST, &dst.data, dst.bytelen);
 
+	if (ext_flags &&
+	    addattr_l(&req.n, sizeof(req), NDA_FLAGS_EXT, &ext_flags,
+		      sizeof(ext_flags)) < 0)
+		return -1;
+
 	if (vid >= 0)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (nhid > 0)
diff --git a/bridge/link.c b/bridge/link.c
index 3810fa04..dd69d7c3 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -181,9 +181,14 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
 		if (prtb[IFLA_BRPORT_ISOLATED])
 			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
 				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
-		if (prtb[IFLA_BRPORT_LOCKED])
-			print_on_off(PRINT_ANY, "locked", "locked %s ",
-				     rta_getattr_u8(prtb[IFLA_BRPORT_LOCKED]));
+		if (prtb[IFLA_BRPORT_LOCKED]) {
+			if (prtb[IFLA_BRPORT_MAB] && rta_getattr_u8(prtb[IFLA_BRPORT_MAB]))
+				print_on_off(PRINT_ANY, "locked mab", "locked mab %s ",
+					     rta_getattr_u8(prtb[IFLA_BRPORT_LOCKED]));
+			else
+				print_on_off(PRINT_ANY, "locked", "locked %s ",
+					     rta_getattr_u8(prtb[IFLA_BRPORT_LOCKED]));
+		}
 	} else
 		print_stp_state(rta_getattr_u8(attr));
 }
@@ -281,6 +286,7 @@ static void usage(void)
 		"                               [ vlan_tunnel {on | off} ]\n"
 		"                               [ isolated {on | off} ]\n"
 		"                               [ locked {on | off} ]\n"
+		"                               [ mab {on | off} ]\n"
 		"                               [ hwmode {vepa | veb} ]\n"
 		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
 		"                               [ self ] [ master ]\n"
@@ -312,6 +318,7 @@ static int brlink_modify(int argc, char **argv)
 	__s8 bcast_flood = -1;
 	__s8 mcast_to_unicast = -1;
 	__s8 locked = -1;
+	__s8 macauth = -1;
 	__s8 isolated = -1;
 	__s8 hairpin = -1;
 	__s8 bpdu_guard = -1;
@@ -437,6 +444,11 @@ static int brlink_modify(int argc, char **argv)
 			locked = parse_on_off("locked", *argv, &ret);
 			if (ret)
 				return ret;
+		} else if (strcmp(*argv, "mab") == 0) {
+			NEXT_ARG();
+			macauth = parse_on_off("mab", *argv, &ret);
+			if (ret)
+				return ret;
 		} else if (strcmp(*argv, "backup_port") == 0) {
 			NEXT_ARG();
 			backup_port_idx = ll_name_to_index(*argv);
@@ -520,6 +532,9 @@ static int brlink_modify(int argc, char **argv)
 	if (locked >= 0)
 		addattr8(&req.n, sizeof(req), IFLA_BRPORT_LOCKED, locked);
 
+	if (macauth >= 0)
+		addattr8(&req.n, sizeof(req), IFLA_BRPORT_MAB, macauth);
+
 	if (backup_port_idx != -1)
 		addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_PORT,
 			  backup_port_idx);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 7494cffb..58a002de 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -559,6 +559,7 @@ enum {
 	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
 	IFLA_BRPORT_LOCKED,
+	IFLA_BRPORT_MAB,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index a998bf76..4dda051b 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -52,7 +52,8 @@ enum {
 #define NTF_STICKY	(1 << 6)
 #define NTF_ROUTER	(1 << 7)
 /* Extended flags under NDA_FLAGS_EXT: */
-#define NTF_EXT_MANAGED	(1 << 0)
+#define NTF_EXT_MANAGED		(1 << 0)
+#define NTF_EXT_LOCKED		(1 << 1)
 
 /*
  *	Neighbor Cache Entry States.
@@ -86,6 +87,10 @@ enum {
  * NTF_EXT_MANAGED flagged neigbor entries are managed by the kernel on behalf
  * of a user space control plane, and automatically refreshed so that (if
  * possible) they remain in NUD_REACHABLE state.
+ *
+ * NTF_EXT_LOCKED flagged FDB entries are placeholder entries used with the
+ * locked port feature, that ensures that an entry exists while at the same
+ * time dropping packets on ingress with src MAC and VID matching the entry.
  */
 
 struct nda_cacheinfo {
diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index 98d17213..0c0894eb 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -44,6 +44,7 @@ static void print_explain(FILE *f)
 		"			[ vlan_tunnel {on | off} ]\n"
 		"			[ isolated {on | off} ]\n"
 		"			[ locked {on | off} ]\n"
+		"                       [ mab {on | off} ]\n"
 		"			[ backup_port DEVICE ] [ nobackup_port ]\n"
 	);
 }
@@ -284,9 +285,14 @@ static void bridge_slave_print_opt(struct link_util *lu, FILE *f,
 		print_on_off(PRINT_ANY, "isolated", "isolated %s ",
 			     rta_getattr_u8(tb[IFLA_BRPORT_ISOLATED]));
 
-	if (tb[IFLA_BRPORT_LOCKED])
-		print_on_off(PRINT_ANY, "locked", "locked %s ",
-			     rta_getattr_u8(tb[IFLA_BRPORT_LOCKED]));
+	if (tb[IFLA_BRPORT_LOCKED]) {
+		if (tb[IFLA_BRPORT_MAB] && rta_getattr_u8(tb[IFLA_BRPORT_MAB]))
+			print_on_off(PRINT_ANY, "locked mab", "locked mab %s ",
+				     rta_getattr_u8(tb[IFLA_BRPORT_LOCKED]));
+		else
+			print_on_off(PRINT_ANY, "locked", "locked %s ",
+				     rta_getattr_u8(tb[IFLA_BRPORT_LOCKED]));
+	}
 
 	if (tb[IFLA_BRPORT_BACKUP_PORT]) {
 		int backup_p = rta_getattr_u32(tb[IFLA_BRPORT_BACKUP_PORT]);
@@ -411,6 +417,10 @@ static int bridge_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			bridge_slave_parse_on_off("locked", *argv, n,
 						  IFLA_BRPORT_LOCKED);
+		} else if (matches(*argv, "mab") == 0) {
+			NEXT_ARG();
+			bridge_slave_parse_on_off("mab", *argv, n,
+						  IFLA_BRPORT_MAB);
 		} else if (matches(*argv, "backup_port") == 0) {
 			int ifindex;
 
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index d4df772e..40250477 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -54,6 +54,7 @@ bridge \- show / manipulate bridge addresses and devices
 .BR vlan_tunnel " { " on " | " off " } ] [ "
 .BR isolated " { " on " | " off " } ] [ "
 .BR locked " { " on " | " off " } ] [ "
+.BR mab " { " on " | " off " } ] [ "
 .B backup_port
 .IR  DEVICE " ] ["
 .BR nobackup_port " ] [ "
@@ -580,6 +581,15 @@ The common use is that hosts are allowed access through authentication
 with the IEEE 802.1X protocol or based on whitelists or like setups.
 By default this flag is off.
 
+.TP
+.RB "mab on " or " mab off "
+Enables or disables the MAB/MacAuth feature. This feature can only be
+activated on a port that is in locked mode, and when enabled it extends the
+locked port feature so that MAC address can get access through a locked
+port based on acceptlists, thus it is a much simpler procedure for a
+device to become authorized than f.ex. the 802.1X protocol, and is used
+for devices that are not capable of password or crypto based authorization
+methods.
 
 .TP
 .BI backup_port " DEVICE"
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index fc9d62fc..187ca7ca 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2454,6 +2454,9 @@ the following additional arguments are supported:
 .BR isolated " { " on " | " off " }"
 ] [
 .BR locked " { " on " | " off " }"
+] [
+.BR mab " { " on " | " off " }"
+] [
 .BR backup_port " DEVICE"
 ] [
 .BR nobackup_port " ]"
@@ -2560,6 +2563,11 @@ default this flag is off.
 behind the port cannot communicate through the port unless a FDB entry
 representing the host is in the FDB. By default this flag is off.
 
+.BR mab " { " on " | " off " }"
+- enables or disables the MAB/MacAuth feature on a locked port. It is
+thus possible for a device to gain authorization on a locked port based
+on acceptlists.
+
 .BI backup_port " DEVICE"
 - if the port loses carrier all traffic will be redirected to the
 configured backup port
-- 
2.34.1

