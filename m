Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE36081E49
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BED781F85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqHB7dWSGsKpXgwAQVQWWEimvj8FozTynhhfekfxDV0=;
 b=KG3tMqeZmADTy4PKT8bM+194p9Ko+bhpCrWsbguW/KL8pxBA6IfUYNilkmfYwLG+a9vKyYjK3VMF2/dPRsbn0KSn/3PoLqW8rAEYpLYfDzH2OqIV27xTdAX8TUHiHtiMk82zmNru/Vb7tgxLUDsUoUpZWiSEVhQNvOXCHRpJDSD0iUjrMfidw8jhorPz/CU5AEOi94od0YGv3F5QcPdcNU4ny1WaXeA3825x4SmAslQMIEBC1LNgW+Ry9dqtO5Z1PlFpWMn6TJM+YsfruN5EBSNSH0nPrKPoTYCWEbM456NNIAjDVUGzCDLMrH+YF1g/5J89Ifye3uLnkhV8UugxMA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  9 Feb 2023 09:18:49 +0200
Message-Id: <20230209071852.613102-2-idosch@nvidia.com>
In-Reply-To: <20230209071852.613102-1-idosch@nvidia.com>
References: <20230209071852.613102-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 1/4] bridge: mcast: Use correct define in
	MDB dump
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

'MDB_PG_FLAGS_PERMANENT' and 'MDB_PERMANENT' happen to have the same
value, but the latter is uAPI and cannot change, so use it when dumping
an MDB entry.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 9f22ebfdc518..13076206e497 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -259,7 +259,7 @@ static int __mdb_fill_info(struct sk_buff *skb,
 #endif
 	} else {
 		ether_addr_copy(e.addr.u.mac_addr, mp->addr.dst.mac_addr);
-		e.state = MDB_PG_FLAGS_PERMANENT;
+		e.state = MDB_PERMANENT;
 	}
 	e.addr.proto = mp->addr.proto;
 	nest_ent = nla_nest_start_noflag(skb,
-- 
2.37.3

