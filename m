Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 15:51:13 +0200
Message-Id: <20200527135124.1082844-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] bridge: multicast: work around clang bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>

Clang-10 and clang-11 run into a corner case of the register
allocator on 32-bit ARM, leading to excessive stack usage from
register spilling:

net/bridge/br_multicast.c:2422:6: error: stack frame size of 1472 bytes in function 'br_multicast_get_stats' [-Werror,-Wframe-larger-than=]

Work around this by marking one of the internal functions as
noinline_for_stack.

Link: https://bugs.llvm.org/show_bug.cgi?id=45802#c9
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bridge/br_multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ad12fe3fca8c..83490bf73a13 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2413,7 +2413,8 @@ void br_multicast_uninit_stats(struct net_bridge *br)
 	free_percpu(br->mcast_stats);
 }
 
-static void mcast_stats_add_dir(u64 *dst, u64 *src)
+/* noinline for https://bugs.llvm.org/show_bug.cgi?id=45802#c9 */
+static noinline_for_stack void mcast_stats_add_dir(u64 *dst, u64 *src)
 {
 	dst[BR_MCAST_DIR_RX] += src[BR_MCAST_DIR_RX];
 	dst[BR_MCAST_DIR_TX] += src[BR_MCAST_DIR_TX];
-- 
2.26.2

