Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JRmAVX0LKzbwaoPbTw2s+8QG+vaakhy1/lXDson76Zo=;
	b=WVnfw1qw2kzwmwk+Bp9IpqrORLjhdpN8OhiSzo8Xv72VKXWy2tLbyIGD3mCh1W0Px2
	qYwa3YUXQc3Ju0aOvn01M+LsQvckfc1hSkoa7sLG3s7EqFxUMPiluPy8qavqc3SlcKLk
	fbsPVon9M7sQ8Uk8iw0gKZERg44ug1XALBwJU=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri,  1 Nov 2019 14:46:39 +0200
Message-Id: <20191101124639.32140-4-nikolay@cumulusnetworks.com>
In-Reply-To: <20191101124639.32140-1-nikolay@cumulusnetworks.com>
References: <20191101124639.32140-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 3/3] net: bridge: fdb: restore
	unlikely() when taking over externally added entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Taking over hw-learned entries is not a likely scenario so restore the
unlikely() use for the case of SW taking over externally learned
entries.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 7500c84fc675..284b3662d234 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -587,8 +587,10 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
-				test_and_clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
-						   &fdb->flags);
+				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+						      &fdb->flags)))
+					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+						  &fdb->flags);
 			}
 			if (now != fdb->updated)
 				fdb->updated = now;
-- 
2.21.0

