Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D0AC60E83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C39D60E30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8/xIsJQcK6FnzRGvR0iwZ17paaEg8VJtJjA1su2xHI=;
 b=TZaxjykQxadUOt2s7leF0sTa277pcwiw/Cw2klxY9liy3tZsD0ldQuay3EMXlviC27aisbuCneVZoi+xDg2laObEUg36yXiFYtx9D2NxZvmVCpGDbUh6JO42nZqFS5fHyS6P9kQVp3Fy8Lu3OFeoCV7h4g+VTMJkBea37icvmi9PEv92XCI/iwpbHOXqmw7tl31oMYYLVZ3KXVjr65/SkrZkMw0zgD9/TSLMueNXmwJG9HL2omwDcCxbSI8CQGp1l2xdnNjusQy1TvJ+PCHYbWeU95FmPRGgo0iclRT1CgDJh10oIQBLWMo/L/QO/C841iMBXlAuVR0c97XlgwMZQQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 15 Mar 2023 15:11:52 +0200
Message-Id: <20230315131155.4071175-9-idosch@nvidia.com>
In-Reply-To: <20230315131155.4071175-1-idosch@nvidia.com>
References: <20230315131155.4071175-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 08/11] vxlan: mdb: Add an internal flag
	to indicate MDB usage
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

Add an internal flag to indicate whether MDB entries are configured or
not. Set the flag after installing the first MDB entry and clear it
before deleting the last one.

The flag will be consulted by the data path which will only perform an
MDB lookup if the flag is set, thereby keeping the MDB overhead to a
minimum when the MDB is not used.

Another option would have been to use a static key, but it is global and
not per-device, unlike the current approach.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/vxlan/vxlan_mdb.c | 7 +++++++
 include/net/vxlan.h           | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 129692b3663f..b32b1fb4a74a 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1185,6 +1185,9 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
 	if (err)
 		goto err_free_entry;
 
+	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
+		vxlan->cfg.flags |= VXLAN_F_MDB;
+
 	return mdb_entry;
 
 err_free_entry:
@@ -1199,6 +1202,9 @@ static void vxlan_mdb_entry_put(struct vxlan_dev *vxlan,
 	if (!list_empty(&mdb_entry->remotes))
 		return;
 
+	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
+		vxlan->cfg.flags &= ~VXLAN_F_MDB;
+
 	rhashtable_remove_fast(&vxlan->mdb_tbl, &mdb_entry->rhnode,
 			       vxlan_mdb_rht_params);
 	hlist_del(&mdb_entry->mdb_node);
@@ -1336,6 +1342,7 @@ int vxlan_mdb_init(struct vxlan_dev *vxlan)
 void vxlan_mdb_fini(struct vxlan_dev *vxlan)
 {
 	vxlan_mdb_entries_flush(vxlan);
+	WARN_ON_ONCE(vxlan->cfg.flags & VXLAN_F_MDB);
 	rhashtable_free_and_destroy(&vxlan->mdb_tbl, vxlan_mdb_check_empty,
 				    NULL);
 }
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 110b703d8978..b7b2e9abfb37 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -327,6 +327,7 @@ struct vxlan_dev {
 #define VXLAN_F_IPV6_LINKLOCAL		0x8000
 #define VXLAN_F_TTL_INHERIT		0x10000
 #define VXLAN_F_VNIFILTER               0x20000
+#define VXLAN_F_MDB			0x40000
 
 /* Flags that are used in the receive path. These flags must match in
  * order for a socket to be shareable
-- 
2.37.3

