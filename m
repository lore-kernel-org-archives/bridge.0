Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=lyN99P58NnZgzDd6tM4tQm6wU7x+Iv4T7hdOYs8j5lk=;
	b=L/M5Gs11W7YrZl9zhhJMwHKQuc/F4w+2Jvyl0a7kFLduPTh4e/eS9dVbu2JibYMzBJ
	1476mn0Rh3qnZcJKQ0IlzU8FxZ44KchDCT9i3wzMzDtyLkaHiUAxVuVGMkYU/36Vjjhv
	D5nNh+xoJJmZcQDQvSiFZm8xslHw59t8Glysbg0fi6vbnDH60RtuIIYt/AQFRZ6g6heg
	W3GmG2ussW4BNFkfZeWWwUXqZ35z3MgqYlC942Bi+xUkREetEy8jMaMZl8aXKmVQg4BR
	S7exp6mzOFGS4+gDuQRGswH/Y7iV7q64SbzUv1hwK0tbSLDdLWS5p5QgjptfC12ZqHrV
	qR9w==
From: Xin Long <lucien.xin@gmail.com>
Date: Sat,  9 Apr 2016 00:03:32 +0800
Message-Id: <8c87a70b3c214f90b7345edb68536429fdaad096.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <1dd5e14c7f042753a4d70b585de407a4e388262a.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
	<8c14a891d0a8bcea071d4e5305776a5c5cd9fd17.1460131308.git.lucien.xin@gmail.com>
	<1dd5e14c7f042753a4d70b585de407a4e388262a.1460131308.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1460131308.git.lucien.xin@gmail.com>
References: <cover.1460131308.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv3 net-next 5/6] bridge: a netlink notification
	should be sent when those attributes are changed by br_sysfs_if
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, davem@davemloft.net

Now when we change the attributes of bridge or br_port by netlink,
a relevant netlink notification will be sent, but if we change them
by ioctl or sysfs, no notification will be sent.

We should ensure that whenever those attributes change internally or from
sysfs/ioctl, that a netlink notification is sent out to listeners.

Also, NetworkManager will use this in the future to listen for out-of-band
bridge master attribute updates and incorporate them into the runtime
configuration.

This patch is used for br_sysfs_if, and we also move br_ifinfo_notify out
of store_flag.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/bridge/br_sysfs_if.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index efe415a..1e04d4d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -61,7 +61,6 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 	if (flags != p->flags) {
 		p->flags = flags;
 		br_port_flags_change(p, mask);
-		br_ifinfo_notify(RTM_NEWLINK, p);
 	}
 	return 0;
 }
@@ -253,8 +252,10 @@ static ssize_t brport_store(struct kobject *kobj,
 			spin_lock_bh(&p->br->lock);
 			ret = brport_attr->store(p, val);
 			spin_unlock_bh(&p->br->lock);
-			if (ret == 0)
+			if (!ret) {
+				br_ifinfo_notify(RTM_NEWLINK, p);
 				ret = count;
+			}
 		}
 		rtnl_unlock();
 	}
-- 
2.1.0

