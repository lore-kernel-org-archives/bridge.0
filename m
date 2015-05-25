Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NXWnB7wR8EQJlb42+sfhtrTv2B9cRnsCJNbQAeNnN20=;
	b=TYPKkzgiKdoxTQ7PkX0gIeoZC05sgzXQmftEgSXeElrtsqyzHXUZtrKwz3JS++8sL7
	+1XQxnaAbGMuFZiu5w9+gbNGazpLQaXjKBUPEt2xCE8z/wAeg2DV3PqHOKA+PzCAOozg
	8VQ7R1fqJR5g39J7Hy8mmivXU9BSThpbtvcbA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 25 May 2015 06:39:31 -0700
Message-Id: <1432561171-4965-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2] bridge: skip fdb add if the port
	shouldn't learn
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, wkok@cumulusnetworks.com

From: Wilson Kok <wkok@cumulusnetworks.com>

Check in fdb_add_entry() if the source port should learn, similar
check is used in br_fdb_update.
Note that new fdb entries which are added manually or
as local ones are still permitted.
This patch has been tested by running traffic via a bridge port and
switching the port's state, also by manually adding/removing entries
from the bridge's fdb.

Signed-off-by: Wilson Kok <wkok@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: return an error instead of silently failing.

 net/bridge/br_fdb.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e0670d7054f9..7896cf143045 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -736,6 +736,12 @@ static int fdb_add_entry(struct net_bridge_port *source, const __u8 *addr,
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
 
+	/* If the port cannot learn allow only local and static entries */
+	if (!(state & NUD_PERMANENT) && !(state & NUD_NOARP) &&
+	    !(source->state == BR_STATE_LEARNING ||
+	      source->state == BR_STATE_FORWARDING))
+		return -EPERM;
+
 	fdb = fdb_find(head, addr, vid);
 	if (fdb == NULL) {
 		if (!(flags & NLM_F_CREATE))
-- 
1.7.10.4

