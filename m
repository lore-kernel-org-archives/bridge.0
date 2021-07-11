Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pLzFV9bVvdr4KYBirs5X2mj4DUo8QQJaXp8K6ahEWRc=;
 b=Y2HnxZE9uISH43M340AOZ5mIqJD9tWGUhE68UhwL5YsyErc23G25PBlgG2ZDFdrqO+
 zQvXelHcRrwzaMKgoRQTYrOe/Zbgc5xWWOtjitlCxiVXQTV9mR9PhLvkpznLLte/hZ7t
 aGeMcAUvRjXnP552wFKcFI4hkyoR/0AicsmPs4nOLZ9mSwlI8OPWp+AQroaSDaeTsr9c
 QmzPBqHQYahnIyxUPKKtM8P1EnhXJEeR5smsWWbJvKBaPRn2Yd+3zowbFIgc47bwfPsa
 8DT8b94QLKevyQvHkav+/nUKuiSUzdYlv7mheI2AR1VpagAnnBmzGSvDp127ZRq4oHrM
 +d6g==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun, 11 Jul 2021 12:56:28 +0300
Message-Id: <20210711095629.2986949-2-razor@blackwall.org>
In-Reply-To: <20210711095629.2986949-1-razor@blackwall.org>
References: <20210711095629.2986949-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 1/2] net: bridge: multicast: fix PIM hello
	router port marking race
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, stable@vger.kernel.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When a PIM hello packet is received on a bridge port with multicast
snooping enabled, we mark it as a router port automatically, that
includes adding that port the router port list. The multicast lock
protects that list, but it is not acquired in the PIM message case
leading to a race condition, we need to take it to fix the race.

Cc: stable@vger.kernel.org
Fixes: 91b02d3d133b ("bridge: mcast: add router port on PIM hello message")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 53c3a9d80d9c..3bbbc6d7b7c3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3264,7 +3264,9 @@ static void br_multicast_pim(struct net_bridge *br,
 	    pim_hdr_type(pimhdr) != PIM_TYPE_HELLO)
 		return;
 
+	spin_lock(&br->multicast_lock);
 	br_ip4_multicast_mark_router(br, port);
+	spin_unlock(&br->multicast_lock);
 }
 
 static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
-- 
2.31.1

