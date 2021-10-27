Return-Path: <ivecera@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635342575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZD6LAq6atB4BsCmnlxgTYHzC6191yWWoUcGigwC22tc=;
 b=KjzIx8za4yy9NDex919H9ZF2RIgWs6tQiRoBcNEWe2hTAKjvRw7GeNOT0hHgEIMlZE+N/e
 +KZ8Bv64RyvlKm8JN7/0VYa8z1uLtUihuLWAuXLsYwFlN7Co2AqEZuNs02jS4vBkDllPfq
 Uacxoy30jH89OvVuJL8DQzvRBGWq5+U=
From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 27 Oct 2021 15:49:26 +0200
Message-Id: <20211027134926.1412459-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: fix uninitialized variables when
	BRIDGE_CFM is disabled
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
but does not check their return value. When BRIDGE_CFM is not enabled
these functions return -EOPNOTSUPP but do not modify count parameter.
Calling function then works with uninitialized variables.

Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 net/bridge/br_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5c6c4305ed23..12d602495ea0 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -126,8 +126,10 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 		return vinfo_sz;
 
 	/* CFM status info must be added */
-	br_cfm_mep_count(br, &num_cfm_mep_infos);
-	br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos);
+	if (br_cfm_mep_count(br, &num_cfm_mep_infos) < 0)
+		num_cfm_mep_infos = 0;
+	if (br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos) < 0)
+		num_cfm_peer_mep_infos = 0;
 
 	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
 	/* For each status struct the MEP instance (u32) is added */
-- 
2.32.0

