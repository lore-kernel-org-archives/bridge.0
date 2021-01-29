Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZvmKhhGuNfQqKYS0ONCipHml5PaR0WqqxykEBH6rscI=;
 b=ip6LdHc/G3yEH9xz5h6f+xeDxBXZwmiONIChDNt1lGD19nYiDc5DCCLV7DxI555Xn+
 bUMtYieBQ6B1aLSk42ueetUHQenPlixh/wlXfBONAPcEVP6SrBbKhR+HTee0o+YZv+qP
 Y0IBsyKgJMFi6JOScWUujlkZtAwGvtCK3a4KsyGtTYuhOnUY+THayB0DQPMe9eVZy6RT
 y/zPae2K1TC+d7Y6z1jlPCe109/JGMabIq+EWdBi+OKdKgNukHTIouABMas6FY++1Zt/
 Z6KKFFEb52V8o3tsPp8ybiRzmCZallGfD066bIRU3xFog5Ts20bAfDDR/rpktm0comUI
 rfGA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 29 Jan 2021 13:51:42 +0200
Message-Id: <20210129115142.188455-3-razor@blackwall.org>
In-Reply-To: <20210129115142.188455-1-razor@blackwall.org>
References: <20210129115142.188455-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: add warning comments to
	avoid extending sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We're moving to netlink-only options, so add comments in the bridge's
sysfs files to warn against adding any new sysfs entries.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_sysfs_br.c | 4 ++++
 net/bridge/br_sysfs_if.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 7db06e3f642a..71f0f671c4ef 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -19,6 +19,10 @@
 
 #include "br_private.h"
 
+/* IMPORTANT: new bridge options must be added with netlink support only
+ *            please do not add new sysfs entries
+ */
+
 #define to_bridge(cd)	((struct net_bridge *)netdev_priv(to_net_dev(cd)))
 
 /*
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7a59cdddd3ce..96ff63cde1be 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -17,6 +17,10 @@
 
 #include "br_private.h"
 
+/* IMPORTANT: new bridge port options must be added with netlink support only
+ *            please do not add new sysfs entries
+ */
+
 struct brport_attribute {
 	struct attribute	attr;
 	ssize_t (*show)(struct net_bridge_port *, char *);
-- 
2.29.2

