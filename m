Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9A4D4F367
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F26944F37D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rae7OqQxUVSCz3yVdVwxQVJJJF5zTn/3L+OqBVD0qsg=;
 b=E7fVF0Ac0mJWGUX9N1QOHm7T4EuEOeRHHJSS4hPRIYk5Y9PXR022Vx7Q3OoE+vQPhIkKmY2k21b2TFzd0xlYF4fj0TIGzQ0ZQowxJT1j6im6X4w5YUOcHs6wEIPRQBvXBLtc0/1gUB+BTQyaLT92DEaDVN2UqeB0UMhtTYcLw8+jIl4QH9+8S5TeprMndN63stuw4shnYyHn79lBaHgQWCFAqDwsARUQ21+XEkNsHIHKHWMtatP1/8rSFqT8bJjUaUNyxyY4rQ1KFnKOmB/k/v79jy+t79J7cGCgiQMi6hAzbhT30vm9ZVFuLMwJdPxF6wDAoR14gsktyqa9vYM6UQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:15 +0300
Message-ID: <20231025123020.788710-9-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 08/13] net: Add MDB get device operation
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

Add MDB net device operation that will be invoked by rtnetlink code in
response to received RTM_GETMDB messages. Subsequent patches will
implement the operation in the bridge and VXLAN drivers.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8bf669212cc..a16c9cc063fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1609,6 +1609,10 @@ struct net_device_ops {
 	int			(*ndo_mdb_dump)(struct net_device *dev,
 						struct sk_buff *skb,
 						struct netlink_callback *cb);
+	int			(*ndo_mdb_get)(struct net_device *dev,
+					       struct nlattr *tb[], u32 portid,
+					       u32 seq,
+					       struct netlink_ext_ack *extack);
 	int			(*ndo_bridge_setlink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags,
-- 
2.40.1

