Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:content-type:mime-version
	:content-transfer-encoding;
	bh=R9Uf3r1BgPxNbcbVRDnLtt7ag7MPlQMIOAM3Q0H6GYE=;
	b=Tom2bIR/cbGRaqDNS1OmYZ9KMpF5gViWmxoRcSQlG4lyXgH/jX3jPun8lShLUccL+7
	6OSx/tMOvQIHWNyGUhjR1FFltqlpZawclQBKzkT6ED2vQEdxmej8mImqzgNf5JNhH6Xl
	hvkWISCPYhbInMnM2wuZZVaou4b7KbQQNnvDKB5fcQGj5wWMKekNR1SIez2IKfBAXvOj
	INrYsve6XHSXO19MGxnEOKtZUOcjr7JH+l1epvv9Molnu7fWZWrbq5pFubRQF799rlsd
	R6HI9zAKy48A8vJ3Km1+6pIuMNSN2SdagmqSXQJWWhJY+cqpq7tM8C6OzTzW/iQFlOFz
	05nA==
Message-ID: <1432813374.16878.5.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 28 May 2015 04:42:54 -0700
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] bridge: fix br_multicast_query_expired() bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@web.de>, "Steinar H. Gunderson" <sesse@samfundet.no>, bridge@lists.linux-foundation.org

From: Eric Dumazet <edumazet@google.com>

br_multicast_query_expired() querier argument is a pointer to
a struct bridge_mcast_querier :

struct bridge_mcast_querier {
        struct br_ip addr;
        struct net_bridge_port __rcu    *port;
};

Intent of the code was to clear port field, not the pointer to querier.

Fixes: 2cd4143192e8 ("bridge: memorize and export selected IGMP/MLD querier port")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Linus Lüssing <linus.luessing@web.de>
Cc: Steinar H. Gunderson <sesse@samfundet.no>
---
 net/bridge/br_multicast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a3abe6ed111e..22fd0419b314 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1822,7 +1822,7 @@ static void br_multicast_query_expired(struct net_bridge *br,
 	if (query->startup_sent < br->multicast_startup_query_count)
 		query->startup_sent++;
 
-	RCU_INIT_POINTER(querier, NULL);
+	RCU_INIT_POINTER(querier->port, NULL);
 	br_multicast_send_query(br, NULL, query);
 	spin_unlock(&br->multicast_lock);
 }



