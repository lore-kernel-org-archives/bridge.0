Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEE9F405F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DA13405A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWAS9sy8p3oKjwtrl1G1L1zE48uknaQb+yom1/wew44=;
 b=T3e1ZycbrtUJHb8l4UMg8FCf3UpjhIZ/BJZLunxiEjYF+BtyJKfV3VPxxWQu8HUvmxYKkBD7YMuXlYq55buUs6cSdrJnloUkI4LNuS4fR9ga6vSziWP4LX7yJDGlDT/88iFEI/Ti+UG5VYbSc3LbObkh1x7VY9pWgvF6/VlmD6NkwqgTOGLgHctEpu9BMw5EpDzUU7jIwg5g3/bpW78sEhiQOuJP6OQjFxa30Fmx9K1eJ5XlayzqdFzsV+M3fkjg15e+AYCOYHkIFMi2MHm77P0VG/C8CL45FKjwRr2O8qxpaUr1Xjn1XXnpoDJGFViUacLYbbyNm1jCCgRS2YmERg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:08:01 +0200
Message-Id: <20230204170801.3897900-14-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 13/13] vxlan: Enable MDB support
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

Now that the VXLAN MDB control and data paths are in place we can expose
the VXLAN MDB functionality to user space.

Set the VXLAN MDB net device operations to the appropriate functions,
thereby allowing the rtnetlink code to reach the VXLAN driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1e55c5582e67..e473200b731f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3083,6 +3083,9 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_fdb_del		= vxlan_fdb_delete,
 	.ndo_fdb_dump		= vxlan_fdb_dump,
 	.ndo_fdb_get		= vxlan_fdb_get,
+	.ndo_mdb_add		= vxlan_mdb_add,
+	.ndo_mdb_del		= vxlan_mdb_del,
+	.ndo_mdb_dump		= vxlan_mdb_dump,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
 };
 
-- 
2.37.3

