Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456825;
	b=rDIxtc2qX8SWvgN0nPSzmX2DlV4CwykBwreJQaX9zI08UYfo9zSX5U9T1U16RHue1XMU
	 Fe3vvJLZ7eQDgdt76mBgmPwTdAzsUOe1KGcxWdGKhrQ/s4SUo9x3bRUka/gCHxfWwFmog
	 uozHK0DfUc13UduscD9FyepVW04qZ6A+CH9rMNao6FqGUJb8xG5XKthoUyOBG/9J0JbgH
	 K95ge8tFJvRxNIbKU8cZznq4lcQGkjQ++va7Oy4izdx5pXkLAmYCTr4DR98E7VvQsBF8s
	 aFlugnTZqO70sHbCnEKQED3hg1NiCM7QLP3Rck4AxCVI7cplQ3AUN4KVcxom3OjZAmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456825;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nb/FGitDKzpAAEQ4y+iINi4RcWIkczm0245abfqpbBg=;
	b=eLfwPdXoRX56Z7NtmDvJCBeIeNmvQ2rMzbkzJXxUpCY0Nw9pOye6STYADOE83hQSCXBT
	 0JPofmHsad87QUoCdeuxyznf6WZnI0Z/LcfQOh+w1eMlrmzVzpMgWIy5gPJyKxUYKepuF
	 t1KW8NlTSecKMR+9u1CUSGZlM7ftBUd0VmnFH9IsY+l9680tDboO2jpa3aZB86DybvOb6
	 4DBtuhqRg9ngl+iBqaYSanz4A/d01LEiKYtiauwvHIfrZb/PdhaVTrQdsgWc4Oz1Mw5ld
	 5/KKeY9p39+2HP91v/Vp/FhuwFqBkTLjLNFfkwof/OWugniN1hlliE9AzJlpw4LwIXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CzfpLtwf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F5606A31A
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D9F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CzfpLtwf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef7eo+yp2tPbe7qr9zKDW1UIqC7d4SCzDgoq1xqunHf/Od2yVn6X17XWrf69fggDUAVWesTbgLcC1ZAwPuWJ4X9iHgyea3MhUWVgfoPzurpPHGvjbXOWLmVp2gBwLYos31cEj5pKSSJgMcBLWZ+BDJgTXBC4tEv6FsIhCcH6j5niT9nJg6Z9cEWs17dfQMo3qdBDn95BXDqGa17XyjJN9zsXTdhvSQ9JBg6cwnhSOH0XpB7vpNin+W250bEJqG+jdkGa01pSjYyql6/StBX7w9G0OyiSII4kkhA85ZIo4BziFMTeZlrUxXzx7mNcrbbiIiS2Efvk18zGA1hiBfoUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb/FGitDKzpAAEQ4y+iINi4RcWIkczm0245abfqpbBg=;
 b=raQ1LFuRDcK2NlgnOQ9V2QMLdTbzhQx54yUEAvqa/J/0vabh7+i9ZutXI6J2Eart+JS4I+SzOv3D7/Gofbzym3bZWfLytQenFe8hwHUIMqbJD9Nzt+OqhT4lmlZqxFLXz5GbcuzyYySJK38P3Exlpdjm2WvDclPPPoVYoLBX0J02TlAifaZJGyNqxOn+jhvhQxsmjYzwWkuyQ4jgcXf6OntScQ4YXX9aEWmKZYA1KtMJWbu0f+UnX7O56FaZxNsU3uIauEXvFmN3kd21hqjJgHXn6v9nUnr+9S3bEbSxUrcTBnDV4xG6ep2pAGWLYQZaoyXCYKAbbbnysTd32ngz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb/FGitDKzpAAEQ4y+iINi4RcWIkczm0245abfqpbBg=;
 b=CzfpLtwfdRHj1f62NQyThkz2HTlxRDRD6PIgtW+8cv5vbuvBSVix7VRlIFNYPrZ0JAy4L2tLmvLTh0Dn6vj4bajOJ7YisE7kXGtFD6toazJOac+PoJqobEBUvLL07rt0uV/nuPVzsJGV322Nz+KNhXKN95rIUsgJHzzqJKURoB+E+lIHPOEYlrtGkZ49auvbZDJkt2M88SiEVqcHCEFiJRyVpgKHlW+gyT9hH50HqaCDjEOMigIjsX40PcJ4UEc3tnWvQ6V0o/ymEbeKZs0I+K0UzEBPXmN0VborxhGipCYm5zHhlDyRutI8q3NvmnK0tsu/PTDP00US/w+GLoiK+Q==
Received: from PH8P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::17)
 by SA3PR12MB196577.namprd12.prod.outlook.com (2603:10b6:806:533::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:00:21 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::8c) by PH8P222CA0023.outlook.office365.com
 (2603:10b6:510:2d7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:00:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 09:59:57 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 09:59:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/13] net: Report requester's port ID in FDB notifications
Date: Mon, 23 Nov 2026 18:59:15 +0100
Message-ID: <cover.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: c8be692d-b830-46f1-762d-08df498ba3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|3023799007|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261021123027099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zcznk0+trU+I2e1ia/XcyQVVW3soCoQQYup2k5yAZLKhxsNPvQIddz0xhTP87owappsAjgpPWig/lf4ibjeRyc7mKb6UNv1gj33Ynr+BDeFvr4zStcSAjgunrYObGbLWf51ehgGxggV4peeif4nRPhrQnEruXGaBibJSLTAotyveIQ3L2yDuqg3rqOdF5+2MrWpajOP+pxOfxLOggUQt0s9XDdA9ZI31A+x6KiV9sKF/9kIQ+BjrZkf1y7LDOaunHtfsXvKVyTD4rddUG+nCXUVEfM64UUPmHn9+1VPh7SEOS4H7Ena1qyLfRodDWBNQEJfnGQXQ4MsggTLfOuVCN5geJT3qUfhr0/7KaR6Bi+cg/kAZmkXsRTtVdfyE7z2EGHNiZZn6Xq5M/1gCtsrGjxHs8Ih3JWUrhKf68GhH+42BMZWFOZRkdJ2Mbm6Yuk9Rgc88XwBLkyGGp+igPsYSF1eRmrZt7yeir0X51nQE1VeBkEVS6arImnLBeuTzJnkbLAY6rCqWfoZq2N/2Fky5DOMU/+2mz+2m53hAr9djaz7Fe+PzlzLRPfU7vRJUshH6Bo+7Wj1TAQO2VX+q+zR2nuothjIbBCfJZR2PMDjvY1K8neAPbKqfWJewK6bP79Sz6v5Bbg+O76/9j2IXY4T8Tt/wC4bdLK21hPFlX27AhyXMm5u137NImDmt+idYJHTYIWqSHDg2Vc3HZ4gXbVZsEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261021123027099003)(261021135927099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Fn2TvgDcX91hjdWdv0H07uQkcPuXr5vBddZXmJbbqAahcWobaX0Un9TjaCpDgH9/4G0/3Ltixldlw5NHc8pKL8Y6/1629jwippwWgJc+Qi0S53I2UU2+oHPfx5hS1ohJd+TJb7SN3XJ6ZEJ8N7W8G/Jv9Z+iJYrYRdoOexD6rxGgWPPXJd1TL+yICPsNLPNJRiTOnAQEkrmdQZYPszmxbnkD3MBbqvm74A699HKXylnQ3jDZvE/0jm/lMgRHf5EK0wq6FxuQ0Qt6Dp2T2PmtU3xgI7XDOLiMufG681WiN/zxwfe0DEqqDue+A2DoLt9HMdNxSHN8AbtLy/fMleGU6HDPMLpVby36i0GWY4IWueLS+z9uxL2dSuAfu+/LdbaS35tSpF7KgDsqSyEavADbhBt/gSpbt71Ov3E5O19bmJeDd0Zgzg5AlQHZryY6wKS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:20.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8be692d-b830-46f1-762d-08df498ba3b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

Every netlink message carries a port ID in the nlmsg_pid header field. The
port ID identifies a netlink socket. In a request it is the port ID of the
socket that sent it. When a change that results from a request is
announced to the multicast listeners, the kernel puts the port ID of the
requester in nlmsg_pid of the notification. For changes that the kernel
initiates by itself, such as aging, nlmsg_pid is zero.

This is used by applications that both configure the kernel and listen to
notifications from it. By comparing nlmsg_pid to the port ID of their own
socket, they can tell their own changes apart from those made by someone
else, and ignore the former. Commit 7b8f7a402d4c ("neighbour: fix nlmsg_pid
in notifications") fixed this for IP neighbours, citing quagga as one such
application. Routes and nexthops report the port ID as well.

For FDB entries, the notifications (RTM_NEWNEIGH and RTM_DELNEIGH with the
AF_BRIDGE family) always carry zero, whoever caused them, so applications
that manage FDB cannot do this sort of filtering. Hence this patchset.

The patchset goes through the following steps:

- FDB notifications are generated in two places. The bridge and VXLAN
  drivers send their own from ndo_fdb_add, _del and _del_bulk, but these
  NDOs are not given the port ID of the requester. For other drivers that
  implement ndo_fdb_add / _del, the rtnetlink core sends a default
  notification on their behalf. It has the port ID at hand, but does not
  pass it on.

  The obvious way to get the port ID to the bridge and VXLAN is to add it
  to the NDO prototypes. But ndo_fdb_add and _del already carry many
  arguments, and one more would further complicate the already unwieldy
  prototypes, as well as require adjustments in every driver. Instead, in
  patch #1, convert the prototypes of ndo_fdb_add, _del and _get to take a
  new struct ndo_fdb_parms. ndo_fdb_get already has the port ID, but it
  shares most of its arguments with the other two, so it makes sense to
  treat them alike.

  A dedicated structure has the advantage that both callers and callees
  can refer to individual arguments by name instead of by position. Any
  future additions boil down to a new field in the structure.

  In patch #2, have ndo_dflt_fdb_add and ndo_dflt_fdb_del take the
  structure as well. That simplifies the drivers that use the helper, which
  can now just pass the structure pointer right through.

  In patch #3, move the port ID of ndo_fdb_get from an argument into the
  structure and adjust drivers.

- Now that the structure argument is available to the bridge driver, make
  use of the fact in patch #4. Instead of unpacking the structure fields
  and passing them on one by one, propagate the structure itself further
  into the driver.

  Then in patch #5, propagate the port ID all the way to where bridge
  notifications are generated.

  It is tempting to somehow use the parms structure more extensively in
  VXLAN as well, but VXLAN has its own large set of protocol-specific
  parameters. Passing the structure as such is not going to help that much.
  It looks like VXLAN would ideally need its own VXLAN-specific parms
  structure. But since the complexity damage here is limited to VXLAN,
  leave the status quo and in patch #6, just add the new parameter. The
  patchset is large enough as it is.

- Patch #7 is where the port ID in struct ndo_fdb_parms is initialized from
  the request. With that, notifications that the bridge and VXLAN send as a
  result of adding, replacing and deleting an entry carry the port ID.
  Notifications that are not a result of a request still carry zero.

  Patch #8 then adds the port ID argument to ndo_fdb_del_bulk, which does
  not use the newly-introduced parms structure, and has the bridge and
  VXLAN drivers use the now-available port ID for notifications.

  Finally, patch #9 converts the rtnetlink fallback helper, so that the
  notifications it sends on behalf of drivers that do not emit their own
  carry the port ID as well.

- Patches #10 to #13 add a selftest. Patches #10 to #12 extend the rt-neigh
  spec with attributes needed to build FDB delete requests, add the
  NLM_F_BULK flag to the YNL Python library and add an RtnlNeighFamily
  wrapper to the selftest library. Patch #13 then adds the test itself. The
  test is written in Python with YNL, because the usual shell tools cannot
  show nlmsg_pid.

Petr Machata (13):
  net: Introduce struct ndo_fdb_parms
  net: Pass struct ndo_fdb_parms to ndo_dflt_fdb_{add, del}()
  net: Pass portid to ndo_fdb_get through the structure
  net: bridge: Pass struct ndo_fdb_parms a bit further
  net: bridge: Pass portid through FDB notifications
  net: vxlan: Pass portid through FDB notifications
  net: rtnetlink: Report port ID in bridge and VXLAN FDB notifications
  net: rtnetlink: Report port ID in bulk FDB delete notifications
  net: rtnetlink: Report port ID in fallback FDB notifications
  netlink: specs: rt-neigh: Extend the delneigh request attributes
  tools: ynl: Add NLM_F_BULK
  selftests: net: lib: py: Add RtnlNeighFamily
  selftests: net: Add a test for port ID in FDB notifications

 Documentation/netlink/specs/rt-neigh.yaml     |   4 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  29 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  43 ++-
 drivers/net/ethernet/intel/igb/igb_main.c     |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  14 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  19 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  38 ++-
 drivers/net/macvlan.c                         |  33 +-
 drivers/net/vxlan/vxlan_core.c                | 118 +++----
 drivers/net/vxlan/vxlan_private.h             |   5 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |   6 +-
 include/linux/netdevice.h                     |  43 ++-
 include/linux/rtnetlink.h                     |   9 +-
 net/bridge/br.c                               |   2 +-
 net/bridge/br_fdb.c                           | 177 ++++++-----
 net/bridge/br_netlink.c                       |   4 +-
 net/bridge/br_private.h                       |  20 +-
 net/bridge/br_sysfs_br.c                      |   2 +-
 net/core/rtnetlink.c                          |  98 +++---
 tools/net/ynl/pyynl/lib/ynl.py                |   2 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../selftests/net/fdb_notify_portid.py        | 297 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   6 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  10 +-
 25 files changed, 669 insertions(+), 326 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify_portid.py

-- 
2.56.1

