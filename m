Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E713793C
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345782; cv=fail; b=VysI7XJeAEqs5Q4rc3PuMKvzTKw3R7C1FErGD6PY0ZECI3PWPFvRJCaY/55d0+hNi21G9+h4lkV6FRg9vpqy3WGrovKJcnV9I6TJUS1YtQ8wTKlocHLNx5ls5yrMavXwowP+4w48lS36wCA0X4+GJYH1TJ2FMy1ZZ4fvvYlEuRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345782; c=relaxed/simple;
	bh=uLbUGGYn/YdjW6kOccvRqvUPNhcivByvVEidaHeHpcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ih5rKDi2Bftd6lhUGKH2bmUESrscAZp0fFfDu/mL7wxxB4uCG2MtpJNSVSVVmvRJr76rEuAQiz+mEAu3xCK7T7f1mWayB7Y1O4I2qfm7OAiI8vJY8E7pBiNWBsIrCofrtKP21TLMfIQhdoPEHQY78a8AcJS2Oe4hYtTr4tx7LWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=sWiLEnGA; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="sWiLEnGA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70492818C4
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 05:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.977
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ghsLGJjps5w0 for <bridge@lists.linux-foundation.org>;
 Mon, 25 Mar 2024 05:49:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:281c::800; helo=ind01-bmx-obe.outbound.protection.outlook.com; envelope-from=tjjh89017@hotmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B62DA818BE
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B62DA818BE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=sWiLEnGA
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn20800.outbound.protection.outlook.com [IPv6:2a01:111:f403:281c::800])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B62DA818BE
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 05:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV2s10NH1Fv/IZ7iHEGguseL59sSRbcIYPPDIyYfm2YBsqReSkVTK45E5NtEmovHrv+h/BwlGFhQi1WgVtf4UScmRSjvoM+85EQ0RoLVHTidXu5P7J6+JkuB3etpdATWAGkkQnCHsI+SvL6xd2khPqMIhzT+VgdyCgDvRKHeMooYF0xMhG+sl+UFGevFgDX9maHnRFg2HK3e3o+GR2IN3dBKjFZfT+FuYj4LJj6y1m8cb5NNCs++4FzsAKuTrin810VyymA75UxtVGd3bzaQB9GC0gomH6nmRSYRlex4p3eVImok3jquF8A95TPBtW+drZruW1ZhAJ003rTtIR8Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ/8gu8/yIZp68qeukr2CQCj8O6B5J8tEUhXe2nrPVM=;
 b=iWAGa6W99iep3uu2vKG69zrAtZItkKYnHiIAGJdwHclnCN+DnxKiqMOGE+GuJdeCaZOY/x+S6gCKM1i11XjrPV31xD4FxRLoxJgQA2QLU5YlwOOtmfFyFRoo3JhcXnUoDbredn359QiqDGcRZ/BWcpLUII5Cp4hMXFwtwBrdkXyaHaTlBhSpbKSQcp2lCFoPorXjAztF2CysZpYVLjx9+7pqsDkCfKqXV2VZQwBgbxaGBAHjUOKkD6niSMT4l0+jsv80fppsPt5caRuKV4UQfaJY8vJCwSnJQB05hGUUh8WTD7qAoImc1x2WKxonKZTJ0gmMhZGbTIStRLPwr79W2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ/8gu8/yIZp68qeukr2CQCj8O6B5J8tEUhXe2nrPVM=;
 b=sWiLEnGAO/dJEerJgHZz41qP2nmmObXNwwR7si5echkjY11sy9sUBTTU6LL9zqANpMVaKBDzu1+HcpvSDd1fvwyQ5MbruiaAZsM+HvVCEvR/nIOU25ORk0PEOvjH5f1PzYgKoym37xhBekmA2k4/lsbJROWb2E+7Mv5It1BXsplNNoPJGwG/2i5RtPogqgXB1ovM8ZU4xQLpZQFQUlQfxkYaa91ZxHUCVqAKG//T3Z8si79w6dKkIyERxIsdS0Mzlg5oZ08D9TdWZeLuo4Ozl9hpeFSte6WX6BT1jIOKBvQW9iiyiB8/EzPOpSMk6gzCmN1mKaqLNmZEPxFmV+G9UQ==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN2P287MB1744.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 05:49:31 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:49:31 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v3 2/2] bridge: vlan: add compressvlans manpage
Date: Mon, 25 Mar 2024 13:49:16 +0800
Message-ID:
 <MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325054916.37470-1-tjjh89017@hotmail.com>
References: <20240325054916.37470-1-tjjh89017@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xFiavMsps724wLy8asei8vNuZAX43OayfAzQzmT5HV4aeVt+Iz89mREVhtDJOH5B]
X-ClientProxiedBy: TYAPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::16) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240325054916.37470-3-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|PN2P287MB1744:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f1b8de-1b96-493a-7066-08dc4c8f572f
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqkjmXb1vlddM5aSa/Epk3AjG5lqiwNHkFp3cf2RhGoYbdBkgog5ZaQnQkIQZZ8NiAdsGN2wXZdJenPaMbOA4CUA1a6ssewSgquet4LDsqGRSkwV74B4MtW5wrommDMaC+eC+hEDvgu7XlO3Qe7CN7z65oTk8fQq11kKaAvUne6fXjlJztxHEQPPr8yyBc537Tk52rKap162xb9a8NTVe3Ja05huj+cdD6Xtfro38SwuMNwMMKwaSlmZX3V5PzHRiYdvtKdgzdFM2jf/CxV29VpGlv5CgW4RvLcSSzNbA75Pj5MEhCkKiKz7JI+WAXU7p7ViTzvCVr1ZgWJN8bKKQsONx3P+f6Ic9RnAl6Du7LU0/S7hnchgZREOZL2JXWo4m2hQnt2xfWBiFz15vg1/48R4KpN59jbZBWmQ6GWJQdWdIkQRApJznr5zQGUcRlxULiV72hUR/8niqcfYz1RFjnDcQxRSlqTz1jVbafvoj+i10EhMQFgLo2abLnbaxhghfvg8ad8hY/60FA3gRRK4bJOfbzMgMVcAVEJOxzy34I1lnlxJFWswfAX/HhP2PGuay4QM3ggqIJlChG55Z9gpXvVZYULoJmSAKimAModzH+DN9wQ9ebOkknkpoZFRtSHRIYCLB/DRp4UH0mF8Kgkdv3z3So9WhltXgSKW+/MmoLMuD15SGKpEj5DD6Mexdj5VC+fpw/1VYLBXngF1/ByNxvIZvWk1dk+6ouIx/Uto849tuhUFUndH4PbPZ/B8MDx65E=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	awuvpp5VKbEyoPxFzAEKz6qqhUHq9pPzTagMKkBEuZbbXye2xXULFE81h4n8jVoW0gg4VPZY/iyjer5QNZYiFOD9p0HEwnLfKcLXNhdlPYqW+Lj/R+6GoqSgM5LEeUqij7XilgG9+IM26fgLHp2GlEUE3a8rV0Xpv1E4kEGCIBDZwzbcdJl3v+C4Fn6vlFdus60aNyRAuMgRHQNj2K8eYsbyuEXr+fPOIcACqbb0qesWhBV2MZGXM3drA1yrJYBHDG5It9G4N3K5x1Io6TB/x/ZT5+lKyebKg6yPnltRM7Nu+V1SreKp22sRwPpOHUjhZ4OSBBWxAEtspAFS5kh9Mws+uaoE22pgRH+xSLu/CLFWN+tRfi/eyf/Q13IvsKGWYTcSR+KrL3O6dUB/z2xdFzmH9poMhjrufjYvMmVs2hlZ16Rt+Jc4TNV9Tbov365U4rNfmhzpw5IFIZsIaJdWhjNPri6QMMGOtLmY3/CmgzcGdogwhRv+2kd9odkQ/CTmtivSXys9OF1a27mK+0p2muaxMk8Lv8aAMOHJayBlnjCKBWeHbRFSNEjoE1VRpbfgabmj7HIoCF1jU11Aq/9BNcePijIJxRB0uEymM2UlJeb9ElD9GG5TAifPTs4FVylT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsrn0wVzVpRWOVkFucrvku+KSVJ2zEohgwZ01DuxSh0hU4IArJHBf9Lzd97I?=
 =?us-ascii?Q?y/KvSqPZ1F3ezh6vJbxhb6/Ol3qKSFSCmpBU7tS61DatEHA5jStM0Lw41bRk?=
 =?us-ascii?Q?4kXHvhFyjMJmTMrW5YFJeH9iHTLFNGBwHU5OotfYV38BCASDMvtEcM5UvJ/U?=
 =?us-ascii?Q?ege0TeJjIS/tcfA59V8Ji3rA5lhV6P5fmM/lLT+1ENyNp90n4bl8ZeZByp1G?=
 =?us-ascii?Q?u24otKGne3+AwqZ0BNQCIih81BaQi0EQIwkKcwetQIUPa2GCw6pCCyRwRi2Y?=
 =?us-ascii?Q?lgJcN8IJUp865eu8XfY9cWFXAsUQoszqfjoYQfMMwfxOxRqDOXjJfNoXduC/?=
 =?us-ascii?Q?HiTfd8LYvROjhzXt0A8vrZS1MJFZ3APu/hwWTgnB6VP1MnBgE+ZqrzxK8nMv?=
 =?us-ascii?Q?e0/eMxJ3NYCRoP0wv1k9Z/V9+FaQdeSWSFugXmHGKWfdJu+cA51r66pTOZFW?=
 =?us-ascii?Q?kL7z99V4Rb00R+Pv+ckt+C+mOpNtC0MSLWFl2zG9DBxLcbT7+joPcYYxq/7j?=
 =?us-ascii?Q?Ttq2UJFlUHVDntnMfW70u/5cdVZFVzPHwx/tTRhh6PXvMWsb+u2dCGN6Orgs?=
 =?us-ascii?Q?+6mv9akUF3Lki0AIrz2X5Ya/mwjAVC0kHHQJL83mEWE+YBE1rJfdCoLu9vqA?=
 =?us-ascii?Q?ymZbNbuuHUXyU/m9dEC7YQWH+4IqwxdlP7hlyBxM+sZRy9nHj/R0+l27ImSJ?=
 =?us-ascii?Q?SXhFRToIpfD3jncMamPUwozsyJtRWyzbdTYyv671kYqlP8FoP8hWtQeCvXCX?=
 =?us-ascii?Q?U6x0D1MNvPNM2TBGfvKJSv6OfMU1r9riBkxJPkZZOtOqK2nHS+1A5jqRJSFB?=
 =?us-ascii?Q?sJ2432Uvzub0+gmSg16mGlYvY584PacPfcMae1LC6kKGiOEUltOkY8SgA4z6?=
 =?us-ascii?Q?rbJn4bW/TXFRFiTNVcfwyRGmDmHZ7RWZz4KGDRMMQJOGFCoYXSBlnfXOMthW?=
 =?us-ascii?Q?ueSSHmLNUUJOM9w25Ub/XI/WvnMbulyw6khxWRp5/OHZ0qMG41V24Njg4SuY?=
 =?us-ascii?Q?sr3hEobzQgfgYMQG2+D5ZHUfPKzrhw29D8xDu2vHnFeFKSmcGUEr+J0Yo3MJ?=
 =?us-ascii?Q?51npqVy7CCYLtNivi7HqGLQ+mcpofLVqD14nFZHgZKiMK8fKEkQWObJcxnxq?=
 =?us-ascii?Q?/VVS65R+EzxQDchY3ntPoQKZxCE4X+mk+WwWW3x8LKQhIPzikND+u08LhgsP?=
 =?us-ascii?Q?AHJAXmgznM/JqxQHN4kfUfM4i465MnBzvrmq6FIV/c8nSKXjSd8AZ6f7mJBw?=
 =?us-ascii?Q?rUPLha77hlImCSHQ1Kl2fUiw8PbmRrX5scumk/NByo46jgNcumNaTrcEWWNU?=
 =?us-ascii?Q?OvM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f1b8de-1b96-493a-7066-08dc4c8f572f
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:49:31.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1744

Add the missing 'compressvlans' to man page

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
v3: change man page desription

 man/man8/bridge.8 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index eeea4073..e614a221 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
 \fB\-s\fR[\fItatistics\fR] |
 \fB\-n\fR[\fIetns\fR] name |
 \fB\-b\fR[\fIatch\fR] filename |
+\fB\-com\fR[\fIpressvlans\fR] |
 \fB\-c\fR[\fIolor\fR] |
 \fB\-p\fR[\fIretty\fR] |
 \fB\-j\fR[\fIson\fR] |
@@ -345,6 +346,12 @@ Don't terminate bridge command on errors in batch mode.
 If there were any errors during execution of the commands, the application
 return code will be non zero.
 
+.TP
+.BR "\-com", " \-compressvlans"
+Show a compressed VLAN list of continuous VLAN IDs as ranges.
+All VLANs in a range have identical configuration.
+Default is off (show each VLAN separately).
+
 .TP
 .BR \-c [ color ][ = { always | auto | never }
 Configure color output. If parameter is omitted or
-- 
2.34.1

