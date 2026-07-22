Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DD4749C5
	for <bridge@lists.linux.dev>; Wed, 22 Jul 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739138; cv=fail; b=myMhU3yV6NntX5JnMpDu4bfafXSywk8sRwMCubBvu13hX652bQU3TkboOUzxwew5nDe9m0zd8MsnHK2QbgQkPZcG7uQu/Aj2s4udelcv7o3g49qW5nHZHeorVnpNtgGt6ljSjE+LK/GoCdGazvyFAWkw3xhGfNfA3PWba5v4Vrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739138; c=relaxed/simple;
	bh=W1enVC7Ti/vA3mf4CMQPp/yEkQx6jHb6haTUdJDV23A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LLha6aTqKajFCptkTWuR//Mtn5T1NUWR94WWgESb/k0gZXFyOUjbfgEeIzyina68KfvGyPLApcPeqWSWeGamMjrU6cB5Xyh3qbaYiI3xacY1KvUjir8CNuxIAblgNEcKTQIZ3bZ+ekLJ+oywom99n3w6ZmPndxWaLp5Tue1ILpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTKBHw0o; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTKBHw0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTc8M+Q4ZlzWlPm/EHX5GBlcKd5BwrRksvs8HG47pnW/eRwcL5q3XtNT4eqxV9WfGDp4oFJuK0OvkptfbbvWWrmPe/agwl7Oq4Sv0LM5K/j0r+tLd6Cym7Aem6pjlHBFaEzMRbWCbkNr8fYTD9DcvnF4feEJg+FrYaOqjI/1M5A20BUV5Hi2wHpxzwYwTg9/DVAG7fBP7OUVPeYoALLcYO0aprhgk581FfSStm0w+QDMLbTVanLylPBybANiuP+/JS59MTPTvccKB1axq/T8xqhlM3qvOgkBIM3bYzI93supuXCxQnPKanmjcH9R8H/rlRnP6ldnekmouQ1F4s93cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KnE0+R8qaQ2bcXyGGUz8ejQ48X8yG0JLSgnyRWuMVU=;
 b=FTlP1szGf1Tm2vfgcQjM6cWVFkzg8NF/k+Ok4uMmBEZCX3KoCUkuxY+ysZWdhpRfcbdHmiGawqt17DlpyD5LwYlDuj73pqEEs77nxUGT2YYTt3Ck0pfn2F8xAYwZX84p17eY7vILFOi9aBqwcFVYD9TCQfHNxypkdt8dJgl4D4jTHpDIee513CS7U9TMQ6h4p9lOT94e4sVHshz74KYCF7qsdWhiV16JXXpItzaLuwib4N52gJzJDesQVLrgdIbRgh1UxR/gOnbkHUBKOMCIZtYfiCnrduuYfLqRBPUfWAwApr7Sv0djlb2SIZKoc2P2qGnXsbL30lXfKRmIHW1NiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KnE0+R8qaQ2bcXyGGUz8ejQ48X8yG0JLSgnyRWuMVU=;
 b=LTKBHw0oekHLs05y5HnDL/zxwwU3flCRsmss/OynHtLInHeI0f1s/e3MMm2QnyUKt8JTTxGms51koKWeN/gzL+yRPYnRkjrNzaH0s69CGAZ8nNkMxb+zoipWJFSOB5tWP+wBPLq2C2K7myqwn65NCoRwpnCQ1vFrjcYDrV16mMWQxenw9hz0D62LkkU77cSpgnrIN4S4poNaH8Ew9NLFE8gEJerJ6BGLKG+KtxVdSKFkLfPW1kvomPEX/EUjmWMydb0R3xcJNFgH5vme1GO+NzKpzZJkVFD8A+tH5KpK6bVodMgMZ2Luct+vDDLn21m4nZpKD+BCrMqZLy6yRbXVTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 16:52:02 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:52:02 +0000
Date: Wed, 22 Jul 2026 19:51:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net 1/2] net: bridge: vlan: fix vlan range dumps starting
 with pvid
Message-ID: <20260722165153.GA3080508@shredder>
References: <20260721140922.682265-1-razor@blackwall.org>
 <20260721140922.682265-2-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721140922.682265-2-razor@blackwall.org>
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: ec46ae88-5295-4ad8-4869-08dee8118da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B0SAAf5YbxteHksn/42RezdH4HNNv2RaOyb0tIYA0K6R3hv6VBuQsNbQhh4VVRe2OnYaDGkiBKzEVaLpDqAdmF6XypUoQeSim5QF5bSYM6c/KbJH2hHZNB+6YTtA+wVBzWhYwp0mto6yAWbDoGRWhBk/KTdt6HtTEHwWom57sCWMHBMLJby7A1O/ZbhPpJ2Z75UNYeigPyJmY57m4/8FkKSibikmarwjVhbh/uU+oo27TBePN1B6aMEjCwgxKbRYDauAR27J5LNo33SD7b0TMYoKFWwiiKzc1Q/3zj27szQE6dNGfHlmmswMuXPg3i8YDpSsWIBabaEzLafr8PNZL6vcZ0fDH9G2+10I6nnPy3DLIpK9wcqfLGdxtNqYdeM2NSFZ3fHscLFkzfdDaM6y72PtcJiauDPrbRHj3cAkAo+OFDzA6mC7pmDDpdMXDTZYgDiPxTB3r7M9Lxw6Rku9+I74Ol2fO5WNKnclL5Jqr5ci7nLxoLHhaVOh3VWn9YBcOCM1Rk3Cd4d+sPIJG2DgfzoWu5/xYMoxABBRm9jwDeAtRTCQCE31glDd3fa5xrAex3ae/l5eZY98BqxYBVGy3z+fJHcqFhqDy+Hx94jdOWL3um0gTsjKzPNG6qxV3KHylZP7FFjJGxGgI8ySCTjx7NL1pMgx9gKLUbIcl5XFSr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JeJclebYKnDeG4rSDCdXkoscZC9I5T+PuDGSRks8h6XASZbVSTTIz1qExN9e?=
 =?us-ascii?Q?XjHNYYIb0G8jfqNyvRgci/qljLAS2W68qTiq4yV8zsmc+fy0xY3zhOMVNiRW?=
 =?us-ascii?Q?5SbMeNrEr3OYqI1DcCwFNH7mZd6hTKJofWb1VizgZmEjRmXvidRfQ5Er0hfh?=
 =?us-ascii?Q?cPX7qLdIgRHkJp7Ei5ACadOwHiGaB9xgAUMoxpAdvuOW9Nuhb6AkekxW98qs?=
 =?us-ascii?Q?xp75fIv2BXHM7KmourM+5BWhuG+tXhI3QBDeAHAk2KynKX3YC70qVr+AOgZr?=
 =?us-ascii?Q?Wm2diQT7lt0yv87ETjlGpIULbl4S0zmGNy7Nss+fEIA4IbetSw0DRCAW2Jd8?=
 =?us-ascii?Q?tcs0yRlTwpaTF0k1AYYeS7lBFLhcEmj6Evy9JTEBEbGu1c13WsBVvfqa/FiL?=
 =?us-ascii?Q?4AtaFCVF5Fzh/lICT5LnDs2WF9QoQ4YApQE/zhNJ+6v5IosbQVYE5IZqUvq2?=
 =?us-ascii?Q?8lVOpXDxG9pwdH/8qvAfzKN0Xr9nmHoiX2Zk3Uergqw3bZAatLDqMYzAgAX2?=
 =?us-ascii?Q?svsLeXVSDj213ZVTpYz+VwzGNGwkoU+ERZ3N7y/QpcdSerEfm9AfBC7JXFUH?=
 =?us-ascii?Q?0Ge9UPzpdUTZvKaRqGmnSPA4aQl0Oz96hNJ2WWLInnx8XMhoS/FB+UUmwHkB?=
 =?us-ascii?Q?JK71dKO3wjBtHsUCD4J3f9IEkowA/EwdUvmQfgjdHZgMUppNQxQO+LKuSKrp?=
 =?us-ascii?Q?cMRDcaumkMeeR/SQPVXw2OiCAmtXGEaIogju/LfgW3ux91e3FRWSvgjM4kWl?=
 =?us-ascii?Q?oR6RvSAoE9zxm/739TQJ8KC8f3HF08fNAz3C+4qly2Ll9o8bD13Vld+VXCkQ?=
 =?us-ascii?Q?ayNEJ4+vPhPofE2WMxisrRSNjZT3NEQt3mloawJR4FsNRfbV5VpqObafkS3o?=
 =?us-ascii?Q?4mp9YqjWYvw3ZX+i6feLb15Vzmy1L57+/puXUTHEIL6unWcDM80CqBZPMCco?=
 =?us-ascii?Q?NMatO1qic1EJ7fmCAU2gqZTYD9WRRQKAKt9/5JiR/enuRoc+t8Lq5JXLNRpO?=
 =?us-ascii?Q?wPPdQZUboCwsQcIvSUmlRtaslJhpmowa/foTkmgfO3BrdbEH7LzB3/4RDMUD?=
 =?us-ascii?Q?di5+dF2Dowc1cT4w0t/ulz/ZvNL4x4rWfm8nFyP6gXKgj1ZCMmlFqMWB7EqS?=
 =?us-ascii?Q?AuqMxyMXB6ps2Nfv9W6jaFueVZ4ZuBlS7DdzeuplpiviHzpdM5taPzIQAW+x?=
 =?us-ascii?Q?qhI6uFsxSOLc5ZBMWSwdUke0V881eVHfU5Gum/tC/Mw6u4paS+kQcI9FGler?=
 =?us-ascii?Q?/NAaY7lBkar49NR+a8Th4r17dW4r1u0UJBOBzyj76cVu5DowXC1cLs5fo1Um?=
 =?us-ascii?Q?QYFIE1brjDgFAUEU80ZKsNE2D7AHDxhIYeB6SNOVV57Rsgdc4ci7XPfT3B6h?=
 =?us-ascii?Q?mZsOmI3HYo+LzfRa2RplLNWKOTFhJIBZMU4amX/ghkpEaO6cTXIBSrMTgkc1?=
 =?us-ascii?Q?6P7SWF7biErEtLTAhaK4tASLGG8qc4IowasPIpR2Iwc3r7/E/tuJd3T6A0YP?=
 =?us-ascii?Q?QDrAMXTzvnvRanhtiEi1599cIEQCRkBeJA5rsCCh/ihPeQNbdSwhswwuUi/M?=
 =?us-ascii?Q?F8i5FmmME6wmuL0wA1bx4XD0ye9O+bIkki2MXywMSM68CTBL0pZ8fYHh5Jch?=
 =?us-ascii?Q?da7NyhiJAoZObz06RrsX2sL9vPB8eFw0t/KJnIhRhcNsnYsfaowbA7OEsYuA?=
 =?us-ascii?Q?cB9Kae1Hb5UEZtIXX8Sbr9gjqIIrOeHmohJwS3S8EkA69vU6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46ae88-5295-4ad8-4869-08dee8118da4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 16:52:02.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNWFoaq835jdF0H448Ca/psYVWCP5RISK1ITdN4Uf1SUkx7T3gyTSN46ZvWFCXzRmvogSd5cm8TKjoPGb4JtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

On Tue, Jul 21, 2026 at 05:09:21PM +0300, Nikolay Aleksandrov wrote:
> There is a bug in all range dumps that rely on br_vlan_can_enter_range()
> when the PVID is a range starting VLAN, all following VLANs that match
> its flags can enter the range, but when the range is filled in only the
> PVID VLAN is dumped and the rest of the range is discarded because
> br_vlan_fill_vids() checks for the PVID flag. Since the PVID VLAN can
> be only one, we need to break ranges around it, the best way to do that
> consistently for all is to alter br_vlan_can_enter_range() to take into
> account the PVID and return false to break the range when it's matched.
> 
> Before the fix:
> $ ip l add br0 type bridge vlan_filtering 1
> $ ip l add dumdum type dummy
> $ ip l set dumdum master br0
> $ ip l set br0 up
> $ ip l set dumdum up
> $ bridge vlan add dev dumdum vid 1 pvid untagged master
> $ bridge vlan add dev dumdum vid 2 untagged master
> $ bridge vlan show dev dumdum # use legacy dump to show all vlans
> port              vlan-id
> dumdum            1 PVID Egress Untagged
>                   2 Egress Untagged
> 
> $ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
> port              vlan-id
> dumdum            1 PVID Egress Untagged
>                     state forwarding mcast_router 1
> 
> VLAN 2 is missing, and if there are more matching VLANs afterwards
> they'd be missing too.
> 
> After the fix:
> [ same setup steps ]
> $ bridge vlan show dev dumdum
> port              vlan-id
> dumdum            1 PVID Egress Untagged
>                   2 Egress Untagged
> $ bridge -d vlan show dev dumdum # use the new dump (RTM_GETVLAN)
> port              vlan-id
> dumdum            1 PVID Egress Untagged
>                     state forwarding mcast_router 1
>                   2 Egress Untagged
>                     state forwarding mcast_router 1
> 
> Fixes: 0ab558795184 ("net: bridge: vlan: add rtm range support")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
