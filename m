Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEC5341CBE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA66641C91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=886fnpq+IvsanNM1sSgN71E2LKYdIG2xDXhWO2Cui5k=;
 b=OqCzO2EUHuTJmZQIEpECtloRkG1s3hbkTkuKhFDXratuJwoeZAhUgpDnO+5r98ctl98/psj58qbG0jAaJ6X5Jru3KH+eF5/XIRyRZVraJ5E7Dl5sr6mHhbb5uoyf4YZDlU5WrLgGFSJ90T7kUND7sx3V2CR97/2AwUe6nKCLQYOXvxlzt8PSRhfxaLpOTnUgFbEZogLgdOxOUdmejEz9PeQdb8uKMij/r8ovmJleVA82ATIbjgSWYr0j+y3FzOml8CkOcF95krp13IIhOsAdm+ubSiVS6x4PbvXz0yiAxBV9HTwHOIuvlGrBUs+bdN3KkzRWsMX43rt5Si5bgen+SA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:07:59 +0200
Message-Id: <20230204170801.3897900-12-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 11/13] vxlan: mdb: Add an internal
	flag to indicate MDB usage
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
index 079741da2599..72c922064c02 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1207,6 +1207,9 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
 	if (err)
 		goto err_free_entry;
 
+	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
+		vxlan->cfg.flags |= VXLAN_F_MDB;
+
 	return mdb_entry;
 
 err_free_entry:
@@ -1221,6 +1224,9 @@ static void vxlan_mdb_entry_put(struct vxlan_dev *vxlan,
 	if (!list_empty(&mdb_entry->remotes))
 		return;
 
+	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
+		vxlan->cfg.flags &= ~VXLAN_F_MDB;
+
 	rhashtable_remove_fast(&vxlan->mdb_tbl, &mdb_entry->rhnode,
 			       vxlan_mdb_rht_params);
 	hlist_del(&mdb_entry->mdb_node);
@@ -1358,6 +1364,7 @@ int vxlan_mdb_init(struct vxlan_dev *vxlan)
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

