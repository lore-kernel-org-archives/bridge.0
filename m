Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6SfiZ9t8kzSwu7i4PiCxLQ7TJZV1rVza5+2e+BFzRc4=;
	b=bP8kUatJNVw+o3Vw2J+6BKUFEu51d6Mcjrfps3vrO5vzZZFjmLHgwU8pU+MPskPgCi
	N80idVEzBtBDKqoMldmDxzWDW2fk9isUlMkuB1gnPAZa7wifsl7mynkvdPby2B0fK2kE
	Po+dGWhMzj+k9Diom0u2YuoMEUm5YOzj6/zmQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 24 Nov 2018 04:34:22 +0200
Message-Id: <20181124023422.13908-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 3/3] net: bridge: export supported
	boolopts
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, andrew@lunn.ch, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Now that we have at least one bool option, we can export all of the
supported bool options via optmask when dumping them.

v2: new patch

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index b4a51a053586..4e7cd993ce94 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -247,7 +247,7 @@ void br_boolopt_multi_get(const struct net_bridge *br,
 		optval |= (br_boolopt_get(br, opt_id) << opt_id);
 
 	bm->optval = optval;
-	bm->optmask = 0;
+	bm->optmask = GENMASK((BR_BOOLOPT_MAX - 1), 0);
 }
 
 /* private bridge options, controlled by the kernel */
-- 
2.17.2

