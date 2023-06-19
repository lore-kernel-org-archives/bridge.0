Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBC6081BC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63DA481AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1687158915; bh=BNp1+DjjLSKZLoGkP0KT3SOsCB2azAY047syYb/kWxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R7jRjnsXhMjv1X2vrOSJOMJZ/V/dfuxQV5Tyg5kgXwC4Cmn8+TjQwZ1awcblvbRkQ
 ZMDZzCSHODo3gnm2eNkcf3wI5AmDDf5HxkcjaJV47j/BYNB+qwZODDYUcPD+ZVuKzN
 1cyvbnXF70dM2l5PcRQ/1Zpro++e0ySRNCLykQgA=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 19 Jun 2023 09:14:41 +0200
Message-Id: <20230619071444.14625-2-jnixdorf-oss@avm.de>
In-Reply-To: <20230619071444.14625-1-jnixdorf-oss@avm.de>
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 1/3] bridge: Set BR_FDB_ADDED_BY_USER
	early in fdb_add_entry
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

This allows the called fdb_create to detect that the entry was added by
the user early in the process. This is in preparation to adding limits
in fdb_create that should not apply to user created fdb entries.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

---

Changes since v1:
 - Added this change to ensure user added entries are not limited.

 net/bridge/br_fdb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e69a872bfc1d..ac1dc8723b9c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1056,7 +1056,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, source, addr, vid, 0);
+		fdb = fdb_create(br, source, addr, vid, BR_FDB_ADDED_BY_USER);
 		if (!fdb)
 			return -ENOMEM;
 
@@ -1069,6 +1069,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			WRITE_ONCE(fdb->dst, source);
 			modified = true;
 		}
+
+		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	}
 
 	if (fdb_to_nud(br, fdb) != state) {
@@ -1100,8 +1102,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 	if (fdb_handle_notify(fdb, notify))
 		modified = true;
 
-	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-
 	fdb->used = jiffies;
 	if (modified) {
 		if (refresh)
-- 
2.40.1

