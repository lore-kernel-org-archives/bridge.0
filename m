Date: Mon, 10 Jan 2005 14:53:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Message-Id: <20050110145353.12400870.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: fix gcc format warning
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: shemminger <shemminger@osdl.org>


Linux 2.6.10-bk13

Fix gcc format warning:
net/bridge/netfilter/ebt_ulog.c:138: warning: int format, different type arg (arg 2)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 net/bridge/netfilter/ebt_ulog.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./net/bridge/netfilter/ebt_ulog.c~brnetf_types ./net/bridge/netfilter/ebt_ulog.c
--- ./net/bridge/netfilter/ebt_ulog.c~brnetf_types	2005-01-10 10:38:40.531343592 -0800
+++ ./net/bridge/netfilter/ebt_ulog.c	2005-01-10 12:31:10.076256800 -0800
@@ -135,7 +135,7 @@ static void ebt_ulog(const struct sk_buf
 
 	size = NLMSG_SPACE(sizeof(*pm) + copy_len);
 	if (size > nlbufsiz) {
-		PRINTR("ebt_ulog: Size %d needed, but nlbufsiz=%d\n",
+		PRINTR("ebt_ulog: Size %zu needed, but nlbufsiz=%u\n",
 		       size, nlbufsiz);
 		return;
 	}

---
