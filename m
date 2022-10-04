Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A76041725
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29E5340911
From: Hans Schultz <netdev@kapio-technology.com>
Date: Tue,  4 Oct 2022 17:20:34 +0200
Message-Id: <20221004152036.7848-2-netdev@kapio-technology.com>
In-Reply-To: <20221004152036.7848-1-netdev@kapio-technology.com>
References: <20221004152036.7848-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 iproute2-next 2/4] bridge: fdb: show locked FDB
	entries flag in output
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

Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
---
 bridge/fdb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 5f71bde0..f1f0a5bb 100644
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
-- 
2.34.1

