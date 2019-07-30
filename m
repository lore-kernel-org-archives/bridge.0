Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tUCE/CHU/TFLeJ8RCnUMeDdjaEvSnhdkU6BkkzT8pAM=;
	b=IG6OHMW5XhjqtC/uFPxBykkCxq2KJntogSkgRduT75mGPI6Sx6/C98OaBe5/Zu7ITW
	tIkBQT2A+GYbhhzCJSmtws5xDw9CNlekeQ7LrdbK2pLC+p/InKYD8EudpNffMQaMc4Hp
	uhAs2ocTRAmTiAc4yexJCBd7AlW8uDWwv1SDg=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 30 Jul 2019 14:21:00 +0300
Message-Id: <20190730112100.18156-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: mcast: don't delete permanent
	entries when fast leave is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

When permanent entries were introduced by the commit below, they were
exempt from timing out and thus igmp leave wouldn't affect them unless
fast leave was enabled on the port which was added before permanent
entries existed. It shouldn't matter if fast leave is enabled or not
if the user added a permanent entry it shouldn't be deleted on igmp
leave.

Before:
$ echo 1 > /sys/class/net/eth4/brport/multicast_fast_leave
$ bridge mdb add dev br0 port eth4 grp 229.1.1.1 permanent
$ bridge mdb show
dev br0 port eth4 grp 229.1.1.1 permanent

< join and leave 229.1.1.1 on eth4 >

$ bridge mdb show
$

After:
$ echo 1 > /sys/class/net/eth4/brport/multicast_fast_leave
$ bridge mdb add dev br0 port eth4 grp 229.1.1.1 permanent
$ bridge mdb show
dev br0 port eth4 grp 229.1.1.1 permanent

< join and leave 229.1.1.1 on eth4 >

$ bridge mdb show
dev br0 port eth4 grp 229.1.1.1 permanent

Fixes: ccb1c31a7a87 ("bridge: add flags to distinguish permanent mdb entires")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
I'll re-work this code in net-next as there's a lot of duplication.

 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3d8deac2353d..f8cac3702712 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1388,6 +1388,9 @@ br_multicast_leave_group(struct net_bridge *br,
 			if (!br_port_group_equal(p, port, src))
 				continue;
 
+			if (p->flags & MDB_PG_FLAGS_PERMANENT)
+				break;
+
 			rcu_assign_pointer(*pp, p->next);
 			hlist_del_init(&p->mglist);
 			del_timer(&p->timer);
-- 
2.21.0

