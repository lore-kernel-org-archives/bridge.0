Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E63A283396
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E5E683367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IamVcORR3O+jhnEgZr4SuPWFBLyo4aPO4o6t+GBlo8=;
 b=d2tLfX0tEH20eoweZQy1vx/YWpOqUKIRU6uCeHVgY/q7WtLoov3v6UG6m5BTMCS6bnAsjK6lLJ7pYLBU3GcBQqMMEfwM3C6mJN28AUpiGQHoKl/OrRx+0Lsx4Lm93N5FSKScurug7j+7FhDURMfz8plzOy0vtqmIohdaADDgeZT31zYhNb2Fu+Qd9QVVxAOkOz6NdSksQwfG2BlmBS/uJOy+/HFXVvZliAqmnBm8FBlwH433dXFMFGtr29IJSkuIIoNJ2YGdxB8Gvh8AofCXPFq0Oz8FsSo7C8CQxzSC7l1+PEJxS+jquAL3RNuraJsJB5X0cfa5W37H7Lzx3vB4SQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 15:04:14 +0300
Message-Id: <20221018120420.561846-14-idosch@nvidia.com>
In-Reply-To: <20221018120420.561846-1-idosch@nvidia.com>
References: <20221018120420.561846-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 13/19] bridge: mcast: Expose
	br_multicast_new_group_src()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Currently, new group source entries are only created in response to
received Membership Reports. Subsequent patches are going to allow user
space to install (*, G) entries with a source list.

As a preparatory step, expose br_multicast_new_group_src() so that it
could later be invoked from the MDB code (i.e., br_mdb.c) that handles
RTM_NEWMDB messages.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 2 +-
 net/bridge/br_private.h   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 09140bc8c15e..14f72d11f4a2 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1232,7 +1232,7 @@ br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip)
 	return NULL;
 }
 
-static struct net_bridge_group_src *
+struct net_bridge_group_src *
 br_multicast_new_group_src(struct net_bridge_port_group *pg, struct br_ip *src_ip)
 {
 	struct net_bridge_group_src *grp_src;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 278a18e88e42..2aa453ea04f9 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -972,6 +972,9 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
 				       struct net_bridge_port_group *sg);
 struct net_bridge_group_src *
 br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip);
+struct net_bridge_group_src *
+br_multicast_new_group_src(struct net_bridge_port_group *pg,
+			   struct br_ip *src_ip);
 void br_multicast_del_group_src(struct net_bridge_group_src *src,
 				bool fastleave);
 void br_multicast_ctx_init(struct net_bridge *br,
-- 
2.37.3

