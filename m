Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PsVnZiU164smHUvfeaLehL8S/X1w62QMfoibHkfcTw8=;
 b=Djy+o3H71e3jVrH1oxVs/TKg65SF8T1ef5c1OnJdOmNtq1nGUFiJfPUyk6RBFwagNy
 q6mO8rf8A2KSQu5/Nd0Cdu0/nslWy9hcaIFGfRO8u9dJz1rTVZIgXjbvVYumTIyv2b/Y
 H6bdubYoXoYX97JdYF2kdf9/2eDkUgHJ5zOJc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 23 Jun 2020 23:47:18 +0300
Message-Id: <20200623204718.1057508-5-nikolay@cumulusnetworks.com>
In-Reply-To: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
References: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 4/4] net: bridge: add a flag to avoid
	refreshing fdb when changing/adding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, anuradhak@cumulusnetworks.com

When we modify or create a new fdb entry sometimes we want to avoid
refreshing its activity in order to track it properly. One example is
when a mac is received from EVPN multi-homing peer by FRR, which doesn't
want to change local activity accounting. It makes it static and sets a
flag to track its activity.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/neighbour.h | 1 +
 net/bridge/br_fdb.c            | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 21e569297355..dc8b72201f6c 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -191,6 +191,7 @@ enum {
 enum {
 	NFEA_UNSPEC,
 	NFEA_ACTIVITY_NOTIFY,
+	NFEA_DONT_REFRESH,
 	__NFEA_MAX
 };
 #define NFEA_MAX (__NFEA_MAX - 1)
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 642deb57c064..9db504baa094 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -860,6 +860,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			 struct nlattr *nfea_tb[])
 {
 	bool is_sticky = !!(ndm->ndm_flags & NTF_STICKY);
+	bool refresh = !nfea_tb[NFEA_DONT_REFRESH];
 	struct net_bridge_fdb_entry *fdb;
 	u16 state = ndm->ndm_state;
 	bool modified = false;
@@ -937,7 +938,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb->used = jiffies;
 	if (modified) {
-		fdb->updated = jiffies;
+		if (refresh)
+			fdb->updated = jiffies;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	}
 
@@ -977,6 +979,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 
 static const struct nla_policy br_nda_fdb_pol[NFEA_MAX + 1] = {
 	[NFEA_ACTIVITY_NOTIFY]	= { .type = NLA_U8 },
+	[NFEA_DONT_REFRESH]	= { .type = NLA_FLAG },
 };
 
 /* Add new permanent fdb entry with RTM_NEWNEIGH */
-- 
2.25.4

