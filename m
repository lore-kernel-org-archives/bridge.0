Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456914;
	b=XPInoMhbqt2IRCYDVG3MwGapZHznz2WBbN4qo/nY9gZIsZJR1inlEQL2P+xwh+o/TG23
	 NF7nBaOZB/MYC9Uzah907/D53WhERIMRG1cOZzvRDPVJKWyV+ZrwtrKfb14j6GsgJWLAR
	 P3s68/Hm6xaKmxEMHU8I4gtnjBY+bRvoj1FXvMCLblcSzDV/jlWC1Cho4FoByplBFbdyH
	 NKiyA2u+y3oH5IHwTGdL74iMswu+GUaxz97eqJDhs6rWnr0PBfR//I62i2Pidal8Mj55F
	 Uu1xwuarWdLTRDcWad8fM6PWc4HRUonKKwFeikOck2nRWWPeVMEpd0v7Ffv23j3xSeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456914;
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
	bh=arx8YwV9LXIJ8gKAjOC7RTyOcSxyXezLIn5p9QTOkSM=;
	b=O1S1VvuKzY82Uj67GYRKP0SKuuWAdML2dVWAA9h/cI6GJnEIj1UD9yhAo7YbzOTUTiCH
	 HZQMoqbEadQkjHWgO9cim4P5Ns8PuF0Jj5aFa6+Nd6MKVVEhHgpvx0eSmY6nuEfR0/xXV
	 ysSrcmGOZknliAb6sUKpNTbriJ1uAnW7iEZjto/BU+Ke4nqqHJHtFQH1ChisxHKm6WBAI
	 wHPtsLk5gHfTD6pX1J66TYtC6XuANpKWFs9ysjGMk8DyzL6zQM2c4d4pEwhVT5CFwwZ4o
	 BO+6//kZ4FiBN5jWY4Bk+DDacH0sN+B6msbe2OpXACSUWa+3eLfCmChHpEeXVdW8HOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i4K5lfBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E6606A327
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3E6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i4K5lfBK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXWMDIfg/jSJwIv04scRMaz11xdhUGQmjnapEbuxNccbxfm80/uSRh3azMobCh6Ggi6S8prIE3CRuRueGG6mtPzGlmo3va3l7yBy9Kwjuty9vnZF22ABg+9iTfZQPMhHt8uXgJsthjgruvXQIHXR9wjMc4/X/nR9TRdfdYeZI+z6s4+0uGS6Y7O16DLsv4ksl8Ytm17JLxCEcD3im1qahU227CbO0IUrdXSsnja/dnQXsd9HEwNPoWqXixpWgEMS7fcpB3I9gpwqR/IsuETbuzShjEcOt+JkA1X+6HYwxsVcUWuvw9C7JwychYbybk94ynmWQ8SDAF1myZhnWDsg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arx8YwV9LXIJ8gKAjOC7RTyOcSxyXezLIn5p9QTOkSM=;
 b=ZOCH+vsLlTHZBOqb9rlsyw8XLzn4ZUrjUol1NQIFpcFeX/3YbaYxIav0GRDUa9SYzDEfuUUTGp0Qz61dPmhbe5qD5gjl086fPC33eTBf0PPv/pvosRO0gcsC4vpk9tAPmg0Me0LMFQt8p1U4OihY3KuQEw4ikaFqVkyODkhhDMIw3mbt3XTLrVld8ZFyTMMdPtXvuTdqH2uiItOdrW+yPBeuavENAfBHX06XhoD4LLlf9Ar0uGPYRnmY7UxU4QN7jImuTRr9WvcbY5AcGWZUTa67cWw6cZ9vvB2Dls0/3bW8Kz5oHQWkE08ADI6oXSb0AFBXAladY7cAbvyGw231SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arx8YwV9LXIJ8gKAjOC7RTyOcSxyXezLIn5p9QTOkSM=;
 b=i4K5lfBKTroZSF3UclfyBqZaN5zSWGqTjLkzLROJT9ZaeIXDNh4ZR5Gh9cq/IYVuFf7SNDuwa85l2UEFquizOqPPZF/t2PsP4UzdByQPctkqr+zho7ZgsDxgzpJIwUjGsPpZ4YMZC0rGaeS2xHSNvxWce6tMNqhk7kBfo0iW567HAPy/zghUZ7Z1CejYPYKDRbERBnTcPZD0+Tmoa5VNAI5y6FB9NUHwTCe4rXYTIH4uIgShPaeATJRBs7QZGcCnFkpMh2wP86NWBMMZ1fGcMoVAEhidCeKRh/Gta4KXPVDObBHJxLRpaNfjSjYMdQ7zC7mJZLltUNxQot6Z3E8fxQ==
Received: from PH7P220CA0070.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::10)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 18:01:43 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::44) by PH7P220CA0070.outlook.office365.com
 (2603:10b6:510:32c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:01:06 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:01:00 -0800
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
Subject: [PATCH net-next 12/13] selftests: net: lib: py: Add RtnlNeighFamily
Date: Mon, 23 Nov 2026 18:59:27 +0100
Message-ID: <4d75835c1c05fc9c201895b4c08aca3c866f6d4b.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e669ae-4b57-4ec4-6740-08df498bd467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|23010399003|376014|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261026121527099003|10067099003|261102123227099003|261022105027099003|261009223027099003|261026140227099003|261022075727099003|261028144727099003|261102130727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Nr1CV548agNlSCbZoaICXzQfGr7u3JOJt1XonIgIKZoqlcS6vvxF8s6j6IiTHTrco7rW5u8uB9IV1eGY/Frb/d3QTv4GJ+rqf4HCZlvQKiNh4E3eMrOFHUCOxOpQ37pUootk3Fahga1VtNXYtVtghyyguRK2woTDwYOR7T2hW3cVrdWTfuL+ZxcOIx/DSvSHSmfc1IHlJJxA57vF1CG9P1ES/CdntJtC9sYuhmKJHu6RCHU5f3tX8EVzH1wKESEGTRdOq+mQVYt0qwJnmyaKH5WOx25Py1Kqc5B12EVfra0ow2Rby5vzgV5tWi7O5XiY0BCHL6TdeR8GxAkjqhUMhjB3kkN10HjHssLG03E7EG1oTZLRiwi8el+3aRFmmSo/dl4i8oRetO9dgYl4woqH4xij6f1glmq88tLBlDtVaj8JzbNkpT9xXf6rk8RLXeK5etL+F4Urvo3D3sXDtY3UpdIvV9GxubX1KhY5VjaT96cm9m3AWcYtYSRtQvmV1PQEiXxNl9MirKQUsmnZK1K7r6sRvWVj3b5tqT4+1MVVlft1M0Lvqoz4zxD9L/HeJfTE51ptY/i2YNufLbrciyr1Invq0UBNABkDYQ3SN7TowYXYh3vKVvcXx3S4NfKI5hvhhSI2pD2CJe/7Obb10Nn0JRPgxVN+i7fXJwlw3vgTny0qGvspuyN9JDG9a0HNNleh3j+y4SwElLIz9wwrP8anwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(10067099003)(261102123227099003)(261022105027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261028144727099003)(261102130727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GsjBFj178y3lK9enYwoNzrz9b1hJUH1hI+72kU0WBPG9+sxqMF0BrHDdGx0uuttNTwwrCWrluEAZ7xyBgVa9Bsz5guykjokO4BwEXBHoVXPGS+bWzltddkkvvubJ4/FUT56/TddHIr2fPv6nhP5GLP9FeLpPw381rmNTK9PFQ5lMlSMBPam/9v7UMzooPzrz4uKmqdgZXfftnkKoskiIKwZYf7mHHReUA3rcY19vA7yEzX05c9upTSx/ATRT3PlNNDK2CDH6MNhE7GEvexbDE2Ufl5TZ//OE4FrWrrrRm3/vAGW6KzWDaVg01h6XX9jlL3d1sbOkXC1zlWQrix1FMERw+oL1+1yT6/YGoDOTPTdVwVWFX4Np/sx0xgUQH4aymxdRB+Xwn1EhwVjPZS14plEFFHz99qBCiKnWn9XoEH2tbrpMn6TDu7hb4w30ucdo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:42.1769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e669ae-4b57-4ec4-6740-08df498bd467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

Add a YnlFamily wrapper for the rt-neigh spec, next to the ones for
rt-link, rt-addr and rt-route, and export it from lib.py.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/__init__.py |  6 ++++--
 tools/testing/selftests/net/lib/py/ynl.py      | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index b1696f432c7c..3f7696d06e6f 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -17,7 +17,8 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     ctl_file_write, wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
-    EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
+    EthtoolFamily, NetdevFamily, RtnlFamily, RtnlNeighFamily, \
+    RtnlAddrFamily, RtnlRouteFamily
 from .ynl import NetshaperFamily, DevlinkFamily, GtpFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
@@ -36,4 +37,5 @@ __all__ = ["KSRC",
            "NetshaperFamily", "DevlinkFamily", "GtpFamily", "PSPFamily",
            "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "NlctrlFamily", "RtnlAddrFamily", "RtnlRouteFamily", "Netlink"]
+           "RtnlNeighFamily", "NlctrlFamily", "RtnlAddrFamily",
+           "RtnlRouteFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 69a6e9d9b390..ac13bf1ff23d 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -29,7 +29,8 @@ except ModuleNotFoundError as e:
 
 __all__ = [
     "NlError", "NlPolicy", "Netlink", "YnlFamily", "SPEC_PATH",
-    "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily", "RtnlRouteFamily",
+    "EthtoolFamily", "RtnlFamily", "RtnlNeighFamily", "RtnlAddrFamily",
+    "RtnlRouteFamily",
     "NetdevFamily", "NetshaperFamily", "NlctrlFamily", "DevlinkFamily",
     "GtpFamily", "PSPFamily",
 ]
@@ -49,6 +50,13 @@ class RtnlFamily(YnlFamily):
         super().__init__((SPEC_PATH / Path('rt-link.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
 
+class RtnlNeighFamily(YnlFamily):
+    """Netlink interface for neighbour messages."""
+    # pylint: disable=too-few-public-methods
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('rt-neigh.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
+
 class RtnlAddrFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('rt-addr.yaml')).as_posix(),
-- 
2.56.1

