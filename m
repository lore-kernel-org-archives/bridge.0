Return-Path: <luis.henriques@canonical.com>
From: Luis Henriques <luis.henriques@canonical.com>
Date: Tue, 12 May 2015 11:32:56 +0100
Message-Id: <1431426776-12744-1-git-send-email-luis.henriques@canonical.com>
Subject: [Bridge] [3.16.y-ckt stable] Patch "bridge/mdb: remove wrong use of
	NLM_F_MULTI" has been added to staging queue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Cong Wang <amwang@redhat.com>, Luis Henriques <luis.henriques@canonical.com>, bridge@lists.linux-foundation.org, kernel-team@lists.ubuntu.com, "David S. Miller" <davem@davemloft.net>

This is a note to let you know that I have just added a patch titled

    bridge/mdb: remove wrong use of NLM_F_MULTI

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt12.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

From d48583cc5f78c60061c11aafe217a41d9219bd1a Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue, 28 Apr 2015 18:33:48 +0200
Subject: bridge/mdb: remove wrong use of NLM_F_MULTI

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 net/bridge/br_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 5df05269d17a..d8b1833a363e 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -170,7 +170,7 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
 	struct br_port_msg *bpm;
 	struct nlattr *nest, *nest2;

-	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), NLM_F_MULTI);
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), 0);
 	if (!nlh)
 		return -EMSGSIZE;

