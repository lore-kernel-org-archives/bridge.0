Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oBdSRBSL9SwHID5EgwRDyrtGW6ivDgDVN8Vt0uknk7k=;
	b=VuV3I9X7EA5m5WbsRBkLJlRmULNcKKsZVoNdbPujTh+3WNOL68dtI5Q3KKzeL4c9hH
	yOGr0V4TWaMt+LovRxfSUwFMhcnfystGyAKVTKGTs1Y/DRA/cMMN87QR+thToRaoajpB
	dVjID26xM8u6jlWSeLRjymdT/2I1ttF+/VNQo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 15 Jul 2015 07:16:50 -0700
Message-Id: <1436969811-13237-2-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/2] bridge: multicast: notify on group
	delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

Group notifications were not sent when a group expired or was deleted
due to bridge/port device being deleted. So add br_mdb_notify() to
br_multicast_del_pg().

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5a44cd9473f2..55903d91d0a8 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -273,6 +273,8 @@ static void br_multicast_del_pg(struct net_bridge *br,
 		rcu_assign_pointer(*pp, p->next);
 		hlist_del_init(&p->mglist);
 		del_timer(&p->timer);
+		br_mdb_notify(br->dev, p->port, &pg->addr, RTM_DELMDB,
+			      p->state);
 		call_rcu_bh(&p->rcu, br_multicast_free_pg);
 
 		if (!mp->ports && !mp->mglist &&
-- 
1.9.3

