Return-Path: <ivecera@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635436727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ZAZTdtyaSOOs5rc8T6wOKjWpg0v6cCvD+QvTGbgJzM=;
 b=RwqCT3vi4JsC12m8UiZduV4+6NEMah7/6sZprhnnz0lSmuM/PjmuPyg1TOHixuAsqNlhu5
 o6x8aWqc5v6jngayWVC569DgEwtt0OL6hI7uddnDgSNanJSKEL1qXORR3tIflXHJifk93H
 1IJ41uR300iBe8hlxq451BSNTEh0anE=
From: Ivan Vecera <ivecera@redhat.com>
Date: Thu, 28 Oct 2021 17:58:35 +0200
Message-Id: <20211028155835.2134753-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net v2] net: bridge: fix uninitialized variables
	when BRIDGE_CFM is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Function br_get_link_af_size_filtered() calls br_cfm_{,peer}_mep_count()
that return a count. When BRIDGE_CFM is not enabled these functions
simply return -EOPNOTSUPP but do not modify count parameter and
calling function then works with uninitialized variables.
Modify these inline functions to return zero in count parameter.

Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 net/bridge/br_private.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 37ca76406f1e..fd5e7e74573c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1911,11 +1911,13 @@ static inline int br_cfm_status_fill_info(struct sk_buff *skb,
 
 static inline int br_cfm_mep_count(struct net_bridge *br, u32 *count)
 {
+	*count = 0;
 	return -EOPNOTSUPP;
 }
 
 static inline int br_cfm_peer_mep_count(struct net_bridge *br, u32 *count)
 {
+	*count = 0;
 	return -EOPNOTSUPP;
 }
 #endif
-- 
2.32.0

