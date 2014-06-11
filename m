Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 12 Jun 2014 01:41:24 +0200
Message-Id: <1402530084-15061-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1402530084-15061-1-git-send-email-linus.luessing@web.de>
References: <1402530084-15061-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 2/2] bridge: fix compile error when compiling
	without IPv6 support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Some fields in "struct net_bridge" aren't available when compiling the
kernel without IPv6 support. Therefore adding a check/macro to skip the
complaining code sections in that case.

Introduced by 2cd4143192e8c60f66cb32c3a30c76d0470a372d
("bridge: memorize and export selected IGMP/MLD querier port")

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 876e5fb..abfa0b65 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2246,11 +2246,13 @@ bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
 		    rcu_dereference(br->ip4_querier.port) == port)
 			goto unlock;
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
 	case ETH_P_IPV6:
 		if (!timer_pending(&br->ip6_other_query.timer) ||
 		    rcu_dereference(br->ip6_querier.port) == port)
 			goto unlock;
 		break;
+#endif
 	default:
 		goto unlock;
 	}
-- 
1.7.10.4

