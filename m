Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792930165;
	b=VXJmRTBYjEmOANGxPlwUIBypMJOXqlj3ixFWK42OKI+STrj/8PZO521vEb0a/ReEGQzn
	 AFRRWlULldvjGixlXpiv0RGtsbEUVIae894NfdcwrGUBsJdnzReTSuZ029aBxqL+nGTCj
	 9Or2VrXzjqa/CAdItwaFPyssYlFr2SeVme1U066g6cgVaaE2aQrTOTnjQPMY01br55YMs
	 c5IL3RT/mDojlVm6FTucJ32R33/6JygcE0g1ZXfsDDuljm8FiSJP6h3qXejM2SLDH+oN6
	 76RUh4aHacW7wz+9vZ56J1wee4kSmzNcKHMYGZo9j+X3t5G3vc4himLkWjmfG+O1ydA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792930165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5jH3MRV+z6edJ+GIC/0hXKHCieyo5wQwkoHRLfB5Nis=;
	b=nfKNGX5JCgcvKtundbXFs2Ah5I9WRgx/doNEOHQLHYH7WzQTjqqQbRJ0sglYCKNnjgQ1
	 OoMJbUcA2ow3EVPX/YecUcjY7mqZGYJ3slSkyksgkH7gMrWAiF71Vd/EBrMNq+KV8smLa
	 hoSWOXoaos8WQ/IGLFJfrX45hf2oUAEkiFi4SnFU+iNsbQazulVvxzpa1ZN10/iKl0u5q
	 anBcksjjm/+Xn8SinRwyveJuehqEkbPu7oqsmAXHeyGlReecU3s+5IODfMyFLmoZy5fzi
	 Rggtx8YwZFG9t7ClzQ+IdEJSA7dt/uta6+outFbmbKQuaqxEO1bLpwlOjeQU9yjtY7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPAHdqxs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.61
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F12E606A31B
	for <bridge@lists.linux.dev>; Sun, 25 Oct 2026 12:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F12E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPAHdqxs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V977JYyiXoC+uSSRUmWVIwHyFVn/5x+I8H6SfGh51P1ldsKm7rFowot/ukkFg90oLnxCeFz4bRdEq8dqkblqKvzvihm1cRZdqYsTqHmVhS/MF5CeEuYN3TF5OwTALexE99PBKgxFBFJwJ73Cx93J2ZgL+SLvNPo+8OVHhpTfiEPxKJp9cTg0RGpbth5f/pV4GEJnCsmgV5cu6NZvLH2WsSXrcpG75gkUtEKrq44LMHoUty5Nvc3iHMyumGmMbk1qNSaR9McJadN8NglJbij/8n8JYTO6rt14jp7SYZkTPnVZDxjPTCidd4PoTFq09BZ3gHGnnV5tC0Mjxd2g6Pi33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jH3MRV+z6edJ+GIC/0hXKHCieyo5wQwkoHRLfB5Nis=;
 b=DxVxnmcTVI95Lmp0nTdOCxpYtBG1hHeWoXAEbJmng+k6DvD4fls3G0pGCZFq556kgREh4ZSOJCxGk6iAG23cROrx6vW4CusZZ9q+o2r4lT/hpkIAY2Q6+fZLnxo3qSkLIIBePwJB6mAq8TbsrroBqMSMZZowMqGgJGNEJItNIynuhyVTW5ZoyObSZc7JE8Y3tQY/Yp1A0MjdIXVPLFK9KLbHhmp7Jn0MDqK+Ou+RrUYOsy0GJEWfb5kMMf/LOdPpWMbU9hTLKPiffl1WRDWaGyAcwMPzmENWeSzw40PzA+ucxwJLkDozZqNX+qL2kBohWGIQ5ukvUk9LZSwEJE9YvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jH3MRV+z6edJ+GIC/0hXKHCieyo5wQwkoHRLfB5Nis=;
 b=BPAHdqxsWBJoocj9EuRCIX1qwzic9OZ3ARDgF5bTdaE9CVA58zhIHFRgiqRZM3amKZSV2dTEXgS10xTkoXJDhatjXRXqRJDYmkvpCAI/YasgPbv5xqWf2F4kAx7TeTB092ahix2h/2qvLSAv4rrUI1iMWOB0OODYzfCjHhB20oGYGoQpzU8BKVFb+QEeR2V3r8EGw8wA/9b4RpyGRu6TmUVNp9yN+8bym2Vz5HLHyPdoIXVLhB7PoADIrTj7Xx3ANLwQduqHH624BJapjqPdmqTuxiCm9AuMaxg3JcEEvTI224fJmQaFS0XB03Jmq4LJaTst+Nkj0j16M1TbuvdF2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 12:09:20 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 12:09:20 +0000
Date: Sun, 25 Oct 2026 14:09:11 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Corvaglia <david@corvaglia.dev>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bridge: mrp: fix silent truncation of IN_ID
Message-ID: <20261025120911.GA156077@shredder>
References: <20261023014536.72444-1-david@corvaglia.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023014536.72444-1-david@corvaglia.dev>
X-ClientProxiedBy: MR1P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f20e70-6f21-4039-aa43-08df3290ccfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|11063799006|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ihx4aQkVPtOtC1yy6Ly/fjGXCGlOHsd9p+DHW08QNBKslN4kJ2mPPbExq5t6TIoU9QP6kHUIvBcRFnL2S71O1IRUC8mSS2VfeaZHYY/Vb1jwlQ4d0RMCLDvXc3vUsG0iUcoNoXjBHxu+tFxit9a1hSZf8LMLtaGnVbQqcbS6318jELCJtvOPfXLcoadk0wtUDkrAeGQfjXry6oFQIcJUGK+fZc8HtJB3uxew9t9Nhh69VxIWNIlAFRjD4YPyWO/qYSG59S11M9olwaBy6ooC9B5CurIb1saFDpZE7I4iaBDJUKuQVNAD7p2OBJtKhBRTKfsZER1F14na4tYHfzmQd0YBMBRTydtEU/EtZwPXNeQqrw+dUHnd44p7xNBcBjecJZKSio1alq3q6uWOEl16EAqEhuMMYG4Zb4qq8A3lJ+JUTFMXtJgjAQl/Mo7a5WHVMpH0eMgAamrt9GLT5qdzYaEgkJjECEKF5Pd4fkuR6AF85O8PvYnaxizESfe2RXq80hTQU8vDijiVfE2VE+HJGpLEpggIJCxQBvHRtV/vBxyVWp1Awhy2MW9lIJGXgzcPX60OsTjbnwMfYCD8h8yH7VNfumXTzh2EaA4/JwyDTksRc/PxeGMMxpaA3AzprCYkeBexlrJfiSIAp7P+PC7a+Wv101NDIfbi/oV49Du2tNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KANbCz00dhge8tBk4hLg3YOmcECz5qO4YqCxv547daAtmjewh3ajRICKBmsE?=
 =?us-ascii?Q?Ce0jDxPKzhFO2qzInItqXFkxHBHXS9b/ecX+oAql6Xn7ECGkhjbP1UK/st9x?=
 =?us-ascii?Q?SNytQrmKNVbeC1d5jLDQxj7GETkgSEbyVNnVWQ+F3am6F+9jLUrUfRiZQsGL?=
 =?us-ascii?Q?o8sqZOeQDarYwa7YOr86nmul8LeGSGnmj6qUfww0JmPoLN5o1wzW88VLUSnz?=
 =?us-ascii?Q?q0InJ3Lf17YBwlEjHRLSats97zj4tMXsIR2DmYmnbvxjT55peYUcaomQqyG9?=
 =?us-ascii?Q?idSnD+D/L7BiwQS2EpNDZ+Gah4H0WUVUdjfys9EXcBJbaWET3ApHG/Cc3kx3?=
 =?us-ascii?Q?E6jSqlWxhfFnJl63JrafmhArQJi0G9i0mmq/n/XtpNfoxExpDAzCNiecw3ZF?=
 =?us-ascii?Q?c9I2dzLcKTe0+g2B9av1rWcuYXdMwS4hKFIzl7FdD3LoYt7Zi3IvRlLOiKio?=
 =?us-ascii?Q?4LKn6GhR9pY5NxRgFZmUj1bOv6Lnh48CmZ6Ijgq5oa34A/1mkGfxL7JOt4IT?=
 =?us-ascii?Q?GJE8qe+gykA8/x1m7TwGsbtKgEojIbG9dLc1f5Q3UtgEZ5Ldh36npzw8Db6I?=
 =?us-ascii?Q?nWvmT+r+ILmYFoIblcWiRucbccTJoff+Su9NDlDNa3rymC2ZsarlZxMy6Owr?=
 =?us-ascii?Q?fQtmKa44TdkKdPSNxQipdX92fFxmT5sMtllXpvVDxdJuhk9RXahqvpah8d6C?=
 =?us-ascii?Q?4gwEUGgJX2KaZEUtEWyNWcVc8N3Slbr1OJfHAwo2fHFDJ/fwR4hsOTfOeCRG?=
 =?us-ascii?Q?kvXy5RvP9cR0yNKrI/1BN0QxLw2KjCWFGkUxzuY+zoehMMrFCAx+fw01d107?=
 =?us-ascii?Q?xm1wIS6aAMDnVYOkt0g6XVO+BA/Bkkcuzcb7cc98yKVuCcIPHOMMJk0iUvKI?=
 =?us-ascii?Q?GC/wD3YZJPuUBcZ71DYgwKhdQpPlL8mY3dWzJRpZG8pcw82kSZb0H2Q4yNcq?=
 =?us-ascii?Q?9zIai6tc+gObjKvRQP6pYA0Ck92aAmt4YWmzHz4nnIeUquEFXYU4Knn2C4d+?=
 =?us-ascii?Q?NXkMMJWoO4GPy72CwZebRCu/bKQspAuH9YtOSlCMvRSFPebzW6kAd/z3AkpH?=
 =?us-ascii?Q?t5a7Ep2W6rAOOekjqQN5Jviivuql7nhmEpsEYT61VeNSg4klESuB0UaRPqFg?=
 =?us-ascii?Q?AJtTmXRcsCkAKMoSOTg0Ttk+nQyZ0PXqAPXM63D82qgZv+yA0UACW0WpMh3G?=
 =?us-ascii?Q?0q7sdlWeZX/X47BR2i3szSGrOLva6nc9kO+07ib3Z3FyK4EWlH+QZayEo2Hh?=
 =?us-ascii?Q?jRJMzbD7bwGIhvkpjrnLuPuq85XFi6C1o6ZZrDKeOyfPwqldhA/jaeNmaF10?=
 =?us-ascii?Q?MqZmfU8ASVRxdXjbfXNdwwUY5bxwllv5xvn5H/GhrLeowQZMQ5JLKlsl0hbm?=
 =?us-ascii?Q?IHw1kwd+W0QhfncdXVXjpLhaZpr+Lex8VVXTGArlU5vEs4SK5flUtrQhmTlA?=
 =?us-ascii?Q?eMkezHqVCwde3hDd9LhEYbstSRwz1kWg5cum8gV/dXlNm1FlYughcFqIfSib?=
 =?us-ascii?Q?1M7CznUnCaVgGUmsnQNi1K7HeH3VHHGy/lE/mZesQ9jyt3xyVBH9tmIHVoQj?=
 =?us-ascii?Q?R1EIfNY411bnOBE+W/k7HrW2im8hwvfE0EDyFRbTK+CTzVlyRfUVf7e2deOD?=
 =?us-ascii?Q?X313X7dzrnWbPUeY8gONWKCQS6POJtGaYnENRLnZYme64BbrOtvqx1s++eab?=
 =?us-ascii?Q?VWYn/aELxYmAqmxnrThtguc7EldJZyGfsEzOHUmF1/cNj08/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f20e70-6f21-4039-aa43-08df3290ccfd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 12:09:20.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXIFe17xm4jN0nObZ7OxyyDF4QRgcUB7+GbaPr1JRxK41+7aLsP39w3rkYGc8dS1kV204i8E1CBcGENiBP2aDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

On Thu, Oct 22, 2026 at 06:45:36PM -0700, David Corvaglia wrote:
> IFLA_BRIDGE_MRP_IN_STATE_IN_ID and IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID
> are NLA_U32, but these values are stored as u16 in their respective
> structs. Values above U16_MAX are silently truncated instead of being
> rejected.
> 
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Signed-off-by: David Corvaglia <david@corvaglia.dev>

If anything, this belongs in net-next. Better to drop it completely
given that this issue doesn't bother anyone and that we're going to
deprecate MRP and CFM.

Also, you're expected to reply to the automated message from
netdev-bot+sinfo@kernel.org.
