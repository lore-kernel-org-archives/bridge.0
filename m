Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=NqCB67vT/c9mnsvCZbyxsMiWwZnjZ99KtMNG9ZRMdjE=;
 b=nCKpcv8pOchn2LpC3a/sEnI8cxJFMz8viJQDl7VV8+p0GiE3TYJ7Tvz1BJEHn/4MfZ
 T7gX/nVKdlYi3BEEDxDduv+dwNSZ6h3g6OBm0IvBc8qgolkU0UP0kMcjP+RYSQpZM9I+
 NFQmUbZGwC2h1JkqvAY5XbGLqyvEWKrisf/O0hMRFPLuXTaD/TYBtiR/W5Br/qxcoxev
 hHid6O4YHi50rYahmytGQ36sGAdlyvB6xYuq5pfU/UWIQXGXDpLenJwB/pX08zahrUEK
 6NUOjLb80aPnM8ZT8Y0VsVa1rz6SiO0yAowTfsS4eSbX/c0iRZwRzu+vjyBhUT99hebH
 WAKw==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Thu, 10 Mar 2022 15:23:19 +0100
Message-Id: <20220310142320.611738-3-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/3] net: switchdev: add support for
	offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

Used for Mac-auth/MAB feature in the offloaded case.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 include/net/switchdev.h | 3 ++-
 net/bridge/br.c         | 3 ++-
 net/bridge/br_fdb.c     | 7 +++++--
 net/bridge/br_private.h | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 3e424d40fae3..d5d923411f5e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -229,7 +229,8 @@ struct switchdev_notifier_fdb_info {
 	u16 vid;
 	u8 added_by_user:1,
 	   is_local:1,
-	   offloaded:1;
+	   offloaded:1,
+	   locked:1;
 };
 
 struct switchdev_notifier_port_obj_info {
diff --git a/net/bridge/br.c b/net/bridge/br.c
index b1dea3febeea..adcdbecbc218 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -166,7 +166,8 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid, false);
+						fdb_info->vid, false,
+						fdb_info->locked);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 396dcf3084cf..91387aa7e400 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -987,7 +987,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 					   "FDB entry towards bridge must be permanent");
 			return -EINVAL;
 		}
-		err = br_fdb_external_learn_add(br, p, addr, vid, true);
+		err = br_fdb_external_learn_add(br, p, addr, vid, true, false);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1216,7 +1216,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool swdev_notify)
+			      bool swdev_notify, bool locked)
 {
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
@@ -1236,6 +1236,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (!p)
 			flags |= BIT(BR_FDB_LOCAL);
 
+		if (locked)
+			flags |= BIT(BR_FDB_ENTRY_LOCKED);
+
 		fdb = fdb_create(br, p, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f5a0b68c4857..3275e33b112f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -790,7 +790,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool swdev_notify);
+			      bool swdev_notify, bool locked);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
-- 
2.30.2

