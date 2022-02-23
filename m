Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=Z+hbLNvF0Nhve3XBOMxW8KtWdx8aJiHJ43sZ0z9sw1E=;
 b=EquzZhxnieCrk3INNeTDu6kmQ8PDFht+473pRAMO2lVGaI5CtlUgrT19oecm4EbYCw
 hD6M14xHzJXWrndGSkPG4myjk46PwiuoXhCGn8s7I6u/nBqTi7YXbUL+s4VLsKyn6XfO
 m1a6muPJyaMEX4pfdpXdQKf1dd9hLUs7Xs3DHZqrBVjJG9yWu3ZEpGhxlQWbtusDskTG
 g/Cv78MImpgV3i0Br+nrhxXoFWVhYV98vIQ/VJNd17kXrgnupVZhcSJCNj0WYRqveCCB
 JSvyMH/eyilIIJn2yp4wfdhMPnMavV+Peq3Z4de/JtuoNGG2lzZzmOFfQXnLsxAPY5u4
 WPJw==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Wed, 23 Feb 2022 11:16:48 +0100
Message-Id: <20220223101650.1212814-4-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220223101650.1212814-1-schultz.hans+netdev@gmail.com>
References: <20220223101650.1212814-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v5 3/5] net: dsa: Include BR_PORT_LOCKED
	in the list of synced brport flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Ensures that the DSA switch driver gets notified of changes to the
BR_PORT_LOCKED flag as well, for the case when a DSA port joins or
leaves a LAG that is a bridge port.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 net/dsa/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index bd78192e0e47..01ed22ed74a1 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -176,7 +176,7 @@ static int dsa_port_inherit_brport_flags(struct dsa_port *dp,
 					 struct netlink_ext_ack *extack)
 {
 	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-				   BR_BCAST_FLOOD;
+				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
 	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
 	int flag, err;
 
@@ -200,7 +200,7 @@ static void dsa_port_clear_brport_flags(struct dsa_port *dp)
 {
 	const unsigned long val = BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
 	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-				   BR_BCAST_FLOOD;
+				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
 	int flag, err;
 
 	for_each_set_bit(flag, &mask, 32) {
-- 
2.30.2

