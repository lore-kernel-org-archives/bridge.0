Return-Path: <bernat.ada@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=++koElXUQ/EnJ4+fSnnIw/vQ6n+cVpaaBQ8odJOHaic=;
	b=gKJtJrbudVZ4HHvsWmRriGk3pO8Nvms5BH2Xjm4AEN6hCz0OcjG9qvZMHAQmUoPklw
	73MfMQ+N7t9QqztjsZJlj5a8fPVh7O6ZHYTVqNvplcS8tEXZwhMe9h9dy05aUND0l534
	8/DhowbPMBzLP+459eUEbnaq+eBeXAGgzazQY2t5sRK0w811TIpA98HIlj1sZw2eH5qS
	73q4EPsS2zOSmOYGsucYSwhugu3unA+rVcKuwjvVQUnsk5ZqCC2STaZmC6qyW2Ar7Op2
	JvXYs7NMyzuw5F5kpP7sHWBvXuBJczai+ppJYUGCWi+FwnmHthKWoxJLpiwwPHraAb/S
	Meyw==
From: Andreea-Cristina Bernat <bernat.ada@gmail.com>
Message-ID: <20140822130609.GA19576@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] br_multicast: Replace rcu_assign_pointer() with
 RCU_INIT_POINTER()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 22 Aug 2014 13:06:19 -0000
To: stephen@networkplumber.org, davem@davemloft.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com

The use of "rcu_assign_pointer()" is NULLing out the pointer.
According to RCU_INIT_POINTER()'s block comment:
"1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
it is better to use it instead of rcu_assign_pointer() because it has a
smaller overhead.

The following Coccinelle semantic patch was used:
@@
@@

- rcu_assign_pointer
+ RCU_INIT_POINTER
  (..., NULL)

Signed-off-by: Andreea-Cristina Bernat <bernat.ada@gmail.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index abfa0b65..9b64383 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1822,7 +1822,7 @@ static void br_multicast_query_expired(struct net_bridge *br,
 	if (query->startup_sent < br->multicast_startup_query_count)
 		query->startup_sent++;
 
-	rcu_assign_pointer(querier, NULL);
+	RCU_INIT_POINTER(querier, NULL);
 	br_multicast_send_query(br, NULL, query);
 	spin_unlock(&br->multicast_lock);
 }
-- 
1.9.1

