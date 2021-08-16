Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VeAxzN5DXkah2WW1j0/kmj2z9yubcpseK6WCofF+3Js=;
 b=g6mPVuDPBag/AAVcsHK14Ce7QpDJMjTOWoV7FJ+tziCL01WHrAJoG64Amw0YaNQKjq
 dXKY/8LiqwzOTfi4lof4HfzWpf+SDvmTbNMrVH12wWrpUtNhM/k6r0Am3l7ne20e3wmF
 m3sFXIf6dOenFk61y4rjDslXOUMbv3Abjn7Y7NUNXoztX9F4UzW52vnxfEMGLG1ZbqAP
 Zd9JNo7V7BO+lf8JMYfaxaF6zSuVH3IXr3KZJ3xwyrpXuXhKeNuC8OWRqxRx55FSyd30
 WW3+/4aR8J3FozZYFYCSnWZ+X7lEpnsAJvcf7wb2ZnHTXQ9tp0Z+H2AwDQQ0P8qlaEmj
 enGw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 13:11:33 +0300
Message-Id: <20210816101134.577413-3-razor@blackwall.org>
In-Reply-To: <20210816101134.577413-1-razor@blackwall.org>
References: <20210816101134.577413-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/3] net: bridge: mcast: drop sizeof for
	nest attribute's zero size
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Dan Carpenter <dan.carpenter@oracle.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

This was a dumb error I made instead of writing nla_total_size(0)
for a nest attribute, I wrote nla_total_size(sizeof(0)).

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 606433fe3e11 ("net: bridge: mcast: dump ipv4 querier state")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9bdf12635871..76992ddac7e0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2928,7 +2928,7 @@ __br_multicast_get_querier_port(struct net_bridge *br,
 
 size_t br_multicast_querier_state_size(void)
 {
-	return nla_total_size(sizeof(0)) +      /* nest attribute */
+	return nla_total_size(0) +		/* nest attribute */
 	       nla_total_size(sizeof(__be32)) + /* BRIDGE_QUERIER_IP_ADDRESS */
 	       nla_total_size(sizeof(int)) +    /* BRIDGE_QUERIER_IP_PORT */
 	       nla_total_size_64bit(sizeof(u64)); /* BRIDGE_QUERIER_IP_OTHER_TIMER */
-- 
2.31.1

