Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE87D60FDB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEF8260FD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc+o0DhHymNEO83gPG4UU9+8CmTDns9+6MM1r1bR4vw=;
 b=A0qNdgpv1ukflSkpLbrMDRWb3UfGtr2cW7i00MGghxkPUxG9b4X2eV05DJkjk/GgHK3Irx32xw79TIFhurMLexksQ5qTXNzwXRGg9e+Yp6mf5IzzxoS5yMfwZjUT8poy1QaefKJlqUv65AS7xrBOIa1P7snGFX0KRV0gmHErifKgG56uMUWIlVxnpywUSbECRX8kzyCOxZV5KNoZA0eo+8dpOGxEZgxEwzYuv50XS0kd41EEbAi3cRPTJr1eCv6z6IEKmp9ZNnXQL3FfAXKsEfFWa9CZtb3DM0gStTTdaFLEH3nDknwCYD9A9t/TJ47zd0cfL46Xss008Axs3IBGsg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 09:40:01 +0300
Message-Id: <20221018064001.518841-5-idosch@nvidia.com>
In-Reply-To: <20221018064001.518841-1-idosch@nvidia.com>
References: <20221018064001.518841-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 4/4] bridge: mcast: Simplify MDB entry
	creation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Before creating a new MDB entry, br_multicast_new_group() will call
br_mdb_ip_get() to see if one exists and return it if so.

Therefore, simply call br_multicast_new_group() and omit the call to
br_mdb_ip_get().

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 589ff497d50c..321be94c445a 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -866,7 +866,6 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	unsigned long now = jiffies;
 	unsigned char flags = 0;
 	u8 filter_mode;
-	int err;
 
 	__mdb_entry_to_br_ip(entry, &group, mdb_attrs);
 
@@ -892,13 +891,9 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 		return -EINVAL;
 	}
 
-	mp = br_mdb_ip_get(br, &group);
-	if (!mp) {
-		mp = br_multicast_new_group(br, &group);
-		err = PTR_ERR_OR_ZERO(mp);
-		if (err)
-			return err;
-	}
+	mp = br_multicast_new_group(br, &group);
+	if (IS_ERR(mp))
+		return PTR_ERR(mp);
 
 	/* host join */
 	if (!port) {
-- 
2.37.3

