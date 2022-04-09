Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OJhM912bfhb7uMFugRwaEA6kDWsFt0tEfGy7vW0mS0I=;
 b=SIbGuIOlNQM2gXLI6wvPq/OiqaZuZlgUzTQ45QFtUYdm6NIIc3GSxL6kYcVzdawb6b
 YtW8i9z7gmBXEx64ydeD1JW3GTPA4jfmSs7UXYvcry4+LO+XfgoAZ2BAUkhM0BN7fDC3
 ZVTQ4/fosfRQ50fAeOZTNrrhPjvb74jIQ7eojyRiEQaDd2e2lr7ydHrYgHH7DOHESflO
 HIbFJgGZ35WPNj4QMOx+/QVLiwJryGWgzxyc3n8Xgfg/V4MSz/LE8o7IH8YKJgvSwDxO
 qtA4SE/Kn94ydc9pgbR4fj45t3HbfndToPy2YfOehBYZodIAiWm53alkq0FjLLV2UwIn
 vURw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sat,  9 Apr 2022 13:58:52 +0300
Message-Id: <20220409105857.803667-2-razor@blackwall.org>
In-Reply-To: <20220409105857.803667-1-razor@blackwall.org>
References: <20220409105857.803667-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/6] net: bridge: add a generic flush
	operation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

Add a new bridge attribute (IFLA_BRIDGE_FLUSH) which will have embedded
attributes describing the object types that will be flushed. It will
allow fine-grained object flushing. Only a single flush attribute is
allowed per call since it can be a very load heavy operation. Also it is
allowed only with setlink command (similar to changelink flush). A nice
side-effect of using an af spec attribute is that it avoids making the
bridge link attribute options list longer.

An example structure for fdbs:
 [ IFLA_BRIDGE_FLUSH ]
  `[ BRIDGE_FDB_FLUSH ]
    `[ FDB_FLUSH_NDM_STATE ]
    `[ FDB_FLUSH_NDM_FLAGS ]

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h |  8 +++++++
 net/bridge/br_netlink.c        | 42 +++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index a86a7e7b811f..221a4256808f 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -123,6 +123,7 @@ enum {
 	IFLA_BRIDGE_MRP,
 	IFLA_BRIDGE_CFM,
 	IFLA_BRIDGE_MST,
+	IFLA_BRIDGE_FLUSH,
 	__IFLA_BRIDGE_MAX,
 };
 #define IFLA_BRIDGE_MAX (__IFLA_BRIDGE_MAX - 1)
@@ -802,4 +803,11 @@ enum {
 	__BRIDGE_QUERIER_MAX
 };
 #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
+
+/* embedded in IFLA_BRIDGE_FLUSH */
+enum {
+	BRIDGE_FLUSH_UNSPEC,
+	__BRIDGE_FLUSH_MAX
+};
+#define BRIDGE_FLUSH_MAX (__BRIDGE_FLUSH_MAX - 1)
 #endif /* _UAPI_LINUX_IF_BRIDGE_H */
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 200ad05b296f..fe2211d4c0c7 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -779,6 +779,34 @@ int br_process_vlan_info(struct net_bridge *br,
 	return err;
 }
 
+static const struct nla_policy br_flush_policy[BRIDGE_FLUSH_MAX + 1] = {
+	[BRIDGE_FLUSH_UNSPEC]	= { .type = NLA_REJECT },
+};
+
+static int br_flush(struct net_bridge *br, int cmd,
+		    struct nlattr *flush_attr,
+		    struct netlink_ext_ack *extack)
+{
+	struct nlattr *flush_tb[BRIDGE_FLUSH_MAX + 1];
+	int err;
+
+	switch (cmd) {
+	case RTM_SETLINK:
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Bridge flush attribute is allowed only with RTM_SETLINK");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(flush_tb, BRIDGE_FLUSH_MAX, flush_attr,
+			       br_flush_policy, extack);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int br_afspec(struct net_bridge *br,
 		     struct net_bridge_port *p,
 		     struct nlattr *af_spec,
@@ -787,9 +815,10 @@ static int br_afspec(struct net_bridge *br,
 {
 	struct bridge_vlan_info *vinfo_curr = NULL;
 	struct bridge_vlan_info *vinfo_last = NULL;
-	struct nlattr *attr;
 	struct vtunnel_info tinfo_last = {};
 	struct vtunnel_info tinfo_curr = {};
+	bool flushed = false;
+	struct nlattr *attr;
 	int err = 0, rem;
 
 	nla_for_each_nested(attr, af_spec, rem) {
@@ -845,6 +874,17 @@ static int br_afspec(struct net_bridge *br,
 			if (err)
 				return err;
 			break;
+		case IFLA_BRIDGE_FLUSH:
+			if (flushed) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Multiple bridge flush attributes are not allowed");
+				return -EINVAL;
+			}
+			err = br_flush(br, cmd, attr, extack);
+			if (err)
+				return err;
+			flushed = true;
+			break;
 		}
 	}
 
-- 
2.35.1

