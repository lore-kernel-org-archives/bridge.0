Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456874;
	b=yZg4D/zPwT4s5XolZ5OgW4Nh5OhbHqmd10GG/r5nAkg1H1hcq60tBzGEg9SqHwfCecc/
	 sKvWLhBFJeaBavjkG8sPpZ+b6K3LEEIIn6mdwMV5vMcVzJ2kPqowJ+tM23L5aBZOUxpof
	 kSEK32w3YFitqUPeX9mLZQRWcvyWIsCoIbv+P/66KMojZ2FWYtc3rSjeFOGgBxea2BWAS
	 3rwYWoG/9bOckgnGrYvW24w+GLlQsywi63vtUmyo6OwDSAHWugspJp4iZjRdBxMxC81D9
	 BuEQfdMGf8LyhJlHd51pp28v1t/LKfbNkbALxNx3G2aMzqR2xW7ppL5XfnGsjIQT4hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456874;
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
	bh=VQbZT8a8kvEY4lrAcweXgfJ02ZgPZipsV5TeKzKHC54=;
	b=ONYJcd4LKKIVh+YKCFliPNY7JHcNmQ50a2KbZ3683+RQvImZBNYn+Sw6xt01u7IlOL2r
	 ZRYRQWaomxAnzoLertJOlHfMb06H9XpH+dhDC2Sszc8ka/ZBF9mA/eFjUIXQ0nVfWNu/0
	 TBDVBq0cdldD9KdN8AsRF+ZFyNeaPK2xakJkoSeRE1enMcuGRzFVnWZ0rloD88G3kIAN/
	 cvVwBrlo1lGFEsvpJsJRVQJ1vXKIKlegX6lck17d00WMpAcYYGdMGJGhu+vHTVdAOIHK1
	 9Wwp1qjj51igKvvu5zEp4Yk2W3Bak7uYG8vlJhnkDDqZTA3CWPKxJAzFtI8U+QXLNnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J1GUIpF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.44
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E4606A31E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D3E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J1GUIpF7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKCVxh2Idsao7soDyXlTHPgNHpba0WdlcDwsJYyM2wkBOZ87mLaAJiqAJcdchWyKgr6fFGDa+2RbMteO/x+rETZkiKkMLM7tox6oqKfc+DsVSv9kEr2ivRniA0FX0RGCeFGm4QeD1BSRYOnFHi63BqaxuV39K/JGYFAOyLqdbbfXPgiJLrOG96hNjOFEE7DIYf14+OQTjphsJPYMpt2x6gPHQqUEpdMZy3Lf3qEf8H5H4UyvDqBBITD7emtaSUBfk3fLoE6OTcAtwyx1ujMooERqqnuqYTRekmaJLrgXIq+7gtB8riYnmnUpOrmtPq4JWgYYttkgBhSpO0LtJYj4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQbZT8a8kvEY4lrAcweXgfJ02ZgPZipsV5TeKzKHC54=;
 b=ZyNQAL+qmCCKRPYR8dGzsuIIiCIjJWLy0NmK5eW535+UxCFQ5RAm/Avot1CuFxiFMOZUZ+6TgCF49AZpDkSQWC/l08tQE63b1Q3Ng38aJKus9wUZghb/0DR3DHWGipB/M6lRmPgg15dX4ELMRaqTv30dZXyFdfYbg3sgbK7lSImDpkmqksOiCW3CewWUjs8SY2l4+sTvruBWge5+M43JCUEFM4r9i+E9IGLzRfZClHumq0cfbIvNYwJHgYVQTt83Vj7Wk15U5NKO04wovMXX0ZUh+HkiDO4vRxJSKD/sM2mivlkPxu6OP9P/3ENWz8W9azIXiu8XHM+GggSHOPjZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQbZT8a8kvEY4lrAcweXgfJ02ZgPZipsV5TeKzKHC54=;
 b=J1GUIpF78oYuGfzUvRpf8xJ6SN4D/U4283lKnxNsNMi97njTzrR9T5Ggvs+jKpNIeeMBTUZ6oozWJn5ymlkOh8nSnDoVz+ijfx670Zy3XVsrZzDhQmrkjlEW8H0xBa2149J4l0Ws0Q3+QlwSbSUFmtLeETj/GpUBbYq5nIPTxXbIyzvLkYq9NI7O03h+yniwBcAWMyIM/wtLqJdIqBC9LFZqCEp6fZ43RoQMpgU8H6mMzuTfMSWGMempcAhSodZdCWopfXlFrr4B4KRFor0ncMmlt0Nirus+F6E0A6oqgHKzVUdBAdUGbl2X5m07/+ROsFOic1hkcJDoeG3XZVVUdw==
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 18:01:09 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::4c) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:44 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:39 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/13] net: rtnetlink: Report port ID in bulk FDB delete notifications
Date: Mon, 23 Nov 2026 18:59:23 +0100
Message-ID: <4651dd160bff7e73492603dc985a2926495c822f.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 44acfb6b-4550-4685-5084-08df498bc0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	KnMmszwYBnB67SvP4eUX08eCGUEO05Q7gCSESF91mC901XIzlNshivbyH90wj4mOvfwwT4FQ7XklVpQiQSKoawYXY2VgF5jyXei6p5DZ5o+wqt2hShxBFW7h1wPtVgaNNmmrBIeXOAsXlRWZRO632Oh+ssgEVv4qSSFDGFsOtx10SyFk/ZcAG6B3CrCKPQzuBBpDpdaWB7aFNDiwIHZZeiqF31qDs736AknhtzlueZ2nm/Sx9yyYM7R8K4cLAJ2Cf34UtI5mjz/6FXEIeaBIjNnSZdOTPUlMlzgItsnqdCeRRSuWPUv3W7TQ8CrwNIKIkN6yqHVqgFtRDOvKzpUYa9ahHnoCwSxivIqbDAKOvn9VS2iWQRWqi+RkZTbdTzEiDAurxBr3LnoMvXrMkjfkbQXHpK8TcGrwYQx7uPBjT/NYODhuK6KMZfNdN3fhtbDVPTrqFd+97WwGIvKaAZgicXHjHlAJGjbx/1bYX+MKlKFXFN5BzksoFOt5Iv/jIFVgAtQwNsXwN/L45sOa7e3+PlG5yok8hh8Y1xZDsN4N3w3JIHPilWVfq8NwiFKV5QhL8KGrNJEl4Es2q+QRu6p7fOG2Xl22kRYiCdCrYX/fJViBj1Koapg7i4iNv26lnIcd5b12OgrRuESMuLx4+D9ZsKmdl2dXJ08YYrk2Mu7C5GUy+XoqiikG/UAv5IrMz5rSQDzBeyqYR1qJAKhh4HdvQw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hdHA9OIFL2l8MJLAZNpoy+pwB+0nMDF2xI4aHD6uIutx7FGrfVWboOJhwsKpdjnfhBx6lF8Y3ky/RA8E6uW64nOAoODA2CsGDnUFqsknTmOHjjsdE3yHiBZNK9sDDQ0WXJBKL1pDwyxvrfVOdGhcXeRVl/zylCbz5pTLUaIvEdPfZvimZwJTAMSQtOoJXj2yn6tM8kLX+6Y9DtlMcwnxWpjnXwS/dXWlXVrsFd+KBXmRX/nfebGMqTK4iY+8WlRipercUJ/oLhNCcYN72wlN97NcWWkNa3oaLumzKjnDzIyrodYJBDCSvGA7KV2qL84DaMwvUbV1UksTRFM93KGOJlvLWlKavoqOELFUFfL5DJ/5uLdD1taBgco9x1QvOKp77/Db8qYHLynGYcWjXieS1CG3/zA/gpkZIPZ3zvHd5QDracDhYpCvPlnLLZqVGC76
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:09.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44acfb6b-4550-4685-5084-08df498bc0a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

The previous patch made the notifications resulting from adding, replacing
and deleting bridge and VXLAN FDB entries carry the port ID of the
requester in nlmsg_pid. Bulk deletion (flush) does not go through
ndo_fdb_del, and thus does not take struct ndo_fdb_parms, but goes through
ndo_fdb_del_bulk instead, and still reports zero.

Add a port ID argument to ndo_fdb_del_bulk, and pass the port ID of the
requester from rtnl_fdb_del(). The bridge and VXLAN implementations pass it
on to the flush helpers, which already know how to use it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/linux/netdevice.h      | 3 ++-
 net/bridge/br_fdb.c            | 4 ++--
 net/bridge/br_private.h        | 2 +-
 net/core/rtnetlink.c           | 6 ++++--
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a010eb8f7f28..c300e0bd9b57 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3208,7 +3208,7 @@ static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 					   NTF_ROUTER)
 
 static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
-				 struct netlink_ext_ack *extack)
+				 u32 portid, struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb_flush_desc desc = {};
@@ -3266,7 +3266,7 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		desc.dst_ip = ip;
 	}
 
-	vxlan_flush(vxlan, &desc, 0);
+	vxlan_flush(vxlan, &desc, portid);
 
 	return 0;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 233584013fc9..b2846b586a7f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1358,7 +1358,7 @@ struct ndo_fdb_parms {
  *	Callee shall set *notified to true if it sent any appropriate
  *	notification(s). Otherwise core will send a generic one.
  * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
- *			   struct netlink_ext_ack *extack);
+ *			   u32 portid, struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
  *		       struct net_device *dev, struct net_device *filter_dev,
  *		       int *idx)
@@ -1638,6 +1638,7 @@ struct net_device_ops {
 					       struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_del_bulk)(struct nlmsghdr *nlh,
 						    struct net_device *dev,
+						    u32 portid,
 						    struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_dump)(struct sk_buff *skb,
 						struct netlink_callback *cb,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 3712e6db90f0..6b1c067974ff 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -797,7 +797,7 @@ static const struct nla_policy br_fdb_del_bulk_policy[NDA_MAX + 1] = {
 };
 
 int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
-		       struct netlink_ext_ack *extack)
+		       u32 portid, struct netlink_ext_ack *extack)
 {
 	struct net_bridge_fdb_flush_desc desc = {};
 	struct ndmsg *ndm = nlmsg_data(nlh);
@@ -864,7 +864,7 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
 
-	br_fdb_flush(br, &desc, 0);
+	br_fdb_flush(br, &desc, portid);
 
 	return 0;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 67e3288b1e40..83f2b7728947 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1018,7 +1018,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  const struct ndo_fdb_parms *parms, bool *notified,
 		  struct netlink_ext_ack *extack);
 int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
-		       struct netlink_ext_ack *extack);
+		       u32 portid, struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[],
 	       const struct ndo_fdb_parms *parms, bool *notified,
 	       struct netlink_ext_ack *extack);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e0d411c251aa..e1607a3232c7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5001,7 +5001,8 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 						       &notified, extack);
 		} else {
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, portid,
+							    extack);
 		}
 
 		if (err)
@@ -5025,7 +5026,8 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* in case err was cleared by NTF_MASTER call */
 			err = -EOPNOTSUPP;
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, portid,
+							    extack);
 		}
 
 		if (!err) {
-- 
2.56.1

