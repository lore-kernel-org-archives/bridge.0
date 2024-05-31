Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61D823CB
	for <bridge@lists.linux.dev>; Fri, 31 May 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143184; cv=none; b=emuJA796DvSQMpWMpJo8+lsI+253p3AoqwoN0XB75exhe5lsUCRCKKimPJdIOwbscl8KkuXCk5qxJEXkJKM07bv31ASG3JmgVYZ9fSFKQfZAGS4zZhoVyLN2jFbD4MPXE15gHEVKk7KLI1If3VRsSxRKjpHk+nNi4bGDWM+rMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143184; c=relaxed/simple;
	bh=YAzk/Z21OffZ/0jQxK+37Gcwl/sCwNgTdKOAQBLXBXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpjYzZE1V+v0/cQgDugVq5TU+Y3Of03psgoF9AKYDlxHUqojOti21yzIjN+MI06iax/CWMqKBNSFiQiwJxQUj+8aR0vuh/t5qINriEbzrzCDzHASNGyBs6yNVYonu9IBJloCFYD8RiH/3ICGDMrAqqrxL/a7EOIgRCPs/oz2GaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NSwfVkCR; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NSwfVkCR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717143182; x=1748679182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YAzk/Z21OffZ/0jQxK+37Gcwl/sCwNgTdKOAQBLXBXw=;
  b=NSwfVkCRYLpYrJFzzSUACSpDFk4jFroEf57B/VSuTF8HDk3akfBO48S3
   bw3TjZ7iAMVOQOZy0Nk4lGiiBzk0mWkfWyKhLXmL/L5vJlDkxUGGzUSp4
   rhGvWJ47YuPPNS0dv5WqoNey8SyJcezUDuWWmunm3v64prgElZKosj8sf
   QrYZqnZ9VLHJNXHpIyj5zvjgB3TxWhGsmp2Jr/3rg36PtyBuAcoOeHoCx
   pvIgzDHd3xu9Y4XywVjFz4pM3Rq+pBdeLnukPzBeuaR36c5wl2yBpGUyW
   ZWVVJtqyyNbTKg1cQcID0rL3TyofgYIhMw2hZpyoDuLdCGIPd1LoJt/6P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="140408089"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="140408089"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 17:11:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E6BD5CD6E2
	for <bridge@lists.linux.dev>; Fri, 31 May 2024 17:11:47 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 26EF6D3F0B
	for <bridge@lists.linux.dev>; Fri, 31 May 2024 17:11:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B60720097E7D
	for <bridge@lists.linux.dev>; Fri, 31 May 2024 17:11:46 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6BD901A000A;
	Fri, 31 May 2024 16:11:45 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] net: bridge: Clean up one inconsistent indenting warn reported by smatch
Date: Fri, 31 May 2024 16:11:36 +0800
Message-Id: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28420.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28420.006
X-TMASE-Result: 10-3.538300-10.000000
X-TMASE-MatchedRID: E96g+3imn7mSlJbFK+uaF2/6CCblACLhTfK5j0EZbyvAuQ0xDMaXkH4q
	tYI9sRE/L2EYbInFI5stE4KgUQ2xoJcFdomgH0lnFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq2uFo2Cd8JyNxeqljGHCpsHTexG/klFQrnrVcsQVCm36v+3yk9jUTPbq8Inj9pPWMWgny
	0VDDErFuOQXG+3ze/ebpNNOGz5jTIVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
	gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

smatch complains:
net/bridge/br_netlink_tunnel.c:
   318 br_process_vlan_tunnel_info() warn: inconsistent indenting

Fix it with proper indenting.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 net/bridge/br_netlink_tunnel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 17abf092f7ca..25ac3a5386ef 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -315,8 +315,9 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 			if (curr_change)
 				*changed = curr_change;
-			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
-						    curr_change);
+
+			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
+						   curr_change);
 		}
 		if (v_start && v_end)
 			br_vlan_notify(br, p, v_start->vid, v_end->vid,
-- 
2.39.1

