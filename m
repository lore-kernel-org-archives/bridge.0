From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:19 +0100
Message-Id: <1297811961-19249-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 3/5] bridge: Add missing ntohs()s for MLDv2 report
	parsing
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

The nsrcs number is 2 Byte wide, therefore we need to call ntohs()
before using it.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 45dcf10..e8fdaab 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1021,11 +1021,12 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 
 		if (!pskb_may_pull(skb,
 				   len + sizeof(*grec) +
-				   sizeof(struct in6_addr) * (*nsrcs)))
+				   sizeof(struct in6_addr) * ntohs(*nsrcs)))
 			return -EINVAL;
 
 		grec = (struct mld2_grec *)(skb->data + len);
-		len += sizeof(*grec) + sizeof(struct in6_addr) * (*nsrcs);
+		len += sizeof(*grec) +
+		       sizeof(struct in6_addr) * ntohs(*nsrcs);
 
 		/* We treat these as MLDv1 reports for now. */
 		switch (grec->grec_type) {
-- 
1.7.2.3

