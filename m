Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2649418A6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 177234187A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8xQD6wIXI7G9nlFvyc28CRTCwLnUV1tYLqhNK96CV4=;
 b=hz72DzRHHtHoVbX72g42rVRYpa1bhI9/vztycAm/n7I0tOvA0TTRpaS7KlnCk0O0+ytYWX0w3kMDzQGHPoeob6mvKqTT2QHK5fYuEV/qbLFosJsrCrgf2BSd1mYV/V51gs5F6yeLDGxc9WXyc4l6SJYj9ns97DCo0hSB8tESeyoJfAlHgsdJE1+uRirBoHiJ0r9SvzleOvg/XNDZKrIJ5vQX/B9MMvnb+dyHwobU6M0+Z9ZwgNyrHmarUhNyIDcFZxWcswO2j45HrRd/B9V5caXQ0OvEZlAfvRFtxFekQ5F5LymFD9khYnzL3Z7nVAl7zhC/aDlvtSet7GKAj5yaDA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 15 Mar 2023 15:11:50 +0200
Message-Id: <20230315131155.4071175-7-idosch@nvidia.com>
In-Reply-To: <20230315131155.4071175-1-idosch@nvidia.com>
References: <20230315131155.4071175-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 06/11] vxlan: Expose vxlan_xmit_one()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Given a packet and a remote destination, the function will take care of
encapsulating the packet and transmitting it to the destination.

Expose it so that it could be used in subsequent patches by the MDB code
to transmit a packet to the remote destination(s) stored in the MDB
entry.

It will allow us to keep the MDB code self-contained, not exposing its
data structures to the rest of the VXLAN driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/vxlan/vxlan_core.c    | 5 ++---
 drivers/net/vxlan/vxlan_private.h | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2c65cc5dd55d..5de1a20497a6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2395,9 +2395,8 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 }
 
-static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
-			   __be32 default_vni, struct vxlan_rdst *rdst,
-			   bool did_rsc)
+void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
 {
 	struct dst_cache *dst_cache;
 	struct ip_tunnel_info *info;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 038528f9684a..f4977925cb8a 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -172,6 +172,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __be16 port, __be32 src_vni, __be32 vni,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
 		     bool swdev_notify, struct netlink_ext_ack *extack);
+void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 		     struct vxlan_config *conf, __be32 vni);
 
-- 
2.37.3

