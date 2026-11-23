Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456883;
	b=1nXYIuwjop3I9Zo6mNRj+cl2GSVwDNH5r1U44i/NV5L5FNvNW07BIWPxUWMmVcXeQHlN
	 YOqlA5ER4orWTpajpnYKXbEiazUuLAQNIl/9bvua+cM2EL3IAyL67LlBkLv4iJG5rJN3c
	 nRGMojtxp4JTSVLvEhwW6xju2+EC4mjhHKLhkg1eQ0Q6/gZSyIKC+v/M9cJ67/veLHVEP
	 qgfJCLHUz7b+5afcay8iUGIVjmj7IvVt4zbOUcFPQOeTMU8fg4mlVj3xbh2nHon4aSVJi
	 ph49F3TO4/8YAl9lG6i5Ns1CAl+FxCNTioulyD6ymkqCfG0D7V2+nsaZnW5HQ6Lb3QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456883;
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
	bh=tQXFUVzcSVlqKE+14OLazdcRgpNdV4QbIs3brNIZMIo=;
	b=5Od9UmQ0WQv73CnLW8Yy0HMtIdAn7bzX1eVVfUyr0Siv4QtOMboc6kdSb58OlT4rKCPK
	 XLaqSiigUQaVxVBhoA5fbfL5z0BUvbbzZS7ngMrsWW0R2bKndvhamfkfLALuoNKQny2wX
	 3U4it/NE4DDjZmXHEu6TK8H6fozQKmS7M/E727QnOia/khw9U/RizJ2nX/ZqUvV+T42zu
	 fdSV8UQYA2OX8omJJ7QE/pAY6LzgVLiEyu0ceZC+NpJUug7vZSa4tt6CUxJRWWMonOSfj
	 cLIkPOvpesRKmMRzKEdB7A/OIM7iKrvDvgKpiMSn+codFTs+OpXIxudaFSpVYAcsJ2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iIJjfrF2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.53
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB4606A32D
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36CB4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iIJjfrF2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVW9MXtVHZxSNNeyVcBep9Z2NsFSqgO2iktqKXtLlDkb5vN9JB6zwxzHyL+MGGj2V3wle0vYOx2w3zMr4F08XElo0Mq2zJZHkeNTpgkAcxYBguodYQFvZXmNXyxafIoU3jFoohO41z46dIGfmsvPug+2AHCAOLdk/4guDMtV2/SUHQBzaY79lmxq/OpoMFHE7+Yau6CA0/EtdJ8wiuK35JNOKDD/5jtl2taJsi3ccP8K7Wr7nuUj1tDPZ8Hyt3JXiVVNAKLZWnXq98iPYzSQltJUgtWkGQpupFl4r+76lalCFOM4Bod65LUlkBCmlg32zsVVwoFDjK0qnjgL2WwNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQXFUVzcSVlqKE+14OLazdcRgpNdV4QbIs3brNIZMIo=;
 b=IHqbu55g1m21Jd2p1FDSpW7/EMYEy10snjEMaoYSHTcPly+SdC3xIPLDVmDI4/honLWRIyz99tNxgQaYvp/K74iZEODkRZ02sKPvKlIPZXJ6W8v+s3uMnXWLMWlKSzPyDjnaHFg7cO1LJjDgKp1J1GtUiNvNRYSqnZDKAm7f677UZM0UdbKtJA2dodqta80a32NqcNRZ4Nyo2al/k1c7LRFORTe1uu0pF2W/yxbQMaj/yd3lD30BT4UNLbo+Fs4NFRs9YDbnRv16Pa5qMhy+kfsqtVEr41A2rdccJ15QbolQ+fzSY2W2dE94oh6muMDQGB+J3HvJlv7f40WW4pSqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQXFUVzcSVlqKE+14OLazdcRgpNdV4QbIs3brNIZMIo=;
 b=iIJjfrF2juFl2OFiZetnqFg1lFJrQMbcvLnaXm/YdAzOlGSZLKcC54oJoh7xTYGAOVwXTh/7dJWA+3swHWC4Ss8c4rbF0yEBsnP8r8lvszwmvi/+Ku9Dtj6SWCaFwqGpoUURq83kcITehbI68riAK42vZLwtewBpP7mZZWxAIlb2P0H+XIgQaCBFO5lgbQj4oSt92NHfbTCHid24RG+hghDL6znh7zjI5VtyeIzkmpS2TDHT+XEcaNxQLY+U8vCBFrJ2ns6A+ViUAj4QcTzWQXSKgqRUGYOKtMKaQEAhKv+nQBwCE4BdkRkZp5QNSm3MtolcqdKSbyElO1S45UyG0w==
Received: from PH7P220CA0177.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::25)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 23 Nov
 2026 18:01:01 +0000
Received: from MW2PEPF00014674.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::3b) by PH7P220CA0177.outlook.office365.com
 (2603:10b6:510:33b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014674.mail.protection.outlook.com (10.167.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:28 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:23 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/13] net: bridge: Pass portid through FDB notifications
Date: Mon, 23 Nov 2026 18:59:20 +0100
Message-ID: <7c96de1b0dc28ff22623133a93dc54999dbec8a7.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014674:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cadbbc-5e09-4bb3-649f-08df498bbb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261022105027099003|261026140227099003|11063799006|261028144727099003|56012099006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022075727099003|261102123227099003|18002099003|261026121527099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XSRpY+h8c8nb9lBOOCcI68Ln0FMw9L35BW/ekRKKRaCdkyJzfkpbdtoCJzTGrO6aXyW6AiZIwFfdD3MmliIvUTGMzg5wJfLsLxYFqY4J7Zz748X8gv8gOUqrO9wn8gIxdafgc3PTfAeNBS04umFScy41nEM5cmJzZIeg3h5juuTP6HE153gAvV6vQlRawWSBbDcdbCXtOjmGkaxoAO6s98/u8OMRT9/QhpdrTZfbiZdagRFDVKTxgxPgpHQCmg+fY3WS9bS0pfOnZEYkEd87O9Rqld0eLCRiqlx5zqT76syw/0KyezXxLOuMMxrQKn3Z6GTFWBxgo/QcBrzoM9WXPmtE5aqk1RrX29IUqXqIf46a8YmXvcnxJX4j7a3rjbt1U7/SvOdkRPiSFNI45zrNIwj9XlBecPdKaZ1qcMAfYN6g2JNF05dv4FwgGHAJ6/AhVkxcxKgi3LT90DqWCFbk9jSwDXzmW7i8gjc24gdSS9oZx9opTK8G7VBZE7ILFPu6DKYQcRr06wt7f59up9CiFr95NcQ7MUXydlz8J8RtBwnEz4n2+wlALogyLmsUXelctq89bWsbySoJHpFozpBo9d8LpyEG7pRHM+EoRcmYXxngv9i7y6zbWxBpA4LDU8R1w/XJ5RldalYmWdiVtqgW/kpRjzAby1op9YfYSkvVl/CHuKD/+EqdvMYRFYOpNPFB5OIkNgcUDvtuBmef8pRxHA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261022105027099003)(261026140227099003)(11063799006)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261102123227099003)(18002099003)(261026121527099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Aa55YeNFV8KzjKK3nV1ueZmrlzDuiSfgmR5OI5QdWMS/XSRwXUte1fUnKRXVLDxyACUV3x6aRF+l5OtzLaJvn/isBXJSpmVcwBHc9lk32Lxn6ROe2DantwMVXy9A5s+HbpRygCDuxEAL6+MOtfY7oEelQaAFTHVxxJTl5CuSKgl1kIpdntwHhjJ+BIVb5FYIhpm+elSh7YazUB4x+12fePWA/rRaYkMSQnzEoM9YFTu2jlOfex7aST+9eDwI/Nj90w+a2Xt7Sd1SMGDUSaDvoqnF/M3/Vrt6ZP68yrxR4U/oXDIM/Rgr/K3/LkRtElayf0SO/d32TUIGrs6W3N41M3lx47vvL54ODcR+y+NRe7J8wCR1/yW0fvy60jHELDeoQvLM3+/wY6WdB/b/RisAE9cLMroSbgYMNoqoommZe38ClkO3o38/5ypQLOrmc2Aa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:59.8925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cadbbc-5e09-4bb3-649f-08df498bbb35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014674.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

Add a portid argument to fdb_notify(), fdb_delete(), br_fdb_flush(),
fdb_delete_by_addr_and_port(), __br_fdb_delete() and
br_fdb_external_learn_add(), and use it for the issued RTM_NEWNEIGH /
RTM_DELNEIGH notifications.

Rename br_fdb_update() to __br_fdb_update() and add the portid argument to
that, converting internal callers. br_fdb_update() then becomes a thin
wrapper that just passes zero for portid and retains the prototype for
external callers.

br_fdb_add() and br_fdb_delete() pass on the port ID of the requester. All
other callers (learning, aging, switchdev events, sysfs and
IFLA_BR_FDB_FLUSH handling, as well as br_fdb_delete_bulk()) pass zero, as
before.

As rtnl_fdb_add() and rtnl_fdb_del() do not yet fill in the port ID in
struct ndo_fdb_parms, all notifications are still sent with zero. No
functional change intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br.c          |  2 +-
 net/bridge/br_fdb.c      | 83 +++++++++++++++++++++++-----------------
 net/bridge/br_netlink.c  |  4 +-
 net/bridge/br_private.h  |  4 +-
 net/bridge/br_sysfs_br.c |  2 +-
 5 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index d9a39ff98868..76feb286acab 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -177,7 +177,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
 						fdb_info->vid,
-						fdb_info->locked, false);
+						fdb_info->locked, 0, false);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 45b844a9a1f6..3712e6db90f0 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -176,7 +176,7 @@ static inline size_t fdb_nlmsg_size(void)
 
 static void fdb_notify(struct net_bridge *br,
 		       const struct net_bridge_fdb_entry *fdb, int type,
-		       bool swdev_notify)
+		       u32 portid, bool swdev_notify)
 {
 	struct net *net = dev_net(br->dev);
 	struct sk_buff *skb;
@@ -189,7 +189,7 @@ static void fdb_notify(struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = fdb_fill_info(skb, br, fdb, 0, 0, type, 0);
+	err = fdb_fill_info(skb, br, fdb, portid, 0, type, 0);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in fdb_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -313,7 +313,7 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
 }
 
 static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
-		       bool swdev_notify)
+		       u32 portid, bool swdev_notify)
 {
 	trace_fdb_delete(br, f, br_fdb_dst_port(f));
 
@@ -325,7 +325,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
 			       br_fdb_rht_params);
 	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
 		atomic_dec(&br->fdb_n_learned);
-	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
+	fdb_notify(br, f, RTM_DELNEIGH, portid, swdev_notify);
 	kfree_rcu(f, rcu);
 }
 
@@ -366,7 +366,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		return;
 	}
 
-	fdb_delete(br, f, true);
+	fdb_delete(br, f, 0, true);
 }
 
 void br_fdb_find_delete_local(struct net_bridge *br,
@@ -445,7 +445,7 @@ static int fdb_add_local(struct net_bridge *br, struct net_bridge_port *source,
 			return 0;
 		br_warn(br, "adding interface %s with same address as a received packet (addr:%pM, vlan:%u)\n",
 			source ? source->dev->name : br->dev->name, addr, vid);
-		fdb_delete(br, fdb, true);
+		fdb_delete(br, fdb, 0, true);
 	}
 
 	fdb = fdb_create(br, br_port_to_dst(source), addr, vid,
@@ -454,7 +454,7 @@ static int fdb_add_local(struct net_bridge *br, struct net_bridge_port *source,
 		return -ENOMEM;
 
 	fdb_add_hw_addr(br, addr);
-	fdb_notify(br, fdb, RTM_NEWNEIGH, true);
+	fdb_notify(br, fdb, RTM_NEWNEIGH, 0, true);
 	return 0;
 }
 
@@ -569,7 +569,8 @@ void br_fdb_cleanup(struct work_struct *work)
 							 this_timer - now);
 				else if (!test_and_set_bit(BR_FDB_NOTIFY_INACTIVE,
 							   &f->flags))
-					fdb_notify(br, f, RTM_NEWNEIGH, false);
+					fdb_notify(br, f, RTM_NEWNEIGH, 0,
+						   false);
 			}
 			continue;
 		}
@@ -579,7 +580,7 @@ void br_fdb_cleanup(struct work_struct *work)
 		} else {
 			spin_lock_bh(&br->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node))
-				fdb_delete(br, f, true);
+				fdb_delete(br, f, 0, true);
 			spin_unlock_bh(&br->hash_lock);
 		}
 	}
@@ -711,7 +712,7 @@ static bool __fdb_flush_matches(const struct net_bridge *br,
 
 /* Flush forwarding database entries matching the description */
 void br_fdb_flush(struct net_bridge *br,
-		  const struct net_bridge_fdb_flush_desc *desc)
+		  const struct net_bridge_fdb_flush_desc *desc, u32 portid)
 {
 	struct net_bridge_fdb_entry *f;
 
@@ -722,7 +723,7 @@ void br_fdb_flush(struct net_bridge *br,
 
 		spin_lock_bh(&br->hash_lock);
 		if (!hlist_unhashed(&f->fdb_node))
-			fdb_delete(br, f, true);
+			fdb_delete(br, f, portid, true);
 		spin_unlock_bh(&br->hash_lock);
 	}
 	rcu_read_unlock();
@@ -863,7 +864,7 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	br_debug(br, "flushing port ifindex: %d vlan id: %u flags: 0x%lx flags mask: 0x%lx\n",
 		 desc.port_ifindex, desc.vlan_id, desc.flags, desc.flags_mask);
 
-	br_fdb_flush(br, &desc);
+	br_fdb_flush(br, &desc, 0);
 
 	return 0;
 }
@@ -918,7 +919,7 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
 		if (test_bit(BR_FDB_LOCAL, &f->flags))
 			fdb_delete_local(br, p, f);
 		else
-			fdb_delete(br, f, true);
+			fdb_delete(br, f, 0, true);
 	}
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -1000,7 +1001,7 @@ static void __fdb_update(struct net_bridge *br,
 			 struct net_bridge_fdb_entry *fdb,
 			 struct net_bridge_port *source,
 			 struct net_bridge_dst dst,
-			 unsigned long flags)
+			 unsigned long flags, u32 portid)
 {
 	struct net_bridge_port *old_port;
 	struct net_bridge_dst old_dst;
@@ -1057,13 +1058,15 @@ static void __fdb_update(struct net_bridge *br,
 	if (unlikely(fdb_modified)) {
 		trace_br_fdb_update(br, source, fdb->key.addr.addr,
 				    fdb->key.vlan_id, flags);
-		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, portid, true);
 	}
 }
 
-void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   struct net_bridge_vlan *vlan, const unsigned char *addr,
-		   unsigned long flags)
+static void __br_fdb_update(struct net_bridge *br,
+			    struct net_bridge_port *source,
+			    struct net_bridge_vlan *vlan,
+			    const unsigned char *addr, unsigned long flags,
+			    u32 portid)
 {
 	struct net_bridge_dst dst = vlan ? br_vlan_to_dst(vlan) :
 					   br_port_to_dst(source);
@@ -1076,18 +1079,25 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
-		__fdb_update(br, fdb, source, dst, flags);
+		__fdb_update(br, fdb, source, dst, flags, portid);
 	} else {
 		spin_lock(&br->hash_lock);
 		fdb = fdb_create(br, dst, addr, vid, flags);
 		if (fdb) {
 			trace_br_fdb_update(br, source, addr, vid, flags);
-			fdb_notify(br, fdb, RTM_NEWNEIGH, true);
+			fdb_notify(br, fdb, RTM_NEWNEIGH, portid, true);
 		}
 		spin_unlock(&br->hash_lock);
 	}
 }
 
+void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
+		   struct net_bridge_vlan *vlan, const unsigned char *addr,
+		   unsigned long flags)
+{
+	__br_fdb_update(br, source, vlan, addr, flags, 0);
+}
+
 /* Dump information about entries, in response to GETNEIGH */
 int br_fdb_dump(struct sk_buff *skb,
 		struct netlink_callback *cb,
@@ -1300,7 +1310,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 	if (modified) {
 		if (refresh)
 			WRITE_ONCE(fdb->updated, jiffies);
-		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, parms->portid, true);
 	}
 
 	return 0;
@@ -1326,8 +1336,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 
 		local_bh_disable();
 		rcu_read_lock();
-		br_fdb_update(br, p, vlan, parms->addr,
-			      BIT(BR_FDB_ADDED_BY_USER));
+		__br_fdb_update(br, p, vlan, parms->addr,
+				BIT(BR_FDB_ADDED_BY_USER), parms->portid);
 		rcu_read_unlock();
 		local_bh_enable();
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
@@ -1337,7 +1347,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			return -EINVAL;
 		}
 		err = br_fdb_external_learn_add(br, p, parms->addr, parms->vid,
-						false, true);
+						false, parms->portid, true);
 	} else {
 		dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
 		spin_lock_bh(&br->hash_lock);
@@ -1453,7 +1463,8 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 
 static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 				       const struct net_bridge_port *p,
-				       const u8 *addr, u16 vlan, bool *notified)
+				       const u8 *addr, u16 vlan, u32 portid,
+				       bool *notified)
 {
 	struct net_bridge_fdb_entry *fdb;
 
@@ -1461,7 +1472,7 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 	if (!fdb || br_fdb_dst_port(fdb) != p)
 		return -ENOENT;
 
-	fdb_delete(br, fdb, true);
+	fdb_delete(br, fdb, portid, true);
 	*notified = true;
 
 	return 0;
@@ -1469,12 +1480,13 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 
 static int __br_fdb_delete(struct net_bridge *br,
 			   const struct net_bridge_port *p,
-			   const unsigned char *addr, u16 vid, bool *notified)
+			   const unsigned char *addr, u16 vid, u32 portid,
+			   bool *notified)
 {
 	int err;
 
 	spin_lock_bh(&br->hash_lock);
-	err = fdb_delete_by_addr_and_port(br, p, addr, vid, notified);
+	err = fdb_delete_by_addr_and_port(br, p, addr, vid, portid, notified);
 	spin_unlock_bh(&br->hash_lock);
 
 	return err;
@@ -1506,12 +1518,13 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 
 	if (parms->vid) {
 		err = __br_fdb_delete(br, p, parms->addr, parms->vid,
-				      notified);
+				      parms->portid, notified);
 	} else {
 		struct net_bridge_vlan *v;
 
 		err = -ENOENT;
-		err &= __br_fdb_delete(br, p, parms->addr, 0, notified);
+		err &= __br_fdb_delete(br, p, parms->addr, 0, parms->portid,
+				       notified);
 		if (!vg || !vg->num_vlans)
 			return err;
 
@@ -1519,7 +1532,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 			if (!br_vlan_should_use(v))
 				continue;
 			err &= __br_fdb_delete(br, p, parms->addr, v->vid,
-					       notified);
+					       parms->portid, notified);
 		}
 	}
 
@@ -1600,7 +1613,7 @@ static struct net_bridge_dst br_fdb_resolve_dst(const struct net_bridge_port *p,
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid, bool locked,
-			      bool swdev_notify)
+			      u32 portid, bool swdev_notify)
 {
 	struct net_bridge_dst dst = br_fdb_resolve_dst(p, vid);
 	struct net_bridge_fdb_entry *fdb;
@@ -1632,7 +1645,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
-		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, portid, swdev_notify);
 	} else {
 		struct net_bridge_dst old_dst;
 
@@ -1671,7 +1684,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			atomic_dec(&br->fdb_n_learned);
 
 		if (modified)
-			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
+			fdb_notify(br, fdb, RTM_NEWNEIGH, portid, swdev_notify);
 	}
 
 err_unlock:
@@ -1691,7 +1704,7 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 
 	fdb = br_fdb_find(br, addr, vid);
 	if (fdb && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
-		fdb_delete(br, fdb, swdev_notify);
+		fdb_delete(br, fdb, 0, swdev_notify);
 	else
 		err = -ENOENT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 79c4a54990e2..0a1dd507bbff 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1001,7 +1001,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 			.port_ifindex = p->dev->ifindex,
 		};
 
-		br_fdb_flush(p->br, &desc);
+		br_fdb_flush(p->br, &desc, 0);
 	}
 
 	changed_mask = old_flags ^ flags;
@@ -1431,7 +1431,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			.flags_mask = BIT(BR_FDB_STATIC)
 		};
 
-		br_fdb_flush(br, &desc);
+		br_fdb_flush(br, &desc, 0);
 	}
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f4eaaff816b7..67e3288b1e40 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -992,7 +992,7 @@ void br_fdb_fini(void);
 int br_fdb_hash_init(struct net_bridge *br);
 void br_fdb_hash_fini(struct net_bridge *br);
 void br_fdb_flush(struct net_bridge *br,
-		  const struct net_bridge_fdb_flush_desc *desc);
+		  const struct net_bridge_fdb_flush_desc *desc, u32 portid);
 void br_fdb_find_delete_local(struct net_bridge *br,
 			      const struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid);
@@ -1031,7 +1031,7 @@ int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
-			      bool locked, bool swdev_notify);
+			      bool locked, u32 portid, bool swdev_notify);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index d2993f187f57..3a05764e607a 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -349,7 +349,7 @@ static int set_flush(struct net_bridge *br, unsigned long val,
 		.flags_mask = BIT(BR_FDB_STATIC)
 	};
 
-	br_fdb_flush(br, &desc);
+	br_fdb_flush(br, &desc, 0);
 	return 0;
 }
 
-- 
2.56.1

