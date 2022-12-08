Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88DA76113E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEDD360A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXjyfGzARL5VUfAnf+q3Hfg+kM6Y8m4Y6sTv0rjK888=;
 b=VBVGzCy7BIA7jOUps4YQ4XS65nr+0BX8NE5A44SUgtF0UWm2Ru7oguDEt9UArZ8MCnos7s86eLXH+kPvYH9E1CcCTPaIFtMwNTaIF4KEiQmpNb7QlBfJ+yzwUM6/LpXUu7iUh8dHnnucAPn84LMUzhi8loT2jNSwoqwQ4CJp+ZEwVzKqm1twVPmKEKYYm6LHZRijR0z8z8KTutLgM8ESqI/hqiJNcbdHl21kZDsNA0IKXAQ4yoHA/xRivWkYSzPIbyBlNWefUj9C3JUNqOxfGHKA1f/zJIM0Xkhxr+JYHNOi2SGsf7K6ZoH//tN8S6j0Txt6fSl2u3tCnZCWkr4TMQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:30 +0200
Message-Id: <20221208152839.1016350-6-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 05/14] bridge: mcast: Expose
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
index db4c3900ae95..b2bc23fdcee5 100644
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
index 3997e16c15fc..183de6c57d72 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -974,6 +974,9 @@ void br_multicast_sg_add_exclude_ports(struct net_bridge_mdb_entry *star_mp,
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

