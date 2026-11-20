Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187622;
	b=X6jWtMKmbR45EEkj3P3DsgpjAHucWys3zxW1SdgMiI1bHlpyaY5Hf2+ztdVSMdPqsXDI
	 d1RPduqJlvG3YDBWJFgcgBFRt5RkotddCE4Rs6XUQtuALN5E5N5dA9tQa+l5dATzLauQU
	 M0jOexkP7rd1HJpUNrfEORigNW0mwQaFdky0wffO6ibOymEsQYMmm9Y0b8HHKybnPizKI
	 Si0DlW2xYnEh1k6jsiO6xt+VHyhbL/bX7siKBVzNdwS3zPgjcPBCvgXMyw+8yY8eyEEEm
	 FAZ+lMAPtZtCf4UKLbFHEMeudfWCesp3qCPBbl3nisok0/zWOpVe6tvu5W+uTIKW75Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187622;
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
	bh=PeJaU9HETn+BvQzI2bDUD85UgGgazaNwhJXZAmpAEy8=;
	b=bP0y9/ATDdYpocDg9915p5WnAftCOzbTmFKpaXfXXGYCt3VrkgdDx22TxXrpp11ak6Np
	 RybCeD2Oc4Pj3zM8B1kEI4IdP4WefRPsvTWBf7xhA+0qHFXZNDFFVkR17dOC7NoWsP/cf
	 FxcaptktSOhuHIhd70FWWHdTNBNXPy1ixxDyq6GwgRxSpGzrn5ggYTCQkBC9fFbYqsnkO
	 qTzBGrDztpKn8QvWY3JaGchbfn2udwzf8+ldMK+c9XSg9HG6NLL4r4gtCJEH8hylJkPwR
	 rL/K3eAFKJYhhqTlu2odXOQO6r3sOFF3esgC4NxK7gXO4KMYb5aw7kCuteGENZbOGDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iH7QLc9Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.42
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3404606A326
	for <bridge@lists.linux.dev>; Fri, 20 Nov 2026 15:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3404606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iH7QLc9Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+8h0ZEkS4hT/2NamvGfLomt+R5D3g4ghjkgkMsPZgUitDg/EfcDKFbi3EcQcqz5f/8P79K4dbsaOXEzvB6yBj86IiXeZQiQYLZLscWPOZpWrV0/C6uRsay1CRj10AsvuZ+RGX5Zl76QinMTIIqyr9n7RL6vaIh8Ppx8kEc/iltfzVnBjV73NVvuRqJMpI4/s5XJvHijopjRuAUwI2Jt2a0dZQLJzKdRnYCi+zZjphetw+1GAeSYqWM50fGgn0xrjk4O6VYgJDbdanyeiAppiHES+bQmjF7DsGkxl0b8JszhdKdWQwCMijNrPM1iwB5lNfM87+SIEOj3juvL7Q2P6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeJaU9HETn+BvQzI2bDUD85UgGgazaNwhJXZAmpAEy8=;
 b=GcKFlz4W/OvDS7XFYsiIon6aeoykUzXR2HwxkAvWElY0w1YH/XUxH9yARfGP2KorKDS7Bz6tUfE063DQDGiDWbIYi3IPflNEk/2QeH6vKv2H4W8aSwPq72P5M+RI9MpEj15H/M9Pgz45O2lrG++s7Myvvms47JvKiOto+jTHHv5BauhIZp8LoxcBtS7WjoQ1Sf/Zz054Hy5MyFkE9mZIvhNbll5mV48480+ST0+7yQHoMKl0Wy2NJwhLntf5hMbnynyiuFAVD1hjedK408Gv/xKUSwZVFgYYiPuTuo4EspDynO8B+5T62JvwG1beFg0B6RzGryHdW8S44pTaIRz9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeJaU9HETn+BvQzI2bDUD85UgGgazaNwhJXZAmpAEy8=;
 b=iH7QLc9Y7ynAOoLmsNIIh7AkEmDtTW3WY8iPNFTjNkpru7yLj4cxU7522yLwduL8Wf7UwSDPtuxjMRxej/RUWIYU9r+yNIoP3JVTa2Xzg/4AQ0Fqv9mLs2SHiyng8uZeUXzYhyY4KW20ZUlknnQNwR1nD7DJ/ik8KUBK3eYqaecUup8Hkzu/sMPlI006sJE+sLGOvTMm09pUnE1K5diFlFYl1sOnF2eyeyBPRm/Q37UuKRkBWDdZiIaSu0ES1M5FbjTlsXQ5BfznCH583sZOu8QgSxi6NmR4UjYE6wiSaT03xvAZWKnCtCOcZF0wrARs/K2bD3c8m6Ik90fkBbkLJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:13:12 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 15:13:12 +0000
Date: Fri, 20 Nov 2026 17:13:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Kyuwon Cho <kyuwoncho18@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: bridge: mdb: duplicate sources make the RTM_NEWMDB
 error path delete a source twice
Message-ID: <20261120151303.GA2280404@shredder>
References: <179489219555.3099318.10297266282803881244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179489219555.3099318.10297266282803881244@gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To LV8PR12MB9407.namprd12.prod.outlook.com
 (2603:10b6:408:1f9::13)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5b7a5d-3f32-43bf-430f-08df4718cadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261021121427099003|261021135927099003|261022105027099003|261028144727099003|261022075727099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bf48g2bCp7ZdmOcRdz0GRmfY7pZMJa8Yz0KPVpfiviYJy5zrnae+KJFFxH0kboQb4SpriE9fHMV+O5Rnl+Rs9w8CQlZmAzuoY6wr1wr/mjPABNcWt+sYE6CjIWypnX+TTHy+Oir1W2ARJJUzVc8GrgV8G9VzxqAxS2eG/FGzgnR4yUSfc49uWFjuNYmgWw/hg/dHuRNf2kmIlKFB3QaDjwUGkvpRf/lUaZPQFiRXHseeRK6TVrF/+dyxn/SymzNt0hbo2DC3xOy9rfrOAsE36sz303QEI40lgBLN4MPf46F1aYHtO1DtV9YOfEJg6YQTZUmeiCM0m3ts/5GLp/nMLLcg/myEzCE4sgyZM8PTsIpe5wc4D6sWrs813z9z/apVRwOFGQP+nW41rSUYMSwZGxCo5bhCYW8GlOLfg/OzouaZKVzFg3uz56n5ob39yJuqZxTs3q6C6UHiXjw/jippYTeFPuFeZkGmxNylMuXp1BT1CCNzf/RKSWAbtCz2k1kkJ/F0mKbhe6fR0s4+OT8hP4Vj5bnjBHcOIgQuQaDTg/KYUWiDoPMiyXfbeQHAYxEKH9XvDy6No7o+Y7q+1oHwl5IA8RsTeFBNnBuBzIQatLwaePtrklQsNmG3qfTIowx+IRi1kxBaP4si7MYtkXCmc7eBcpz/Lm6T+Ek5YjLoidQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261021121427099003)(261021135927099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/VqswSfoaXWwaqEPb8RN0+aCOZsxM0xHR9L1HnSjQxgMl49Qxitr++TBm2w?=
 =?us-ascii?Q?fAgmZW9sxJxNVEV/e0P+3tHC4Ex3Lg1o/qpjfXWsqsQhW7Uxtzi/M86L53rk?=
 =?us-ascii?Q?vs0sdUVC1otsXXfAJpIY+Whq/GKvpl6ZdaqLn3lwwCYgfAZxVBmBfU2vDIwi?=
 =?us-ascii?Q?5VTjnO9QnLr6+cytEQM+YZsQtgK+I1/5fQx5Fh2RBAivmrFo+RwLEKdfYUnt?=
 =?us-ascii?Q?yF1z52FcGCQSIE0VD1Z3BSgk7562rl7OyLET35D+Tt6L+MQq37Mf7PHToAcy?=
 =?us-ascii?Q?k0Kiy/amyuKro9HhRQkKHJsfZteQEksyOdihWC6HTCjqUaOQBFNcskUNPuEi?=
 =?us-ascii?Q?3X1fYMURNR591b6gZdmp0DPIZb2GpIPCvTOyJLqv7Yhk9q+VL45D+16pfrNs?=
 =?us-ascii?Q?VET/0vahOlYD89pUdPzY/BwY5bJoH152OWIH5vm1rv1eCeW31lnBx83X3soy?=
 =?us-ascii?Q?wQn2pktbUeAjYsB6tsBFUW5G5vyL3dLvC0aza9JWsVe6Zi8gWxLBRgho0iLJ?=
 =?us-ascii?Q?Zuy29pe4Wb9DXf8JOcbGBmr5lTN+tv8kgms4oVRO/wVx57NilmbMTEofG2Yv?=
 =?us-ascii?Q?SSV9Z0wjDdSRHfb1L4bSFsYgsNQZlg84EoPjZkMSLyGcP2fIgjBjh9Bdtm1c?=
 =?us-ascii?Q?E/8mSx4uv4KP3Hf3prubHXYH4q+a2nuZ2kXFV/xHlnvP5NZuHKycJN7kpACi?=
 =?us-ascii?Q?NfTYVR3gl4qEqs5nwFcn3uJxPJtZ8NO6KFkgyUr+pcdcuFLFwUodM0UYEFke?=
 =?us-ascii?Q?Zo2NiG7SS7L5jxgV8rA8JW1WK/ZQM7q0phkXNCBeitz2AFHR75bklxPl6ORG?=
 =?us-ascii?Q?+wDZtjTFWJPq8SmbNV0GsZxFC8bcWA3xqinoUSUbse5/fBRHnrdZj0d2WwlG?=
 =?us-ascii?Q?jO4J/E1Efhhi87wHLQGIGY2pvoLvkpdo5jlq7LkIUGbruzcnoE7weUXiMEYN?=
 =?us-ascii?Q?Zy0nfzIzGyEK/HFEa89hrtVbs7nvdPEmEphztBNgDlIL9dzOa6NVCY7iu2LG?=
 =?us-ascii?Q?KArn7//6jBhrfrEvXCA64Dm5x8zWlUD6nrt/uLPWFiBlKAyxEmXmYULuYtek?=
 =?us-ascii?Q?dJjf0hu580LY1RGq8RE1Vsm08S296Sd0rx3TXAh+yK1PgvISIkAlNEL/28MI?=
 =?us-ascii?Q?nVEP8MgqwsbtUD3oBHvMOpQrA9pQ9ug/uENrXtFg1wtD1Hi3bO9maw4neH7/?=
 =?us-ascii?Q?DfBHQr2ZtyZDKs50+7MbbNZ1ZyDyp+Yd/Ghk1/L5MJ8kjhJE4UniK68C7Hcw?=
 =?us-ascii?Q?I7fLLTw+ExXP/7D+rswEV6MuLy1zViMpwE0GCRS2xFMhD3Fz5XkwcMpKQ95l?=
 =?us-ascii?Q?8zaeRRBjv6JKQmeX3sCfMbXdzt32GW2RMME0t5xWcWrUyJjNqt6XJHDRHW8B?=
 =?us-ascii?Q?Mu+6Tb0VNnDgyEcBJLf7+JfeT0aav4bT5Gf660+8JEx8hoC5PThs5vv6GPmk?=
 =?us-ascii?Q?TyzhEHzi6YskhVvQizTAe9c9NGJ1G0bilpB6MoNvcFw4xaBHvE+yQfHK++wb?=
 =?us-ascii?Q?GfzMGgqB9YMQVISYHd4YUxGSti/fW6iX46ilKbP4Dr7wAbn3U26EioT2ZzLa?=
 =?us-ascii?Q?BcURXeXxXZJ1N4+WNHDRWMqM7QeEErXCdxnNJeNqdCftsFPlbR04A69XiZBJ?=
 =?us-ascii?Q?Rd+025581453+gIxG2JcS3XtjIqfKh5jBEvIZyCXSnFELRdpU42cyGqXmrx0?=
 =?us-ascii?Q?mljizoCQvhXl++LFqpqHjtsXI67khoGiJ7L7ugK8EFEartAp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5b7a5d-3f32-43bf-430f-08df4718cadf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:13:12.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X+ZW4woTKgMrTwz9JGIz6Yq6TtqggR7RlTJY1FNWgFXMvTrVM0n3IVIkBzjKvA0eAUDjzZmKx9nQMDe83XkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On Mon, Nov 16, 2026 at 09:10:10PM -0800, Kyuwon Cho wrote:
> Hi Nikolay, Ido,
> 
> While testing v7.4-rc3 with an LLM-guided test generator that we are
> developing as a research prototype, we found that an RTM_NEWMDB request
> with a repeated source address and a later invalid source hits the
> WARN_ON_ONCE() in br_mdb_del_group_src(). An unprivileged user can do
> this from its own user and network namespace:
> 
>   WARNING: net/bridge/br_mdb.c:901 at br_mdb_add_group_srcs+0x375/0x4a0, CPU#1: test/106
>   CPU: 1 UID: 65534 PID: 106 Comm: test Not tainted 7.4.0-rc3 #1 PREEMPT(lazy) 
>   RIP: 0010:br_mdb_add_group_srcs+0x375/0x4a0
>   Call Trace:
>    <TASK>
>    br_mdb_add+0x7e2/0x1390
>    rtnl_mdb_add+0x218/0x490
>    rtnetlink_rcv_msg+0x2f7/0xb80
>    netlink_rcv_skb+0x11f/0x350
>    netlink_unicast+0x518/0x870
> 
> br_mdb_config_src_list_init() counts and parses the MDBE_ATTR_SRC_LIST
> entries but does not reject duplicates. In br_mdb_add_group_srcs() the
> second copy of a source finds the entry that the first copy created, so
> both refer to the same struct net_bridge_group_src. When a later source
> fails (here 0.0.0.0, which is_valid_mdb_source() accepts but
> br_multicast_new_group_src() rejects), the error path deletes every
> source added so far, duplicates included:
> 
> 	err_del_group_srcs:
> 		for (i--; i >= 0; i--)
> 			br_mdb_del_group_src(pg, &cfg->src_entries[i]);
> 
> The first deletion frees the entry, and the second does not find it:
> 
> 	ent = br_multicast_find_group_src(pg, &src->addr);
> 	if (WARN_ON_ONCE(!ent))
> 		return;
> 
> We have not seen memory corruption from this; the effect is the warning,
> which panics a machine with panic_on_warn.
> 
> Rejecting duplicate source entries in br_mdb_config_src_list_init(), or
> making the error path delete only the sources this request created,
> should avoid it. We have not tested either change.
> 
> The reproducer runs as an unprivileged user (uid 65534) that creates a
> user and network namespace, makes a bridge with a port, and sends
> RTM_NEWMDB with NLM_F_REPLACE and the sources 10.0.0.1, 10.0.0.1 and
> 0.0.0.0. On an x86_64 QEMU guest with 2 vCPUs and KASAN (gcc 13.3,
> config attached), it warns in every run (5 of 5).
> 
> Checked against v7.4-rc3 (aebb72744764); br_mdb.c is the same in
> net-next (6ff4c5942a30). We found no earlier report on syzbot or on the
> bridge list.
> 
> The reproducer (repro.c) and the kernel config are attached.

Thanks. I will send a fix and a selftest.
