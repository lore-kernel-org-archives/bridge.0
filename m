Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=o2I1bU88CfKQ2XLXoH5sbrxZN9tD3nHk3LZ+1JsJFVw=;
	b=mU6tZuE7soA7pUakweT20GAuHiZS9xKqsvPAxUUSZcodXFyFWUNGxEO+H6Lo/GBF6d
	KyE/SklUNwl5vV6XESykAqLx603oNc+m6V7DgPBlGMcaWTFPsXt7o9jLsP4VX7nLhMCJ
	dFAUzl+kACZY+q1gVdhVIkNEuV0Is4PWYp3QI=
From: santosh nayak <santoshprasadnayak@gmail.com>
Date: Thu,  1 Mar 2012 14:47:14 +0530
Message-Id: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: [Bridge] [PATCH 2/3] netfilter: potential null derefence.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bart.de.schuymer@pandora.be
Cc: Santosh Nayak <santoshprasadnayak@gmail.com>, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, shemminger@vyatta.com, pablo@netfilter.org

From: Santosh Nayak <santoshprasadnayak@gmail.com>

I am getting following error.
" net/bridge/netfilter/ebtables.c:269 ebt_do_table()
  error: potential null derefence 'cs'"

    i = cs[sp].n;  // If cs == Null then this will cause problem.

Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
---
 net/bridge/netfilter/ebtables.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index f3fcbd9..9c0f177 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -209,8 +209,10 @@ unsigned int ebt_do_table (unsigned int hook, struct sk_buff *skb,
 	   smp_processor_id());
 	if (private->chainstack)
 		cs = private->chainstack[smp_processor_id()];
-	else
+	else {
 		cs = NULL;
+		goto out;
+	}
 	chaininfo = private->hook_entry[hook];
 	nentries = private->hook_entry[hook]->nentries;
 	point = (struct ebt_entry *)(private->hook_entry[hook]->data);
@@ -313,6 +315,7 @@ letscontinue:
 		read_unlock_bh(&table->lock);
 		return NF_ACCEPT;
 	}
+out:
 	read_unlock_bh(&table->lock);
 	return NF_DROP;
 }
-- 
1.7.4.4

