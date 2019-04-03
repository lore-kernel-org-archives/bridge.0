Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=cviNhN8lipMp7LA1QicaaUzhIeFP5ky1Hv7DQgVZe3M=;
	b=epSTUULSAYR3wHhhHpipyjhNonHEEn6YZgcFeECj3CnrZqmC0xnKfHQniRaKvAQNHZ
	O4AXf17swl3EdkiriFDvB5PMQVvJnjqW5/PBkXcNyj6o2+43YBhtxHK0Wf9YwkoNhNQ6
	kPrzxDcIvtqkGil8K3qgNkfzCeSgJKQVDUeXM=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  3 Apr 2019 13:49:24 +0300
Message-Id: <20190403104924.32695-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: optimize backup_port fdb
	convergence
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

We can optimize the fdb convergence when a backup_port is present by not
immediately flushing the entries of the stopped port since traffic for
those entries will flow towards the backup_port.

There are 2 cases specifically that benefit most:
- when the stopped port comes up before the entries expire by themselves
- when there's an external entry refresh and they're kept while the
  backup_port is operating (e.g. mlag)

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
We have been running with this change for over an year, it has been
extensively tested.

 net/bridge/br_stp_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 808e2b914015..8d65ae5210e0 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -117,7 +117,8 @@ void br_stp_disable_port(struct net_bridge_port *p)
 	del_timer(&p->forward_delay_timer);
 	del_timer(&p->hold_timer);
 
-	br_fdb_delete_by_port(br, p, 0, 0);
+	if (!rcu_access_pointer(p->backup_port))
+		br_fdb_delete_by_port(br, p, 0, 0);
 	br_multicast_disable_port(p);
 
 	br_configuration_update(br);
-- 
2.20.1

