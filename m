From: Julia Lawall <julia@diku.dk>
Date: Thu, 11 Aug 2011 13:59:38 +0200
Message-Id: <1313063978-29400-1-git-send-email-julia@diku.dk>
Subject: [Bridge] [PATCH] net/bridge/netfilter/ebtables.c: use available
	error handling code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Free the locally allocated table and newinfo as done in adjacent error
handling code.

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 net/bridge/netfilter/ebtables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 2b5ca1a..5864cc4 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1198,7 +1198,8 @@ ebt_register_table(struct net *net, const struct ebt_table *input_table)
 
 	if (table->check && table->check(newinfo, table->valid_hooks)) {
 		BUGPRINT("The table doesn't like its own initial data, lol\n");
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto free_chainstack;
 	}
 
 	table->private = newinfo;

