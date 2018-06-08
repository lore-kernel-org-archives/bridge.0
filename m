Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BEQYOMaol3w6XMUXNVMnLkhh+O3/DC6o3wTiTrVAkqs=;
	b=QKCI/FMr4vnSz5EpG5bbzumIJFh6XxjNfXCqvZnJHSr5wunRoCs/a9IH6aV50on0ee8KRDim/0vzBP3ytiY+XfDvzkDW2bMUIJTc6CaUgu99srcbWCgnQ3+ReZ0MGU4xTa4VhNGKw7STFQmXB8RDz+jAw46c276aOxNbMTPxP4U=
From: Petr Machata <petrm@mellanox.com>
Message-Id: <c41fffa00abb9a123039e5509886a0de85274291.1528450455.git.petrm@mellanox.com>
Date: Fri, 08 Jun 2018 15:11:47 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2] net: bridge: Fix locking in
	br_fdb_find_port()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: davem@davemloft.net

Callers of br_fdb_find() need to hold the hash lock, which
br_fdb_find_port() doesn't do. However, since br_fdb_find_port() is not
doing any actual FDB manipulation, the hash lock is not really needed at
all. So convert to br_fdb_find_rcu(), surrounded by rcu_read_lock() /
_unlock() pair.

The device pointer copied from inside the FDB entry is then kept alive
by the RTNL lock, which br_fdb_find_port() asserts.

Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
Signed-off-by: Petr Machata <petrm@mellanox.com>
---

Notes:
    Changes from v1 to v2:
    
    - Instead of taking hash lock, take RCU lock and call br_fdb_find_rcu().

 net/bridge/br_fdb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b19e310..502f663 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -135,9 +135,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 		return NULL;
 
 	br = netdev_priv(br_dev);
-	f = br_fdb_find(br, addr, vid);
+	rcu_read_lock();
+	f = br_fdb_find_rcu(br, addr, vid);
 	if (f && f->dst)
 		dev = f->dst->dev;
+	rcu_read_unlock();
 
 	return dev;
 }
-- 
2.4.11

