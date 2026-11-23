Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456854;
	b=gOvmDP2uSonfsXOnc2aTovBc50jQfN2Nfb9u0mtmYOaoTHas5xHVFE6Sp2g9bL90o7V+
	 rdybIgg4JTqDoi6N5Syc/SMi9hoakDGNBP2ps2PFYVXgEkiUj7a1rM0C7tmAxrhoRigeY
	 /26BkWshM9sheAGsIsJL/j+xUDVv6VlkovmBuEdFc8YIbtpwC3ktoyUTFVhqoMezq3If9
	 +7tdN5ZCmmsp79vkLbav38mHTR8Dp/rNvG47pJ7iQY1SL/fP0pV1NNJ1ao1U60l5U+fi5
	 doO+IeMVZIZTS2QQqu9Kp305KXU9kRbtczcv09yu9Y4VBl5Cs5pykeOg3IspzZNFAkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456854;
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
	bh=U7lOpbi7NMR6t1+dZU+c11ap0PTl9W72mPN5yl9pG40=;
	b=POIkkXHQe3EylhqJ3PBSnns1qukxYRjeKqc934n+Np7KYuddxIZtofbx3dn6XqXRViwn
	 iUVkdeaJs0Qy6QR/orwe+MEHWtDNIS8Fj4jDIbtnmEAZtfrzPzpGCMCGD0Crf37eEvY8w
	 DqT54fzA0jT096VXWQHfCTzbVbnZQt/FEj/DXrxZzbkztMkZxi7VUnjpcnXoePmPKaqxx
	 jghy1bpWrEh2lG0z/oS+ulLpA4pdhBnzE55fjp9YSu/dgC0VPWNHVJKm+hWfdVp8CeiGq
	 Dj0VGJnK7eeMrFsgYDR5oiV1dxMrwCjVi/zXlA7lbrgCoWHwimwfWJRONvxP/fgXvAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WkHGhgpT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.59
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87219606A31A
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87219606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WkHGhgpT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Paz4My8svHaTtO8s5pwtMIKfu/A5bBDIP6tGIliwzWKa/9qCEzCacZuOjU7rYIHK8d6Y62a3jno+VURKnIfMKbgLJt9yUO3kd//oWcY/SfhsrYCD3EFOncOhMriBeB8mQ+9xPEaHvrCKtBn+WK9P2sr7ySVPNvbHJD9jeBMNMKaKVqJWgG8vQizj4TSC0penul/ilKpi+7/MU6YryQUvAF+HmY7GRl1M6x9p0j/R+TL1/YmToCEgV0aeSpw8vdGJvs2te4nqCvJDHlBI+xywxZ4Gug3wgPM/DR0eK8SpI7hIpBFV7LZQ2ZptX+xW8w82+eAeZIvjmjOI6rGbwdTSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7lOpbi7NMR6t1+dZU+c11ap0PTl9W72mPN5yl9pG40=;
 b=A1RHAL7vDeuWggZCjV2S7di/meg34q7YWNendJSxyglI/AGjfKQYw1mCDM6YMoWulxnI5msOQY5MhSE2LTlq3T5Gv6VSZjv5JXcBym8yGB9I73QHVnTK+dDt9EXz8BElSUAPXLPQm1UUzILfWbTd3VoGeiicGrfMc33MxNjO2xINRtsx9Ea6KaJnp3hFEWU43t8s+y9qH49JC8iMRyTnANdsyWUA84mgV+xqllI8WcHaEeqkojG7mWGTmxmuVotvKrNgwP5zzdI9l+mhBvRwQecO5omvTj93+N/fXQyawKswYcw+pHT5dmiTUA/XeNUgZMu7Aq/Yx7HZgPFcoqybsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7lOpbi7NMR6t1+dZU+c11ap0PTl9W72mPN5yl9pG40=;
 b=WkHGhgpTIVM00xfvD9ca1datlIeOT9pDoxyCukVYnE/JbbPMk6H9zEbhACud3xbR0USpn6Lof+FMZPXpJAAC3xN/tWk3Piv7A0WBSlGL8whMSVqaY0dGJgxRbxciD0SffhpSfkPe+MtYwIt6icgX9/58T3TrDS9R6PWZVEWVIgSrcyDJ5HuBY8fEb6h1/RgHkB/CXJWTyO++P0bcsuVXhud7goM2z9JkBO+bIwn8E6DxwVMmQoWRzrLUj3PtRUQP1ONtf7y2qZLwZeuckqS62nv9+KCftb4EanM0iz8IOkzrHhb34dwuYW6rGry8XthCGwg4azmoO3Hp8lYHgkebXQ==
Received: from PH8P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::34)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 23 Nov
 2026 18:00:44 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::52) by PH8P222CA0004.outlook.office365.com
 (2603:10b6:510:2d7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:00:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:18 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/13] net: Pass portid to ndo_fdb_get through the structure
Date: Mon, 23 Nov 2026 18:59:18 +0100
Message-ID: <6c4383956009b4e377cb563d2e84c853c260fbc8.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f50bee-6e6f-40c8-eb76-08df498bb202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|56012099006|261021123027099003|261028144727099003|261021121427099003|6133799003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ASxE2JYPunmM6wcMXH5IhGJBjslIiYN41oeXNbFWVBk/wW4BffP1h2q05a/C0XTUbPHibx0imqiHGCZUCEfFF056NA2kOmDqM6tVW5TW27GxTp9loANK4J6/E9yIDVrWidKRXjoovG1ms4YfYEgFAyuCR07ovk90CpeUPOEGXnO4BojdziwTIzLyyJPTZmE9qBnJ+N0W/emolrnpkPds+Gz4yXVGDpKql2nzfhbcEZmnvNShvqQMnMI90asfNbJDWZio0vPnfolWZ2I4KLnlDmiTAE+TJUvKZ+K+KJ7pjHnPv3a1J/4zHIdZAiWlnc5v1SicBpyjMwcaP/eWu6h53hs/MMbdVFDVHbkm+1R0ebHhZ94PboEFqdj8PGRh8OlAKPP1ejUnJI/85vtwl/C+DZNw7TuuImZYDiGopJJSVzGmEL+UcWN+uJNsU+PhEFuOZAjMwyRtw0cgyPqzBtV/iIaeqd4YGdSD5+5AJ3JDx0E8QS76BwooiJHyduTbq3nTwdi3tJT8SYycTYyhvouEoacbiikFP0M5VXU+yFPLrSmcJ1QO1VciVvzi+lWJlJCCJ/UuiTnNBDaiFA/quP6Rea40S4lKjDYXVqpyCrCn7lPYjdgKhqOAiKcFifyTYxXTBxGkXW69s5B8/UQfVWRKmciBIJ7DM96b8CCej0UBi4k+55gJiTPGSM+LbpNZnbJ5JjGGgt3mDuZdBtL8LyBXSw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(56012099006)(261021123027099003)(261028144727099003)(261021121427099003)(6133799003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JaRGgoe4mvvlpBQ9DBL3ESdH3vkDQCH1LD+Kihm82thci41EbsYdEF5bhmQPfIL5PIBqaPVzAuwct8x2LryLWJmD51JBi+4N9MkT9xt33358/mEZImcgoANSRyGOXa1XoXel0dTgtyfK0HlQ4/CRz2J7lbil+/5SqNlybfFVztp2Pwn1agXKqJ9wbZHd93nppYnGiuRNJ3VTMhAZLx8QkLRUvZF6p5t8wpz/K8QzvaICU/9Oyt3uKcna2n8lspkwvfRZyWgu9bbeM9c0Xp/AVVAJjgGTI15wGiSF803Qw7PA3mJeWwo8x7Te42OqyWKl/cQhC8O/2VapFon4yIBEYK3a7+FsscxziJwdo9jt27+x3IE7n+au46J6/SYQUHiF2gtR9o5kaik1oFSR6f4J8/hRq2oJLeu0cPMduEPn6PGCulf7iQ/dWlpHSbnz7RGy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:44.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f50bee-6e6f-40c8-eb76-08df498bb202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

So far, portid was passed as a separate argument to ndo_fdb_get. In
order to get the portid parameter to ndo_fdb_add and _del, we'll be
adding it to struct ndo_fdb_parms. That will make portid as an
explicit argument redundant.

Make the move from argument to structure member for ndo_fdb_get now as
a self-contained change. Proper support for ndo_fdb_add and _del will
be done next.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/linux/netdevice.h      | 4 +++-
 net/bridge/br_fdb.c            | 5 ++---
 net/bridge/br_private.h        | 2 +-
 net/core/rtnetlink.c           | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a9f6bdd52c12..725c6216d56c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1399,7 +1399,7 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 static int vxlan_fdb_get(struct sk_buff *skb,
 			 struct nlattr *tb[],
-			 const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
+			 const struct ndo_fdb_parms *parms, u32 seq,
 			 struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(parms->dev);
@@ -1424,7 +1424,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 		goto errout;
 	}
 
-	err = vxlan_fdb_info(skb, vxlan, f, portid, seq,
+	err = vxlan_fdb_info(skb, vxlan, f, parms->portid, seq,
 			     RTM_NEWNEIGH, 0, first_remote_rcu(f));
 errout:
 	rcu_read_unlock();
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0bfd36057d3a..233584013fc9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1093,12 +1093,14 @@ struct netdev_net_notifier {
  * @addr: MAC address of the FDB entry
  * @vid: VLAN ID of the FDB entry, 0 if none
  * @flags: netlink message flags (NLM_F_*) of the request
+ * @portid: netlink port ID of the requester
  */
 struct ndo_fdb_parms {
 	struct net_device	*dev;
 	const unsigned char	*addr;
 	u16			vid;
 	u16			flags;
+	u32			portid;
 };
 
 /*
@@ -1645,7 +1647,7 @@ struct net_device_ops {
 	int			(*ndo_fdb_get)(struct sk_buff *skb,
 					       struct nlattr *tb[],
 					       const struct ndo_fdb_parms *parms,
-					       u32 portid, u32 seq,
+					       u32 seq,
 					       struct netlink_ext_ack *extack);
 	int			(*ndo_mdb_add)(struct net_device *dev,
 					       struct nlattr *tb[],
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 8ed7af3e410d..9e2fdcc5ca9b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1146,7 +1146,7 @@ int br_fdb_dump(struct sk_buff *skb,
 
 int br_fdb_get(struct sk_buff *skb,
 	       struct nlattr *tb[],
-	       const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
+	       const struct ndo_fdb_parms *parms, u32 seq,
 	       struct netlink_ext_ack *extack)
 {
 	struct net_bridge *br = netdev_priv(parms->dev);
@@ -1161,8 +1161,7 @@ int br_fdb_get(struct sk_buff *skb,
 		goto errout;
 	}
 
-	err = fdb_fill_info(skb, br, f, portid, seq,
-			    RTM_NEWNEIGH, 0);
+	err = fdb_fill_info(skb, br, f, parms->portid, seq, RTM_NEWNEIGH, 0);
 errout:
 	rcu_read_unlock();
 	return err;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0062bbe94d1c..f4eaaff816b7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1025,7 +1025,7 @@ int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[],
 int br_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		struct net_device *dev, struct net_device *fdev, int *idx);
 int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[],
-	       const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
+	       const struct ndo_fdb_parms *parms, u32 seq,
 	       struct netlink_ext_ack *extack);
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e7d683952838..f31549923848 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5420,10 +5420,10 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		.dev = dev,
 		.addr = addr,
 		.vid = vid,
+		.portid = NETLINK_CB(in_skb).portid,
 	};
 
-	err = ops->ndo_fdb_get(skb, tb, &parms, NETLINK_CB(in_skb).portid,
-			       nlh->nlmsg_seq, extack);
+	err = ops->ndo_fdb_get(skb, tb, &parms, nlh->nlmsg_seq, extack);
 	if (err)
 		goto out;
 
-- 
2.56.1

