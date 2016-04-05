Return-Path: <lucien.xin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=lyN99P58NnZgzDd6tM4tQm6wU7x+Iv4T7hdOYs8j5lk=;
	b=WXBrWh10Qk45jUEG44vlrOKGsl6W5S5yp3U7ACqOy30myshXB1sreEbVKJAJeH422p
	df4bk+7tbzt1oDAyiJgxChjVsKxuXwxWVEAcs4j3wU7PnkN5bzynBER1deUPMqO9UjN/
	6gge61Ta2Kp/Qn9PtlTQID+aj2+mZRkCzEpcW04xJaP8sSRY7YO08+xH3Mal75WuzSZ0
	0UFW3+15khd25G7oVSXbcPlk1Yqkgq6z9g0WUIupawrdSfAFYpmgripTxqjWfbNm6UJK
	2pXIg1yfEYzJm8Lqc6h5ST9/JowXrAPo97gMSzTd/jRTl1NIqrwlkYj/BOZLgVkUa6Hl
	/4cQ==
From: Xin Long <lucien.xin@gmail.com>
Date: Tue,  5 Apr 2016 11:32:40 +0800
Message-Id: <d6f49fd173d183b78c4dd4e18e67d394438f5d7d.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <9bf0874c74438a287968ef5190599214333b52be.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1459827115.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1459827115.git.lucien.xin@gmail.com>
	<baf4788b6ac529a2132ace735fc1caf4989307da.1459827115.git.lucien.xin@gmail.com>
	<9bf0874c74438a287968ef5190599214333b52be.1459827115.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1459827115.git.lucien.xin@gmail.com>
References: <cover.1459827115.git.lucien.xin@gmail.com>
Subject: [Bridge] [PATCHv2 net-next 5/6] bridge: a netlink notification
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

