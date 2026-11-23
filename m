Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456872;
	b=YuWodB5F4pRZCHr9UtGnBSvWBE9LJpCx3rl9eTXTMx6sNzZ8aSU6JmeaLFYkKn2FtK9G
	 iNH4s9xfjHEoVOYvaDMrNPo3FbDMuAeSRLy5bVh9f1LPBipkbEzhSpKkeVoUhohT3HwUe
	 86jvzmxeC2cE8tBH/e9x4iYRribBLZWj7Ywr12fUMkx5w1FZA9095ybKRWSjxQzXsG7T8
	 jMwcbMoE6ItmNGazxVu1LEICXMMqjAnT095+OnKvfC1Ex+300MkgBac1NILhddeXoNu2o
	 /xonhV7wrYFIBiEkI9/361Tw4zYu/R54dd3NdIlR35IzYRstGFU6o1BzIZQ53us/0xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456872;
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
	bh=5icK6gJ9M+2GYQhkpBtIMheONBO244alrBEdgVSVdYo=;
	b=HHMeDKjyvPPxGj7DE8ziF6enLO0aRk5WOrLX0IzLbz4e7Ij4I0ke9VQ+I0EGxSFk2bW5
	 +O7cXL4h+QU3hXWV7Fn+SdkbYhHrk0AFqw7/zlFW2ucA8BezPBdzKTwIj5eD90DqpQvuU
	 Z+Y9jJKS/UBb4nrVcprvPItk5y6GmZ6cVAahJvfbq5IiYhdWMQK+APBbRFQ/I3mnIkIXe
	 5RoDeDZK8YxGt1o3yFU68fStRg4SlsRWQeQfhqM1/slhMjWXiu67OGVhI7CJXQjxwQ3RB
	 SSk9HJ8Cr8qd7Gj7egFieU4D2L3IQYpj8+Qv1EdxZRLKG7LoABuYosdPbCQp/x31UnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d1oNzD5u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.31
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FA606A332
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2FA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d1oNzD5u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrarKPEpb2VBrGNYjJGUijAHeZTGOOJX6a1kcFRqD8bm4YUCjuKhKGj9CbRx28Ez8vJlIk2svF28ylNVti3VWfA6LLWKdT3H00acNcR9DUhcKeYX66Ycyjt7ClnSm83AbPi4dk3RXHtNzU6aAGl1ErXKt/tMD9vdMEMM5TdqtyPQCCmRWscXSy6wDKue3Ged/4Fh8JpDv5pqRoem8q2urGx6TJQoK64x4o4DSWUjE6z/WQf2E5Fs6y0HTfQYDkGAO5mx8GkswpLdDmHeXXAWu6fDpLdS7sr5J6WqpffbaBvBwWklGmA69UX7aDChpuc2JKCwimpubSH+YiAuUbDhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5icK6gJ9M+2GYQhkpBtIMheONBO244alrBEdgVSVdYo=;
 b=xCrW6jMIIS4YMaQCDLZCodQ0qyr6JzmJ26F4Srj+kZJChtutTHnVzTU76lvfO649ckq/LWRX9JkQIftnPFxJs2X7yoCkZh9GrVGh+T61EzBdEgyKfCIYk50pGGi521Bn71ZoyfwqUxScAYM7YrCZ98z1G8dV5PGwn+ARLgHuZsn8u7D99fBJTvnuBJbf1MmOBk5Ene4pDTzkv0Wk/lG3Hv26w7B2yCDYHotitXK8d0wd631GMcrKlXRxubcvwWoj5xNGRszHxzqjK3Q/TPZHX4UtmIklI0WofdW0JX97sL4PDgPn/aqfk6KUID6WVsqYSdHmOno3Shx+5vecmWFvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5icK6gJ9M+2GYQhkpBtIMheONBO244alrBEdgVSVdYo=;
 b=d1oNzD5uBm+qaMQBO6p5Th7h5kUncwSAm3GAUXM8C0AE5DP8lOqXL0LbB/2i8ltwg6BMd2OqO9o0bmB2mU0UyTyhTmALFnzK5anuVw37QRa85aKZ2gio7/H91icJWs1RNPeovSYbTwHwzMSFY2oCjfz0J4eoGSrgAgMJL0boitiVMi9mjTVgspzaPUNoneRllAL0AUCwoypKjpoowmU4fSBTYJi0ecp5bxkCh435f26BURgViAyjVr03Pp+kjYntzqyI0hAmP+WAjeEHhTYHjo3OoNc+NJYAuZwNf0tOJkvSFwpAD1Ncyhr6fUVSe67uTEXHTLGcEJaR/PvRBTL8rg==
Received: from PH7P220CA0103.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::29)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 18:00:58 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:510:32d:cafe::69) by PH7P220CA0103.outlook.office365.com
 (2603:10b6:510:32d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:00:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:23 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:18 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/13] net: bridge: Pass struct ndo_fdb_parms a bit further
Date: Mon, 23 Nov 2026 18:59:19 +0100
Message-ID: <4721639390ba4d395d536cf118cfb392725a2ff9.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fc412e-4a0e-4f6e-6837-08df498bb975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|10067099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wKGzV4KiexegJ19PRaWxjGSQI+lOg/VLJfTPHcUCrS0NPrchj1cgDfT4Z0ALpYs1XpNdWqeKfEQA0dkDp3595HQ1rcZi2scr2Fv9ogpYl//DR1Dk+w95T7nbMd1fWbNnB6X5yrfPTVephsLXu0xMU6OZlzVAPAv8TXlqfyiLgFD1kbsaxJz7XFZDybbBpVJ1Ok9HH4cfHPOH0qQliidZkGTCx5OtG0YGf1IvhJpdvDnbzW3swHAfAz6ubO4Mw6HkAlltt611Lx0sUELLrBEtUKIeCFjuAzbN1cVtU9z8IaTETwMEItDJ6H5GUCAoBpkrmge03BIR6dMcFx1OELgDJK3/tDSZhpXCP5oMu1c9D23fbGouWwbzwF5/eUWPhKYr1krrSbMA9b2WGWBN4WXJPt0d1apZ1DL7JTbh33B9no6YTwnfPxzrDcCt4DHL3+ZGilIM3xSijxUuyTyA0Vx7c94L3ijUYgAwuo8A7ZcPEpQEd+7HU/LgHxEfjQdSOOcZwft/DW/lBEmMg1LjdALfDzozx3bCxDC+hck4zkgPIy9DuGX4zW/u4daIuKLbChSXzxqcDba9A+IVcPIi2YFDSma4bXNCMN5nLdkAA5Jp01wfRmgpf0P9tqcMs1yKGW20s7vVh0n87F2F51WlldY6/u/ev/mKwRZQ3t5awcpoyDuUB1fOlIz//hhoU1ZBmQ5vLW7+tWRAMkwpgQ57XcwCTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(261028144727099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cuvaQIXS93hXnU6pK3OHgjT4CFlZgPVzK18z27mkVOSdaa1dyKyMRGXGYQuFt5m34rFbxQDhA3QsxXa+RP3br/LreL6a62ojpMXy03LBMWT5b5Or+eAyJHyROx0puhRb/NDIhzQjoXg4V/xRm/1qkI6jfSIyNsjEXCGRuH1VjTIBYW6LaSSwZXO3QPCuX0x2G3qTIgx1O9vJXINKvO7rvkMqeO5vYGjddBGOWuJ+nQrEqKk/fy1yD8SPDI1T+s1EUPh9zl+0YoUTq0u2ORC4yw/ZR/s3D8LMwj2N3G+iEqG99u8uOVxf0/d56ObQPhfwPp5oTwvVx4ju2sC9RRJ+enwH6Fplh5ECOQOLdIVvbAP+SauIzpwIUWZa195heuxaV11SUsbO7zmMV7xAYYCk+xHjImRU6x8B1IFduMa37auJkgHYP4u9Mf50PQwZ1oK/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:56.9578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc412e-4a0e-4f6e-6837-08df498bb975
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188

__br_fdb_add() and fdb_add_entry() take the FDB address, the netlink
message flags and the VLAN ID as separate arguments. All of these are
already available in struct ndo_fdb_parms, which br_fdb_add() receives from
its caller. Just pass the structure instead.

__br_fdb_add() uses the passed-in vlan parameter to decode VID and passes
that on to fdb_add_entry(). Instead, in br_fdb_add(), prime parms->vid to
the right value, so that when __br_fdb_add() passes the parms structure
through to fdb_add_entry(), the latter can just take the VID from there.
This obeys the principle of least surprise: an add-like function that gets
a parms structure has all add-like parameters properly initialized.

It would also be possible to pass struct ndo_fdb_parms to
br_fdb_external_learn_add(), which would replace addr and vid now and
portid later. But that function is also called from switchdev, where the
appropriate structure would have to be created from scratch, which makes
the benefit less clear. In the end, I left it out.

No functional change intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_fdb.c | 48 +++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9e2fdcc5ca9b..45b844a9a1f6 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1209,7 +1209,7 @@ static bool fdb_update_dst(struct net_bridge_fdb_entry *fdb,
 
 /* Update (create or replace) forwarding database entry */
 static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
-			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
+			 struct ndmsg *ndm, const struct ndo_fdb_parms *parms,
 			 struct nlattr *nfea_tb[])
 {
 	struct net_bridge_port *source = br_dst_port(dst);
@@ -1242,12 +1242,12 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			return -EINVAL;
 	}
 
-	fdb = br_fdb_find(br, addr, vid);
+	fdb = br_fdb_find(br, parms->addr, parms->vid);
 	if (fdb == NULL) {
-		if (!(flags & NLM_F_CREATE))
+		if (!(parms->flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, dst, addr, vid,
+		fdb = fdb_create(br, dst, parms->addr, parms->vid,
 				 BIT(BR_FDB_ADDED_BY_USER));
 		if (!fdb)
 			return -ENOMEM;
@@ -1256,7 +1256,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 	} else {
 		struct net_bridge_dst old_dst;
 
-		if (flags & NLM_F_EXCL)
+		if (parms->flags & NLM_F_EXCL)
 			return -EEXIST;
 
 		old_dst = br_fdb_dst_read(fdb);
@@ -1271,15 +1271,15 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 		if (state & NUD_PERMANENT) {
 			set_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!test_and_set_bit(BR_FDB_STATIC, &fdb->flags))
-				fdb_add_hw_addr(br, addr);
+				fdb_add_hw_addr(br, parms->addr);
 		} else if (state & NUD_NOARP) {
 			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!test_and_set_bit(BR_FDB_STATIC, &fdb->flags))
-				fdb_add_hw_addr(br, addr);
+				fdb_add_hw_addr(br, parms->addr);
 		} else {
 			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (test_and_clear_bit(BR_FDB_STATIC, &fdb->flags))
-				fdb_del_hw_addr(br, addr);
+				fdb_del_hw_addr(br, parms->addr);
 		}
 
 		modified = true;
@@ -1307,12 +1307,11 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 }
 
 static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
-			struct net_bridge_port *p, const unsigned char *addr,
-			u16 nlh_flags, struct net_bridge_vlan *vlan,
-			struct nlattr *nfea_tb[],
+			struct net_bridge_port *p,
+			const struct ndo_fdb_parms *parms,
+			struct net_bridge_vlan *vlan, struct nlattr *nfea_tb[],
 			bool *notified, struct netlink_ext_ack *extack)
 {
-	u16 vid = vlan ? vlan->vid : 0;
 	struct net_bridge_dst dst;
 	int err = 0;
 
@@ -1327,7 +1326,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 
 		local_bh_disable();
 		rcu_read_lock();
-		br_fdb_update(br, p, vlan, addr, BIT(BR_FDB_ADDED_BY_USER));
+		br_fdb_update(br, p, vlan, parms->addr,
+			      BIT(BR_FDB_ADDED_BY_USER));
 		rcu_read_unlock();
 		local_bh_enable();
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
@@ -1336,12 +1336,12 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 					   "FDB entry towards bridge must be permanent");
 			return -EINVAL;
 		}
-		err = br_fdb_external_learn_add(br, p, addr, vid, false, true);
+		err = br_fdb_external_learn_add(br, p, parms->addr, parms->vid,
+						false, true);
 	} else {
 		dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
 		spin_lock_bh(&br->hash_lock);
-		err = fdb_add_entry(br, dst, addr, ndm, nlh_flags, vid,
-				    nfea_tb);
+		err = fdb_add_entry(br, dst, ndm, parms, nfea_tb);
 		spin_unlock_bh(&br->hash_lock);
 	}
 
@@ -1422,11 +1422,11 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		}
 
 		/* VID was specified, so use it. */
-		err = __br_fdb_add(ndm, br, p, parms->addr, parms->flags, v,
-				   nfea_tb, notified, extack);
+		err = __br_fdb_add(ndm, br, p, parms, v, nfea_tb, notified,
+				   extack);
 	} else {
-		err = __br_fdb_add(ndm, br, p, parms->addr, parms->flags,
-				   NULL, nfea_tb, notified, extack);
+		err = __br_fdb_add(ndm, br, p, parms, NULL, nfea_tb, notified,
+				   extack);
 		if (err || !vg || !vg->num_vlans)
 			goto out;
 
@@ -1435,11 +1435,13 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		 * vlan on this port.
 		 */
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
+			struct ndo_fdb_parms vparms = *parms;
+
 			if (!br_vlan_should_use(v))
 				continue;
-			err = __br_fdb_add(ndm, br, p, parms->addr,
-					   parms->flags, v, nfea_tb, notified,
-					   extack);
+			vparms.vid = v->vid;
+			err = __br_fdb_add(ndm, br, p, &vparms, v, nfea_tb,
+					   notified, extack);
 			if (err)
 				goto out;
 		}
-- 
2.56.1

