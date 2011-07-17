Date: Sun, 17 Jul 2011 19:56:38 +0200 (CEST)
From: Jesper Juhl <jj@chaosbits.net>
Message-ID: <alpine.LNX.2.00.1107171953500.32359@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] [PATCH][TRIVIAL] net,
 netfilter: Remove redundant goto in ebt_ulog_packet
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: Bart De Schuymer <bart.de.schuymer@pandora.be>, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, trivial@kernel.org, "David S. Miller" <davem@davemloft.net>

In net/bridge/netfilter/ebt_ulog.c:ebt_ulog_packet() the 'goto unlock'
before the 'alloc_failure' label is completely redundant. This patch
removes it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 net/bridge/netfilter/ebt_ulog.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bridge/netfilter/ebt_ulog.c b/net/bridge/netfilter/ebt_ulog.c
index 26377e9..bf2a333 100644
--- a/net/bridge/netfilter/ebt_ulog.c
+++ b/net/bridge/netfilter/ebt_ulog.c
@@ -216,7 +216,6 @@ unlock:
 nlmsg_failure:
 	pr_debug("error during NLMSG_PUT. This should "
 		 "not happen, please report to author.\n");
-	goto unlock;
 alloc_failure:
 	goto unlock;
 }
-- 
1.7.6


PS. Please CC me on replies since I'm not subscribed to all the lists 
copied on this mail.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

