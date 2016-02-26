Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/YxZi8vT9+YzE5L1WOrVT9X5jmzYBwUaHOI8iT6QCCc=;
	b=DJo2Erx15qeYuku2hhs4EH8gERNkcK86LFsJmHUtzTW/Ich0NIvk967qJMLWZGWYdA
	NqKeDNVqrID5CM3J5AX0x5nrqIVdY4SVRMkrfxJaIibawrQkW2dPV58mvbdOl2JQSPdZ
	i36+VLS1C9wa6Y5eEERB/OBN7agyAWh4ljYZc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 19:59:25 +0100
Message-Id: <1456513166-20159-3-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/3] bridge: mcast: do nothing if port's
	multicast_router is set to the same val
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

This is needed for the upcoming temporary port router. There's no point
to go through the logic if the value is the same.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 015c47dd1364..496f808f9aa1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1853,7 +1853,10 @@ int br_multicast_set_port_router(struct net_bridge_port *p, unsigned long val)
 	int err = -EINVAL;
 
 	spin_lock(&br->multicast_lock);
-
+	if (p->multicast_router == val) {
+		err = 0;
+		goto unlock;
+	}
 	switch (val) {
 	case MDB_RTR_TYPE_DISABLED:
 		__del_port_router(p);
-- 
2.4.3

