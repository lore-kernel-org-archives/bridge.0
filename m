Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
Date: Wed, 24 Mar 2021 15:09:50 +0000
Message-Id: <20210324150950.253698-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH][next] net: bridge: Fix missing return assignment
	from br_vlan_replay_one call
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to br_vlan_replay_one is returning an error return value but
this is not being assigned to err and the following check on err is
currently always false because err was initialized to zero. Fix this
by assigning err.

Addresses-Coverity: ("'Constant' variable guards dead code")
Fixes: 22f67cdfae6a ("net: bridge: add helper to replay VLANs installed on port")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ca8daccff217..7422691230b1 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1815,7 +1815,7 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
 		if (!br_vlan_should_use(v))
 			continue;
 
-		br_vlan_replay_one(nb, dev, &vlan, extack);
+		err = br_vlan_replay_one(nb, dev, &vlan, extack);
 		if (err)
 			return err;
 	}
-- 
2.30.2

