Return-Path: <root@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue, 28 Apr 2015 18:33:48 +0200
Message-Id: <1430238831-29966-2-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
Subject: [Bridge] [PATCH net 1/3] bridge/mdb: remove wrong use of NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, bridge@lists.linux-foundation.org, dmitry.tarnyaginuug.ch@6wind.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>, davem@davemloft.net

NLM_F_MULTI must be used only when a NLMSG_DONE message is sent. In fact,
it is sent only at the end of a dump.

Libraries like libnl will wait forever for NLMSG_DONE.

Fixes: 37a393bc4932 ("bridge: notify mdb changes via netlink")
CC: Cong Wang <amwang@redhat.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 409608960899..e29ad70b3000 100644
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
2.2.2

