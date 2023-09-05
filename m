Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 604DA6066D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E41D760AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1693914590; bh=LJulS2PK41xRqIXVFIJDhKz2cjHftcib9uFS9jUkoNI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hmNsuVZhXkEP6JEYy9rESDP5Oi/VLaKuZ6KoL9sPKoT6vLkBJEXMMA2ZLNoAcFWCE
 YIA1aTzardwKQdIWGmUaJTRxJaS4X1webWJlKnq1DiuM3DsDfSgr1yyQwrz9ik1lqS
 M494uUBroXgVsNWfJ3VPhPzTdtQi35T8KPzGIoFk=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 05 Sep 2023 13:47:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-fdb_limit-v3-5-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
In-Reply-To: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
Subject: [Bridge] [PATCH net-next v3 5/6] net: bridge: Add a configurable
 default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Add a Kconfig option to configure a default FDB learning limit system
wide, so a distributor building a special purpose kernel can limit all
created bridges by default.

The limit is only a soft default setting and overrideable on a per bridge
basis using netlink.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 net/bridge/Kconfig     | 13 +++++++++++++
 net/bridge/br_device.c |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 3c8ded7d3e84..c0d9c08088c4 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -84,3 +84,16 @@ config BRIDGE_CFM
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say N.
+
+config BRIDGE_DEFAULT_FDB_MAX_LEARNED
+	int "Default FDB learning limit"
+	default 0
+	depends on BRIDGE
+	help
+	  Sets a default limit on the number of learned FDB entries on
+	  new bridges. This limit can be overwritten via netlink on a
+	  per bridge basis.
+
+	  The default of 0 disables the limit.
+
+	  If unsure, say 0.
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9a5ea06236bd..8d4221fc5a6c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
 	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	br->fdb_max_learned_entries = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
+
 	br_netfilter_rtable_init(br);
 	br_stp_timer_init(br);
 	br_multicast_init(br);

-- 
2.42.0

