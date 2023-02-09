Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72DAD40612
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A257640104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/6+UXKKZ2rpYAaCAv+LG7aAv+9rhlrWlu74D+hcCj8=;
 b=HfvunNxH99N67atjuhvx551EyOJpUK1uV+f3DzMdbo/tmfPcsTWt1WisEHkXyLLzTShepmJ8Ueo1EsBQ3EClXmNjJ0F9eAtpEmOvLSi2qKA/malGa8LcoKMcxyxMvhXjvnER46dSdtkkenyRdAjyHYZARseHdBXCjy7iy0XLaobxTBxMHHvrEQB2nGToFEYaB7oQP/fZmxTlJq7bBmeadrG5s7tDvx/g21U+HuVZ7dG+0y4a2deFEeMV2fw8wsFN0iNU1k36fObxAHcRvaL4ffx/PRFnt6OisMybNBNI+UCsJUE/hBiCQdMMHJwKG0C6oGXEPtKNfSgRAb9Biffgxg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  9 Feb 2023 09:18:50 +0200
Message-Id: <20230209071852.613102-3-idosch@nvidia.com>
In-Reply-To: <20230209071852.613102-1-idosch@nvidia.com>
References: <20230209071852.613102-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 2/4] bridge: mcast: Remove pointless
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

Note that even if the function was invoked, we still could not
accurately determine if the dump is consistent or not, as there is no
sequence generation counter for MDB entries, unlike nexthop objects, for
example.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 13076206e497..96f36febfb30 100644
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

