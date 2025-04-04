Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01462CA6
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743805937; cv=fail; b=U5++KJPxfqt7m4a22KWYveY279/5zja7WX5Rw67gChbama+NH3TIegWwhFTgzhlI2KjwZ5wmjtP5jw2S9LuAeMDyW8QUDz79CpZ4hRK13k7ZwmFgbamjRtDq4P0OahlZzkdhvYoIvgoqgDmUJ21eSytlH4b9psk0ztpOVzS3ybc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743805937; c=relaxed/simple;
	bh=XRnl6WDibZmGti9jglzN0RuuzHHFv7a9j7xMkIJLQow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WduDWw1fhwXD5dg8eNPBKU3gcFzMaLGhx9jp/hSqyUbs8oZXflWRARjxnpuqIdJNEVQ2BtSBlAaqGtNHe7mm+GaNESav3N1OrVlSAG8YmRuuUKD0JmgaE4BXfyksMdZfsbP2ndlohBjnQMlL75JoLPGo4tIr5oquM0HPFa+CPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=XLByr2rI; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=lteLLSnF; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="XLByr2rI";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="lteLLSnF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34AC38134A
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 22:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.492
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-ebgVP4wHx8 for <bridge@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 22:32:14 +0000 (UTC)
X-Greylist: delayed 2308 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 04 Apr 2025 22:32:13 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5583481128
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5583481128
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=garmin.com header.i=@garmin.com header.a=rsa-sha256 header.s=pps1 header.b=XLByr2rI;
	dkim=pass (2048-bit key, unprotected) header.d=garmin.com header.i=@garmin.com header.a=rsa-sha256 header.s=selector2 header.b=lteLLSnF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.212; helo=mx0b-000eb902.pphosted.com; envelope-from=prvs=71895046b5=joseph.huang@garmin.com; receiver=<UNKNOWN> 
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5583481128
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 22:32:13 +0000 (UTC)
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JXCs7000992;
	Fri, 4 Apr 2025 16:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=Xdp77
	OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=; b=XLByr2rI3WXT2NYq1b2ZW
	kXONowopSml1LDKBPhLDSzTO7OQoclwYfaM/X/3gstBndzia6z6WUgnNv6Rs4Bx/
	NdqcqCGMC2oYn8I6KfxdXkspUDydEoJb0TgzuCaZtMmaXx2JLlA8HBNjovEVzC0E
	dE1XYuEndHcV4+bLv5pm6qB1BunPTRODLMZhA9ZZRgZ8WWXTtrJsn47htTHjudsV
	EQAFOqg43be3Yiz+v2tGlT+orVnleL5Tm2cC8SvXdQcmfjx8KJ8tshRnsDVgqI7x
	7HGkBXKkdCAmv+Xn3ggCEUj5y/HWmXnvGP+dpHFzbUt2KyoJbG79fJf5zJVVHU0Q
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010005.outbound.protection.outlook.com [40.93.10.5])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tk4e8emb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:53:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/JIg43l/m3xnNACBOp62+1hhWdYgsnGBlFXO8T9GifWuX02OsBw/0GLFDYNPxA3ArjnVPPjL/WRHun6qbRqIzL6lJQjDeC74EO4FjKhNjPU8y9goOQAaGYkQ5Kw6OMlnz94gpqvenqAka0Lq6Qe6Po5B/vVV4OfAlgSoaZUY7NMaQNM4XsIsfHQwiot87C37qKn8TpHqLoQWpZNftlN17F8saHC+HeUJppFAlUUL9DGjrbCdD576/WTBKYiTU/h8QXIk0A+DwrzjLAYDMM5IMY9GHyBy4BBuIzOxcuf01tvsh6sWTjhySU2RJ4cCzO7DX4KQRCAHPLDvAUp8HvVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdp77OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=;
 b=u21gmG7Bheq96LKosvAZ0q98i7JmuVqqNUoPSjr8rReJ174jIUWk+64EVIGjtFvkuQxIFdU95so9Pm9R39zobO1NWuVnrTwkJ0nXoEyM7avepDZpN5jwW1hhnQ8XyIYah4mjx24s3lNaCFYmPCv4QQyebnzcJBHR8iZ4zwOeJpAfo4S1R4gWI8mngRjRfxkFhR5h4qneUAAZ3G9QzLJa/CKxflgmFQGTKnoN5qQRHtXmvifwt8FAAUfrAPlj2lQVRqoaWe3V96w66H12BMYYKs60Hjt5RFjwC8A9mlWBLsIJ95/ISPVfRMnhVlAb+z2j3s7d/mw6QlcYYGGWdZo3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdp77OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=;
 b=lteLLSnFeIPyL8XmFjBYRixd+tjoPVFe2+o+yu2RB3yjOw2DqYdfACyEo2vR73CHFrPr6AHaDt6ToF3wYuiljcjQ9qwdbaNog+jzZFPTix4sycAY047VHrA34O6xL7bmEJy2BWEL1EID9uQMs4pm15he8VRHZd6yu+I4rf0oD3SX8v3UJjFGN0NO5h31u3e57ZmUNAFRjcmi+Q6v+ZC5f3wv0FafDIDojRcJokZJmCzB8TnGpCWAykyP3Npr+XIZfwAQCZDhWXb6OQmb6Iw9Dqzf6A9sDr2+2etKuCRLM3vJPDUZPmO0pNV0KRjJsNuLpwFGFqbbEhCJHdEWRUNiTw==
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by CH2PR04MB7029.namprd04.prod.outlook.com (2603:10b6:610:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Fri, 4 Apr
 2025 21:53:41 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::97) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Fri,
 4 Apr 2025 21:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 21:53:41 +0000
Received: from cv1wpa-exmb7.ad.garmin.com (10.5.144.77) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:53:38 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 cv1wpa-exmb7.ad.garmin.com (10.5.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Fri, 4 Apr 2025 16:53:40 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 16:53:40 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:53:39 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Subject: [RFC v3 iproute2-next 1/2] bridge: mdb: Support offload failed flag
Date: Fri, 4 Apr 2025 17:53:27 -0400
Message-ID: <20250404215328.1843239-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH2PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 660ccde4-906d-4aef-562f-08dd73c329ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIGG9TUcnSslCYSB8Fq0K0xzhyvOVIbG4VVx/a9WuO/AWqu80T5r6rQdtyVQ?=
 =?us-ascii?Q?Wt5gYH4gQ7ArbCky2NUDB866S+bDHo/glyhYCfBLtP/gOwuSYWXIYU4UqjDa?=
 =?us-ascii?Q?Kq2uZ3OULx4VyyE98R6J1ZwqgtLTN55bgB1HcEWfTKja+QdXezQeA6+Ei3R+?=
 =?us-ascii?Q?5B3A4BDWtLhmnSp0dDTWj6bPAP9bmSVsEnHxam+WH3hUPV9apSgbk02Neahy?=
 =?us-ascii?Q?V1IzyzE/TanL/WGc8gPrF900ItpdV0Ef9vnmeHNB5eUUYNAw7Hf+owu993fW?=
 =?us-ascii?Q?8LXZhbcVTY7vtAOA1+ozldUYu1vcQ5fGx0yB8YVUnPUzGdVNqzMj0vlMEauW?=
 =?us-ascii?Q?aWsTBdYuTb+hNwXtvhndGrrEGBwtM1Ii+RlirRf6PQufII2K/oK8U+BL4nX0?=
 =?us-ascii?Q?g4l2+vNc24aJO/EDaUAsZwiuAwcohKzi8WKu9fQt7Fe41D2gXX7Lj79n+lMf?=
 =?us-ascii?Q?bVw78Dcao632d5KRpd4E2tjyUF7MnesBErG8+Rd3mfk3kIPH4UTSAGyYol0Q?=
 =?us-ascii?Q?GuoiMqjmjNUBvWXMMRIKVzBKbYSi1VPiDfOaVp/0JyPYRILC2YcyqzuiQTPg?=
 =?us-ascii?Q?B7P342DFamqmJI8+PzxnwE5z0GlQFlyBPVDD1rAL6PByTVHiC56od1hmISKD?=
 =?us-ascii?Q?vwg2KdfHHiw+DC8AcbyXKgJsGjc2PDF7idjSy/AO5MqqmVMxGTvlfSUtHDLm?=
 =?us-ascii?Q?ynL68zyHQEuM2BW8dKf2DeWhNhVmbzzmIDJRK0qI17yu+bbzNuRehbT2aDin?=
 =?us-ascii?Q?PAzd1ACb1jF91Hw/zn/1BE1MqtdZhGOn7wGEq6Eqh4/OP2vjwWQ4RXDZcAw2?=
 =?us-ascii?Q?mqEBZTRkhrI/VNrYdxFEn36iVuupmuVsA6/yfjfpyuZo3QmkoOOHO8L8ICSe?=
 =?us-ascii?Q?hCH0NAbKp5lF6HNplMhbQ6YSKIFid6llWGkfIt49ON+t+XCEXaGeEZiOUuON?=
 =?us-ascii?Q?srYh3AdNX1PDPwk4qpS78IH+wEHxRyJiNnWVpu0OBhwUGiZmLnMJAnVskbPI?=
 =?us-ascii?Q?mMQ70zhipaOxDCW6U7kl4UCgKzuz/OdZlGpxKScCWrK2Iapp+Wy4zEIh2twG?=
 =?us-ascii?Q?tvY6jiQ9s3EjmorDnmITeHV+y9W66mwrowLZgiaXPOf/DzBCnkCL++f9tXB5?=
 =?us-ascii?Q?6gSBpubR9geYI7uKjQioVlUNrT4NH7AxT1Lm9PGIpktuohd64YZ9fzXHEdvE?=
 =?us-ascii?Q?y8ImyxLs6oczAyaC9osPIwtUxTYRVGroHRRLfTh2rRe6+XizOE6uXL0huMoL?=
 =?us-ascii?Q?iPaQn55GOMdNZ2Ej1tA6N0uzEjsNFauovHQys+yjYDj8d/SVaQK2UZmw66yd?=
 =?us-ascii?Q?88DZkxexW7odtmqJKkG6QlhUVhUnFBC5TM7cyaseB1Kzcz4S/o1uQt0h5pPI?=
 =?us-ascii?Q?W63P4/ETEarnpRXUMRgLgEWoMo7F6aQdUvAWnsRS35fTf/EhiK28gxcMi0oe?=
 =?us-ascii?Q?nKkkHB6EC2JyT5RFRTPBnek/zNsEVpXjvWJSH96YLBj0lXCEk3mhsLQVlr1R?=
 =?us-ascii?Q?dFWhufBLT9v9Ukg=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:53:41.1859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ccde4-906d-4aef-562f-08dd73c329ca
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7029
X-Proofpoint-GUID: oT-nIcZSK3e9y4PMbMLYNRouMWfE-YsX
X-Proofpoint-ORIG-GUID: oT-nIcZSK3e9y4PMbMLYNRouMWfE-YsX
X-Authority-Analysis: v=2.4 cv=DcsXqutW c=1 sm=1 tr=0 ts=67f054e7 cx=c_pps a=hrtkuvlCWAGxlhsWV3VdYA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=vJ3Si-Bo0Wz43vYLVJQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=949
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1031 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040151

Add support for the MDB_FLAGS_OFFLOAD_FAILED flag to indicate that
an attempt to offload an mdb entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 196363a5..72490971 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -256,6 +256,8 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
 		print_string(PRINT_ANY, NULL, " %s", "added_by_star_ex");
 	if (e->flags & MDB_FLAGS_BLOCKED)
 		print_string(PRINT_ANY, NULL, " %s", "blocked");
+	if (e->flags & MDB_FLAGS_OFFLOAD_FAILED)
+		print_string(PRINT_ANY, NULL, " %s", "offload_failed");
 	close_json_array(PRINT_JSON, NULL);
 
 	if (e->vid)
-- 
2.49.0

