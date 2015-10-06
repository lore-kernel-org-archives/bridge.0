Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  6 Oct 2015 14:12:01 +0200
Message-Id: <1444133522-16907-8-git-send-email-razor@blackwall.org>
In-Reply-To: <1444133522-16907-1-git-send-email-razor@blackwall.org>
References: <1444133522-16907-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 7/8] bridge: netlink: allow to flush
	port's fdb
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Add IFLA_BRPORT_FLUSH to allow flushing port's fdb similar to sysfs's
flush.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h | 1 +
 net/bridge/br_netlink.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 9c17f605e013..fcea39a56095 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -303,6 +303,7 @@ enum {
 	IFLA_BRPORT_MESSAGE_AGE_TIMER,
 	IFLA_BRPORT_FORWARD_DELAY_TIMER,
 	IFLA_BRPORT_HOLD_TIMER,
+	IFLA_BRPORT_FLUSH,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 04b0e5072686..6468166d6bdc 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -631,6 +631,9 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 			return err;
 	}
 
+	if (tb[IFLA_BRPORT_FLUSH])
+		br_fdb_delete_by_port(p->br, p, 0, 0);
+
 	br_port_flags_change(p, old_flags ^ p->flags);
 	return 0;
 }
-- 
2.4.3

