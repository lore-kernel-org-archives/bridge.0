Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456912;
	b=SAhUyrpP9i+xDl+fp6TrPhvcUW9db93XxoaqR0pjX6ow7KhcDXo2BccKFl11L96ECE0s
	 1Zt1ryF560DHDXHyzshCzvP3WVUxHTo6L2e0SRS2IjiPsKRtfzWpMckjomaq7cL24khhZ
	 v1RanomLfeq0t7vj7IHPb9WVYMI2JL0UL6u0kXVfYn25o+m7No4feOIa1yuTmXAQwhvID
	 llq3y8IL172b+bMgB9Dc6nld1BHxBKZCcz7WTUYM6uvObVPPlnNEi22U2QVng5BwON6hY
	 zN/xfYLWZCxyRNIEsDy4jGX6eGXqXUlCGu3gi9UHvusnPOQPf2wY17WJYKP019VmttA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456912;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mfq9TD4uNLKog6pJ+zdcLpJD3ougZ9SwH+dbDxxWBkY=;
	b=XL3jqY2E2E8xs4MYkHNkN2+T+WdSn0nECdIZhpzffR3h91hR0rhuuBgC6agkBQjNsujL
	 ymxrRqKOvq6556pydrAOKtRc5u7XdFIsgBHbHJAnwL1Xr4E7F70m+MsU2Qrm/h0BXyhiQ
	 0CRPHz5fflO9EeXR4QouRsdPSQu0YP1dRyz9slWWG856jfpYN5ON2TpCu3vQeVBMuYHi+
	 r9FoOhmXs35kymMBh+wx7Hx7OkD+MC9Qb3w+dwUGCvf1QutZbFDTqhvK/0YZNsndMioAT
	 a94UN33syAI/BfgxvHZ7jt/7NoKbN0UzEGHnjONGDkOy16tqBbgfevJG4q6ctu1ZjBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MNn2QHid;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3672606A321
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3672606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MNn2QHid
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+casXCvnUaXRrptvWKJnIezhRjcggTl/7E70cfjHfFJwi8iwA+3eed2BtX3TF88J9tNab3ODSnPhIcQbk62v+XM8yu3ZMBpdy2l/0hA3/TxLfbAkpgfD2cAmnErvHbod4xRRih0JitdGUh7QwIIuM9gzPFlf4TIWHwYkfbVIGcC3OaA5Xg8QULMnwLvOK4N5GOTAB17aYYveHaaEP0NBygJLk6WMNy79SCjxxmmoe0Qwj87JU0gJWvCDGFcNECBQy75kSkMJgiH5uHjIgfrqPmMJofjkkRZrL1JbCuQXUfM6oOND6ZTBmrFu1p70pmQV7bGKLVZ6yqVjkhxvT+3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfq9TD4uNLKog6pJ+zdcLpJD3ougZ9SwH+dbDxxWBkY=;
 b=v7stpNpuM5jPg3i/mlgfm2/uShnqokSItvYLpROKK5vWHl6F51+bZWEpVlJO1adK6Oys4Ez3+RXaK+BeFmspL1ZLZmqp7Wa5CSCjGQEfH7WOzVqWsPk/HJbXt5vTmbcPg5kjJaKuJRuuEAWFBlzb1RQwT2X+F8F2bTkXhGtzFfODQ+LD+RwAKCduSZLJj4VOS2lAhzmGSCxBxhxLOYhti138JQCGzahA+86cMQhbVLgU3e6k8VAhfG4bGsOEmvynJAj4HYhiqaN9W65qkbIB6Eucx6s3zs2MuH43WxbEZ0RgP7EFmAaOsjDVoGAezOWP4aoOLbeVlfwnSYVLjM5omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfq9TD4uNLKog6pJ+zdcLpJD3ougZ9SwH+dbDxxWBkY=;
 b=MNn2QHidceMDWCjs4TNaoKwHgck/rBiiQdzn90mjPfmO6cneZ3/Mh9Sf8Q1Bed0I6sVve+kJBuKHllBEY7l1mlF/I1ieuF9JDaazl07fICV4VvCWJPmaseCSWabDbJjX3X6DEht1hi8TGbFZ8W1BrKV+SJ0X1L96kBSsLYsX7rUDbc2WRRWAoTHIaN2OH9F0f+j7SBB5xF8UVBVxeltn/de8MR62fOzlPGDrMA6P0RgssMwWjLrMVBfpIyv5LFkFjULwpmGAJILDurnPJJe1/htLDQrzlRMPrF/NNyIZYeRyqukidu41OADitMUvkN+2pKrF1qtd1C+++SqO8WZgag==
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 18:01:43 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2a01:111:f403:c95d::1) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:01:11 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:01:06 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 13/13] selftests: net: Add a test for port ID in FDB notifications
Date: Mon, 23 Nov 2026 18:59:28 +0100
Message-ID: <a09fea415670a74f853e6dc56cdf4a4184c40ce3.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
References: <cover.1795447450.git.petrm@nvidia.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 49611e1c-383d-4d35-9727-08df498bd430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|261026140227099003|261102123227099003|261022105027099003|11063799006|261021121427099003|261009223027099003|261022075727099003|56012099006|261028144727099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	IyvsAQ5h5GAQHxRHBkhkG29rFxHg3Q+q870x44+6FmI/uNwDYP2hZIW25NSfiEjT23PCoc56J0Grb1f9f8OfRQVW81eQCRQerfdrdf7tmdPIiVBkANIJ9dxFITBfGcxJFg2+4Nxtg6ByrRASqz9baNi7a9ibDe60fhN8klR1KuvXn/oZjxU+LTGz8XzdlQX5qLPTBGTLDAX6i0AjyolK470luGzAkfckfGYjhrmymbXmoxv2KjTAO7WrwiD8GUvBCUG7fiHh+NPn7MT6IHA6fXHbobQXAfEvqdIStCIp24aX1S6ggcP/X458duVM8PTE4eTOoCa2SIYWwTBDZ0KXoIi8rjhbSYx1bx5h4hRz6sjuZj2eBeUrfurZaQ5giZ8VWVw55UWI1pJDrzOyq4BryJXGF+1r6rSxUjJMzp1AJUkiSSopPPaKhFpL9lDLQJGKsNlCqN5+DOZMh7NraFuQwo5pplm+rm7VOeYJ1bK7E/9Xc0/ObHu3aWysnMeDrgmKdJ8aRaVK/MOSM1SJXwpknVicSeAC2tZRE6g2K8o2H+JxAJRvxRCIUQhEK3q63Ncp0HhUL3aJIz6HK98/cO/47/Q7zw2wL4zfaP9GOx6J4EaN3qWouHOWDF6roMQ6x6jBwoVrD07memvtrkU4cAyZQjW/8KvsurxRbsC3ara2eX6PyBUqSrYTlUACRtoVr6UxH998QAsfKbi2NxNnVRXHAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(261026140227099003)(261102123227099003)(261022105027099003)(11063799006)(261021121427099003)(261009223027099003)(261022075727099003)(56012099006)(261028144727099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JR/7H7ALsu4pX+K798rDHLKxxLBatAYnRV9GFSr8g2WHTJZsQQpYdRJ5Vg1yhVEocDBe/NvCUxjqCXG15NlHKmsfuouY7UtsjfuYHJhG9dfyZEum2vTrBYqVH+dy+bUU8BWkFelZtFAmPpN3GlBCvGuHDNYh98w+cYQrzDkNn9w7DS7QohdHH7qAhRv0k2otmMqKvCNphX8SXz7XQeBHz29LiQlR16xlDznMvwDdYRxtR43jm3cIH69qVEZE+feNL0qyCLoLpmRRsJjfD14jI12/igeU4qJ8F8vpPvWuKjWIz1K2kReZNcueH2W7cMmO7xSiYAMlXZi22yXlPtsq+5MheE64m52TrzvUsbGclgqHoYU3tIkexQ1rwWJQ9x7wL82WAvF8FpRTnQ+tRNHPUEAAVK+Nrw/U/zFN/zW0dSKoqe5epicKpaEQPihwJE1E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:41.8292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49611e1c-383d-4d35-9727-08df498bd430
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858

Add a test that checks that RTM_NEWNEIGH and RTM_DELNEIGH notifications
for FDB entries carry the netlink port ID of the requester in nlmsg_pid.

A listener socket subscribed to the neighbour group receives the
notifications, while two separate requester sockets, A and B, make the
changes. Entries are added through A, replaced through B and deleted
through A, and the port ID seen by the listener is compared to that of the
socket that made the particular change. The following cases are covered:

- bridge: a bridge port (NTF_MASTER) and the bridge device itself
  (NTF_SELF), including a bridge with VLAN filtering, where one request
  results in several notifications
- VXLAN, including replacing the remote
- macvlan, which does not send notifications by itself and thus exercises
  the generic fallback in rtnetlink
- bulk delete (flush) of bridge and VXLAN entries
- bridge entries learned from traffic, which are not a result of a request
  and should carry a port ID of zero

The test needs CONFIG_PACKET to send the frame that is learned.

fdb_notify.sh already covers some of the same device setups (bridge, VXLAN,
macvlan), but it checks for duplicate notifications and cannot check the
port ID, as the broadly available tools do not show nlmsg_pid. One option
would be to capture bridge monitor run with strace and parse out key tells.
But that felt like too much of an ugly hack. Another option considered was
netlink capture (nlmon plus tshark), which would add further tool
dependencies, and then, a capture does not say which socket a message was
sent through, which is needed to tell the requester's port ID from someone
else's.

Python with YNL, which the selftests already have, can read nlmsg_pid and
compare it to the requester's socket directly. So instead of extending /
consolidating with fdb_notify.sh, a new test was written.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../selftests/net/fdb_notify_portid.py        | 297 ++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100755 tools/testing/selftests/net/fdb_notify_portid.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index fb0a64662053..fafe30367243 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS := \
 	fcnal-other.sh \
 	fdb_flush.sh \
 	fdb_notify.sh \
+	fdb_notify_portid.py \
 	fib-onlink-tests.sh \
 	fib_nexthop_multiprefix.sh \
 	fib_nexthop_nongw.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index dab62cdfa27b..18dfb45fb914 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -126,6 +126,7 @@ CONFIG_NFT_COMPAT=m
 CONFIG_NFT_NAT=m
 CONFIG_NUMA=y
 CONFIG_OPENVSWITCH=m
+CONFIG_PACKET=y
 CONFIG_PAGE_POOL_STATS=y
 CONFIG_PSAMPLE=m
 CONFIG_RPS=y
diff --git a/tools/testing/selftests/net/fdb_notify_portid.py b/tools/testing/selftests/net/fdb_notify_portid.py
new file mode 100755
index 000000000000..b7b398aa8040
--- /dev/null
+++ b/tools/testing/selftests/net/fdb_notify_portid.py
@@ -0,0 +1,297 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Check that FDB notifications carry the netlink port ID of the requester in
+nlmsg_pid. A listener socket subscribed to the neighbour group receives the
+notifications, while separate requester sockets make the changes. The port ID
+the listener sees is expected to match that of the requester socket.
+"""
+
+import socket
+import struct
+from collections import namedtuple
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_true
+from lib.py import ksft_busy_wait
+from lib.py import ip, tool
+from lib.py import NetNS, NetNSEnter
+from lib.py import Netlink, RtnlNeighFamily
+
+RTM_NEWNEIGH = 28
+RTM_DELNEIGH = 29
+
+NTF_SELF = 0x02
+NTF_MASTER = 0x04
+
+NUD_NOARP = 0x40
+NUD_PERMANENT = 0x80
+
+ETH_P_EXP1 = 0x88b5  # Local Experimental EtherType 1
+
+Ntf = namedtuple("Ntf", "type portid addr")
+
+
+class Env:
+    """The listener socket, the two requester sockets A and B, and the
+    netlink port IDs of the latter. All sockets live in the given netns."""
+
+    @staticmethod
+    def _socket(ns):
+        with NetNSEnter(ns):
+            rtnl = RtnlNeighFamily()
+        return rtnl
+
+    def __init__(self, ns):
+        self.ns = str(ns)
+
+        self.listener = self._socket(ns)
+        self.listener.include_raw = True
+        self.listener.ntf_subscribe("rtnlgrp-neigh")
+
+        self.a = self._socket(ns)
+        self.a.sock.bind((0, 0))
+
+        self.b = self._socket(ns)
+        self.b.sock.bind((0, 0))
+
+        self.portids = {self.a: self.a.sock.getsockname()[0],
+                        self.b: self.b.sock.getsockname()[0]}
+
+        ksft_ne(self.portids[self.a], self.portids[self.b])
+        ksft_ne(self.portids[self.a], 0)
+
+    def ifindex(self, name):
+        """Look up the ifindex of a device in the test netns."""
+        with NetNSEnter(self.ns):
+            return socket.if_nametoindex(name)
+
+    def ntfs(self):
+        """Return the bridge-family notifications received by the listener."""
+        self.listener.check_ntf()
+        ntfs = []
+        while self.listener.async_msg_queue.qsize() > 0:
+            msg = self.listener.async_msg_queue.get()
+            if msg['msg']['ndm-family'] == socket.AF_BRIDGE:
+                ntfs.append(Ntf(msg['raw'].nl_type, msg['raw'].nl_portid,
+                                msg['msg']['lladdr']))
+        return ntfs
+
+    def check_ntfs(self, nl_type, addr, requester, count=1):
+        """Expect count notifications for addr, all from the requester."""
+        portids = [n.portid for n in self.ntfs()
+                   if n.type == nl_type and n.addr == addr]
+        ksft_eq(portids, [self.portids[requester]] * count,
+                f"nlmsg_pid of {addr} notifications")
+
+
+def fdb_req(ifindex, ndm_flags, attrs):
+    """Build an AF_BRIDGE neighbour request with the given attributes."""
+    return {'ndm-family': socket.AF_BRIDGE, 'ndm-ifindex': ifindex,
+            'ndm-flags': ndm_flags, **attrs}
+
+
+def test_msg(env, sock, message, message_type,
+             ifindex, addr, ndm_flags, flags, count, attrs):
+    """Send one request through SOCK, and expect COUNT notifications of
+    MESSAGE_TYPE about ADDR carrying the port ID of SOCK."""
+    # pylint: disable=too-many-arguments,too-many-positional-arguments
+    req = fdb_req(ifindex, ndm_flags, attrs | {"lladdr": addr})
+    sock.do(message, req, flags)
+    env.check_ntfs(message_type, addr, sock, count)
+
+
+def add_replace_del(env, ifname, addr, ndm_flags, *, add, rep, dlt, count=1):
+    """Add an entry through socket A, replace it through B, delete through A.
+    ADD, REP and DLT are the attributes of the respective requests. If REP is
+    None, the replace step is skipped."""
+    # pylint: disable=too-many-arguments
+    ifindex = env.ifindex(ifname)
+
+    test_msg(env, env.a, 'newneigh', RTM_NEWNEIGH, ifindex, addr, ndm_flags,
+             flags=[Netlink.NLM_F_CREATE | Netlink.NLM_F_EXCL],
+             count=count, attrs=add)
+
+    if rep is not None:
+        test_msg(env, env.b, 'newneigh', RTM_NEWNEIGH, ifindex, addr, ndm_flags,
+                 flags=[Netlink.NLM_F_CREATE | Netlink.NLM_F_REPLACE],
+                 count=count, attrs=rep)
+
+    test_msg(env, env.a, 'delneigh', RTM_DELNEIGH, ifindex, addr, ndm_flags,
+             flags=[],
+             count=count, attrs=dlt)
+
+
+def flush(env, ifname, addrs, add, dlt):
+    """Flush all permanent entries through socket A, and check that all the
+    notifications carry the port ID."""
+
+    ifindex = env.ifindex(ifname)
+
+    for addr in addrs:
+        attrs = add | {"ndm-state": NUD_PERMANENT,
+                       "lladdr": addr}
+        env.a.do('newneigh', fdb_req(ifindex, NTF_SELF, attrs),
+                 flags=[Netlink.NLM_F_CREATE | Netlink.NLM_F_EXCL])
+
+    env.ntfs()
+
+    attrs = dlt | {'ndm-state': NUD_PERMANENT,
+                   'ndm-state-mask': NUD_PERMANENT}
+    env.a.do('delneigh', fdb_req(ifindex, NTF_SELF, attrs),
+             flags=[Netlink.NLM_F_BULK])
+
+    ntfs = [n for n in env.ntfs() if n.type == RTM_DELNEIGH]
+
+    ksft_true({n.addr for n in ntfs} >= set(addrs),
+              "Flush did not notify about all the entries")
+    ksft_eq({n.portid for n in ntfs}, {env.portids[env.a]},
+            "nlmsg_pid of flush notifications")
+
+
+def test_bridge() -> None:
+    """Bridge port and bridge device entries: add, replace, delete."""
+    with NetNS() as ns:
+        env = Env(ns)
+
+        ip("link add br0 up type bridge vlan_default_pvid 0", ns=ns)
+        ip("link add d0 up type dummy", ns=ns)
+        ip("link set dev d0 master br0", ns=ns)
+
+        add_replace_del(env, "d0", "00:11:22:33:44:01", NTF_MASTER,
+                        add={"ndm-state": NUD_PERMANENT},
+                        rep={"ndm-state": NUD_NOARP},
+                        dlt={})
+
+        add_replace_del(env, "br0", "00:11:22:33:44:02", NTF_SELF,
+                        add={"ndm-state": NUD_PERMANENT},
+                        rep=None,
+                        dlt={})
+
+
+def test_bridge_vlan() -> None:
+    """Without a VID given, an entry is added and deleted in every VLAN."""
+    with NetNS() as ns:
+        env = Env(ns)
+
+        ip("link add br0 up type bridge vlan_filtering 1 vlan_default_pvid 0",
+           ns=ns)
+        ip("link add d0 up type dummy", ns=ns)
+        ip("link set dev d0 master br0", ns=ns)
+
+        tool("bridge", "vlan add dev d0 vid 10", ns=ns)
+        tool("bridge", "vlan add dev d0 vid 20", ns=ns)
+
+        # Three notifications: for VID 10 and 20, and for the entry
+        # without VLAN.
+        add_replace_del(env, "d0", "00:11:22:33:44:03", NTF_MASTER, count=3,
+                        add={"ndm-state": NUD_PERMANENT},
+                        rep=None,
+                        dlt={})
+
+
+def test_bridge_flush() -> None:
+    """Bulk delete of bridge entries."""
+    with NetNS() as ns:
+        env = Env(ns)
+        ip("link add br0 up type bridge vlan_default_pvid 0", ns=ns)
+        ip("link add d0 up type dummy", ns=ns)
+        ip("link set dev d0 master br0", ns=ns)
+
+        flush(env, "br0", ["00:11:22:33:44:10",
+                           "00:11:22:33:44:11",
+                           "00:11:22:33:44:12"],
+              add={},
+              dlt={})
+
+
+def test_bridge_learned() -> None:
+    """Entries that are not a result of a request carry port ID of zero."""
+    with NetNS() as ns:
+        env = Env(ns)
+        ip("link add br0 up type bridge", ns=ns)
+        ip("link add v0 up type veth peer name v1", ns=ns)
+        ip("link set dev v0 master br0", ns=ns)
+        ip("link set dev v1 up", ns=ns)
+
+        addr = "00:11:22:33:44:31"
+        frame = (b"\xff" * 6 + bytes.fromhex(addr.replace(":", "")) +
+                 struct.pack("!H", ETH_P_EXP1) + b"\0" * 46)
+        with NetNSEnter(env.ns):
+            tx = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
+            tx.bind(("v1", 0))
+
+        portids = []
+
+        def learned():
+            nonlocal portids
+            tx.send(frame)
+            portids = [n.portid for n in env.ntfs()
+                       if n.type == RTM_NEWNEIGH and n.addr == addr]
+            return portids != []
+
+        # Keep sending until the entry is learned: a frame that
+        # arrives while the bridge port is not yet up is dropped
+        # without triggering learning. Once the entry exists, repeated
+        # frames only refresh it and do not generate notifications.
+        ksft_busy_wait(learned, deadline=2)
+
+        ksft_eq(portids, [0], "nlmsg_pid of learned entry")
+
+
+def test_vxlan() -> None:
+    """VXLAN entries: add, replace the remote, delete."""
+    with NetNS() as ns:
+        env = Env(ns)
+        ip("link add vx0 up type vxlan id 2000 dstport 4789", ns=ns)
+
+        add_replace_del(env, "vx0", "00:11:22:33:44:41", NTF_SELF,
+                        add={"dst": "192.0.2.1", "ndm-state": NUD_PERMANENT},
+                        rep={"dst": "192.0.2.2", "ndm-state": NUD_PERMANENT},
+                        dlt={"dst": "192.0.2.2"})
+
+
+def test_vxlan_flush() -> None:
+    """Bulk delete of VXLAN entries."""
+    with NetNS() as ns:
+        env = Env(ns)
+        ip("link add vx0 up type vxlan id 2000 dstport 4789", ns=ns)
+
+        flush(env, "vx0", ["00:11:22:33:44:50",
+                           "00:11:22:33:44:51",
+                           "00:11:22:33:44:52"],
+              add={"dst": "192.0.2.1"},
+              dlt={"dst": "192.0.2.1"})
+
+
+def test_macvlan() -> None:
+    """The notifications for macvlan, which does not notify by itself, are
+    sent by the generic code in rtnetlink."""
+    with NetNS() as ns:
+        env = Env(ns)
+        ip("link add dd up type dummy", ns=ns)
+        ip("link add mv0 up link dd type macvlan mode passthru", ns=ns)
+
+        # macvlan does not support replace.
+        add_replace_del(env, "mv0", "00:11:22:33:44:61", NTF_SELF,
+                        add={"ndm-state": NUD_PERMANENT},
+                        rep=None,
+                        dlt={})
+
+
+def main() -> None:
+    """Run all the tests."""
+    ksft_run([
+        test_bridge,
+        test_bridge_vlan,
+        test_bridge_flush,
+        test_bridge_learned,
+        test_vxlan,
+        test_vxlan_flush,
+        test_macvlan,
+    ])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.56.1

