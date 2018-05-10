Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=KvrjkduRLngL5gLfohPTCLgpgE1zMUbzTRti8H9Z2KU=;
	b=BNsIikWtisa4XO3Esz3zd7XwGxKptVAXaLr3H/x34i2iNLKW41cDJIxlQ4gf8zOD5Mo4dkx5EJ4xXIBhxhoEaUq0YGVgUGZK3669ceg1WLPg2EcVS5ic0o7U00x9blNGr3PAfXtRjP6C6gJ5xDHevs8cUgtbxBnjqbYr/FWISP4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:03 +0300
Message-Id: <20180510101306.4891-2-idosch@mellanox.com>
In-Reply-To: <20180510101306.4891-1-idosch@mellanox.com>
References: <20180510101306.4891-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/4] net: bridge: Allow bridge master in
	br_vlan_get_info()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Mirroring offload in mlxsw needs to check that a given VLAN is allowed
to ingress the bridge device. br_vlan_get_info() is the function that is
used for this, however currently it only supports bridge port devices.
Extend it to support bridge masters as well.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 net/bridge/br_vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index df37a5137c25..dc832c0934c6 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1176,6 +1176,8 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 	p = br_port_get_check_rtnl(dev);
 	if (p)
 		vg = nbp_vlan_group(p);
+	else if (netif_is_bridge_master(dev))
+		vg = br_vlan_group(netdev_priv(dev));
 	else
 		return -EINVAL;
 
-- 
2.14.3

