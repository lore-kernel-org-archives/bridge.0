Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792916378;
	b=V7X+QmVUaJPkV3VGJW9RKJePATa/Gm8qCkC3FXliDh3/z0OoPdnR+a8OE9LKFqRYoOp+
	 3/y/M8NdxZlX8Yoor+o8bs8A+3Z4PQwVdV3tWYW7qSgEsBn2KpKcNvFbs198abpeQAgFs
	 vlwtKq8viAwTr2xR0jgGHHg53QMt5D3T9rW+vwZ0KvmtDFmCXc0++g8nZWalJkGTXBzJJ
	 4Xqs2sUrjNDbPTmIZ1G4QBhyfdLa0/5tTo8KeYCvWsS6fLmoPE7F84CAomtrVFs4hHd+A
	 76+hrK8M/6BY9Tcr8CpUDu++WBZML51HrcGMjxKD3GaEZVI4rxnsEwrlasWX10O7x1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792916378;
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
	bh=rENUgjkSDwafXuGlPE0izRwRmb9jlJcnSRhFTBtc/lg=;
	b=L3PcKYoAysme58zJ04fKn+UKxIqxqf0HqUUwdIyoe/2CBskWZQfmqHaUmL2FereyOfoP
	 cZU3Wf1Df/UvzGfY9ao31harPzojMLP+ta6qf9CiwX61thN4m02Z/QyV7O+rdbRlbObG4
	 9CP77DdL5eT4uWITAWHjbL/mwblE9Ioe5FqqIYwRvQ0MYmVMumIf+vMCWqB+rkuOw2cJ4
	 o3VqK/MAkFx0NfZ1vdkozoPhm4IUpeBeE5L+zux2J+eNakjdYZBVcUCVbXrZFFIeNqNfH
	 fXDd+priLJtkkrz/wUk4TgAw14eXq/0Pl4knUiKqkRisIBiK3jU7crXsHe140Xv9+Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rhBVIv06;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.26
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AB606A31B
	for <bridge@lists.linux.dev>; Sun, 25 Oct 2026 08:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E4AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rhBVIv06
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND4f2F+ljBS+n0lFW6kQKHSOyUMdBGHF8HDAwWLHUJk+rhmXfvzvQ3xIVjw1arOClCuoM/p6ynZ9L/3ChOSEfsrRRUBCacMBC0JO7DgtmXkyms7SzYkUHfRcwfMWu3HW7DfTG+C2oAYj9DM24sS8Tuhuk8sKuVaLPnQslVDvZJpamJmCJ7bRdct/m9bdtiLwlBZYq4fTn2DIk0PrmCPquDnoeod7L77lpalHTT39MPVJCEiAePWZ8lzURl5IJb5VVQhOHocLVMbaJq3FvLUb/IcnHOfO1FiSMSdk2U6ZFeveSp4ZiDSVKj05cri7A1Jzc87Qpe3MLN8TdUd2tyNOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rENUgjkSDwafXuGlPE0izRwRmb9jlJcnSRhFTBtc/lg=;
 b=jNwHgyt3MiYkFPT/qJbIl7vC37727Wkd8jYN2H37KdpAk11A+udgGwai7ZfPDps04NuTCwEmMrc1ujl/B0P7KiAStF3lSIH1u5n1kgL3JrK6V+YIY4T/D+bzlwnUteVAAsqmzJWNMkD6R8WsUJVp5bInPaKN/TcdASICMy+aUZ4a+D5HvNK1urcFM7yTWIG/WAb9opgvui0HOEhGH1ze/o1R2I2UMGAFGQJjeslsBGSULL2yKU4y+mJDvnyvyGdgVnuQEAoprOpeXNQUioTmNDCC9r62wlMpdXq2yAVLdC7nH992FnbkMBbhJbGwW8iK0k/b5Eo+doDerYjGn1bJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rENUgjkSDwafXuGlPE0izRwRmb9jlJcnSRhFTBtc/lg=;
 b=rhBVIv06Nf5M1w2TmxsY6o/Xe/3rm34HzZId0zynwZ5QYtC/Gyme4S5sJ0F2a8RVaV4/zocDhkXtW5XnaYnn9nCCgEdtBBxPDRP9dDDt00c10P0X4lb54n83T3JYksTdrRr/22jCgtDQ1Otgz1eMlXWdHwmpF0ywTv3gFCXnXymxVPBxlwpEihQ/lE/Mt9FGZM7z07NP/3UTp7m2kzZaZ0tPTZv8GDnEHn8cLybsuuNkyNiR1cbVWGPlRgpjR55YjzVsp4ZxUm1ymMPUNhVpAVT1y1r4G1zyHKgOyZQodl9GABFt8Jx7YCrGcTrj7tSl8CCxpYcjO57+Fwp2A5VJcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 08:19:33 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 08:19:28 +0000
Date: Sun, 25 Oct 2026 10:19:19 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net] net: bridge: flush FDB again after unregistering the
 RX handler
Message-ID: <20261025081919.GA53797@shredder>
References: <179268538303.70821.8213834342995341232@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179268538303.70821.8213834342995341232@gmail.com>
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 92857034-092a-454b-5a1a-08df3270aff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|11063799006|261009223027099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NqtF9/TS6aUo7yWNh9trZ6LpBWwML9jX7E6VzozCQIanm+YNmzEnn7+jq6xT99rat701b33qzDC87M8LXygaIaQ6cdSlBkM7htUrtaD79BLMjVj73aWNkagMg2OTpM/fob/JreXiCka1XCNy/fprtRViuhRVeg3vg7pxEZuhSKfsrvP+2R9hpYKe716hfHWj0q5JboTq7Q1JwMBakZZDm9DpiiMQcSot76GQuPrB5WqkGfQ0pHUEeiVR4pIL+xQSyOCpUuDWwbp/PpUgONt5C0EBQUTSRcgAQfB23atQKLONmRp2/QahU9T6fbsDiJxZVQJl246bHGCkvaI5x3eT29EaNzUSD26GyDYCin65vmpP3Ude4Q05F/+FIiRPqNrz4DUbtbrYmOQTV3d4u78efrJw/m1d30p969/TU4k8rkrFNB0CPpQRbHp2c7fJDOp0e/jbV4JACTEMCR+qjGp8sr18TOccr8POCpxR3LTXWvkNFMYxu4q7Bb+fVOPdciCuDIK7qcoigN7pQ2CR/m6GDRDcNyAP7neqUb22HShsCIRq0VAOF9aN36o969ODtsspD4GJjhT1+Eb01tXlFjH0+kwKV6NOtQe7NJ3l7wKNd+2o9zh0jshqCx/ZuJxocABR25Wkl+HobZv6RYG5ywaQbF9Y5dS4tfHODpLA1uszQ9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rL9zTDTIxjldqrFAWpen9OcgTzqUwHcE9JA9aueA11ycEgusQplrxajZMIRi?=
 =?us-ascii?Q?oKbtqkcdjnqdWSVYZp/uMVuv2P56G44TMLIgA5T+JLrtIgDLH3wH5h7/jUIQ?=
 =?us-ascii?Q?nSj/f3FxjHgDhXfj2S7tI0o1MkNWD/0Kwc7u2lUekpE01d4d8he/qTdLMUTz?=
 =?us-ascii?Q?2p8NgVydVTA/nIpmEVP94IV7egIB/zrMm9iupWHbuMm5eIZE8trb+G3CaR4P?=
 =?us-ascii?Q?aMRcT7Ema+YgHhHEfd69rVopVUTmJkBvUOVJ5FnrywmIMPvX5cm1/aIpyAVu?=
 =?us-ascii?Q?MvAjhMrgs+NlLOCEOLU1bW2veR/GX5xuaj7Dexrxu2douSnk/OLuKvUboesd?=
 =?us-ascii?Q?EB/WogNXK2sUi3KNzD9Cmsr2FiBCvQGh5K8mBLtulZNd6o9obsQShqL7VLSI?=
 =?us-ascii?Q?AktytuoLsAgVMCRsBoe9ci6eS4P/Fk8p2SbgRcEbqX5HryB6XUUkL/fUtZTj?=
 =?us-ascii?Q?MkRU1q4Lw5NDfPlQ7aRStZjynENIAxt6Td2yA2OGYNUtw8o+igm4lf94lCxe?=
 =?us-ascii?Q?kUuftR277Xut91gnYqY4AOVlvBjdXNgkEd5It5e565FFfgdsoYVfjTFB+O+S?=
 =?us-ascii?Q?b48I46CaztBemrcJLxG/t/YFWQ+6HZWDKOcx4f8KReopsn3U/jcgjAoBdRFu?=
 =?us-ascii?Q?UcbgFb0q5+7nwQSvNsk+PORbBYdCXtJz4Xbbd/QLLr4vVCB36c2IvKXEfCTS?=
 =?us-ascii?Q?hilv9apLqFxH1tPn1zjSLw+3oLE7evaTYoSMIoWYLuDgkixxKirNSlOvJFi+?=
 =?us-ascii?Q?awvRSovhacVvJa0pkN6Vxs5jBRT17Hw1bZJqj+TZVqJqnc4B7sdbC8Z+p6gk?=
 =?us-ascii?Q?grY0BoqLRREDXnaxwYsdVr6dWiiKwujyJdCpoBoyh+mbQhrAIQzpbygNdfgM?=
 =?us-ascii?Q?S9XmoezTMoHC9QiK00u2d92y57EhzuLD0D/SkWmP+DOQOjnmd1pioN5GfDMM?=
 =?us-ascii?Q?2Epl69w/+jb2fsR2xqahNHQyvF4xiWqWBwt7hdS5cHit5DOq+7RmZtlce2U9?=
 =?us-ascii?Q?b/6BqrH99f3K3Scs5vdMva6YsAn3G1viQIHv9U6dB/xzXFs/ib8MZWT1Ddur?=
 =?us-ascii?Q?1uF4Kgm/kIPRpWOjXGP/ozR+SINtv2pVdfAUJvRY35xXKeYsOURMpse3cdsO?=
 =?us-ascii?Q?wRuGEWQC2ZQl4hIaNytaEfumXoI9K0QRqKVGH0s0DfRD2xDPxi2l6jx+mSaX?=
 =?us-ascii?Q?2X9QUSsnwLzm6v2gukapdq6nCSXeLhV/Rzqk8jpHXpoqXwbOGnB+YBkngdfe?=
 =?us-ascii?Q?HgJT4wXom5yE15p/9KcxGSoRoRrBS3M/L0K2cFF+hG5G3PEoxphqeuIRec0G?=
 =?us-ascii?Q?36MyoCdmOI5D8l4fycqgzcr4g/5hCWkYOmDxB7zHdFwRI3abG4CBv/B+luLh?=
 =?us-ascii?Q?okp5vE0Oa+Bsa5dx78lIT0mZuJ4/1aU23Tktexm3B/A5kRx0SiOCJNKaC2Aj?=
 =?us-ascii?Q?EgxhpUbI6/AVAyDRHVHA1iXr7W9hAPjvubEgR/3G2OtbBUqQUvkDETKXLkSQ?=
 =?us-ascii?Q?FggF9O9Mun5Rw2sX4zTF16UA/ne954yMIsZAO7meztl2K7LpcP08uhXc54q5?=
 =?us-ascii?Q?PtQiEE6CQacFhcSzcZW4V31wei/oJNH42/ybF7JpAoDyAtUQ+cKsIN8zudkB?=
 =?us-ascii?Q?5GYobbGS5p9LGbLyghyJlZDc+h1yMk+URwPt7AxXSfaT02Rnt22ZNIzRQG1n?=
 =?us-ascii?Q?y3REBz62hpswGmf3MlyscNQCb1dJ+32WM/DdGgEdbrfQqskb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92857034-092a-454b-5a1a-08df3270aff3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 08:19:28.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS9AFVcNfL/xuwTHJTNz17awx1FtnQSKO9Hacni1a5435fIxgNKMiKXTFNGpeBACGUH4+ncKpnb0JEFCePre1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443

On Thu, Oct 22, 2026 at 08:26:49AM -0700, Cheng Yongkang wrote:
> del_nbp() flushes the port's FDB entries before it unregisters the RX
> handler.  For a normal port, br_stp_disable_port() has already moved
> the port to BR_STATE_DISABLED, so no frame is learned in between.
> 
> That does not hold for an MRP ring port.  br_set_state() ignores state
> changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
> the port state alone, and br_mrp_port_del() then sets the port to
> BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.

Same root cause as [1] where I suggested moving br_mrp_port_del() before
br_stp_disable_port() so that the port is actually disabled. That would
also fix this issue as the port would be disabled before the
synchronize_net() in nbp_vlan_group_unpublish() and the FDB flush that
follows it. Can you test it with your reproducer?

[1] https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
