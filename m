Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632859365;
 bh=JUbEawgwP2c3g8ePRDbJDUMS5ioHTfLNboJDo0lgTFU=;
 h=Date:From:To:Cc:Subject:From;
 b=Ux5mxk8+u9s/JuBAUe8lOapvH73pC8IDGMANlVx6y8oPhvgbvBvHWer4TncIe4O5P
 zRAc9E+j11GMc534Us0lyChK0krofQdH61wQYT+tlB96ajEswJlW5LiB//1WTO2L5f
 OMdrtwjp0duaQIPR+qZIqgAi6Qa8l2np6wXwolZtpIwLuqrEayWPXVgfeSukyRPcND
 nY0jFdRZ4a8XxMmYjRaDR7p3FjeSk8z6pkePYifJt/My7UG/ldZJhgQVzS3VbSERG8
 OBVMvKrRhltAQVgX/vRxXj76KXsBAURq7425SEWqtcbmF2tEpoF58LKK2rfiAYS5sI
 9KKrJqsNYsFsw==
Date: Tue, 28 Sep 2021 15:06:47 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <20210928200647.GA266402@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH][net-next] netfilter: ebtables: use array_size()
 helper in copy_{from, to}_user()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, linux-hardening@vger.kernel.org

Use array_size() helper instead of the open-coded version in
copy_{from,to}_user().  These sorts of multiplication factors
need to be wrapped in array_size().

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 83d1798dfbb4..32fa05ec4a6d 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1071,7 +1071,7 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 	 */
 	if (repl->num_counters &&
 	   copy_to_user(repl->counters, counterstmp,
-	   repl->num_counters * sizeof(struct ebt_counter))) {
+	   array_size(repl->num_counters, sizeof(struct ebt_counter)))) {
 		/* Silent error, can't fail, new table is already in place */
 		net_warn_ratelimited("ebtables: counters copy to user failed while replacing table\n");
 	}
@@ -1399,7 +1399,8 @@ static int do_update_counters(struct net *net, const char *name,
 		goto unlock_mutex;
 	}
 
-	if (copy_from_user(tmp, counters, num_counters * sizeof(*counters))) {
+	if (copy_from_user(tmp, counters,
+			   array_size(num_counters, sizeof(*counters)))) {
 		ret = -EFAULT;
 		goto unlock_mutex;
 	}
@@ -1532,7 +1533,7 @@ static int copy_counters_to_user(struct ebt_table *t,
 	write_unlock_bh(&t->lock);
 
 	if (copy_to_user(user, counterstmp,
-	   nentries * sizeof(struct ebt_counter)))
+	    array_size(nentries, sizeof(struct ebt_counter))))
 		ret = -EFAULT;
 	vfree(counterstmp);
 	return ret;
-- 
2.27.0

