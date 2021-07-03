Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcXpR57JCcAMQ9q/jdIeT5Ev/nTHUqZD/rJq1Q8j8q4=;
 b=XCRHziJTV6C4CGUooEYbkpDGkLegU80mRJYA0pwF8df78TIh/UkpjaVzTbJYeM9rP6F2MODRmMvpl+2N5wnLT1fQsqBc+kbl//P4eu36f8VE7GsYdl4WIDL53lTaALHG81cSJnb2QM+OGNrh8kr1KXsdUKUb1UUG8UHmYVsz0j0=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:57:02 +0300
Message-Id: <20210703115705.1034112-8-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 07/10] net: dsa: track the number
	of switches in a tree
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

In preparation of supporting data plane forwarding on behalf of a
software bridge, some drivers might need to view bridges as virtual
switches behind the CPU port in a cross-chip topology.

Give them some help and let them know how many physical switches there
are in the tree, so that they can count the virtual switches starting
from that number on.

Note that the first dsa_switch_ops method where this information is
reliably available is .setup(). This is because of how DSA works:
in a tree with 3 switches, each calling dsa_register_switch(), the first
2 will advance until dsa_tree_setup() -> dsa_tree_setup_routing_table()
and exit with error code 0 because the topology is not complete. Since
probing is parallel at this point, one switch does not know about the
existence of the other. Then the third switch comes, and for it,
dsa_tree_setup_routing_table() returns complete = true. This switch goes
ahead and calls dsa_tree_setup_switches() for everybody else, calling
their .setup() methods too. This acts as the synchronization point.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h | 3 +++
 net/dsa/dsa2.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 33f40c1ec379..89626eab92b9 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -159,6 +159,9 @@ struct dsa_switch_tree {
 	 */
 	struct net_device **lags;
 	unsigned int lags_len;
+
+	/* Track the largest switch index within a tree */
+	unsigned int last_switch;
 };
 
 #define dsa_lags_foreach_id(_id, _dst)				\
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 185629f27f80..de5e93ba2a9d 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1265,6 +1265,9 @@ static int dsa_switch_parse_member_of(struct dsa_switch *ds,
 		return -EEXIST;
 	}
 
+	if (ds->dst->last_switch < ds->index)
+		ds->dst->last_switch = ds->index;
+
 	return 0;
 }
 
-- 
2.25.1

