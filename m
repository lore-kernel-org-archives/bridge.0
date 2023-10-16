Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D3BA611F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44A40611F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z01Ln3/2kwAqhN9oOHTp4mbfckYoMDivcI4Z3lRkU34=;
 b=AZnOcmbzbVWED4VGyKoXs6k3bOF4SNUXbjUdsxA4FauQoRul0doqY19UMcME+N9hI+cznaHvqT3MeHRJJLUFTvqUtKZC9XxH3EpPsUtkhDisC3WhP3GPJaaJwslBQlB1FoOHNUq/gZ+En9ebnjM9KDpRNxFigFXsl+qPT6WMeDEdBR2ZuslvAAhainmA7uVGVqQSduWNhBolzAEiHEKHUf7qPs107jetA5Fx5YpoN6Vq/zTQ4qTTkmGKl0pceFKWC4lgOml+ncT6Tfh/plbwmljSPkawCEga76Ybv1VdyWpPaadql2e6+wk3lC4z8idMmlcGgCTRFEll530Tq/ffUw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:52 +0300
Message-ID: <20231016131259.3302298-7-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 06/13] vxlan: mdb: Factor out a helper for
	remote entry size calculation
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

Currently, netlink notifications are sent for individual remote entries
and not for the entire MDB entry itself.

Subsequent patches are going to add MDB get support which will require
the VXLAN driver to reply with an entire MDB entry.

Therefore, as a preparation, factor out a helper to calculate the size
of an individual remote entry. When determining the size of the reply
this helper will be invoked for each remote entry in the MDB entry.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 0b6043e1473b..19640f7e3a88 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -925,23 +925,20 @@ vxlan_mdb_nlmsg_src_list_size(const struct vxlan_mdb_entry_key *group,
 	return nlmsg_size;
 }
 
-static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
-				   const struct vxlan_mdb_entry *mdb_entry,
-				   const struct vxlan_mdb_remote *remote)
+static size_t
+vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
+			    const struct vxlan_mdb_entry *mdb_entry,
+			    const struct vxlan_mdb_remote *remote)
 {
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
 
-	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
-		     /* MDBA_MDB */
-		     nla_total_size(0) +
-		     /* MDBA_MDB_ENTRY */
-		     nla_total_size(0) +
 		     /* MDBA_MDB_ENTRY_INFO */
-		     nla_total_size(sizeof(struct br_mdb_entry)) +
+	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
 		     /* MDBA_MDB_EATTR_TIMER */
 		     nla_total_size(sizeof(u32));
+
 	/* MDBA_MDB_EATTR_SOURCE */
 	if (vxlan_mdb_is_sg(group))
 		nlmsg_size += nla_total_size(vxlan_addr_size(&group->dst));
@@ -969,6 +966,19 @@ static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
 	return nlmsg_size;
 }
 
+static size_t vxlan_mdb_nlmsg_size(const struct vxlan_dev *vxlan,
+				   const struct vxlan_mdb_entry *mdb_entry,
+				   const struct vxlan_mdb_remote *remote)
+{
+	return NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+	       /* MDBA_MDB */
+	       nla_total_size(0) +
+	       /* MDBA_MDB_ENTRY */
+	       nla_total_size(0) +
+	       /* Remote entry */
+	       vxlan_mdb_nlmsg_remote_size(vxlan, mdb_entry, remote);
+}
+
 static int vxlan_mdb_nlmsg_fill(const struct vxlan_dev *vxlan,
 				struct sk_buff *skb,
 				const struct vxlan_mdb_entry *mdb_entry,
-- 
2.40.1

