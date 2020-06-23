Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iTn4YwU+nfTQfkZuPTzGncuZ8rRbBocyqzX19b4wUbA=;
 b=TMhFhm6nfkpXmHPW+lhJe1n7cOAbgmdnyRnYRF08ge1eyJ2DV9spltmSVwZ4VSK4Wc
 Jt+Vztp07cBJUvd//XpdL7CXGrBp15sBWw5RyPDAs6+VDyhZ7be6kNhjp3hxaN0BI85b
 IjevMCed9DomHmDIsfcEaVrrUegwc59D4qWVo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 23 Jun 2020 23:47:15 +0300
Message-Id: <20200623204718.1057508-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
References: <20200623204718.1057508-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: fdb_add_entry takes ndm
	as argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, anuradhak@cumulusnetworks.com

We can just pass ndm as an argument instead of its fields separately.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4877a0db16c6..ed80d9ab0fb9 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -793,11 +793,11 @@ int br_fdb_get(struct sk_buff *skb,
 
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
-			 const u8 *addr, u16 state, u16 flags, u16 vid,
-			 u8 ndm_flags)
+			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid)
 {
-	bool is_sticky = !!(ndm_flags & NTF_STICKY);
+	bool is_sticky = !!(ndm->ndm_flags & NTF_STICKY);
 	struct net_bridge_fdb_entry *fdb;
+	u16 state = ndm->ndm_state;
 	bool modified = false;
 
 	/* If the port cannot learn allow only local and static entries */
@@ -893,8 +893,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 		err = br_fdb_external_learn_add(br, p, addr, vid, true);
 	} else {
 		spin_lock_bh(&br->hash_lock);
-		err = fdb_add_entry(br, p, addr, ndm->ndm_state,
-				    nlh_flags, vid, ndm->ndm_flags);
+		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid);
 		spin_unlock_bh(&br->hash_lock);
 	}
 
-- 
2.25.4

