Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A722B40965
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECFA1408EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHN1TKhsg+zpUSQzmah2NESJCnPaiPmR+MA78MJlse4=;
 b=lvk3zSEXJDCFx2aqoXPQKyqJTNseAsTlSnIsmos1A6ny6d2+DYdfEbESfgbSLNbRgLzqVnyqudUmi3hf3Qtc5saNAQEHDQh97CNGTwK0sMo3bVk9ch7094G+1bGqE4jNvCacFwYBTg+mTNIUkNJA5P/SpeqicHMfJQjQfaPMXO0YfRZZS8iabCZZbCNQ56lvpKdoZtSr+SJzOh/LKzOdBAkr3AQqyxsPpKRUInTV0r8+MByx6kOY8FgpzYZVoUFwLNx9Lm0kn2Y4AKwikQ/5yy6HvzIdNn4Mrg13kMYT09I3uQWyPN0XOc4bS95ImIsJZvNI9K0S/nDdlFRqpAWM7w==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:54 +0300
Message-ID: <20231016131259.3302298-9-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 08/13] net: Add MDB get device operation
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
---
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c7681263d30..18376b65dc61 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1586,6 +1586,10 @@ struct net_device_ops {
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

