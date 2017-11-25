Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 25 Nov 2017 08:44:18 +0100
Message-Id: <20171125074418.16537-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting limit
	rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

So far any changes with ebtables will reset the state of limit rules,
leading to spikes in traffic. This is especially noticeable if changes
are done frequently, for instance via a daemon.

This patch fixes this by bailing out from (re)setting if the limit
rule was initialized before.

When sending packets every 250ms for 600s, with a
"--limit 1/sec --limit-burst 50" rule and a command like this
in the background:

$ ebtables -N VOIDCHAIN
$ while true; do ebtables -F VOIDCHAIN; sleep 30; done

The results are:

Before: ~1600 packets
After: 650 packets

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/netfilter/ebt_limit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_limit.c
index 61a9f1be1263..f74b48633feb 100644
--- a/net/bridge/netfilter/ebt_limit.c
+++ b/net/bridge/netfilter/ebt_limit.c
@@ -69,6 +69,10 @@ static int ebt_limit_mt_check(const struct xt_mtchk_param *par)
 {
 	struct ebt_limit_info *info = par->matchinfo;
 
+	/* Do not reset state on unrelated table changes */
+	if (info->prev)
+		return 0;
+
 	/* Check for overflow. */
 	if (info->burst == 0 ||
 	    user2credits(info->avg * info->burst) < user2credits(info->avg)) {
-- 
2.11.0

