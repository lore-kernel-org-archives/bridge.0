Return-Path: <nigel.l.christian@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=ZiDan9dXVGzljGcSZKPfVX7WRo0V+2AqnJOcfMOnQww=;
 b=D5n2ETATta69U/pKGykggX+cHanHnfSc4MGuc/zzkdsYy0gS2VnxMtN1jTzfC2Xi9b
 EFP4ml6Jn6LiTajZfcR07sevsMrBTcEdKnczR4wW6T9uNy4GGV+jXmwPjOsUNMsKTl26
 WoHtHm8NzgE2hQSefNie/YnfJV49fsXeFOa/mDJ/rX9CS9jEtGJ/BYfkB09Ae0brt83G
 fRFx+tLyEs/6NwTZoVm0mgEeW9QGfz9gt+qId6FIpNpqho98MZxeXNSWRir3f9qQjhE0
 0KYaqCSpp6uJsAAsFiMBCQdww+sjp+3/mm9suTWZViFs2SaOTZWotbks4mUavRRhimFS
 dMpg==
Date: Mon, 24 May 2021 23:05:58 -0500
From: Nigel Christian <nigel.l.christian@gmail.com>
Message-ID: <YKx3ptXPNbd3Bdiq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] net: bridge: remove redundant assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org

The variable br is assigned a value that is not being read after
exiting case IFLA_STATS_LINK_XSTATS_SLAVE. The assignment is
redundant and can be removed.

Addresses-Coverity ("Unused value")
Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 net/bridge/br_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e4e6e991313e..8642e56059fb 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1644,7 +1644,6 @@ static size_t br_get_linkxstats_size(const struct net_device *dev, int attr)
 		p = br_port_get_rtnl(dev);
 		if (!p)
 			return 0;
-		br = p->br;
 		vg = nbp_vlan_group(p);
 		break;
 	default:
-- 
2.31.1

