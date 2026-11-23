Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456857;
	b=Ch0SoDQFFdbY2Qwwh/5EgsbrRolroFQRr7lsBom0czQFcCEZ+G11n8rEshduIOocfJkZ
	 FzQFC2TVeTGhDNDqF/vwSebhuTfQX83CVbitpHl9cc8S+Q6CH2x5Is3v5PnoViMYdnkEv
	 Nv3n3AG7Mc3YSYgfjC5dPl6JVcSgyVFxfen+57WYFf5kzOHiNkNCpY2JhOQWrfsW2OyCz
	 Hr4B4AbfdRqT7hRtD0yJy7ZS0X9hJS+ZGLjdMGER0pjTGvs5zwZ/lWZSfOYvts7aaGe44
	 1xoVjradjaP5wH2FoGRMi5ixQ068bYrah98Hjne/DhQWSDzN8wch6lVsq2v8kVhIP7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456857;
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
	bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
	b=e02I3i46fxE0LkBazeCrF+4r9H++I/LzTb7pGBGMAhTdyj/NlyOX/apEip+AoXZSKCgx
	 GS3QNl0oxM4Ei/1OTlNiHzNUitmPJZDlSbbx9MVN1S96WlrVC/W1dmLcvYMMAD2a+P+Pk
	 ae4wBrBKaQACi4OOW2HCXuou9I0FCEKzrfXkPTiPtcSZJte0oVE5c41HH2pjIP2RF9CAo
	 BL4NDXd6JWAqnUGjZCpAHhDAeS7GMzoSbnyGaZzt4aJQrHikZUMdQG0J1WK8yyKWgLdS9
	 rpJiWu+xkVDwVBfjrefcGComkdGVT9jbpujTnKWzXs56OacQFWJkQLcg9jHy5B2ERzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HUoHEc4v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.69
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08615606A32A
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08615606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HUoHEc4v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0JspqJjhQUeE0riqyB43VCgqNYVJDf7CFRc+g7W7lMCH5jCJvadYZfkjRHVtayQ7S/WL0oT6Zm3UDevinItjSQw+JIxCRrdQ6B8W0OK/Ihp24nqJojdjZC2/Gx4iL6y3o0JTonpWL4WeMpq0sbZWsVmyFqnCyJT4UNQrb6lfh3t7IWUsww7OuLxDqYGWSe7Hrt9Fu9Z5mvc6wdyO/ap7rcZ5jLH0URWn60r0winTAhlHJK1vU0m0SYj0or4A16rQNyqmka7TrztdEJNGEAaA+iq5apxmcPeTUIQpX62dOyg9xpBwhok4Uzd8jDgkrQ+/EYa5TTzvoGyw8Roc0mE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
 b=mtcKIURiBAUI27HtfkyY+ppdtZ/KrNWP+q1OzYKSgdATdeJgXPHqXxbiDYddlpBW6dJWQjBVLwfkd+xDxiBE5eSSkk1IHG77oFgpBdNjy/beK7YNL0IFkRb5XnXB5qemqdNGGplA/T5RpOwLgDUe04CvMtfbImitpMLhkvLNPb1tlRscSiAhmIgxCsqkglTTBbJ4vnqYHNmoMO9qxcY7bfMxywhNDB2VOvFgoQx+4+l4sxel3XR9JSZ4rzjfDinwVaW+IREmQXf1nvm0+MB18nRjUyCMvukXW/IPYQ+IA3FeCw0pXxGAbuHW6LI1rOJuu8So7ZftX3g+msoNYALeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx6yEgwy8nze2Tq2bWtkVXJMQWmaTvH/rbYpXA9I2lQ=;
 b=HUoHEc4v1b20bkiDbdZ42NRWqGM7XDSUvPZaQy64bFfkxhWNRz7xfjGt7Y8kOQNSdd7i04LWqoybOg3GMzkSyHmKqYzFITWR1PJaktbjuxYoH+cU50XSMwdwaioPf6Qtly2EdW4Fvv8A4TilWd4UZ9NnT4XSKBBAp3zmQ5L6nxTK3HUBdhcw4YxYLO5aQIABA/Pce5DIPZL0l8S7OVzP1RtqsDP/KF3SltKZCNAJ56QXXMyGu0R+LHCEGJUDdZ4ouOV21UkZg7eoso3CqLqJYgXkvi2Stra0i0+LXbIrb7HcXyRAyODaVeqqFbchplMC+ZqSuXeQV16CY+Tt/+FC8w==
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:00:48 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::24) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 18:00:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:13 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:06 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>
Subject: [PATCH net-next 02/13] net: Pass struct ndo_fdb_parms to ndo_dflt_fdb_{add, del}()
Date: Mon, 23 Nov 2026 18:59:17 +0100
Message-ID: <dfb728bec60618c6f1bebea429cabba25c5be36f.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: d927ac3a-da8a-428f-2b57-08df498bb36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|261102123227099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kvcJlbWfrrOThYNnLRKTvCyrINCjQjl/gbQNB1iBFGySULZiVSg69t9hWp6ElMFxJSWG/y86qPGqafinpXOT1Nge9pfW/FYVkPzf6cIk/L+1G17A4qwmaAbEIikntMXUeo2HxpNUq/3BcBatAgwbXxUBdO8V/aQs3/qVZF7tawIEq6PcXlcEJBctc+VZRELSbNKeNPOOQsamxKR0hkD41pajBa5jb4qYBvfQQsI42OkmRY16GEKopMDHJTKhEuKORCLU0ULn/fezA0s8cEwRYC1titqJAFzSM7En5vk+e+mGtxmssU36f0yxdw8EmYX74qGqTcw2LWBqpQi/Dh3ATmM2ZjHOBXCsZm29ayv1PZzUjB0gEyxT/uHn5BKu2kBrszjCqjbpSqLjgmR6+rkVRfztyAD/KiQavWsN1DQiuANveXY5kK3wejSYhN1GnkqYuwKHcZP1t9HIhfS0XQS47yiNTmJ302gUUSa3PVdKzI8Ug++g6/gBoXZH3kfOQnbd+WcUA2i1KYxY/iHF4OtqrRnGg6RB6OilfQXWJ8oT3CQcaPBy28n8r8vMY+Ba9LQre9V4ScOL2hLnJkbU4xc8hagPOnzT0J+4zYTXEOmn7JkjGhJueIdV/qrwV+5bpIQ+eVum3/3adT5pvxKF27Bi1DUt0Ho21GfCGMPUNgUyk95Cu6IoNu8IXiHtUDqiptgsTSikAgBciFZ38iNrSYo1nw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1nsEXsHnpvDh0eTMlqNY3SOskbUn9RbXLYU1bp9PvmL+ngRTdRH0YJYykNDqCzQlBHhvY3z6a13h41dxDQcgzMfVvjU7H5F+jqZiNf0TELG3bu/KWHst9cy8XyGTR9mC9nGhQ1iejJNfpaRB/A+7cbJ6m0C8WvL+xoDOoLj9InC5+c68hrAXsDrnrDuyMFNsJ/d5hkDuhatClxce8JiHUP3yO4kRggmOgLN25AHGQiROjHcxwTIgpqzZXjbv/y3Hh+9xNLpzJsAGyyZ/l3QCWay7G9ISvfxXmApwriujJtgL8d6Yp9EQhOLdyhRHMNqOy48SRihff78EfxxhZp5/g6mjmfH4iRqMk6nUvIdTEyLOVbAtS/5X9WZUf7AsZFIbV5w9DVqCkjSczvvL6aqbS9gfUZpNu9dPLTsx0kUtY6e1xg9dwVT5fzgbomKBiS1P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:46.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d927ac3a-da8a-428f-2b57-08df498bb36b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

The previous patch converted the ndo_fdb_add, ndo_fdb_del and ndo_fdb_get
callbacks to take their common arguments through struct ndo_fdb_parms. The
default implementations, ndo_dflt_fdb_add() and ndo_dflt_fdb_del(), are
called from those callbacks in several drivers (igb, ixgbe, qlcnic) and
from rtnl_fdb_add() and rtnl_fdb_del() as a fallback. These default
implementations have not been converted, and callers must unpack individual
arguments.

Convert the fallback functions to take the structure as well.

No functional change intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: Shahed Shaikh <shshaikh@marvell.com>
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
---
 drivers/net/ethernet/intel/igb/igb_main.c     |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  6 +--
 include/linux/rtnetlink.h                     |  9 +---
 net/core/rtnetlink.c                          | 42 +++++++++----------
 5 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 42b2fd3ed95c..b2efa0a1fa07 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2531,8 +2531,7 @@ static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-				parms->vid, parms->flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms);
 }
 
 #define IGB_MAX_MAC_HDR_LEN	127
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 26d1a7253cf3..e444ebfe77fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10617,8 +10617,7 @@ static int ixgbe_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-				parms->vid, parms->flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms);
 }
 
 /**
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 85017de2161b..6c48cdaf25c0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -373,8 +373,7 @@ static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	int err = -EOPNOTSUPP;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_del(ndm, tb, parms->dev, parms->addr,
-					parms->vid);
+		return ndo_dflt_fdb_del(ndm, tb, parms);
 
 	if ((adapter->flags & QLCNIC_ESWITCH_ENABLED) ||
 	    qlcnic_sriov_check(adapter)) {
@@ -399,8 +398,7 @@ static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	int err = 0;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
-					parms->vid, parms->flags);
+		return ndo_dflt_fdb_add(ndm, tb, parms);
 
 	if (!(adapter->flags & QLCNIC_ESWITCH_ENABLED) &&
 	    !qlcnic_sriov_check(adapter)) {
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a54ec40d095c..e963b43bce76 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -211,15 +211,10 @@ extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
 			     int *idx);
 extern int ndo_dflt_fdb_add(struct ndmsg *ndm,
 			    struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr,
-			    u16 vid,
-			    u16 flags);
+			    const struct ndo_fdb_parms *parms);
 extern int ndo_dflt_fdb_del(struct ndmsg *ndm,
 			    struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr,
-			    u16 vid);
+			    const struct ndo_fdb_parms *parms);
 
 extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev, u16 mode,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b1649f1cb33a..e7d683952838 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4749,9 +4749,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
  */
 int ndo_dflt_fdb_add(struct ndmsg *ndm,
 		     struct nlattr *tb[],
-		     struct net_device *dev,
-		     const unsigned char *addr, u16 vid,
-		     u16 flags)
+		     const struct ndo_fdb_parms *parms)
 {
 	int err = -EINVAL;
 
@@ -4759,27 +4757,28 @@ int ndo_dflt_fdb_add(struct ndmsg *ndm,
 	 * implement its own handler for this.
 	 */
 	if (ndm->ndm_state && !(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_info(dev, "default FDB implementation only supports local addresses\n");
+		netdev_info(parms->dev, "default FDB implementation only supports local addresses\n");
 		return err;
 	}
 
 	if (tb[NDA_FLAGS_EXT]) {
-		netdev_info(dev, "invalid flags given to default FDB implementation\n");
+		netdev_info(parms->dev, "invalid flags given to default FDB implementation\n");
 		return err;
 	}
 
-	if (vid) {
-		netdev_info(dev, "vlans aren't supported yet for dev_uc|mc_add()\n");
+	if (parms->vid) {
+		netdev_info(parms->dev, "vlans aren't supported yet for dev_uc|mc_add()\n");
 		return err;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_add_excl(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_add_excl(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_add_excl(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 
 	/* Only return duplicate errors if NLM_F_EXCL is set */
-	if (err == -EEXIST && !(flags & NLM_F_EXCL))
+	if (err == -EEXIST && !(parms->flags & NLM_F_EXCL))
 		err = 0;
 
 	return err;
@@ -4884,8 +4883,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = dev->netdev_ops->ndo_fdb_add(ndm, tb, &parms,
 							   &notified, extack);
 		else
-			err = ndo_dflt_fdb_add(ndm, tb, dev, addr, vid,
-					       nlh->nlmsg_flags);
+			err = ndo_dflt_fdb_add(ndm, tb, &parms);
 
 		if (!err && !notified) {
 			rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH,
@@ -4902,8 +4900,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
  */
 int ndo_dflt_fdb_del(struct ndmsg *ndm,
 		     struct nlattr *tb[],
-		     struct net_device *dev,
-		     const unsigned char *addr, u16 vid)
+		     const struct ndo_fdb_parms *parms)
 {
 	int err = -EINVAL;
 
@@ -4911,14 +4908,15 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
 	 * implement its own handler for this.
 	 */
 	if (!(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_info(dev, "default FDB implementation only supports local addresses\n");
+		netdev_info(parms->dev, "default FDB implementation only supports local addresses\n");
 		return err;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_del(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_del(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_del(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_del(parms->dev, parms->addr);
 
 	return err;
 }
@@ -5019,7 +5017,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 				err = ops->ndo_fdb_del(ndm, tb, &parms,
 						       &notified, extack);
 			else
-				err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
+				err = ndo_dflt_fdb_del(ndm, tb, &parms);
 		} else {
 			/* in case err was cleared by NTF_MASTER call */
 			err = -EOPNOTSUPP;
-- 
2.56.1

