Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=15O42YcTjpmDhDPvSQqOizS3ABZbH38ENN7jhBTnn4Q=;
 b=IaBb4jkSWIxICG3VJbssykTGz95G7zDiifz0RBjL7GZ0tpIylTl8B5PNRmMO5lYyW9
 u4I8tQzRMFBFmViPiEgTzX9uNrJ0bvNsnj9b6BxHtlJnbk6D/3daKgMX+7/zPJ9688lV
 UXkLUnEF2gFdok5cQjofcP4nnSwFnnoI+P+WEUmEjDG2/byd8dBjrlFJjcKhvr32ZbY5
 KB3pT6TLB8YBzk/xlcdHO/I0xOZtmpYImmemgxjl48DHu5Sk7WeWYbpTz/1IQiKiimzG
 mSROXfhet++r3kzANHZrmtF51DKjmziKgj1dg8TOPZeE8u7wm/G65hAMbS7VVbMX3uGv
 E3bA==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:27 +0200
Message-Id: <20220411133837.318876-4-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 03/13] net: bridge: minor refactor of
	br_setlink() for readability
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

The br_setlink() function extracts the struct net_bridge pointer a bit
sloppy.  It's easy to interpret the code wrong.  This patch attempts to
clear things up a bit.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 net/bridge/br_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 7fca8ff13ec7..8f4297287b32 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1040,6 +1040,8 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 		return 0;
 
 	p = br_port_get_rtnl(dev);
+	if (p)
+		br = p->br;
 	/* We want to accept dev as bridge itself if the AF_SPEC
 	 * is set to see if someone is setting vlan info on the bridge
 	 */
@@ -1055,17 +1057,17 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 			if (err)
 				return err;
 
-			spin_lock_bh(&p->br->lock);
+			spin_lock_bh(&br->lock);
 			err = br_setport(p, tb, extack);
-			spin_unlock_bh(&p->br->lock);
+			spin_unlock_bh(&br->lock);
 		} else {
 			/* Binary compatibility with old RSTP */
 			if (nla_len(protinfo) < sizeof(u8))
 				return -EINVAL;
 
-			spin_lock_bh(&p->br->lock);
+			spin_lock_bh(&br->lock);
 			err = br_set_port_state(p, nla_get_u8(protinfo));
-			spin_unlock_bh(&p->br->lock);
+			spin_unlock_bh(&br->lock);
 		}
 		if (err)
 			goto out;
-- 
2.25.1

