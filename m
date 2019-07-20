Return-Path: <wang6495@umn.edu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=K+9BHnE6RbUTOFhStcy8LrNMOZBD7Jm9/NExEpRtGTs=;
	b=VsAKaUY5H8pRtOL9M2UvY9iZeZDLaYKRfFF0N8a+Ayc6PHMdqmm/9LShwhaw19OENE
	pxtbM5Fx5DUA1WzHR5dxLHVeAKGy9wKZXYgRBawbE8gT60iqJsAjGCOPSjBdSDDgFxvu
	b7Wr0bcGk88XngcmuNvn83WoG1nUCpjjQaU9cJI+MIRtg86w26V7jxttyupJtMxWd/HB
	ZNw/Rn624IVLdtvABLf7EWYHrhdx7u+JpOfG34xrmKCHBbNWQawqc/DwOrZRcYdi1DQ/
	3tvSHgoFfGyPCW6CymV+IYbxh4sDtLrW7kVl2JQZ6QC8HV0+Ih1vS9KCl1OiZvVwOR6c
	aJ1Q==
From: Wenwen Wang <wang6495@umn.edu>
Date: Sat, 20 Jul 2019 07:22:45 -0500
Message-Id: <1563625366-3602-1-git-send-email-wang6495@umn.edu>
Subject: [Bridge] [PATCH] netfilter: ebtables: compat: fix a memory leak bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Florian Westphal <fw@strlen.de>, open list <linux-kernel@vger.kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "open list:NETFILTER" <coreteam@netfilter.org>, "open list:NETFILTER" <netfilter-devel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

From: Wenwen Wang <wenwen@cs.uga.edu>

In compat_do_replace(), a temporary buffer is allocated through vmalloc()
to hold entries copied from the user space. The buffer address is firstly
saved to 'newinfo->entries', and later on assigned to 'entries_tmp'. Then
the entries in this temporary buffer is copied to the internal kernel
structure through compat_copy_entries(). If this copy process fails,
compat_do_replace() should be terminated. However, the allocated temporary
buffer is not freed on this path, leading to a memory leak.

To fix the bug, free the buffer before returning from compat_do_replace().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 963dfdc..fd84b48e 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2261,8 +2261,10 @@ static int compat_do_replace(struct net *net, void __user *user,
 	state.buf_kern_len = size64;
 
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(ret < 0)) {
+		vfree(entries_tmp);
 		goto out_unlock;
+	}
 
 	vfree(entries_tmp);
 	tmp.entries_size = size64;
-- 
2.7.4

