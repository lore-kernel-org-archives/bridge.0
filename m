Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D03F65F9
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179153; cv=fail; b=Om2Ohq/mRffcMX59G92Gyk0VJhsBSg9zQkbaBDtNB4en3zXNb8rVCrzk3R+868JLn3NpC8ILx+i/9e3Oli0qv/zBd2/9RQKNOrCA4T7TY+vwYA4dK7rOrykY62GpYgfi2ofUsotZbL2W9ZE9Hj7MbCS3jc4ny2zGLZcjNhOxZFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179153; c=relaxed/simple;
	bh=Hc55XJfMSHZjWM+RJz29WaHqu2IsjF7f7VuZxwMSj/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMxZA/+aa1jlrWTulDwz1Blz1SFh4KktkK+53t+stqnmcjaZA3E122kN1TTzXJ3ROKA8hy+j/a5khzppggzKm7PJ3MZnFpPYSihyauauC53QAf7+wXPjYz+wd8SlXh/bxJmYY06HEU5817+sM9bf1pTRrtJixt0Wi2CPxqDgIlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2vJnI/L; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I2vJnI/L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN24r9fHlohvnk52FrVUce9XYkVJYDt/MFzfalnRP1zuLGxeJ3KUhUWTkQG2ggWsx6dZhdIRw8AtRco+U8ha18ECmc0t1lFEWJmTZqczfjsmqxe0pgbmoJD8F1CQWgkffafuzPOZwRywdLP0+wvseZAjly9lYNsUSdBp2dba+k4+TLAPDUrnOYu5/avICuOyF1xb58vxmYqksY35SavyIGj3b0kfwH4qNTqW2FNzYSN/1Qxu/rc3hAyjtlJ/sHsVPNAFaTY9rz3R4lV8OJFwGZsY02cAostoJ/45teklJvnI4fgcm30FHmweZaMPmMndgCPqYfaneaXG3qomHCIAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZeTWI1HO92NXpSiaWmvXAa0mifRGIJZXWDdsVjZKY8=;
 b=LOTIg5b5fbwJm+bDS0gXKjzY1XuvUS8TbBrQLwx9/zmQIbvcq2V4whpdCsCCRMjk1HuRHxLeX+Ez/Ci7SpVJE9fOulBPymNryAG1shKM6+xFH5vRoVfRHHcpv7st42u3RLOMHNrYBpAtD+6pOY8DYh9eURU15GkxLqW/LvlJZ9ZYCS/DrMsUAOvkRv0S7Y2d3YePHcx6FqdHfSIRe0K6y3hyPnouaA2jEvk2E5cdmoi1R+oQTqnsXpz6zBELqS7H4GiG7uuba8+07B7Sr/OD01SxhH1ZCmFR0h+QBjYnWK+8S4qz4SVu5FCYYdhi2szANweozJ3OtoJ2wqrq9siwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZeTWI1HO92NXpSiaWmvXAa0mifRGIJZXWDdsVjZKY8=;
 b=I2vJnI/LnUGucEyqlHhd3gr/tKboqMQ5T+WL4vAvFp7jfII/8lP0oEIY7PPo0v6QubqybX4c0+AbQ8IeqbmDqnENp7mrv9XKT2sPKq4izJeZPVAWuC1xmpzdN+Ac0mHRJQLAZFjT+a9eiKJYHTpA4euK3T3D3x0/5JpLh2XFGIjIEISCtH0SbCUSN/tpAQnsSSTOaweImchOJt0FU8eVS/Jq7gkuWZ10nssjpKU5bx38V1SAb2Nd2c3GF48RCfRWEMFozTvykQp4MaBCo2e7sW/UO0UhdHfOx8TxrHBAR/MQGelvZkrl1Mpsgrs94pdjex8ak+nqtz7ersOfgg8Wlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:25:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:25:42 +0000
Date: Mon, 31 Aug 2026 15:25:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhao ShiRong <shxzhaosr@163.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bridge@lists.linux.dev,
	syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Subject: Re: [PATCH net] bridge: skip generic XDP on locally re-injected
 packets
Message-ID: <20260831122534.GA3247474@shredder>
References: <20260831113051.13072-1-shxzhaosr@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831113051.13072-1-shxzhaosr@163.com>
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfecdfb-fb81-45f9-0b9d-08df075af9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A2WlhqRMbFPLK3K4ktUclimM+tlY6YcyT07LpRcN66T7ZAmtMwlDSTzP8C7tpG2yB65Im7uYzk2kBXi6xW9IafSLlJnLEzcTkg5d6L19IUi9HREbCfaqmtUctxAn1g0a3nrODKqH19RfDPIvwlQx8UcRW+gKuVML52s7xknkllbTckaf4l8nM5p+wuwWa4ntZ5+qdodK/4g/s9out6kjAz+mFds/sE0hyuPvzzR7H26xdmDqEaNznJHNAPxYEvewff90Z0QiNJycBeMygjBUsO5uJvGEeHrO2/u59rXTMvp9028khcBi1wTEbU6x/vrhha6M2QiPKnq630kOcJ6zHtYqxHwbG9eQwaH+uIiML72I5OZmhuRGMXXRV+IBhoUG2LIaaPRJgp/n0CaLpYZddSDueZ8eZTlyjgeXfdVgjwTkBooPX24hbIhuXCzLNck2JBAy8ydPdbYUzq1ZWdgQwjYIs0nfVmWP3Fqf9t6sdWd1ovtdoKRlTrXIdbnTULghkP/6Cwrjb4xzzMqU5IxXPq27wG/Me/Ho/XE9cq8MAeVQyj2bUzQcL68wPVM6Ipz+/M0ZmV/Y5M8Bqu0e8mZdtcic8dl3PGc65QCPh/b9BH+ZmEhc6WmdQCdFaN04FsC6b7891VNoRjpOs1man8HIWN6qir7tGu16VpY5MrIo5HY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRO9p6LTpOjNo1RZF286IR6g0/o2BF8u3GPYwGjzbwgi9i2OZas06cEYcyRn?=
 =?us-ascii?Q?954oljb16cvu+UBEAOWpfUco8p/MNcGaUIZGEm51KbXMyhYMf0iIpkOHf+ta?=
 =?us-ascii?Q?QBS8Jchyikhqk4acK/C6hc+NW+Nei02p+7Dt9e7Im4diOjsgT3N8IRT5l3Fw?=
 =?us-ascii?Q?0w6XcVembHN20+23ysvPeTzPSUrgA60b9+7Nj9jym138t+oxL89SgsWJa7hU?=
 =?us-ascii?Q?GRuqh5G3sfqzEcqjTocx4myI6hIq+BI8wFBCedAMmjwSLl6End3MO+UpwWW5?=
 =?us-ascii?Q?OulWR9Og8Wv+waMaAiMny6T6vtV+EGgnxPfVlbFIWGgOjCKxe8mTBQkSfSej?=
 =?us-ascii?Q?msdJA6Djf+xuCt1LQxFdZi4N0nx/L5s6mCVEco9FJaeW1YV4wTauqedzCKRK?=
 =?us-ascii?Q?J5S6ZS34iqNUFMvlpo502B9q8EOVJqBYVTH1cztWxQYRq1ilpAnWP6z3LBtn?=
 =?us-ascii?Q?py7JZeiCDjvqbbc8jl+yU4KNTRlIfppWWUcX7H+0xLZjqNRkX8pjDDLjMJtp?=
 =?us-ascii?Q?d4OR8pPy3OLGmbaoqwwa77njSTuZ5VJFp6ydFh1wwsx1bC9XgH3H1/J5ONfl?=
 =?us-ascii?Q?Ju6LFfKKzLwJKXToqln1Cn1Naku41dv8gAASjSi6uIflHIzHXZnxBC2sFzf8?=
 =?us-ascii?Q?DcFx+Kk5y7XvSMOj92SbUlbEGjm8Xa2dfkYffbFsxdQT1oQXImdhVG1PHmX0?=
 =?us-ascii?Q?sAiiLK3K1MQokUbH2Cu+os62CkAJ2D4tmxJoztDrtFbY2WPdtU7rwYiQYON5?=
 =?us-ascii?Q?PYABMt/3fOPdJ+BF/9VFjGcj9lIWtazA1dK0LLcIdj8DhVdfZ51oZbFL2oWZ?=
 =?us-ascii?Q?Ix5hBuzuBeASxAoPj5ndVx+8O2xdaU0dug5UCfKhhvSfga/p3aLhxwak8/HX?=
 =?us-ascii?Q?5REpVXt1FGxCjFk+kARRxVukA1NBm4r7GQSH4h4UMoqos3j4Pd/CI/91oZdf?=
 =?us-ascii?Q?uCPeayxkYttoeevYDY6L0LOW9cTDUC5dH9+6pjQ6iGaBLzCnU9nPQM9S4DMm?=
 =?us-ascii?Q?A4fGNzhuj67PQ/Nyj1ho5mMdZBd1oyzraxRSvG9BkRUVZod8qFwMScm6VFa9?=
 =?us-ascii?Q?RMeotfI/Z+F/ljNt4z6u4REjVLRJtm/hH+HFKTfhU+iLDAYbmsojtZelNaYk?=
 =?us-ascii?Q?S6fPHM86Gp0ZPaFz6WB1j0rnY+X0nNMFsREvr4WpLssARIWeLBvvSXL7i6B8?=
 =?us-ascii?Q?XPtW3Jlk1kdDnCC1vONT9noES3dhKLMJTVtIGVQb475Wsm9WsPt9YNUqkTCs?=
 =?us-ascii?Q?07iXsO9+XCA1ijKjGimp0bv/vfqr+mcUZd1UkobvqY1YFyRnwav/AwOsGw+A?=
 =?us-ascii?Q?pEaW3398K7JNLpyHdJ4KDZ9QDSNbZmdAIT5umhnHJQsNw8lJhh1E8cG8vEhf?=
 =?us-ascii?Q?QzpS1rPFj2TGZy6VLleSBR/BB/Y0xSWS64qLBBGub1lLwGUf4gSehQAu3Pb6?=
 =?us-ascii?Q?icYq3SAUWmKNmKbh+gm2rwJc4fQGkgCoRpKL9AW8DM9k/pXIp5kxg/rmxWu/?=
 =?us-ascii?Q?WWt+Fj4cZRGMLuONry8wpKYg8AQNr1tsByEfcLHCnqDXcKxPY0rNpYGMRv89?=
 =?us-ascii?Q?WK+MBEdMyN5MVFmEQqbhfQ+9nXkxLZL37bej82zaT3ZFbj66yli7eGhIIQ7P?=
 =?us-ascii?Q?iaxCWG6O3uFZ02sKmyKbzFDlbnGZ1C4Ty/Tfq1x1Uql3ub5JOtKDv714mNUY?=
 =?us-ascii?Q?/FPoIqzInZnBRW4/VhlbvA3ZjGNv7rZKTi0F7ZGBiuzy4ev9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfecdfb-fb81-45f9-0b9d-08df075af9a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:25:42.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI/5WtETP34b2pzNsW8qDPC/aWVzGAtP3pmPm27QlSlMZ9KuAIoxby7lzUcKAEDhs1K6satVPi2JUs6jQTrtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

On Mon, Aug 31, 2026 at 07:30:51PM +0800, Zhao ShiRong wrote:
> Packets locally delivered by the bridge are re-injected into the
> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
> netif_receive_skb() with skb->dev set to the bridge device.  If the
> bridge device has an XDP program attached, __netif_receive_skb_core()
> runs do_xdp_generic() a second time on such packets.
> 
> A locally-delivered packet that was allocated on the TX path (e.g. an
> MLD packet built by mld_newpack()) does not carry the
> XDP_PACKET_HEADROOM that generic XDP requires, so
> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
> skb head buffer.  This frees the head that the bridge rx path
> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
> to a use-after-free read in br_handle_frame():
> 
>   BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>   BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>   BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
> 
> netif_receive_generic_xdp() already refuses to run generic XDP on
> reinjected packets by checking skb_is_redirected().  Reuse that marker:
> set it right before the bridge re-injects the packet, so generic XDP is
> skipped and the head buffer is left intact.
> 
> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>

Eric sent a fix for this issue earlier today:

https://lore.kernel.org/netdev/20260831095952.3385596-1-edumazet@google.com/
