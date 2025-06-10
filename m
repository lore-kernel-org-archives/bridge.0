Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B723BF80
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570862; cv=fail; b=gXHXX5rDMPKbjD3qx387AEhmABNd7MgvVvzvpqi70OkA7jFbIzWzl0actpqrXnbI7w6/4PuklXMRBebMEtS+6iqnnp1UdOclCVgtMDgAE6YA8fkeLacteh9o03SYSya9WugNqwBsfoBV3+F8FL3At1dwfTNSjAI5xupZuJchzLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570862; c=relaxed/simple;
	bh=l9jxgpVtQ3QZbzlGjWO8uylUyGsrKlONc50lBf0SmP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak6EV8YH1CborQuwWgSE1S+3FJJWTqBIX2NiJj4rMJdz8zYYVB7f+WtVokbcRQfFw7hhTmlLXs75basbmm/vT+0y2xNG0FO+6NupM6pg9i3TpeyL4qseS2F/bK+xJfCDTMVTDsf/Igkfnjxbhiqa5Q8U39L2OWlL5Mt4F/neOQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zx3s1JPy; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zx3s1JPy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ED4E6073C
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCVkc8D9UvfG for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 15:54:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2412::61c; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=petrm@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A8A3A606AF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8A3A606AF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Zx3s1JPy
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::61c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8A3A606AF
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd6DaMJaJnooxNyQ7OA2l8MKIyftMETd8xjHcdBVR0RvRePyrX2fYHm4AxRRXkih7GF4T7m0ay0OJ+Vl9lXlgshXfD7+7YS/bNeRJBdbRHI5xRUH/4MPSrSpXjrngcBZku8Pa5/Aa1LRlvh7Kf3ujGqJCJwqGdNjT21hLdEi+EOcDvI5E0/XHy3BhCSrO4uu5f49ykTNjNSySUU/T6WWDbtavcI+We2itcgGIf7jD07xAWF0iHiEbpbTU4dLt4LWhpnozOwg2DV4M2DuoFXq8ShVZFjLHR8dCAsqBGlD3MPJBUI2qrP2lLgzzSmzaO7IwOMOhkrfioDy6pMpaByCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxT2eD26vsdePxgi4OXzJpCgqEL9/Pfo6MaBbMavH2c=;
 b=MHX40b19vnK7OLyWL91j0XBBYWH95487ye9+qyytGsksRSuopi0qJqh9ziOFxMGrCIyPMpnmIOuf0TWzwCJpGSLfX7CVsPcfkXLjeJcbRBY3QIno/tzEJ303N3x2VhOpAcd9Ex2mwMTXk51vcCDUyEg5EzwTc9LZUXzQJ11OQ932ox4n9UVYhIZqlKObv39lq7lJWSJ3U0xV0Uagx+r7TX9CRCJqESkxCMBk9Lr0F9e8ngLkHlj11tF4+TZh4LBMPN7B6GBF9KmzpmRmDZh7oBvOutigEkFwxRYxg7+pNNbDv5K1gAkV9ySM3JvGxKxEVTg/ElpI0KOVy65CkqC/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxT2eD26vsdePxgi4OXzJpCgqEL9/Pfo6MaBbMavH2c=;
 b=Zx3s1JPyHMCorqJkeLNyQk6VQxIH5j6DZp8M4fwkfxDYF8qm4EU0YEPeJbw3SftgYb3ghweyQtxbyOGCtcQ6L61vG9aFnEpMkLaLsX2cNk+IkZ4O1D9qFZObEg6MnPyhq6MP0LqfhvbdNjVQX5VrT1bl0ZaI6ePEUNlSQBVo+RaFmdb77HN/D0plVF3zGbobvFu/SKFeK5m20eT9NtZjmCWCWBiGrwElWHA2sgPTEZcGqc+iT09drCbadtzHtmiGgEgb0eEcW0/G46nSlKseJ3aJznTawDCUu3JBFlM0EbUOKpkScdSTSeXFM1LYNbS9LwHJ/ykNlfQgC7VG0W5/qQ==
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 15:54:15 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::97) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Tue,
 10 Jun 2025 15:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:54:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:53:53 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:53:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v3 1/4] ip: ipstats: Iterate all xstats attributes
Date: Tue, 10 Jun 2025 17:51:24 +0200
Message-ID: <c09ea07d23bd11cb906e9a48595f0347a18f9117.1749567243.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749567243.git.petrm@nvidia.com>
References: <cover.1749567243.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: bacbc934-0148-4674-e7da-08dda8370ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9BSolxH520oJ35bTVYNwv71kDxPDMfPciCJmK8Qw3MKsu0DFXCtnzDcTEml?=
 =?us-ascii?Q?hb/zwe9WmoRiLHsG1ABiMcRU4OqgjzHnORQ4dNiny6muKOU1FMvf9LELgukl?=
 =?us-ascii?Q?DElEyHb0wcCFdSO509ctvW7umLZT18JGVwE98sz3acRLurJv80UmfffsBgBm?=
 =?us-ascii?Q?7TnoeIhxTJXHCBUkcLW9zYH35ic37abf7h1yU73xf7B2L/fAQYYyN61blOgk?=
 =?us-ascii?Q?OZEE+L3EkVo5W+heZrxRa2tzSh1vxdiO3oOm8OWR0dyV3sbAB8GRwDoUwOiC?=
 =?us-ascii?Q?lyDLGxaCrXlPv7DDEnMHyhCs6/UtUBc483pnsQ3Da7D2mbe4t0NbpRRBm1gs?=
 =?us-ascii?Q?dgtxsSDfEfAT+aOpnmv9SPi+qDCP55lqx7f2iUhzkGrA3k/pRbOqeTmv6CGQ?=
 =?us-ascii?Q?TxKFv7UQxcX9fmcLSXY4/OXx2yHO/BeXBKq8Y17J2tRfLUnsW4UXR3E9jC1H?=
 =?us-ascii?Q?0Gf2ebBKqQtmZ/UCtZ0Wp1IylG9lilT/nkM1eHxyPUsS6MFgKmFMiNcBQwK6?=
 =?us-ascii?Q?wDHcPreF4Q7ZmmQ0IChhgNLOsGwutH80dRS7B8mlYJqp09TeuyDz2jQ1ulRd?=
 =?us-ascii?Q?Tvdfzckb8b7M5XgGi76kwaW+3TyScUo2hy/BgPI1AdV0QGEmqb74vDGsrh6w?=
 =?us-ascii?Q?DQi8BJRr2UQQ5iWXruAqVd0djMXI53qsqjvB0WTOtAPJgf5JpBCSEtqXuhub?=
 =?us-ascii?Q?6px8u3CFEETeaaxOw3UN4hxUUJEFi6UAZieAY+mMlBLwMAQ8LLJFaA/V8syC?=
 =?us-ascii?Q?++o23IYqRoP4DLCpCW3kx+XeLAc6S+vFG14gAuO+icfs34+Oxt98+wYvGX1U?=
 =?us-ascii?Q?B0FKaOq3ukRVIudUTp8TC3kd+X/yp98GYJspY3uEDllrY/PiEqZ105fmLua+?=
 =?us-ascii?Q?pRgvJsGYDCxuJTiOezPf4f589EVv+NTC3Eu7ck8fIideG8pGEoZTWW5xWZfY?=
 =?us-ascii?Q?BK6jXUc/Cy7PMk1MCSxFLDMASiWB6PAvRAkOo8il38UAN27morSHa0w5q/0G?=
 =?us-ascii?Q?orixlN8+cry2aH9TQAEyn0CCNCt6qAspkF6HsWiXXSsTY0mzQP6IyuYAch3P?=
 =?us-ascii?Q?Kn8qQvQ5yu3sHC/pPvVrXi9N0VEC+sy3xu9Y67en3zYS8L02/kidhXEI4klT?=
 =?us-ascii?Q?PebVUqch5R7Hd7wx7N7FKxjUb+kBZNQdqkCLE2mwAdwDoIc2sZLO/aCbf4yw?=
 =?us-ascii?Q?2uT6HF/Zx9Mi+e2UxKMRQwba6itAuhAxpNJwWJxNkLaySugiiBtMg7hkJ47H?=
 =?us-ascii?Q?0tYS4DwH0EGgk+AwjV4fiPdEUXoz/F7cMQeaS68SPmaAe/YHBkv67gN62Dfg?=
 =?us-ascii?Q?DQPaZLx6k0NSF/bja61FMrx9OrUvyzqdjlHDOE+P270ELQIGklI73Lz0QSsy?=
 =?us-ascii?Q?Imr+ObyiR+Wr4qWCSN64TYoLWCkctl6gUFWLAIREzVaZdRJSe1MvBc2SYv8s?=
 =?us-ascii?Q?4L9MCLTEVEGzcQ2MNtJrWGWNlzvkhWMPz39JlAZz8o3U+FR+olFtEcjx2LwQ?=
 =?us-ascii?Q?6C6IVkrcfA5WTADaMctNpBskp0tZhgRCK5qX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:54:14.8616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bacbc934-0148-4674-e7da-08dda8370ce6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

ipstats_stat_desc_show_xstats() operates by first parsing the attribute
stream into a type-indexed table, and then accessing the right attribute.
But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
one per VLAN. With the above approach to parsing, only one of these
attributes would be shown. Instead, iterate the stream of attributes and
call the show_cb for each one with a matching type.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    - Use rtattr_for_each_nested
    - Drop #include <alloca.h>, it's not used anymore

 ip/ipstats.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index cb9d9cbb..f0f8dcdc 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-#include <alloca.h>
 #include <assert.h>
 #include <errno.h>
 #include <stdio.h>
@@ -590,7 +589,7 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 {
 	struct ipstats_stat_desc_xstats *xdesc;
 	const struct rtattr *at;
-	struct rtattr **tb;
+	const struct rtattr *i;
 	int err;
 
 	xdesc = container_of(desc, struct ipstats_stat_desc_xstats, desc);
@@ -600,15 +599,13 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 	if (at == NULL)
 		return err;
 
-	tb = alloca(sizeof(*tb) * (xdesc->inner_max + 1));
-	err = parse_rtattr_nested(tb, xdesc->inner_max, at);
-	if (err != 0)
-		return err;
-
-	if (tb[xdesc->inner_at] != NULL) {
-		print_nl();
-		xdesc->show_cb(tb[xdesc->inner_at]);
+	rtattr_for_each_nested(i, at) {
+		if (i->rta_type == xdesc->inner_at) {
+			print_nl();
+			xdesc->show_cb(i);
+		}
 	}
+
 	return 0;
 }
 
-- 
2.49.0

