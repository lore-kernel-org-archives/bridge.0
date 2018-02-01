Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: Fix uninitialized error in
	br_fdb_sync_static()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 01 Feb 2018 10:25:32 -0000
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "David S . Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

With gcc-4.1.2.:

    net/bridge/br_fdb.c: In function ‘br_fdb_sync_static’:
    net/bridge/br_fdb.c:996: warning: ‘err’ may be used uninitialized in this function

Indeed, if the list is empty, err will be uninitialized, and will be
propagated up as the function return value.

Fix this by preinitializing err to zero.

Fixes: eb7935830d00b9e0 ("net: bridge: use rhashtable for fdbs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/bridge/br_fdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index dc87fbc9a23b04e6..d9e69e4514beb20d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -993,7 +993,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)
 {
 	struct net_bridge_fdb_entry *f, *tmp;
-	int err;
+	int err = 0;
 
 	ASSERT_RTNL();
 
-- 
2.7.4

