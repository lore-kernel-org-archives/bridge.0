Return-Path: <kamal@canonical.com>
From: Kamal Mostafa <kamal@canonical.com>
Date: Wed, 17 Jun 2015 15:22:01 -0700
Message-Id: <1434579851-1719-17-git-send-email-kamal@canonical.com>
In-Reply-To: <1434579851-1719-1-git-send-email-kamal@canonical.com>
References: <1434579851-1719-1-git-send-email-kamal@canonical.com>
Subject: [Bridge] [PATCH 3.19.y-ckt 016/146] bridge/mdb: remove wrong use of
	NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Cong Wang <amwang@redhat.com>, Kamal Mostafa <kamal@canonical.com>, bridge@lists.linux-foundation.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>

3.19.8-ckt2 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit 821996795973fd52703c35811a03db9fec1ac141 upstream.

NLM_F_MULTI must be used only when a NLMSG_DONE message is sent. In fact,
it is sent only at the end of a dump.

Libraries like libnl will wait forever for NLMSG_DONE.

Fixes: 37a393bc4932 ("bridge: notify mdb changes via netlink")
CC: Cong Wang <amwang@redhat.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 5df0526..d8b1833 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -170,7 +170,7 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
 	struct br_port_msg *bpm;
 	struct nlattr *nest, *nest2;
 
-	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), NLM_F_MULTI);
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), 0);
 	if (!nlh)
 		return -EMSGSIZE;
 
-- 
1.9.1

