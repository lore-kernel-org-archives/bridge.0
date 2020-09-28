Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6VVT8An+NVIG2uzRBeTIUimQFMuHQujGalFijHXJVJI=;
 b=XhxW9IkpduseHfGezLNC9OdGxB2wtvIOpXqB3BDtu6tTq9Mm4FSLxbmnCPAiejqzMy
 lLX5xwhrs8gWvpa5OyzpjP6uZYDLzVIOU4TL07RRpNUAELUUd8PS2twg43gLPUp3BPQD
 7m9PLhMfF9D87ue2POf2SWtB8NjmNEp/qwxs/RWEnYYFWLu2RElcCLRQS2cfluakSu+M
 mNiVE39M/ItzKQxu2zEpZY9HrgzS7khanvvW1O5vP8iSG+DT+L2yOyCZb57PmkPHvy+A
 HXGbGKaatNVxbed9XwCQjOewVAV19W+0NmkgLSZQGztFMpRv3BlvlUfp8dQ0oqCo+vBL
 U6QA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 28 Sep 2020 18:30:02 +0300
Message-Id: <20200928153002.1697183-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: fdb: don't flush ext_learn entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, idosch@nvidia.com, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When a user-space software manages fdb entries externally it should
set the ext_learn flag which marks the fdb entry as externally managed
and avoids expiring it (they're treated as static fdbs). Unfortunately
on events where fdb entries are flushed (STP down, netlink fdb flush
etc) these fdbs are also deleted automatically by the bridge. That in turn
causes trouble for the managing user-space software (e.g. in MLAG setups
we lose remote fdb entries on port flaps).
These entries are completely externally managed so we should avoid
automatically deleting them, the only exception are offloaded entries
(i.e. BR_FDB_ADDED_BY_EXT_LEARN + BR_FDB_OFFLOADED). They are flushed as
before.

Fixes: eb100e0e24a2 ("net: bridge: allow to add externally learned entries from user-space")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_fdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9db504baa094..32ac8343b0ba 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -413,6 +413,8 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 
 		if (!do_all)
 			if (test_bit(BR_FDB_STATIC, &f->flags) ||
+			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
+			     !test_bit(BR_FDB_OFFLOADED, &f->flags)) ||
 			    (vid && f->key.vlan_id != vid))
 				continue;
 
-- 
2.26.2

