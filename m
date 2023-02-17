Return-Path: <alsp705@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1185041B3D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDA5E41B2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MVXpSvxD8IQLLcvTNwyEk6nPjo5geqGNCFp6pQeswJ4=;
 b=EWCj+D/JciN173neJ/bAWbb8Wsq/dKdqGJ7JlzysVjI7T6XYobU3X+botTB7SN8ZzP
 i/wd1GhONcUrM6D3vvxK7vCWfOBD4a1yloUyKQrd3AOIz5lYxRd+Zud+Mj2NNrQBAJ2U
 q7qaxB0QZRe6W56+l8Z4YpXs1796EiobAWPam60eKGpRAtSFvsXr93htNbVRwCwkIlC3
 5pxwiY3IXTZPozDxqXEkfCTiDdzEOCxjsPjek3YDsAQcPy68bvD6S16GG1a1pHk//d/1
 fPwp8SF9gcgqwAxhurtTdOpyEnpeTuyy+FnAl+x+wBlzyUqOChVXctZd48wBI1YcegxT
 qrHA==
From: Alexander Sapozhnikov <alsp705@gmail.com>
Date: Fri, 17 Feb 2023 16:16:57 +0300
Message-Id: <20230217131657.12649-1-alsp705@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net-bridge: fix unsafe dereference of potential
	null ptr in __vlan_del()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>
Cc: lvc-project@linuxtesting.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Alexander Sapozhnikov <alsp705@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

After having been compared to NULL value at br_vlan.c:399,
pointer 'p' is passed as 1st parameter in call to function
'nbp_vlan_set_vlan_dev_state' at br_vlan.c:420, 
where it is dereferenced at br_vlan.c:1722.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 net/bridge/br_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index bc75fa1e4666..87091e270adf 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -417,7 +417,8 @@ static int __vlan_del(struct net_bridge_vlan *v)
 		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
 				       br_vlan_rht_params);
 		__vlan_del_list(v);
-		nbp_vlan_set_vlan_dev_state(p, v->vid);
+		if (p)
+			nbp_vlan_set_vlan_dev_state(p, v->vid);
 		br_multicast_toggle_one_vlan(v, false);
 		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
 		call_rcu(&v->rcu, nbp_vlan_rcu_free);
-- 
2.34.1

