Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Th9WKl0IW7GpxbqwwqPmaZkhN6z6TMP9nRsqCNvkXyc=;
 b=B1kZBxgA7H8EfDvYb+YKpfkgRv4EqGRi2cH1Te2uNIimCZT5XlojbYszrNoi9qIQLx
 48uzO637fAGckSKocGF6qT99SFw0+S9cg6QmbUWk9xZF085QvQUC1Udn3QqoeTGM7y2s
 +QVOfLPW9B7K9hlkEQHBieJ8HT4t2UpyDEJdmo+f7kRlKCROqxlF/jZr9G02q13tsV8l
 5FqjNqllTJyw73LCn39+PxASzRsKmbLTeDPoQHU5rMJG51qbyU7nzbQGph6E7u9516r1
 RYtVZPTChFfyfGy2NRW53ClkrGI2mCNaHCUg4Uy4rICDjZpi67kB2NBgClxPDeiutpZh
 Rs1w==
From: DENG Qingfang <dqfext@gmail.com>
Date: Thu, 12 Aug 2021 22:22:12 +0800
Message-Id: <20210812142213.2251697-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2] net: bridge: switchdev: pass more port
	flags to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, Vladimir Oltean <olteanv@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

These 3 port flags: BR_HAIRPIN_MODE, BR_MULTICAST_TO_UNICAST, and
BR_ISOLATED, affect the data path and should be handled by switchdev
drivers.

Add them to BR_PORT_FLAGS_HW_OFFLOAD so they can be passed down to
the drivers.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: DENG Qingfang <dqfext@gmail.com>
---
v1 -> v2: added more flags

 net/bridge/br_switchdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 6bf518d78f02..2ab46178c47c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -70,8 +70,10 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 }
 
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
-				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_HAIRPIN_MODE | BR_LEARNING | \
+				  BR_FLOOD | BR_MCAST_FLOOD | \
+				  BR_MULTICAST_TO_UNICAST | \
+				  BR_BCAST_FLOOD | BR_ISOLATED)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
-- 
2.25.1

