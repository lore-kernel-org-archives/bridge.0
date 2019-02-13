Return-Path: <sashal@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025391;
	bh=oTMGjszo6I0HjGUIDuK/cz8GozeNGBd4cUT4fhbWEco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8AoJ6azeFnqg1vUkYIQ/sdaDzRV9vgPs/ynS/tK01tMv4qwl9ulTCMQkWxCPxTvt
	Ph92LglLtbfgREAsf7vwLzTROU7FQKa+oSR26maCRd9wKtfBZj1P2A0bjiNXy3L+S0
	RLkaA7lkt2/h9OpPBDHKEsFE5UYZBH4MA9WNaOXU=
From: Sasha Levin <sashal@kernel.org>
Date: Tue, 12 Feb 2019 21:33:30 -0500
Message-Id: <20190213023336.19019-99-sashal@kernel.org>
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 4.20 099/105] net: bridge: Mark FDB entries
	that were added by user as such
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, "David S . Miller" <davem@davemloft.net>

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 710ae72877378e7cde611efd30fe90502a6e5b30 ]

Externally learned entries can be added by a user or by a switch driver
that is notifying the bridge driver about entries that were learned in
hardware.

In the first case, the entries are not marked with the 'added_by_user'
flag, which causes switch drivers to ignore them and not offload them.

The 'added_by_user' flag can be set on externally learned FDB entries
based on the 'swdev_notify' parameter in br_fdb_external_learn_add(),
which effectively means if the created / updated FDB entry was added by
a user or not.

Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e56ba3912a90..8b8abf88befb 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1102,6 +1102,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
+		if (swdev_notify)
+			fdb->added_by_user = 1;
 		fdb->added_by_external_learn = 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
@@ -1121,6 +1123,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
+		if (swdev_notify)
+			fdb->added_by_user = 1;
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
-- 
2.19.1

