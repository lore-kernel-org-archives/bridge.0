Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208340BCB6
	for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800291; cv=fail; b=RVBh3owab2jNi3jrzt9DwZ2r3nHKnVkI10hDCkiKhGOEGbzLav1XKPHvzK5m0kpv5lCqYvECgrmhyBTs9g+GZPttUweEgHgKOFe0DfNJQhm498mD8tKiaLCt6mwmTKVXO1LiaVAWOvc/cHfFg1uqING0zhiiS5kmwAVtbEm2soA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800291; c=relaxed/simple;
	bh=7Ypnoh56ea3rTNxxDea+W6u3v4aMR/cjSz+foR1H0hs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VHZ6ZsAA9oqyr0Og1DeVOwCcgICm9JtBIAiJyYGOFJHMAdWtQbsZ76Sh+UrjAyDA1km9dCFLbDmVpqh7n+VcnB2N1ntWjCEuffdvMZZBKaZ9PJYz2SjTt1OgO6jWJpKnPWXTw0RgBr4z4jFUTLKvzz8O2GBanbcFv5MNpiLGLlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wf+GK7Jd; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wf+GK7Jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BirS2BzhkbvAwfVofvweDgu9Dud/I7vaI3fgiV1/SePhLlUXrleBKFJ6GUTxDdzx1Cb/9aR7o8wwA/n1HxynCmkR4wWpjwyIYg7PtJGGoXgVBB/AHWWHNoFdCQUF5m6BZZA6GGVkrCWwx8AAxp7JWGKAn4CZa1L2J+6I/XMPgagf70Gg8r4qlL6dhevikMaz48e6b/vW330npZDgRcCBF64K3/LpyROTAX2e1c3lO+9gHuhaYvPs1fkINO5PPga1A1z283QG/aMsaRAFWLRQpRM/szdg5AfPvL3IKkGXfsQD4IXMVfDsrm6a29X0lYPdnNEMLbqExZdi/PFypYnsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr9jqXwqCnW7TX6SWqKnJVyc0Wx6xdtohJQaAEkBmOM=;
 b=Jp2mwKXHgMeoyk1V2qe0WMTpDj+2h/6uPM4FUVVkRN2kORlekgCqDIirMKhmEyRv+Wokc3g9TMTwGp6DS6csb+fR4r4AUPPEt8wKatEPYI1SUi2geOTSZkT19SEv5rK10KvgkMmA4Asjry/OQempVFnU+Z2EDQ2CpkeBgj/TLXwtMXkh42u1SeCYwjCbY/Yy51eraWOpgf+DhLluQVfPmpKUcc+yULY1/8gtUxStGd5uGat2ahF5Ye76ZT0IAmzrG+4lOEmVm4RJ4UJrK1yeV3tpC3H+7aajWekkwmP+ki8iiYe/PiT7+lgfRN3rbSANobafsM0ScisYu23l439S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr9jqXwqCnW7TX6SWqKnJVyc0Wx6xdtohJQaAEkBmOM=;
 b=Wf+GK7Jd57VBvBiNzLX8hsw8WQXcp3Sw+Jz+Z1PP0zwpErhcLr8SZClk5rRhNB8y5L2nXUZTIgnUY6fXjmWI8X9YABK510EvJvrDmh9NxiGK73DUMSBqCzT35NccJKKqKkxYvn2q/4PgxPXe/LhNZkZAy4R24eYZTCYGPLCtFiRLXre9X7KJODfoP3eL/45efMm6KHqLCRwU1UKJkN8kQDSX2k7N33phSAlB5Ii/tVUCbjaCa4VsLJq3z4SPkASLvoKUeVisZ3FLcRIlC/FYzAMsIbAHIEvCsj4J+CdSwl+JqD59lSXX7WSoiE6qvAK8+NCIc4B18/MXX6/RYZQjtA==
Received: from BL1PR13CA0342.namprd13.prod.outlook.com (2603:10b6:208:2c6::17)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:51:24 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6b) by BL1PR13CA0342.outlook.office365.com
 (2603:10b6:208:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 09:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 09:51:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Jul
 2026 02:51:08 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Jul
 2026 02:51:02 -0700
References: <cover.1784463131.git.danieller@nvidia.com>
 <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
 <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
 <d27e9e6d-351f-45e6-914b-3189fb6d3fd7@blackwall.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: Danielle Ratson <danieller@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, "Ido
 Schimmel" <idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ja@ssi.bg" <ja@ssi.bg>, "Petr
 Machata" <petrm@nvidia.com>, "fw@strlen.de" <fw@strlen.de>,
	"kuniyu@google.com" <kuniyu@google.com>, "bridge@lists.linux.dev"
	<bridge@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6
 neighbour suppression
Date: Thu, 23 Jul 2026 11:49:31 +0200
In-Reply-To: <d27e9e6d-351f-45e6-914b-3189fb6d3fd7@blackwall.org>
Message-ID: <871pcu8265.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 218e4cdc-7eeb-4ef8-1065-08dee89ff4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|10067099003|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6h0yftjHNokbRhvmv/a2TXB5aObR3IWJcT9o/WgHPBv2640UoHlWonU+hGN1Hh2GxB1fTrt22JaM6p2VYDX8txF3BpV3RphwlwFGQVCsoDry6uKFnNmpm739vs2uH5/87ceH3pRDfHv5dPU2u3XkuDWQEEr0BrRbjPCGe2OWm8E1Q1tLx3Y8kJMuxGnoNrm9T92qOLV/rHlGmtm3SQhMazRRHOaIPJST//m9DzPjtJLeaqtWqHJD4yBm6nrM3430dXZ3uPCuPjZtgsm660/zvdfl6tVktrW/ddxAREFYkuuvn0L+VGw82FKhrTCx4mfYQA50vC8s9k4QirxrJpi/o1rXwjHx2kfIAvQ15OcZsQif+FS9G/flEK42zLuztzo/kqO5MWOM1XUH+tbNOKQ76ax00YH33vtaUE4/qbHbTqzmpmYilW6hq+lehNuZNMfDa6CYBNsZ/y5o+Bm0VGd/LpoKR3Se6Vj8ATbTunt0IGwx/7jfaL/4X7ARtA1126JlRwx7gDMyUlEn0whjIajEBZkQ5w1O1/4zy2C6xeRVD+u68j9b/SGFYNUm51Rnv1aLDOosWLrmVtQ+xPoU0ph3MMUODDVxvhjRqVB1qm014u3SmhWhtHzdDilb0AUaPeawoU02pJYge33JffFdPc/32bzfrO/7vzVxCh1g/8cgmnYDphHG7IE6hU3ympBaHBQUAr3fTfOlRXnWxiQJp9ObAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dkgfnA78lDw4hfCcR+TAlE0h+RxofY2r2sr2RQTJ48pk6PYGVV1Ve400QdMuqqJWkNTVV5+usNG6wIwh8vcYEIx9UYAkuwzAO90eOFQ6iroE/9dEdQFAKv7jIJzpp1EfXf9HJRFPKmB7nbzynELF8caDC9jgt1j36JYYCFxofw2CXkSV29ET1smPwiupdCSK3MgDujWElTaOELWVVThuglzEV78KwVOzc4KTy6aO9vizjGM/fx6bSc5EI1cgn/kXXcjXBb2mCLzGv4MibXETYFr53AFEtu49Wo7SWgwuSP/chog3l3kUwCMHctmWr2PKwXVv4MlOFDiLlx5YfoiqDBI5d0ZAXkcAOH64XAY5UtFqM+OWYr5AP2M2WpfbEyF/ImWWvMRxcBoUCLvirW/qeSQmOWp8RdIGWSBw/YQeTV1m/fPy4FA9h3wduW3yTheF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:51:23.8444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218e4cdc-7eeb-4ef8-1065-08dee89ff4f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 23/07/2026 09:40, Danielle Ratson wrote:
>>> -----Original Message-----
>>> From: Nikolay Aleksandrov <razor@blackwall.org>
>>> Sent: Monday, 20 July 2026 12:31
>>> To: Danielle Ratson <danieller@nvidia.com>; netdev@vger.kernel.org
>>> Cc: dsahern@kernel.org; Ido Schimmel <idosch@nvidia.com>;
>>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>>> pabeni@redhat.com; horms@kernel.org; ja@ssi.bg; Petr Machata
>>> <petrm@nvidia.com>; fw@strlen.de; kuniyu@google.com;
>>> bridge@lists.linux.dev; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6
>>> neighbour suppression
>>>
>>> On 19/07/2026 16:34, Danielle Ratson wrote:
>>>> The bridge implements IPv6 neighbour suppression by snooping Neighbour
>>>> Solicitation and Neighbour Advertisement messages, but it previously
>>>> only checked the ICMPv6 type and code before acting on them. This
>>>> leaves it open to acting on malformed or spoofed packets that any RFC
>>>> 4861 compliant node should reject, and the option parsing in
>>>> br_nd_send() open-codes a loop that has historically been a source of bugs.
>>>>
>>>> This series hardens and cleans up that path:
>>>>
>>>> Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
>>>> ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
>>>> mandatory receive checks (hop limit, checksum, code, length, target
>>>> and option validation). Wire the bridge into it so NS/NA messages are
>>>> validated to the same standard MLD already enjoys.
>>>>
>>>> Replace the manual ND option parsing loop in br_nd_send() with
>>>> ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
>>>> once it has been validated as an NS/NA message so that this and any
>>>> future ND message handling operate on a linear buffer. The first patch
>>>> is a small preparatory cleanup that drops the now-unnecessary
>>>> skb_header_pointer() fallback from br_is_nd_neigh_msg().
>>>>
>>>> No functional change is intended for well-formed packets.
>>>>
>>>> Patchset overview:
>>>> Patch #1: drop the skb_header_pointer() fallback.
>>>> Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
>>>> Patch #4: linearize once the ND message type is validated.
>>>> Patch #5: parse options via ndisc_parse_options().
>>>>
>>>> Danielle Ratson (5):
>>>>     bridge: Use direct pointer in br_is_nd_neigh_msg()
>>>>     ipv6: ndisc: Add ndisc_check_ns_na() validation helper
>>>>     bridge: Validate NS/NA messages using ndisc_check_ns_na()
>>>>     bridge: Linearize skb once the ND message type is validated
>>>>     bridge: Use ndisc_parse_options() to parse ND options in
>>>> br_nd_send()
>>>>
>>>>    include/net/ndisc.h          |   2 +
>>>>    net/bridge/br_arp_nd_proxy.c |  54 +++++-----
>>>>    net/bridge/br_device.c       |   4 +-
>>>>    net/bridge/br_input.c        |   4 +-
>>>>    net/bridge/br_private.h      |   2 +-
>>>>    net/ipv6/Makefile            |   2 +-
>>>>    net/ipv6/ndisc.c             |   1 +
>>>>    net/ipv6/ndisc_snoop.c       | 190
>>> +++++++++++++++++++++++++++++++++++
>>>>    8 files changed, 224 insertions(+), 35 deletions(-)
>>>>    create mode 100644 net/ipv6/ndisc_snoop.c
>>>>
>>>
>>> Nice set, but I'm curious - any reason not to use EXPORT_SYMBOL_GPL()
>>> instead?
>>>
>> I guess you are referring to ndisc_parse_options and ndisc_check_ns_na?
>> The reason is basically that other sibling functions used EXPORT_SYMBOL() rather than EXPORT_SYMBOL_GPL() (ndisc_send_skb, ndisc_ns_create, and the ndisc_check_ns_na() equivalent in mld, ipv6_mc_check_mld()).
>> However, ndisc_send_na() for example is newer and uses EXPORT_SYMBOL_GPL(). So it might make sense to use that in ndisc_parse_options(), if you prefer.
>> 
>
> Yep, I was referring to those newly exported symbols.
> Personally I'd always go for the _GPL variant when possible, but it's not a
> strong preference, more a personal one. I was just curious if there was some
> particular reason not to be. :)

Yeah, I missed this during the review.
I'm in favor of GPL as well.
