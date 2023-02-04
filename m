Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D305382086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD5FD82078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4PXtYbUKyUivLLP3rUrPplalXXEIhuL6DL8cRncPe8=;
 b=dQQsmV0FTx1fcBwZAvgp4P+sw6DUYWcSRS5fmFUvt7GuAtykJvqtm6rtOISPffs0VUArJ/wJdPOAwEhnwdaRXnGV6GXwtbgfgCKIA8GK1BPSFqlfl3Faf2Y55vtSa3ZVO2lHa1/fOoS7inEGsB9nuvqJwrZuFgzXeKGKOQgcBiJjOuWjw5HYzCllkdhMXdKw6TYmNuEfleJTHvxPzZebK65yic5T/0QaT+KSDet3PqEmYMGssAtL7vDUUApqAtwZeGtqnluhJGIooI1tbLv4SVNbuUlYrkVuI14fvMKOt2AM8c1TvIImt+rKu5nw56B1XdijK7wesJ6th77LO4wOKQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:07:55 +0200
Message-Id: <20230204170801.3897900-8-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 07/13] rtnetlink: bridge: mcast: Relax
	group address validation in common code
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

In the upcoming VXLAN MDB implementation, the 0.0.0.0 and :: MDB entries
will act as catchall entries for unregistered IP multicast traffic in a
similar fashion to the 00:00:00:00:00:00 VXLAN FDB entry that is used to
transmit BUM traffic.

In deployments where inter-subnet multicast forwarding is used, not all
the VTEPs in a tenant domain are members in all the broadcast domains.
It is therefore advantageous to transmit BULL (broadcast, unknown
unicast and link-local multicast) and unregistered IP multicast traffic
on different tunnels. If the same tunnel was used, a VTEP only
interested in IP multicast traffic would also pull all the BULL traffic
and drop it as it is not a member in the originating broadcast domain
[1].

Prepare for this change by allowing the 0.0.0.0 group address in the
common rtnetlink MDB code and forbid it in the bridge driver. A similar
change is not needed for IPv6 because the common code only validates
that the group address is not the all-nodes address.

[1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-2.6

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c  | 6 ++++++
 net/core/rtnetlink.c | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index f970980e6183..88f0519520d2 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1249,6 +1249,12 @@ static int br_mdb_config_init(struct br_mdb_config *cfg, struct net_device *dev,
 		}
 	}
 
+	if (cfg->entry->addr.proto == htons(ETH_P_IP) &&
+	    ipv4_is_zeronet(cfg->entry->addr.u.ip4)) {
+		NL_SET_ERR_MSG_MOD(extack, "IPv4 entry group address 0.0.0.0 is not allowed");
+		return -EINVAL;
+	}
+
 	if (tb[MDBA_SET_ENTRY_ATTRS])
 		return br_mdb_config_attrs_init(tb[MDBA_SET_ENTRY_ATTRS], cfg,
 						extack);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 892d4e8fd394..1c7a8cbc4ce1 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6149,8 +6149,9 @@ static int rtnl_validate_mdb_entry(const struct nlattr *attr,
 	}
 
 	if (entry->addr.proto == htons(ETH_P_IP)) {
-		if (!ipv4_is_multicast(entry->addr.u.ip4)) {
-			NL_SET_ERR_MSG(extack, "IPv4 entry group address is not multicast");
+		if (!ipv4_is_multicast(entry->addr.u.ip4) &&
+		    !ipv4_is_zeronet(entry->addr.u.ip4)) {
+			NL_SET_ERR_MSG(extack, "IPv4 entry group address is not multicast or 0.0.0.0");
 			return -EINVAL;
 		}
 		if (ipv4_is_local_multicast(entry->addr.u.ip4)) {
-- 
2.37.3

