From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:18 +0100
Message-Id: <1297811961-19249-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 2/5] bridge: Fix IPv6 multicast snooping by
	correcting offset in MLDv2 report
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

We actually want a pointer to the grec_nsrcr and not the following
field. Otherwise we can get very high values for *nsrcs as the first two
bytes of the IPv6 multicast address are being used instead, leading to
a failing pskb_may_pull() which results in MLDv2 reports not being
parsed.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 135d929..45dcf10 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1014,7 +1014,7 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 
 		nsrcs = skb_header_pointer(skb,
 					   len + offsetof(struct mld2_grec,
-							  grec_mca),
+							  grec_nsrcs),
 					   sizeof(_nsrcs), &_nsrcs);
 		if (!nsrcs)
 			return -EINVAL;
-- 
1.7.2.3

