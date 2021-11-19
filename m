Return-Path: <bernard@vivo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com; 
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuyhKQDliC8I4qFoPNAaE88O5kX8kCM/Ysiv4nmtNu0=;
 b=nwC1Mw8GU8Lg11GigkUPCb5kEwJSqdcdzU6iKTACTsSNmikTgJjF5jMxooL7LTkoCW65k8ANE2EOFTJnGVGT7ZCsMji53ChHeN24NUUGwC4lvhfZeY3ij2d7EIk3BLS9yEbCija9guVQF/nrNufc+4N6Vp+GF44dVxZBvGoYz9U=
From: Bernard Zhao <bernard@vivo.com>
Date: Thu, 18 Nov 2021 18:06:42 -0800
Message-Id: <20211119020642.108397-1-bernard@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bernard Zhao <bernard@vivo.com>

simple_strtoull is obsolete, use kstrtol instead.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 net/bridge/br_sysfs_br.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index d9a89ddd0331..11c490694296 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -36,15 +36,14 @@ static ssize_t store_bridge_parm(struct device *d,
 	struct net_bridge *br = to_bridge(d);
 	struct netlink_ext_ack extack = {0};
 	unsigned long val;
-	char *endp;
 	int err;
 
 	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
-	val = simple_strtoul(buf, &endp, 0);
-	if (endp == buf)
-		return -EINVAL;
+	err = kstrtoul(buf, 10, &val);
+	if (err != 0)
+		return err;
 
 	if (!rtnl_trylock())
 		return restart_syscall();
-- 
2.33.1

