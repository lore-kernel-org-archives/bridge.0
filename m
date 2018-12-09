Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1544336062; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:in-reply-to:
	references; bh=oNHoiu42/t/ww87E46wJP16iwRyR74KseDxu5fVbDXM=;
	b=Hk0RX1IZ4A4xusHEMxXqrBC1ik1wUXrq5iAO73QOUgGmSK42RLv8EJlKW0rW1iZYPb05Iw
	xuopuq4ty3Hf3EzYLYhnZEErlIsFfT1XN05kQSN9Qul0q44SucWKNkiYvGvFSRaYKnyhGQ
	jETIYZnMMp8p4bgJ8v0NNC8u4C0V1mDIflyEmcNrgFqIQo17/WuvAcV6+T6BxrwtDU02HL
	JV56tJmf4TPTPbZll5qIqbGxTDUYGDHA5fkEtVxea/WpXAqBl3xgW5C6AGH9eg4UaN+KAL
	dbFCV8qlff9FuNWy6DX07M2vQI6PtLuQskrdu7oeoJ1nNKGfyhGeHeVPTlqozw==
Date: Sun,  9 Dec 2018 07:14:05 +0100
Message-Id: <20181209061405.15112-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2] netfilter: ebtables: avoid resetting
	limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

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

This also aligns the behavior to "xtables-nft-multi ebtables" which uses
nft_limit instead of ebt_limit. In tests nft_limit did not suffer from
this issue and rate limited to 650 just fine.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Changelog v2:

- Adjusted commit message (adjusted title, added test results with
  nft_limit for comparison)
- Excluded rate limiting variables from zeroing when passed to userspace
  by increasing .usersize. This became necessary with 4.11 /
  commit ec2318904965 ("xtables: extend matches and targets with .usersize")
- Retested with 4.20-rc4 and current net-next/master (83af01ba1c2d)

v1 was:

"[net-next] bridge: ebtables: Avoid resetting limit rule state"
-> https://lore.kernel.org/patchwork/patch/854802/
---
 net/bridge/netfilter/ebt_limit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_limit.c
index 165b9d678cf1..2cf9861c3bce 100644
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
@@ -105,7 +109,7 @@ static struct xt_match ebt_limit_mt_reg __read_mostly = {
 	.match		= ebt_limit_mt,
 	.checkentry	= ebt_limit_mt_check,
 	.matchsize	= sizeof(struct ebt_limit_info),
-	.usersize	= offsetof(struct ebt_limit_info, prev),
+	.usersize	= sizeof(struct ebt_limit_info),
 #ifdef CONFIG_COMPAT
 	.compatsize	= sizeof(struct ebt_compat_limit_info),
 #endif
-- 
2.11.0

