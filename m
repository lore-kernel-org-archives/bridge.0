Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F5CC41725
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A73741728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF8W4pgPuMSWR22hb9sXprLpuXg9ANFWlvD59qDGA14=;
 b=TCSeWC8b5ev+pdLMYqzbD5y3hEgtnfCTPECtx98CZ2qQuak9DSUN+n9xVwR4OOn+fTUZwTqAsBj60Zm8MyA9v2V++AQ8pr2zG46ccxvmACa9cMw/HbqD1QtGQzUzE+EosvRINhY54nb359LT5ZTQ79i8lSxgJzB9ih0UzxzyetgHxI/gQZUXXbZSw1XyUiBMUeoXAmk7D80blHIOVonybIuKa19Xflt3Dt5daTVdW7PmZ52GfibB03ch4iCZGVuUR+/OBQUW5HERH8JV3QwTkBpk+4+nXLbA+MNB+3+OUnuWVkzM3yJ2mJNOX6+dSFYV3JF1P+Z16LDrswG7vezLew==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 13 Mar 2023 16:53:46 +0200
Message-Id: <20230313145349.3557231-9-idosch@nvidia.com>
In-Reply-To: <20230313145349.3557231-1-idosch@nvidia.com>
References: <20230313145349.3557231-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 08/11] vxlan: mdb: Add an internal flag to
	indicate MDB usage
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

