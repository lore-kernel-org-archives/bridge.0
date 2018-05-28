Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FS/PSjWciJJWN5F7D03tJrOIDzD2wHCqD2aFUVtCvA8=;
	b=W0XJBKlrkY935g1/5epekldGEDPdNvboqDPxcNWWLgKq1Ibyxg7++2MVLj6UD7tXD0Y+AoC07c+A/oi2Uo/I51ZMin+BbKzzfgu3FJiIS2c10554AQ5/IxAATnE9GSecJX9JzXsQ5FVORkHIP+bKWDcmXaXzwmkCTuSde0CvYUc=
From: Petr Machata <petrm@mellanox.com>
Message-Id: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 17:44:16 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
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
br_fdb_find_port() doesn't do. Add the missing lock/unlock
pair.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/bridge/br_fdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b19e310..3f5691a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -135,9 +135,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 		return NULL;
 
 	br = netdev_priv(br_dev);
+	spin_lock_bh(&br->hash_lock);
 	f = br_fdb_find(br, addr, vid);
 	if (f && f->dst)
 		dev = f->dst->dev;
+	spin_unlock_bh(&br->hash_lock);
 
 	return dev;
 }
-- 
2.4.11

