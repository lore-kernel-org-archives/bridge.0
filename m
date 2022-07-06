Return-Path: <sashal@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6243641869
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A6F841877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657121621;
 bh=mvb+Pnz5R7gA+DpzUV27ng0t5QwEHDHEUMFotMgG9EY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ffcNga2hgEe0nwRVziR8O+vyRrtTiWAGy3S7EJ+0iVowNgKFSLlxYRnt9uyIKmuRC
 A0tMt5wPVLK/RS4unGMnsl2i7yr92UQYrRzaUu3X6YTjVvHgajltnyuAw8Cktt8lts
 3NNTKpMmc3nC1K4Ek7fLTMy7m2qlWY5PcZQudiQ4kpiUNMewDcFwtHxGnV9/B8k9S8
 vA5rWEXpwPlqQ/rcZderqGJH1L1DLZPW8XiSyOmZqIZurUMO+ePLGTwWwmP7gqr2mK
 yQCnG4oDUAZg1zLjkG9YTVYHyEIaMqihLWLFRY9hid1D6itM6gMkUvlKwRzDshcqO6
 +XLPtN2S+tHtg==
From: Sasha Levin <sashal@kernel.org>
Date: Wed,  6 Jul 2022 11:33:30 -0400
Message-Id: <20220706153335.1598699-3-sashal@kernel.org>
In-Reply-To: <20220706153335.1598699-1-sashal@kernel.org>
References: <20220706153335.1598699-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH AUTOSEL 4.19 3/8] netfilter: br_netfilter: do not
	skip all hooks with 0 priority
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, kadlec@netfilter.org, edumazet@google.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, Radim Hrazdil <rhrazdil@redhat.com>, pabeni@redhat.com, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c2577862eeb0be94f151f2f1fff662b028061b00 ]

When br_netfilter module is loaded, skbs may be diverted to the
ipv4/ipv6 hooks, just like as if we were routing.

Unfortunately, bridge filter hooks with priority 0 may be skipped
in this case.

Example:
1. an nftables bridge ruleset is loaded, with a prerouting
   hook that has priority 0.
2. interface is added to the bridge.
3. no tcp packet is ever seen by the bridge prerouting hook.
4. flush the ruleset
5. load the bridge ruleset again.
6. tcp packets are processed as expected.

After 1) the only registered hook is the bridge prerouting hook, but its
not called yet because the bridge hasn't been brought up yet.

After 2), hook order is:
   0 br_nf_pre_routing // br_netfilter internal hook
   0 chain bridge f prerouting // nftables bridge ruleset

The packet is diverted to br_nf_pre_routing.
If call-iptables is off, the nftables bridge ruleset is called as expected.

But if its enabled, br_nf_hook_thresh() will skip it because it assumes
that all 0-priority hooks had been called previously in bridge context.

To avoid this, check for the br_nf_pre_routing hook itself, we need to
resume directly after it, even if this hook has a priority of 0.

Unfortunately, this still results in different packet flow.
With this fix, the eval order after in 3) is:
1. br_nf_pre_routing
2. ip(6)tables (if enabled)
3. nftables bridge

but after 5 its the much saner:
1. nftables bridge
2. br_nf_pre_routing
3. ip(6)tables (if enabled)

Unfortunately I don't see a solution here:
It would be possible to move br_nf_pre_routing to a higher priority
so that it will be called later in the pipeline, but this also impacts
ebtables evaluation order, and would still result in this very ordering
problem for all nftables-bridge hooks with the same priority as the
br_nf_pre_routing one.

Searching back through the git history I don't think this has
ever behaved in any other way, hence, no fixes-tag.

Reported-by: Radim Hrazdil <rhrazdil@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_netfilter_hooks.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 4b9d1d6bbf6f..55c7cdf5e7b8 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1001,9 +1001,24 @@ int br_nf_hook_thresh(unsigned int hook, struct net *net,
 		return okfn(net, sk, skb);
 
 	ops = nf_hook_entries_get_hook_ops(e);
-	for (i = 0; i < e->num_hook_entries &&
-	      ops[i]->priority <= NF_BR_PRI_BRNF; i++)
-		;
+	for (i = 0; i < e->num_hook_entries; i++) {
+		/* These hooks have already been called */
+		if (ops[i]->priority < NF_BR_PRI_BRNF)
+			continue;
+
+		/* These hooks have not been called yet, run them. */
+		if (ops[i]->priority > NF_BR_PRI_BRNF)
+			break;
+
+		/* take a closer look at NF_BR_PRI_BRNF. */
+		if (ops[i]->hook == br_nf_pre_routing) {
+			/* This hook diverted the skb to this function,
+			 * hooks after this have not been run yet.
+			 */
+			i++;
+			break;
+		}
+	}
 
 	nf_hook_state_init(&state, hook, NFPROTO_BRIDGE, indev, outdev,
 			   sk, net, okfn);
-- 
2.35.1

