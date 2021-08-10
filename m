Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LGHkd28MWGOCiDBxhGiWFhEVrZHPKuUZlWpdM+gDHPo=;
 b=Os0pBMxreEKRJKeGlgpOk6mhU80oeCPD0k8HXW8LyBX20WrTt35SduZm5PWEMqoFBA
 npOXb5Tno00CL6AJfoTU/RSi998rNHcBE7RfpqJTavKL8md5exUc0lzjKzoYSiU7L3m0
 5HI8rcceizbw3URhKKmIJf0UD78lRfStAqMtdu42n8HHe5bpW5juP6y6xVPgbyxtSz6m
 FJQM9Y6LUs3idH0JgKvgsrPWgyPJ2GsyBCspBMpHtGSYhmBlzEzldZ+Dttt12jVOkhSp
 H1BekTHWhYi6nRD3iK+mP7g77pAmkstaBku11eAYPjTW/jQgkPz+3Bj2C7jqvo0qfHqV
 IGjQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 12:21:39 +0300
Message-Id: <20210810092139.11700-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: vlan: fix global vlan option
	range dumping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When global vlan options are equal sequentially we compress them in a
range to save space and reduce processing time. In order to have the
proper range end id we need to update range_end if the options are equal
otherwise we get ranges with the same end vlan id as the start.

Fixes: 743a53d9636a ("net: bridge: vlan: add support for dumping global vlan options")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8cfd035bbaf9..cbc922681a76 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2019,7 +2019,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 
 		if (dump_global) {
 			if (br_vlan_global_opts_can_enter_range(v, range_end))
-				continue;
+				goto update_end;
 			if (!br_vlan_global_opts_fill(skb, range_start->vid,
 						      range_end->vid,
 						      range_start)) {
@@ -2045,6 +2045,7 @@ static int br_vlan_dump_dev(const struct net_device *dev,
 
 			range_start = v;
 		}
+update_end:
 		range_end = v;
 	}
 
-- 
2.31.1

