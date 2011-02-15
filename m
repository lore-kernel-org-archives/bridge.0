From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:17 +0100
Message-Id: <1297811961-19249-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 1/5] bridge: Fix IPv6 multicast snooping by storing
	correct protocol type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>

The protocol type for IPv6 entries in the hash table for multicast
bridge snooping is falsely set to ETH_P_IP, marking it as an IPv4
address, instead of setting it to ETH_P_IPV6, which results in negative
look-ups in the hash table later.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f701a21..135d929 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -785,7 +785,7 @@ static int br_ip6_multicast_add_group(struct net_bridge *br,
 		return 0;
 
 	ipv6_addr_copy(&br_group.u.ip6, group);
-	br_group.proto = htons(ETH_P_IP);
+	br_group.proto = htons(ETH_P_IPV6);
 
 	return br_multicast_add_group(br, port, &br_group);
 }
-- 
1.7.2.3

