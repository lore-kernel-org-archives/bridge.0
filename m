Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81F8385211
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC1D985167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laoG30tubjGqBrfWjLo6SuMiCIlE3dw4f+NOzwcbHRY=;
 b=c2nuO8oN34md3cTGZCRHx3EFf35q20I7PjRuu/7vG6Jq9TIx1GfM4h8K3ju5fRmEtE7ccjtvkN5AhTsB1efCTS4ZtusE+BiYQA8r7oLDHXURTZ7TQdQdOJW9GU4BlukVklzUnxW5PlaXs2tT6Jx0mpEgikBnHk2dS4L5V7A9O+VE9ws7HBSCssVHrvNAe74S2o5eIFgiflr8Fzbo5pffIIV86VCGiw4B0ka6Sh43HpPt+PAj2M5OLyEfbjhSZSgfHJ9LKuUNj3CiJpKNlfBH/tUHTVc/sO5k2gDUg9/K41HWCapWQ5rnMCansSw8fUDlUS0W9TVW9IGKOOz+hoPbag==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:14 +0300
Message-ID: <20231025123020.788710-8-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 07/13] bridge: add MDB get uAPI
	attributes
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

Add MDB get attributes that correspond to the MDB set attributes used in
RTM_NEWMDB messages. Specifically, add 'MDBA_GET_ENTRY' which will hold
a 'struct br_mdb_entry' and 'MDBA_GET_ENTRY_ATTRS' which will hold
'MDBE_ATTR_*' attributes that are used as indexes (source IP and source
VNI).

An example request will look as follows:

[ struct nlmsghdr ]
[ struct br_port_msg ]
[ MDBA_GET_ENTRY ]
	struct br_mdb_entry
[ MDBA_GET_ENTRY_ATTRS ]
	[ MDBE_ATTR_SOURCE ]
		struct in_addr / struct in6_addr
	[ MDBE_ATTR_SRC_VNI ]
		u32

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add comment.

 include/uapi/linux/if_bridge.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f95326fce6bb..2e23f99dc0f1 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -723,6 +723,24 @@ enum {
 };
 #define MDBA_SET_ENTRY_MAX (__MDBA_SET_ENTRY_MAX - 1)
 
+/* [MDBA_GET_ENTRY] = {
+ *    struct br_mdb_entry
+ *    [MDBA_GET_ENTRY_ATTRS] = {
+ *       [MDBE_ATTR_SOURCE]
+ *          struct in_addr / struct in6_addr
+ *       [MDBE_ATTR_SRC_VNI]
+ *          u32
+ *    }
+ * }
+ */
+enum {
+	MDBA_GET_ENTRY_UNSPEC,
+	MDBA_GET_ENTRY,
+	MDBA_GET_ENTRY_ATTRS,
+	__MDBA_GET_ENTRY_MAX,
+};
+#define MDBA_GET_ENTRY_MAX (__MDBA_GET_ENTRY_MAX - 1)
+
 /* [MDBA_SET_ENTRY_ATTRS] = {
  *    [MDBE_ATTR_xxx]
  *    ...
-- 
2.40.1

