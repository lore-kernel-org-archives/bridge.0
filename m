Date: Tue, 26 Feb 2008 01:20:24 +0100
From: Fabio Checconi <fabio@gandalf.sssup.it>
Message-ID: <20080226002024.GA36411@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] bridge: use time_before() in br_fdb_cleanup()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org, fabio@gandalf.sssup.it

In br_fdb_cleanup() next_timer and this_timer are in jiffies, so they
should be compared using the time_after() macro.

Signed-off-by: Fabio Checconi <fabio@gandalf.sssup.it>
---

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index bc40377..9326c37 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -136,7 +136,7 @@ void br_fdb_cleanup(unsigned long _data)
 			this_timer = f->ageing_timer + delay;
 			if (time_before_eq(this_timer, jiffies))
 				fdb_delete(f);
-			else if (this_timer < next_timer)
+			else if (time_before(this_timer, next_timer))
 				next_timer = this_timer;
 		}
 	}
