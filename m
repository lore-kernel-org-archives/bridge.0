Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02DDE41B9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9242D41B87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REBoPD/3fQkhdNFrYHOPfbSU4VP8xl+1/rrOSS6EpiM=;
 b=Xpe75xFXp7TfciZj62RfnS5pOJlCDkoe7MrQ4MmSMTbacWdaOso8dwAcNtHWWYU144MuNNqOdM1L6O5TfXXHgdNFvCB2QKM+edQBVkKJMbnipr+gxQpKCjnDk+640ScMro6i6mvxqNOXGTt9pg7BBXLzL9kKGLWTz7nTByBqowg1BtTyrHNIPFJFdbW2enEm1hG8FzPTcowG0Di9nucHRiMYzpnBjd1mgBDptTktnGIjBu67vvNBfe6juOWIHvtZewWsv4lzQ71QAAArg5uEL0hL05z9VE+nC7phqjjBwzrHrTcHDeQpuq14AGTIml4cLbtvM5zEIRikH0XrrvmXJw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:07:50 +0200
Message-Id: <20230204170801.3897900-3-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 02/13] bridge: mcast: Remove pointless
	sequence generation counter assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The purpose of the sequence generation counter in the netlink callback
is to identify if a multipart dump is consistent or not by calling
nl_dump_check_consistent() whenever a message is generated.

The function is not invoked by the MDB code, rendering the sequence
generation counter assignment pointless. Remove it.

Note that even the function was invoked, we still could not accurately
determine if the dump is consistent or not, as there is no sequence
generation counter for MDB entries, unlike nexthop objects, for example.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index fc98c32e5894..e40a4c275d63 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -421,8 +421,6 @@ static int br_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 
-	cb->seq = net->dev_base_seq;
-
 	for_each_netdev_rcu(net, dev) {
 		if (netif_is_bridge_master(dev)) {
 			struct net_bridge *br = netdev_priv(dev);
-- 
2.37.3

