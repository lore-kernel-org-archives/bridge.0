Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=+kuDhnUR3YuImz4RVuNWZRkytTyl15c52epk+YukdGs=;
	b=eeVBbiD58cLfc3LpHZFrDgq8ZhKTdFJSSNjJD4XRfIEE2+I33wbRYZfwqx5Msdl7FH
	UAocV3/WPf/B+FVnG9C+48ah9/YuP6t/LCx786udDmFjbfezTKIc6QD+5lxyz8eJytkF
	XY8Hnd0XXHwuJgSDbGUS8vhX/1Gharz0+43uU=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 19 Oct 2017 20:17:32 +0300
Message-Id: <1508433452-23812-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: fix returning of vlan range op
	errors
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

When vlan tunnels were introduced, vlan range errors got silently
dropped and instead 0 was returned always. Restore the previous
behaviour and return errors to user-space.

Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
err should be always set because we have a check for the vid range above
the loop and it must ensure we will go through the loop at least once

 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3bc890716c89..de2152730809 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -573,7 +573,7 @@ static int br_process_vlan_info(struct net_bridge *br,
 		}
 		*vinfo_last = NULL;
 
-		return 0;
+		return err;
 	}
 
 	return br_vlan_info(br, p, cmd, vinfo_curr);
-- 
2.1.4

