Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=O+qlCeiMR4wNEYStatDWAWRjjIGpz2wsw5tbhBwTAzI=;
	b=BgYzNYuiOl+efhLVY4Ewzl6mmAo+B+wqqe5Dcxip9o5xXpG3smazEqgv1WtcvUOoDo
	6GhFkBC34k4U8CvNlQgzoHMZi/cxQWqPrhb6XFMdOPbkcHWYNA5zVZJqGkfrKRzY1qRp
	xhHVfrxChfDrKmwn9hyKdtZvbaYusJsEIBUBY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jul 2015 06:36:19 -0700
Message-Id: <1436794579-4188-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] bridge: mdb: fix double add notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, amwang@redhat.com, davem@davemloft.net

Since the mdb add/del code was introduced there have been 2 br_mdb_notify
calls when doing br_mdb_add() resulting in 2 notifications on each add.

Example:
 Command: bridge mdb add dev br0 port eth1 grp 239.0.0.1 permanent
 Before patch:
 root@debian:~# bridge monitor all
 [MDB]dev br0 port eth1 grp 239.0.0.1 permanent
 [MDB]dev br0 port eth1 grp 239.0.0.1 permanent

 After patch:
 root@debian:~# bridge monitor all
 [MDB]dev br0 port eth1 grp 239.0.0.1 permanent

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Fixes: cfd567543590 ("bridge: add support of adding and deleting mdb entries")
---
 net/bridge/br_mdb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index c11cf2611db0..1198a3dbad95 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -351,7 +351,6 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	if (state == MDB_TEMPORARY)
 		mod_timer(&p->timer, now + br->multicast_membership_interval);
 
-	br_mdb_notify(br->dev, port, group, RTM_NEWMDB);
 	return 0;
 }
 
-- 
1.9.1

