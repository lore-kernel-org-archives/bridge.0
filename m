Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B439BFFD
	for <bridge@lists.linux.dev>; Tue,  7 Apr 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569518; cv=fail; b=ZirSrFsxUqbJeKBYtFF6GAqpvTyikANU3pt0YghNeqaci4fC9MIRfIAbRx1cAPF5++S4DY44Kbu58swPSrDocdjLutSvvW8XMFHkHR5PCZF0rt0JQxudr5DFd/m5v1qgWkPzUd8/h5txM4BD/EsQ+WX3TMpQIlW8aM3xOApuH2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569518; c=relaxed/simple;
	bh=Wd7xjIX8/1m6IFofyYqA989a3mrdBDbWLPhSqKgRzRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXvsltTR56n5+QKmuVUPJdBoaPOxUIWDgUAteN8/FEfbfiUy84zDHgULphgpbBhNiszch3uHTYUWaW/xrpGQEjQ/K2j37gkDcorAlJqiY6Pm37AydMnQAIoVKcqURnqII0al2cSeydkz9AhehSFYBlp4mMMK6KX+BebzK0OW088=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NqS1/Dru; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NqS1/Dru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9EEjKuwYmnbVDm13PdPHrV+nN/CNEQ9A1ac2gFOCZsQUJ/zE0agcUmlcc+DfM/QVKYju3heLJMfMMfv3WNmshixj/+z5/+bLmOGYWKyfiKbup2VMO/yVGofoTadx1wzj/BtJjYPSK7iZWFmnvDOHzG6Vy+q9k+kfOt2BOJ8c5glKEqrlrIFZmPlNCPeA8n+hYL7Rt7lgvK77Wfr23iPnG1eA4M730YNTi/twZrSko9OnTjHajKm2pf8dtwCfzuO9PYP+Z06IqTUGEtEXVoHyKKPkQGZbXydz93ITPR3ohDgswXs17+MJ7EkOj5Y5v7qCRD/OifOLBbSiHQTcQ4Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dA6RT7W7ZNwNBDpA9Gn9UcGsM7XWTwGB2Zd9AyBav8=;
 b=sxwM3wFBhqfFApS0cNoJc4w9c7nJN3MRVA3XazpB7tiBVI+9ttybPYPdkA+rSYenh2fxqqxs6oh0HYK22zya8PgEkKoGCc5DG+fAnKmVD5jUBbliVWLFVpF1ZNNo6FTd0m6skm1DlOfKbI+kdNrL+n0Q0B3xBd+HdiT+WXrY1NwC6NDX641HypXdzdub0vjWPU6SgE4bYZQCFO108wgu8C4wzyF+lHrt+5qEGfIhmRFuCXKe9Kf7E5AP5zq8KBsKaY0xzPHIURPvzhHieHAimE/sn/6kJOewMISM4l2UEdzBy4/S1M4nqtdfO4Y+VnFxvDFHWrdmFi1Vp09lVMqYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dA6RT7W7ZNwNBDpA9Gn9UcGsM7XWTwGB2Zd9AyBav8=;
 b=NqS1/Druq12OC0HNHjb/chlA1qOoGFp+Q713ZSDaNynAkXraMVIiXZX6zSNM+1sPJsWoyQXdpzWmmIo4pC8HIuw3sSlP8nprO7s7H72NhgYuKlUZe1rfXsCISY0LRUtXvjlbgWLPulgRdclNNjPZreqq4GhDGtaE2RbbQJURcXjJeDQr6/6DVD9YpV21p+qNLbYSEtCIUwoi83inro9eOiJF/6zvXeRfB82ErajsK1NwYSvM+OZstKwYaVgar4Uu1swXKhn1mbXYx3nkyZnm0wBXyL8Cya54KNVnLQS2oZHRGLE5U4f4HPEe7Wz906vAqU4UaYbvONrN3dgbD/cPEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 13:45:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:45:12 +0000
Date: Tue, 7 Apr 2026 16:45:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] ipv6: mld: encode multicast exponential
 fields
Message-ID: <20260407134502.GD849209@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-5-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403150050.1235-5-royujjal@gmail.com>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6415e5b9-7c63-48de-7014-08de94abe478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	inJ1OmEoYZWTTwHOHx5mI4ewAgw+WZWYD7lHWgn6ur3wZ4Z+hxWjXrXOwHEViEZUDuzwg1b8F0fWJPMH6QsI0ot0ZNWMQQ9oG4ugBYu5xlz/dqg6Y7WbKH84+YHr0N4yeYpTFFI5XAZlFUgfN2lH7a6blnzPHOB8l2WbKKFzTyy9P5cuHdcPCizRhnnbs/emLgfQ7jv1bqEODXgQtiq3PSvoE6iB/GSfbPLZrHtGxvZMOGiye/IP29J6s7L4+Rip6DNSf4mvopCfih7KXg4F2GHTlNqNjrs60fVP215koSjYvMehR4wcoEoxR/Qi5GOQw8LQS1D8Z5EuTdWlDdYSEDX+esLE/D7vIo7TVes3br0Imu38j+CRtqTR6DumV4X0+Yss1oBOuPeeREsRxLLl5HeC7RgXZ2XVXFBddo9usCajimmjR00FVbME+hCkAGgojUp85cmQUOXY27URpIr3eP4pUP1jzr7UI7eukxJinGNnnJXPz+0NITwiKuAQDXB/D9mDxekpv8QwVU+pIfbICd6xm4bcmmGKc+Mn/wcVpcgGba7FW3HB6Uf5Ph5K5WB8bvLTZKe72OMnPc2CsGkyb3eopnBRVCWk1l+dc+qIpfA/C8KT3KU6wrRhMeBNNYLAt5TjEOAcO0M5tD9DzT2Whi3gcGaWYcoJq/7UvhQs1/6CqcCsAt1XGM/h8EISPW0NRJccoIcC4eMKxZQuTi6N3k5Z0csbuOWK2DkBb/p0yKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6x+Kix1/fB34tZhsn9MHWO2L70zUWkSpD+IYXCyye2gQkeWMo87nbTjR65M?=
 =?us-ascii?Q?BUalD8u0fbYLOYK/wgCiWSfkLNnpqNW2IdvWK5PzNq+c45pxBIPnqI0hrZrh?=
 =?us-ascii?Q?N3HDYRm7wmc/TUw3qc1OkMY76BBSI2oRY9bAaEUbnh9wIdTvTiTqs2D6ELFZ?=
 =?us-ascii?Q?GT6OgNlH8po2UHjNcXNM0+oDS10tycfAMO3cTbU4DPvurRIlazwHIq5jqcgh?=
 =?us-ascii?Q?T6SRStv4eW/ymV18UujTjaVlFCXsk2CmA+x6xiY/xpOHDCCsVbzJe5COBSAt?=
 =?us-ascii?Q?wSBckdC5gruxBQ1ftPs6OPEMpuJITo2vvbPzW/FGBVSTGDoy8XOoNKS5UV7Y?=
 =?us-ascii?Q?OQelC4eeUtQJoV1XiD0gDI59kdbTL37Hb7mQrt1N/zjChj2sFCOgMu+b007s?=
 =?us-ascii?Q?+ywf3X/iIDkOLmY5iBb/39dcUHvlOKQItVYtNy6b+Vhgn6SFMmq+M8CB01gs?=
 =?us-ascii?Q?ztbfmmkWeHYLP7eujHvlxXuAaidC4p706KNKmQGV4UWbimXP7pDT6QzzuXNR?=
 =?us-ascii?Q?dzfOlfUwIzxlI45gQt3mx/1sw3deAh6Gq06enQH3PLKglCSmg/DNhYzEqGe/?=
 =?us-ascii?Q?CU5KkYHYZTiMPzKy0w5CgoBswm6ftnsGjP6NvD4AQ5idUtMd1Zyhvil/lgtO?=
 =?us-ascii?Q?ez9hN0WFStw6piDFC7usp2imCIw+27N2OdBoGV3IPivCxILMz1/0wlYEQaYv?=
 =?us-ascii?Q?DIVFsLHkF1K9UQuOKafi8wJZVco2hSmFNcB6BXntTU1iVOxnqFeQlQhmJjxg?=
 =?us-ascii?Q?SYdmO8OfqA3TBWz4DYrkbIxmJ5ZpkzTG4US1nysKmyDvy8OZX0jrfqaKF9CT?=
 =?us-ascii?Q?r7Sod8No4tFOOmUZOZemuyEXv6hLkPBDGlg6VKEK7zq+XxHiMaFfIPpugHPb?=
 =?us-ascii?Q?pbfU0iJKtoMdrzFFBWTYxDHXJPok14ydY4AzXuwG16l03tl1SlPz2pxSPRvz?=
 =?us-ascii?Q?H36eLFL94S65VUPlfsmjfEtSwLGcRGc8aAZobkLkrgNU/Liq33GekPDnfCIM?=
 =?us-ascii?Q?EAshRvDwlEkegFMV/OlWD8o1pFAOKDeix4tHWRriVGVUYfm9aVOE2mOfA2b2?=
 =?us-ascii?Q?40WhP5qPXrkl64sCyuSdY7b3aHathGThHhINcTt4Azp5GBBpU6UMltN5Gc8G?=
 =?us-ascii?Q?jfJmyMIViSOQ2TgVaboedLsu38VLXfEmawc6oxItpQpeqToPlJNMqvssiU5Q?=
 =?us-ascii?Q?92uNpEfqvDLu1BCNXSimeMXdgzqBpuaFf1jnFEXbtLl1Db7TeE8oHkZUHuXJ?=
 =?us-ascii?Q?KHX4dmTKVkD8utcd1YvpSxpJpF+WnDgCra+e3Xwg0OSI8uL2GzlLOUClvvix?=
 =?us-ascii?Q?XkfU85ua2aPObgDOidOtRenAMXDmZoeqWni8bLN4zFtqOq8mZMKxuWb4h0wL?=
 =?us-ascii?Q?kHcypfmHHEbnfPWGY2dFKeMwPkXi2luRPVsMJplcZhe/uGmXT+OVeEHjtxGZ?=
 =?us-ascii?Q?qghX/CroXKBP44if4FJdqgoXVuP5g/fuLS0juZg8mXL5sd5pfm38EIYAMPPR?=
 =?us-ascii?Q?BzsJb8whOaeOEb7IuB32eDTwF8OwlOsBcZpZct/0S+DLmtkDP2/sThhANigI?=
 =?us-ascii?Q?3HKZIVZ3rSjyKRo1AgSMQU1A1XVJpiVAfLEIZUUxKNtLN8bm+LMQfF0SuoHR?=
 =?us-ascii?Q?YO9tR5jx7IX4kg91/lcbYP4zO2bHQQA/2H5MVNCWYE7Tn8eBGB9w+Qp3vz9q?=
 =?us-ascii?Q?O026rWo5G5NpQB4gJlsJbTfLQ5v5MLnJAj3ksD4Y3vNZm8s22o6cA3YfDltk?=
 =?us-ascii?Q?PcatP0bhCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6415e5b9-7c63-48de-7014-08de94abe478
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:45:12.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOh9MAYBIVQWyNYiftusRXER0+jVFDsln5fjYRSVjYCQCO4v78iL/XvOzNHMYLO1YqMqCHLFMxujwps4x30OvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

On Fri, Apr 03, 2026 at 03:00:49PM +0000, Ujjal Roy wrote:
> In MLD, QQIC and MRC fields are not correctly encoded when
> generating query packets. Since the receiver of the query
> interprets these fields using the MLDv2 floating-point
> decoding logic, any value that exceeds the linear threshold
> is incorrectly parsed as an exponential value, leading to
> an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC (8-bit) and MRC (16-bit) fields are
> properly encoded when transmitting query packets with
> intervals that exceed their respective linear thresholds
> (128 for QQI; 32768 for MRD).
> 
> RFC3810: If QQIC >= 128, the QQIC field represents a
> floating-point value as follows:
>      0 1 2 3 4 5 6 7
>     +-+-+-+-+-+-+-+-+
>     |1| exp | mant  |
>     +-+-+-+-+-+-+-+-+
> 
> RFC3810: If Maximum Response Code >= 32768, the Maximum
> Response Code field represents a floating-point value as
> follows:
>      0 1 2 3 4 5 6 7 8 9 A B C D E F
>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>     |1| exp |          mant         |
>     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
