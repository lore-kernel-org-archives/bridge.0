Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E3C74040D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7402540990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1687158917; bh=qdpfcwYJozREfwO7wJNLhMCU7PvcwSIQgOBak+A3XJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wJXRGuwLpufvyO35rY7eiPTeWucD3UIqOIZF7OLPG+6A9/2CYXequAkMHnKARmVkl
 4qB6wRHhAXle0ZR2kpEg8KgX/V1W1Hy303tnJHQ7yNrD5Xd4T+kxERlEZJShny2tJM
 pAu6B/MqCEHzFkvz0wvfdKS/gpM9KYjfVa6p5Jt4=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Mon, 19 Jun 2023 09:14:43 +0200
Message-Id: <20230619071444.14625-4-jnixdorf-oss@avm.de>
In-Reply-To: <20230619071444.14625-1-jnixdorf-oss@avm.de>
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 3/3] net: bridge: Add a configurable
	default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

This adds a Kconfig option to configure a default FDB learning limit
system wide, so a distributor building a special purpose kernel can
limit all created bridges by default.

The limit is only a soft default setting and overridable per bridge
using netlink.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

---

Changes since v1:
 - Added a default limit in Kconfig. (deemed acceptable in review
   comments)

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
index 8eca8a5c80c6..93f081ce8195 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -530,6 +530,8 @@ void br_dev_setup(struct net_device *dev)
 	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	br->fdb_max_learned_entries = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
+
 	br_netfilter_rtable_init(br);
 	br_stp_timer_init(br);
 	br_multicast_init(br);
-- 
2.40.1

