Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=EwW1ad9aaDxzLEmHNXCm17nZVCt4Pcys+G0syr6CYU4=;
 b=pZe7+VYM2Ch4tnW0vNrVk4kIXpos0UkPqBnqRz0liSSCmjg5WR46ijNkTFp1HCgHFG
 G7xtFljcmI1+/ai2y4SDM+SuB0bYJ6ujqEiFCprXncNFqQuO3QTWAYzw1L2HjZjT4H3N
 v/0RVdM4I4DpTyyct5KApt+YAfxnXRgaxNJUJAMngBXVw0Ri55ZE9X1fL2nhUd6LZcrn
 skDkxgDKgNOhZFP6P6RWDaFGYspOza6cihrkcaaDHNr72RtORhJmLoMNX/dxH0eZmcRY
 MNvzvYmKHTdpW8/Glo8PDfXtx+xP4+15Juf+9hRUfW87XIYD64cyFvB8sH6Ie98g2nc5
 gR+g==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Tue, 22 Feb 2022 14:28:15 +0100
Message-Id: <20220222132818.1180786-3-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
References: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 2/5] net: bridge: Add support for
	offloading of locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Various switchcores support setting ports in locked mode, so that
clients behind locked ports cannot send traffic through the port
unless a fdb entry is added with the clients MAC address.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index f8fbaaa7c501..bf549fc22556 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -72,7 +72,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 
 /* Flags that can be offloaded to hardware */
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.30.2

