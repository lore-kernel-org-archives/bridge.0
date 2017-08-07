Return-Path: <geliangtang@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=N+zhXXDGY3xX/jeikbK7+hUU6rorjSIz8etj7++om0s=;
	b=lYmwP8djt/9xD5W5KuDR20JOPeKYWP1tc3W2DMkabHQPRNiiGBbQlCg8IEcvWRumY/
	E3sr3TWrqURn6OZ7uSq0VV+qfKtBNXA2FCBObO9hoFEj2A9/fJoNi/W7hDsnYEhu2M4B
	r36C4Iwpm4yLNpmrjLNs4dorz2wZ1UyDzMUoWlxTHWZRwzxrWHeeqLpoqNfjnKfTqDPH
	fb4/ihEEu1rXuDkwcj08fpDtGRqHvkeINgW6uGIc+0Rh7BmQaGjUL9yw/7DJHu4Vmxby
	M0yUZrhS3qbnfU59JBVpUcmMcyaLXd4vaw+wAvf1CAbdbJiUs8o3txGBf/tu35ImpmnZ
	akbw==
From: Geliang Tang <geliangtang@gmail.com>
Message-Id: <bcbd9b076cee1b585a756a1eadd16325dc341ca4.1502098910.git.geliangtang@gmail.com>
In-Reply-To: <5f901760510d0dc6e6e971d4136c8d2d4e0a13fd.1502103408.git.geliangtang@gmail.com>
References: <5f901760510d0dc6e6e971d4136c8d2d4e0a13fd.1502103408.git.geliangtang@gmail.com>
Subject: [Bridge] [PATCH] netfilter: ebtables: use audit_log()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 07 Aug 2017 13:45:26 -0000
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org

Use audit_log() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/bridge/netfilter/ebtables.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 9c6e619..54c7ef4 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1069,15 +1069,10 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 
 #ifdef CONFIG_AUDIT
 	if (audit_enabled) {
-		struct audit_buffer *ab;
-
-		ab = audit_log_start(current->audit_context, GFP_KERNEL,
-				     AUDIT_NETFILTER_CFG);
-		if (ab) {
-			audit_log_format(ab, "table=%s family=%u entries=%u",
-					 repl->name, AF_BRIDGE, repl->nentries);
-			audit_log_end(ab);
-		}
+		audit_log(current->audit_context, GFP_KERNEL,
+			  AUDIT_NETFILTER_CFG,
+			  "table=%s family=%u entries=%u",
+			  repl->name, AF_BRIDGE, repl->nentries);
 	}
 #endif
 	return ret;
-- 
2.9.3

