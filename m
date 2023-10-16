Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20BA1410DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A165040EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1697463932; bh=NgkBfZvDnp28tB6EIHeiDgFJLnuXeYPOeJIQSM0YMeE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hPiwZJzHDyHwvtw9w3aqRm2XGikiBFzEqbKBz0V43r6/uu5/4J/S14d9BZWyjboIX
 G+OeYavPXwENlHXPSt/1HM5ZcFLoTRjkpox46SxaxlZx4RCs4wHxFRr6TdBJ53xwah
 RIEau2hR8os/+1G2nfCnJSCejFuNp2PSdOpXKhBI=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 16 Oct 2023 15:27:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-fdb_limit-v5-1-32cddff87758@avm.de>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
In-Reply-To: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697462840; l=1476;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=NgkBfZvDnp28tB6EIHeiDgFJLnuXeYPOeJIQSM0YMeE=;
 b=P2CRt2GKCgPCuza2aoXCWsML2X4W2HLuSp+5c1Blm8e6al9ihRSzyw1YQ2TSmaNo4IK/NzDAy
 zXNjq4FN/AGCkUPB6HUXdFIrJyowgO7hwjA9qrATlxO1UWtm/ND3p7T
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
Subject: [Bridge] [PATCH net-next v5 1/5] net: bridge: Set
 BR_FDB_ADDED_BY_USER early in fdb_add_entry
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

In preparation of the following fdb limit for dynamically learned entries,
allow fdb_create to detect that the entry was added by the user. This
way it can skip applying the limit in this case.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/br_fdb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e69a872bfc1d..f517ea92132c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1056,7 +1056,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, source, addr, vid, 0);
+		fdb = fdb_create(br, source, addr, vid,
+				 BIT(BR_FDB_ADDED_BY_USER));
 		if (!fdb)
 			return -ENOMEM;
 
@@ -1069,6 +1070,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			WRITE_ONCE(fdb->dst, source);
 			modified = true;
 		}
+
+		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 	}
 
 	if (fdb_to_nud(br, fdb) != state) {
@@ -1100,8 +1103,6 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 	if (fdb_handle_notify(fdb, notify))
 		modified = true;
 
-	set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
-
 	fdb->used = jiffies;
 	if (modified) {
 		if (refresh)

-- 
2.42.0

