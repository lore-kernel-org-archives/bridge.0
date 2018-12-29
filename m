Return-Path: <3MtQmXAgKBl0NC5F99G6BJJBG9.7JH6MD8B9GDNON.GDIPS-AJPI85ODJI.JMB@flex--shakeelb.bounces.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:message-id:mime-version:subject:from:to:cc;
	bh=8Befy3R1F0eWwTQ9Ik5Xd4dXNM48kHZxmA2Si2BNh00=;
	b=mlJ42Wmk0g/Zww+wc3HKcPht3SrNzqwN2DG+h/dsO09sj927qHH3eGiBy5Afo0HNo+
	bctv4+9wDrgDHLfhKzOle+rQcSOTFC0RASt9EBC/uogrRZFx/sO0wPjCbVOu6ptOVQA1
	f2V8aAOHMjsUORgJNd2eNlQMHwPFkzur8+Jsa6NWt658Ye45a196pTY9ereEh52XKGpm
	O8uQ02a5qG23Qsspm3RQ9yfkWrCRbXIknMpk7rXJZDffpoUn7ReZGDuBFkJHz33bzVwA
	ihk4ppGr4T4pvA8ZIR3hRYGfRMAhkA8qXYEdyV8hNUUe0H0f0jYRaO1Zil0L63knZ6JP
	a6qg==
Date: Fri, 28 Dec 2018 17:55:24 -0800
Message-Id: <20181229015524.222741-1-shakeelb@google.com>
Mime-Version: 1.0
From: Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] [PATCH] netfilter: account ebt_table_info to kmemcg
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com, Shakeel Butt <shakeelb@google.com>

The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
memory is already accounted to kmemcg. Do the same for ebtables. The
syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
whole system from a restricted memcg, a potential DoS.

Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/bridge/netfilter/ebtables.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 491828713e0b..5e55cef0cec3 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
 	tmp.name[sizeof(tmp.name) - 1] = 0;
 
 	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
-	newinfo = vmalloc(sizeof(*newinfo) + countersize);
+	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
+			    PAGE_KERNEL);
 	if (!newinfo)
 		return -ENOMEM;
 
 	if (countersize)
 		memset(newinfo->counters, 0, countersize);
 
-	newinfo->entries = vmalloc(tmp.entries_size);
+	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
+				     PAGE_KERNEL);
 	if (!newinfo->entries) {
 		ret = -ENOMEM;
 		goto free_newinfo;
-- 
2.20.1.415.g653613c723-goog

