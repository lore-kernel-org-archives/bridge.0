Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793370366;
	b=XNw/uJU2eul9ntQ5jXjAfUcIDLmR8LrCCSl2YzM8nHkPtRelGTUODgV2WQAQFSuKXqHt
	 GLvh2isooTo0MYtHrqNDMt9HMqcBPAc1q+OeIcKKhCdMHhpvvvvIt540rQkhLoT98q/DL
	 HDXhlmjYMhcBfVk/eftLOidD2P4j7iQ5fXmw3kxw8jRzFvOTDd1E24zcA6uPu1JLH5dBD
	 sgLu/IVwdZBhh1oaVybrZWkTP8bInqtRYVAZqnkazS14NMbOSjpNf2LjWRiuSNtAwfUE6
	 xW43ImO0JOy/0TdvsQIoM6zgCKBUnIFj52u0It+vl8tGcqLAazEda811tZr6TxMAERA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370366;
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
	bh=RyCNSrYhW6B+E3SCvYgNIMzX54RkNg0iP9VdlOQj110=;
	b=H8iaJkvzVacQYHiLHeZGhp4PFvUCwisFUmM/HXzENa+yaPUa5AINMBn/5r2T8FUGnymI
	 t0Ys5pOecrjXCpAf6yNjQs2qo6Aa5oxhUa56GEZglEHVGTojpIlknyK79VTc88rT3gdij
	 Bu7CnlG3mxMYBY/iKkfRFV6HaYfBBTWb1dR+ht0tHbaO+12rYf4TAvhzkmVsCKfwIITlr
	 HUNls2vzTW12wnUgjfRMpgEXExmRdJy6qUH34LyJ6HeO0hKwoO78Y/u5KTst4F2R5xrV6
	 OMnZAMmUcn/s3oKpGx7Xoq26yHLafgIUWp6jNBnhsz/FOjjobK6o1LbKvvEHvgZZvbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LvZFHAUO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.62
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238B606A31A
	for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 14:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3238B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LvZFHAUO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcnQBMOwOWvwsh1pXNchaoVvClJ1b9OEOhqHFmi5W5Z4U5K21E6ph3JEY1nND31fvbsOcdzCe8Gv1sdsui0dgJrXtxtzflU7p4itcgOm04EW3zjmlZ0/ABZ6zK/RmLb160AxnR57uiimg+g4xpXy8z7REt9M/WQq/rXZ2YIk1+0gVTzDGNHtbv0uWq71wAzdphrDYrzuliHWaQmBPEXY37MLSDFPeC0z3mCh8su84o2HxaOcZs472zgiBA/GkU7r+yHguwDaW53uLwHZwicIPB6bsP6nv8YdSGZ/MeqEyyWa8lH+dQtiukps5VqFrzfSfTh8P+PUCJ4iMMt0pCPayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyCNSrYhW6B+E3SCvYgNIMzX54RkNg0iP9VdlOQj110=;
 b=F5al4ej+ODz5JXoKUGOxhRXmB6ajGUZUYVL0xvjButlMb2q3+FwGkLnDyWu1JuCharU8Xe4yP349g80l0ogH7/Xfesied1sz/qI72On/O79v+Yz9h4T3IfQ2pqfcBGKi8IFDvK/i58yyIvo5RPvJZarEiYgGK2FBKkrxmiee7NNAbzcrjpKWz65knyp3PnzBWcq4u6UoL6hWVvRx35C1hiCcvfst6eTMI8Fc+n+10rN5sotFpXzeUYSEOrjn71j1P+nYyGjOiOWVfzBlanaz+asW+Yi3HChJVd/n1JwupFlSelIyTrc4GtsJaAyj3WJ9+qrcVX8t+UHD/J9mx7iahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyCNSrYhW6B+E3SCvYgNIMzX54RkNg0iP9VdlOQj110=;
 b=LvZFHAUOP7Kn5FwDeKbKnps7clDwoDPiTOPzIkVOanzihFP6u4oWIiBOvAgX3mhugakIrVjQ+OlvUEkIGZ/VRqtf7VMwASJ4+5ZCTQB4VKaDP/xwcZyCTfOaVSwACZLjp/zO83oaQoEjwfIEQjIB4BQDNLozcPpUwqCjU+VRKEafATgKYOTejmRzNGjn0+cnLcSSZ13FC9KgZbkEaM8deBI06+cYB4en7ZfTHhi5V0KaXZfmkVkiB7lIm70KsYzDqrgERi0NXW5Iw0WmE71H9WJNJ7X3OOBkgm4b5gNbzP8cHt5+sbsr1Gka0J1gg+46y4KqJrfb3Zs6EPYOUZeQUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SAEPR12MB328963.namprd12.prod.outlook.com (2603:10b6:802:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:26:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:26:02 +0000
Date: Fri, 30 Oct 2026 16:25:52 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
Message-ID: <20261030142552.GA53460@shredder>
References: <179333317814.2102764.8780283783548366593@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179333317814.2102764.8780283783548366593@gmail.com>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SAEPR12MB328963:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f93219-62f3-4e80-1d78-08df3691b9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|11063799006|5023799004|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OWhEMPB0tJ3gYvHMFaL1mLdidLXxbfqbRG3DpYIF4SjR33qlGuaT91YRkzkLJmfUOK5vqGkb2v4syZ3Cq4P+l3wD+NW2gpU6TlxSq27JWaaiPDVYSyQsM+xgdLyTUNsyFKHRM6rqroRWmvUWQgcujOMH3X/2TQmfqQ2ermIYZozF6Ztr27qaFz1kkfTP9EU5Tj0wtkOm7c+3RhShVNwzHlI9rOS9D4LgBrHNB3COeOneVpolFviyHcdA1S/jpb6HAONuTys4aHIkiuwYLnYU0KC1UYoWAnDwuEGaQ79RXa/YWBDbke3Wug46iTuza7VpN+JuaH1L6bmR9QiS1Hy4p0GyqVfXl3TmrB68opxKatPswz49kSDQvL2XyRVNzJwHSYhbscfiYyhErX3kN9+LDdRUV+UrhzS+Kj88gwSfuySLd4Zco/cEGQxjfGcurflLYDLBxOjNZvqA72H8L93lUR9wpu3SPmOFoHe1oLR1cxnP/RvaXKLMDyu+uGmMv1cidoxTJW7cMORTRjCfNgzAoO4ZqZC2yk6cVlD/fFaFUPl4rq8CUxkJoy7NHmsPfc/z7yAQYEwuAwit0ZfBjCKVqeGSQBduLXSWkJUn+V+guVNFGkIxjN6Ej1qyiGxK5ysNZNHiSVB+dZXfEEavCDORJMWJ2ZP3EIZzo4U6CrYx98Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGitlcR/j2hhxMmXBuwKgfM26prpWB+5syooxat+3oIcNQFJ9l4Ufh+evXUo?=
 =?us-ascii?Q?f+nPmMSO4YJ2xuO67pjfaaQqQi1aLOpgzptgTAE7DdzNKvAUtmHoROObzh6b?=
 =?us-ascii?Q?Demix/XAxLNzU1Dp7HxAweV4ByHq8sCLb6KpSHThB6Ajdc9eilAQdYbTAKJc?=
 =?us-ascii?Q?BZ7OMBz4mxZW4mSaXNXtoqG3OBFxhLz67uT04ocSsQUTtofmr9eS+o/fHd7g?=
 =?us-ascii?Q?fPHI6mnMnsKRzHTmHfbV3kvMKrmNRarxdjVjVzeRzTN0odISAgyX8ArRVf3N?=
 =?us-ascii?Q?Mxp9LNNUWem6INk2lT4KfUDXz0cPrXZkol8PlGQ9QrwcjLAHv5SynSjOFfrb?=
 =?us-ascii?Q?7BKEKIFUQLTf8uL1e05OwRj2Pw5sWX4s8sg+GMS1XfX2jU404FS0qYEMhWii?=
 =?us-ascii?Q?I25grywtQ1WPFcFqlYy8BxWKPKekYc7nHEiy754sKX9CpORVU7JE2mnmpxdP?=
 =?us-ascii?Q?Rik5U2Es9MN/H3JzH8y5Vk/92VNKm1TBUQsC7hG9G9FprVnNp/xd+Dq3qS9U?=
 =?us-ascii?Q?5aNLGe+nyAdFvUylYaGWIt5KiYG57NuJSBoVal0b33Mk0fdp2S61QtFlDe3z?=
 =?us-ascii?Q?PyRSPZnsjtp1RlpwQCS5zartGDQHtEBjlMfs5qWgbejiwq/sC3yyTPEoMfqa?=
 =?us-ascii?Q?WtC9RdkgFaWkP+s/Ug/V8VLdEiiNZet2V6XHYOoS53pkzb7SvImmr005qbJZ?=
 =?us-ascii?Q?IZjZ5B/Y6zHtvq4Lau3uBVKIMdrvUronQRw3AXqBiqlrGrAW+7onCaGePB/k?=
 =?us-ascii?Q?gWx/nMYxVb+GVsjndplHaIH7dOKa0I4rJcNfBaO1I/wDhvOWlciPUsyIIxqG?=
 =?us-ascii?Q?XLrGIKA59KYGj0AuRPnU1DJQBlzygDslUz6d6UCRmN74ytE0q9Mhh28CewgD?=
 =?us-ascii?Q?RbdanO3QySIb5CMA1lJq9Nmd+FGpro29eYOKudJWjR7S1NvLAJ9dj8JR6vSC?=
 =?us-ascii?Q?BVeI+smwwl+dHheNXDqyI7O041sFvY8W0DtS9nyQyXP3lccQcqxUxRo99HFk?=
 =?us-ascii?Q?0ZWKyO5jvwzCnhIX+2BCXCwO0GBoqxVmb46kKbBeYHiP/b/S5Kgg9RzttQVF?=
 =?us-ascii?Q?sJroCfEQOH0LG4dA7rtGn+tjAkVA0ztHfzZIDWCTYlT7MjAlJdmY+uYqegMe?=
 =?us-ascii?Q?zNJAwFWK7Ch57h6t6DoHNuznEciMt2Q4t+Oi5yrI/OM+B+SmDe3SCciXsZpN?=
 =?us-ascii?Q?qkTg/N9OmZQUfzVZ1UlEtvrjvb5pKCqD6RzpjiybSEtNGmlE9WE4FDMp+vk+?=
 =?us-ascii?Q?xpwTb190JBFcIDt2BW3IBzs8GgBHbVaPOz+/fz/e0D/x3bDYN5rmWkT3qnWO?=
 =?us-ascii?Q?Ir0zdXPQpyToCiEib4GcVJ1sT2C6BJr6PUJ5K4QgOuZfISQN2GR3CM4P06i2?=
 =?us-ascii?Q?jJvgVwHS19878dllq3qXUbaNdYGLu+i90dKt17MXyjEKjpnOXoo0hGH8aAJy?=
 =?us-ascii?Q?C8DiSNprD53k3RC5jcleMiVbQoQ0ViaibsS6v6/iDDs9rU6v0i2ZAinW28wm?=
 =?us-ascii?Q?/uoExMwvymj2O2WbGrRBdvGu/HfuQSs15vN6bgm9ksWCkwpoh3v1QpKBg/QE?=
 =?us-ascii?Q?msusIw+BT8z630tZVwHziDN4RqzDBKjNUG/IH9uWxZ8n0cKHHLN+j8SOFAsR?=
 =?us-ascii?Q?FI4lOyN/8SXKgkp17qDFL6JZdNajUmzedxpogetnhuq68l+oiS01uvDXNdEH?=
 =?us-ascii?Q?JplMlH08Atytd9wZP0aGty4IumFjWNa2kmxL4340BR7CwAEE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f93219-62f3-4e80-1d78-08df3691b9b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:26:02.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMzX/GLJnn8TEq6WIHT/vK3LZkG+OExNiqG2EC/55M9wHqbA6mu8qvgwMpyWaYyNlYAjpMS2itKglTR+MaEQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR12MB328963

Diff itself looks OK, but the commit message needs to be adjusted since
it no longer matches current net.git. See below. Please re-test on
current net.git and wait at least 24h before posting v3.

On Thu, Oct 29, 2026 at 09:06:18PM -0700, Cheng Yongkang wrote:
> net: bridge: disable MRP ports before the FDB flush in del_nbp()
> 
> del_nbp() flushes the port's FDB entries before it unregisters the RX
> handler.  For a normal port, br_stp_disable_port() has already moved the
> port to BR_STATE_DISABLED, so no frame is learned in between.
> 
> That does not hold for an MRP ring port.  br_set_state() ignores state
> changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
> the port state alone, and br_mrp_port_del() then sets the port to
> BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.  A
> frame received between br_fdb_delete_by_port() and

s/br_fdb_delete_by_port/br_fdb_cleanup_by_dst/

> netdev_rx_handler_unregister() is learned with dst == p.  Nothing
> removes that entry before destroy_nbp_rcu() frees the port, and a later
> frame to the learned MAC is forwarded to the freed port:
> 
>   BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
>   Read of size 8 at addr ffff8880200bf038 by task mrp-poc/9420
>   Call Trace:
>    <IRQ>
>    br_forward+0x55/0x3c0
>    br_handle_frame_finish+0x1300/0x1d40
>    br_handle_frame+0x90a/0x15c0
> 
> Remove the MRP and CFM instances before disabling the port, so that
> br_stp_disable_port() actually transitions the port to BR_STATE_DISABLED.
> The synchronize_net() in nbp_vlan_flush() then drains the receive paths

s/nbp_vlan_flush/nbp_vlan_group_unpublish/

> that could still learn with the old state, and the FDB flush that
> follows removes their entries.  No frame can be learned after that
> flush and before netdev_rx_handler_unregister().
> 
> Tested on v7.3 with KASAN and a reproducer that holds del_nbp() in the
> post-FDB-flush/pre-unregister window for 1.5 s while a flood keeps
> sending frames.  The unpatched kernel reports the KASAN use-after-free
> above.  With this change the same window is exercised in six cycles and
> no KASAN report is produced; normal bridge forwarding, FDB learning and
> port detach also pass.
> 
> Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
> Assisted-by: LLM

This tag is deprecated since commit 1e035297ffda ("docs: remove
Assisted-by references").

> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>  net/bridge/br_if.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> v2:
> - Implement the reorder suggested by Ido instead of adding a second FDB
>   flush after netdev_rx_handler_unregister().
> - The reproducer still exercises the post-flush window; the unpatched
>   kernel reports the KASAN use-after-free and the patched kernel does
>   not.
> - Regression-tested normal bridge forwarding, FDB learning and port
>   detach.

Please also include a link to v1.

v1:
https://lore.kernel.org/netdev/179268538303.70821.8213834342995341232@gmail.com/
