Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kAZh9fqmHigo6xRDqgFos5JwAKHqDbj5bkhVwftM1Ys=;
 b=KrAgOqV1v2KxOuW7pkfy/lKylkCadAUoPsHrJ7bpEFwfLuP2zvalxzqIFo4jfEfjc5
 iBdWZ+bk8TJhhjQqzl5lUgOwloB6XEqqxkJ6FVzvCixT1SLpn/CO0t0IBSYWT6FOhaMv
 /gKEplLZbjCdiUi2TusREYcGOkzdYQts62fGIPetDmKc0djiKFRSj95jwnUZLEMabZHO
 OdzuSOb4svHB018Ff/nQjlhq/Cc/xFw1b1p8qF8OJO6aTJY9z4faJRPBsrre/Hb8W2vI
 jVFmX8D4M7htPSCERrDiepcLTAYmSgdiLjV4EcOeRyfyTQ1q6GIZ3IDQGFsLZ1KbE3Ra
 xmyw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 15 Oct 2021 12:05:46 +0300
Message-Id: <20211015090546.19967-1-razor@blackwall.org>
In-Reply-To: <357fad9e-581e-7b71-9b32-aac77d5d13c1@nvidia.com>
References: <357fad9e-581e-7b71-9b32-aac77d5d13c1@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: mcast: use
	multicast_membership_interval for IGMPv3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When I added IGMPv3 support I decided to follow the RFC for computing
the GMI dynamically:
" 8.4. Group Membership Interval

   The Group Membership Interval is the amount of time that must pass
   before a multicast router decides there are no more members of a
   group or a particular source on a network.

   This value MUST be ((the Robustness Variable) times (the Query
   Interval)) plus (one Query Response Interval)."

But that actually is inconsistent with how the bridge used to compute it
for IGMPv2, where it was user-configurable that has a correct default value
but it is up to user-space to maintain it. This would make it consistent
with the other timer values which are also maintained correct by the user
instead of being dynamically computed. It also changes back to the previous
user-expected GMI behaviour for IGMPv3 queries which were supported before
IGMPv3 was added. Note that to properly compute it dynamically we would
need to add support for "Robustness Variable" which is currently missing.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Fixes: 0436862e417e ("net: bridge: mcast: support for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_private.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b4cef3a97f12..5c68052466a0 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1125,9 +1125,7 @@ static inline unsigned long br_multicast_lmqt(const struct net_bridge_mcast *brm
 
 static inline unsigned long br_multicast_gmi(const struct net_bridge_mcast *brmctx)
 {
-	/* use the RFC default of 2 for QRV */
-	return 2 * brmctx->multicast_query_interval +
-	       brmctx->multicast_query_response_interval;
+	return brmctx->multicast_membership_interval;
 }
 
 static inline bool
-- 
2.31.1

