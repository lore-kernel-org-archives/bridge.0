Return-Path: <dichtel@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri,  6 Sep 2019 11:47:02 +0200
Message-Id: <20190906094703.21300-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net v2] bridge/mdb: remove wrong use of NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>

NLM_F_MULTI must be used only when a NLMSG_DONE message is sent at the end.
In fact, NLMSG_DONE is sent only at the end of a dump.

Libraries like libnl will wait forever for NLMSG_DONE.

Fixes: 949f1e39a617 ("bridge: mdb: notify on router port add and del")
CC: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---

v2:
  add netdev and bridge ml :D
  remove Satish Ashok <sashok@cumulusnetworks.com> (its mail bounces)

 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bf6acd34234d..63f9c08625f0 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -437,7 +437,7 @@ static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 
-	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), NLM_F_MULTI);
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), 0);
 	if (!nlh)
 		return -EMSGSIZE;
 
-- 
2.21.0

