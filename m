Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11FC582143
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 411DF820F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yjMJB5rcJ+8MrWeQsljB0+d7+3hGEcxUAz/vBZ1bvo=;
 b=bazPTwSSHt+gkLbygiQjlEbhxeaxCwKg1Uan1roIIRyR0Ifgll6HCOZchtm2vf1Y2CtWCvkRBdk370Zvj99NFykUvUY4d4xbbG5Mt/bSTcyzOd45+1RRlC7girqrWcbkz9QS26CFMkEJFuJx7AVCmWGimiw2+8TznxsnZsUIe9QSVquL4J+rioK81lnL7F9rvTIw0Vd+QrmqOmOk80mj+1T41uErS2r6BKUmqeBu6sps1v5UT3HT5BshBTSKbP/l7jZH5mEYHQBAP6X6n2Gpgj9/BWH0E5okdhLZoJpKoQ8oz8gTClVOsm4/Vdqj/BGbUoTu94/PhWbV11RJXw0qbQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:51 +0300
Message-ID: <20231016131259.3302298-6-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 05/13] vxlan: mdb: Adjust function
	arguments
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

Adjust the function's arguments and rename it to allow it to be reused
by future call sites that only have access to 'struct
vxlan_mdb_entry_key', but not to 'struct vxlan_mdb_config'.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 5e041622261a..0b6043e1473b 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -370,12 +370,10 @@ static bool vxlan_mdb_is_valid_source(const struct nlattr *attr, __be16 proto,
 	return true;
 }
 
-static void vxlan_mdb_config_group_set(struct vxlan_mdb_config *cfg,
-				       const struct br_mdb_entry *entry,
-				       const struct nlattr *source_attr)
+static void vxlan_mdb_group_set(struct vxlan_mdb_entry_key *group,
+				const struct br_mdb_entry *entry,
+				const struct nlattr *source_attr)
 {
-	struct vxlan_mdb_entry_key *group = &cfg->group;
-
 	switch (entry->addr.proto) {
 	case htons(ETH_P_IP):
 		group->dst.sa.sa_family = AF_INET;
@@ -503,7 +501,7 @@ static int vxlan_mdb_config_attrs_init(struct vxlan_mdb_config *cfg,
 				       entry->addr.proto, extack))
 		return -EINVAL;
 
-	vxlan_mdb_config_group_set(cfg, entry, mdbe_attrs[MDBE_ATTR_SOURCE]);
+	vxlan_mdb_group_set(&cfg->group, entry, mdbe_attrs[MDBE_ATTR_SOURCE]);
 
 	/* rtnetlink code only validates that IPv4 group address is
 	 * multicast.
-- 
2.40.1

