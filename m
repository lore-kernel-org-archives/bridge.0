Return-Path: <joakim.tjernlund@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Wed, 29 Feb 2012 10:15:23 +0100
Message-Id: <1330506923-10878-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: [Bridge] [PATCH] bridge: make brctl showstp display port id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

My brctl showstp br0 always shows a 0 port id:
eth2 (1)
 port id		0			state		       disabled
 designated root	8000.00069c00b2fb	path cost		 100

because port id is printed as a hex number in sys fs. Change the
two hex occurrences(port no and port id) to decimal, just like all
the other numbers in this area.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 net/bridge/br_sysfs_if.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index fd5799c..9c4c2eb 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -86,13 +86,13 @@ static BRPORT_ATTR(designated_cost, S_IRUGO, show_designated_cost, NULL);
 
 static ssize_t show_port_id(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "0x%x\n", p->port_id);
+	return sprintf(buf, "%d\n", p->port_id);
 }
 static BRPORT_ATTR(port_id, S_IRUGO, show_port_id, NULL);
 
 static ssize_t show_port_no(struct net_bridge_port *p, char *buf)
 {
-	return sprintf(buf, "0x%x\n", p->port_no);
+	return sprintf(buf, "%d\n", p->port_no);
 }
 
 static BRPORT_ATTR(port_no, S_IRUGO, show_port_no, NULL);
-- 
1.7.3.4

