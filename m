Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793607966;
	b=IpX6SOuKe5iA4OblgNR6AgIRpZzuy7xPpH4h4UYGto8jOhaz4dVzaNpZUgeMDh44P9zV
	 Pr9If5+CJjhVTOUU+/QA8R6U8NKiYBF7yPr3IKVw+xCwwhMBpeSQt3OQY+CiSbv+dB/wj
	 NxEV5/GtjzKqi0jK3FXSto20dUilFijD1lK0d69rvqk4BG/51Cz7q/L1XDfpZwDi2fvb9
	 rDJH1mgEINX5g3tv/mLdY5qpmneqUwqRMOTHBPB+YWbxM+Ho5OAjpavH9ZBmzAXk/aeyc
	 1deQ10uZmVWyEA/96YnCq3VDvZcMVhnlBImAWtMbxEjymXkw2a5vNAdXL1ZgrjDVmpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607966;
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
	bh=JWDT/px6SWtAvf6LMThBeS0pk1m1hSRjIWm3EaYLFIY=;
	b=TotR/hPGSZLIiqrixIpd+q6Z+K5YIUTZcQlvxxNW5u6WNRj7bC85ZrMP6blGs2NxaTVQ
	 FVK+9faePZdg0VtoIKlhA5lLlHOlXV+6gPbmjH1dzzZbFnpnWNV+G510fl7kkgC8IV35a
	 XWz2ruerl4AkLZ9lJN7KmyJRJEBHGo8y3bIWSv4hGReaRQFn0tmR5BMXGGny7QcoU19ea
	 65MuA9/Q8CRtoBazo3AdWIMVkfKtNFdpm8nUlVwugjIp7MjhVuHe4KmDAV/C0rf3/hk4S
	 nm6dEXsblE3flZb7dhfniRHj/yGRzYGBjU8U+443mSpYE2TP+a++Xy9dAfFd8oQ5G1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=URLaw2tw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.4
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8EC606A32D
	for <bridge@lists.linux.dev>; Mon,  2 Nov 2026 08:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC8EC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=URLaw2tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuj2ZQY3ewwLG3lYpalST7d6/mmBuYxN5dBTLNoOWTHKYM401w+kghKHcS2DJ8qeWW7lR0yFTXeM/hpBc3t6+h+40VJ91M4bQSFnh6eun9wNlbFZcNpXqTg2n07opqxd7MuKfsOfHBpa6ZP8NNE2SxdqT7wXOlNeIzhlThjSu8q4cMxKaQrtS/osAZIOH0xkPMYeItHzAiplyj/D0eR8cvKFQBkNaOHvJHcgx7v1hpZecYfUAdBuOivUHzNqy1iUbhE6czWpERoknCtkd6yDbdozF71peHQNJu0VrOyJrmupyXBtcUBtIagR4Yhom2X+tOrfLLb5fPc1mG/l+cqRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWDT/px6SWtAvf6LMThBeS0pk1m1hSRjIWm3EaYLFIY=;
 b=umelu7V4P0wsh9JM4tbPvw/qnCH7W/814B7WcZ7Wkbz4danGinMSuL7nOU+2lh4Lgd+pyaBSm8gC6cx1OW30re6iHQnmS/8DT7z1bnD9Sy0bYI8Uw3TlE7Nl04Rdl7yKkDBd4SfwmmenFcrEHVedtiIQaiZVg7sZO7toFp+UIiNUbiB20MC7pxK//Ww3syQm9PpcXApKgRihwhVWX2iyMjlsigw4xOL5d0QCQrayJrIct63G4TBUIRXnLcNIMZrEMa88ohr84xdQEG511WMokglDi00QANFb92cOaRjZavgmTWYHYvY6Yg6t2vlsCWENG71Qrn0v/WWbJ41Yn1rzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWDT/px6SWtAvf6LMThBeS0pk1m1hSRjIWm3EaYLFIY=;
 b=URLaw2twVkR1/OcehhxDyh7D27golYI9uIYLggizvx7KhEnsuhcUtZC06iUGjxAfJ3iP/P4/2+ISeDXgIRIisW/bBrqAI7whYMC1i0v16ikNkNvgpTeAWabVqROLeFykzH151UfGyx+1F1us0AUbnZi2aHlu1kaVUb5liW7dN+Vg20aFo88mO3AMDlg+/B3id6P2P1eNY7wfhbY3ReCvuLoKQfjgU2kkZFaQ5ebBvV7M/QjZ3VRtzHO/gOk2/VhKKivEaEi8gED9DL+jPyYe/MIX4gS2hOkk2v6w0/pFEwjTEQNtxWpvcZEwPeszhB7z1S9d7ofKgC2zuIOJ1cN0VA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:26:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 08:26:02 +0000
Date: Mon, 2 Nov 2026 10:25:53 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: xiaoblac <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
Message-ID: <20261102082553.GB778610@shredder>
References: <20261101044840.1595584-1-1020691186@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101044840.1595584-1-1020691186@qq.com>
X-ClientProxiedBy: MR1P264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::12) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f32645f-9d42-479b-d5fa-08df38baedf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|5023799004|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	PprgOOF94V4DITFEjEpeCJrwpHH7y/hYrxLWIbq/ZK3YMnCt04pnrKSEEnc+CRPsg7S869j7sdaWyRLgATkGB6VtrmRxdcR8NvAvYAK461YrENi1FJIHZptaWHYjB+p2jX/UmzHwBBpEHGa0Z/vtiyb6tlQI3KCyxJV9GUJw/ThNdAsmBRxUX/g4wb9YMFD/89m/eJ1dOqjFQ2JDbiVBIelnVjjskTzXEMU0iJDv+/fgOfce2MUfy/3IYrV96i8FTqrZaGJn5EzBoOTUWMrz0kkI8zTsH7ilKmcpoQhmYCK+TgEiGr98QgZm6K9ENNSKdJ1FFjucvuabgkU7VfwbNv8dIPdS4ncnCq+GdfcZKWyOkmORRbuij1kMXJ7wVnYf6+z1pnL5ymiOyYRiB3ZNpos6PM4a6shyWl42jStJ0CSAwG1XWKic88vVLBCgbqdZHN59+HzexIWqYhdmcMNLl8fn8Si1zXl0C/OYQ83Sumed/s5Q6QYaPPtWOVNdLOqcSn2A+IL0HoAWBkWcbGsFEY0pwDX2AznovwLCUZrnPcIPqanlcVOf0aWddSee0+YzC/sck+X3u2gxqOzV0k/iJIaCj2KD8oI3OobYSkdlSlVq4ef6uLTLnNptvYJLqaXqyC5dfxwzLHdjFujcNDlrM1n3r2/RjvUNpW0IW6/+rJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9tgsUf2f+hUWAuPwcgnzoH2GgE5tu5F3kEeZ4JCXzggeq+blteyBc9aWn6n?=
 =?us-ascii?Q?q8oJwgKKN9VViEcd38fCJZb0LGSs/x/mkkN3uCeQFvjk+vVVzusKxme33N0N?=
 =?us-ascii?Q?ApKp/PgFOk4bRn4edMLBvUu6hfeIbi4lB4yTR7B8w4CNL0B6n86HeS50DEio?=
 =?us-ascii?Q?JasnIahS3Bypeb0Qwt90QgeDipHlmfhdDsAzxc04Kk9aqJD5KOqdikb9FH02?=
 =?us-ascii?Q?zOINUKCIXgX71Sw3acHUCSpTfEcyNS1H5PlNIhCYMxWIokEw5+ma2kZ+2Sq1?=
 =?us-ascii?Q?6bY8IjdfKAE+WmuGdLabNHAseT486R+z5Fz8FloHY8LNhQEgen0Jinh758Jo?=
 =?us-ascii?Q?HQMhAlPnADJfT3zQOU2xmlYex5JpQ+8cXK5YiNfTFjPzhDCh+A538/zn54/b?=
 =?us-ascii?Q?95V96n9ga5RQGvhcGMDRxCK43VxPCl8cMJ8433VBFgqPYWpto5C47w+rnZGk?=
 =?us-ascii?Q?3xuc1uVdTrM59njr/1sVgCJpmSKK9DadobvQkugpvKHtLO25626wcF0hfGxJ?=
 =?us-ascii?Q?dvesOUbX9JVOspXTJwHmCfi56ZKm/J01c7zUax0NoBrix6vu5SAbAdJIk85q?=
 =?us-ascii?Q?kTNtpxlGneLkTLo7d6xFjt1Ktgdl2XNGNr19a/4YLEtZq0uq3+ZeADzZkqXY?=
 =?us-ascii?Q?6HYkvN7Q/4yEnmoPtGDZzkE6j5BdqZ61eTXG7N6iT/+nsFruf3bzU1NSkmhJ?=
 =?us-ascii?Q?TDTtwcczuoqwB0n2y9sAVYy+2J1GITSMZTvbimhOwkevNAgNpIli22etTCbK?=
 =?us-ascii?Q?KD1WoCBPIdX7ejNoIowvswlzk6uvt8EqGMNGj6Yw1jsD6P6OsXJ0rq5nvZBj?=
 =?us-ascii?Q?UExIQZSxwPyGvVPIgoTrfp5gacUVExh/wLDq/5DOTy3V0cdV43YfsS3SbFMt?=
 =?us-ascii?Q?S0BVFvdgbRCtIVKBH4omhwFuhxGMSen9ApU1TnjLICyR9oRbzhL13uV+mL4t?=
 =?us-ascii?Q?4JiEyCif0coJraP7w1IjCxNbG+y1uRNV8iBFHu7+Bn14LfV9maQuuZmrj4BA?=
 =?us-ascii?Q?fcKPspzNq4eRIeGgVsnJI7K3GMBr23yrBW9OawE/OkapxDo5nmXD46iuLGhm?=
 =?us-ascii?Q?h1pN6R0wWxwAUzL5kNqwL8YsmQOVAn6sXU7UTHj99W76iEwRNn98F2nkFV5Z?=
 =?us-ascii?Q?J5cdaoq/YhcpAifqg7dsqy0BEDBXlb3VvO5Ds/0d8kGHhKtJByml+web/vf+?=
 =?us-ascii?Q?HAx1aLHm6PGqa4f1NtMCDyCZXgi/oQkeHZE4CkDvoCuyBI45AC7AWKPHKQbW?=
 =?us-ascii?Q?Xr7vCu/wNNFlaPOhpOLi5kSiVRGbEe8D2o5OHP8SMTyCqyGmyNc7ASUmFzIg?=
 =?us-ascii?Q?9ATd2JWqD6LdrDYehDVEMP5NdDw/H2haXwIzWUS82bd6KrxUdEkmz/hTzLk8?=
 =?us-ascii?Q?3fxwVEC7XW5NQMm2Y3IkmHhJik8ut516mpuRTiKbLw/5viL2RyP7wGV+JDM/?=
 =?us-ascii?Q?PPEohSjG303WArfMYC4xUHJTFDAzR4IhHM4dVBoqk12lyUUeVFGnMt1aPnSS?=
 =?us-ascii?Q?n40bDiiNTyLuM/i9ygQGNoKf4uU8Y+CoWOZGsqTF22EzUw+DoCLtRh0fwc2S?=
 =?us-ascii?Q?LZxzUp/FqhToPKGtKfk2Ie5z41qtaiS7yi7SsbJZ17AqSav3JcQaO/8VGPWU?=
 =?us-ascii?Q?yWiNHlXuFXoi1TyZMUKyX+QtWL2Aluh/x1sa/qVCSVU9t4j+nqVaak5aUgnQ?=
 =?us-ascii?Q?pEIRAs2xOW5i0pX31sUwd3UTaJKgUsTqolaRH5WeRtxB/b7P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f32645f-9d42-479b-d5fa-08df38baedf9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:26:01.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JudMi8phkOvHt9getJ7uytsvbYqZz3yUx/UOsld34yDDQCrlA+oMpw0H00zsYI2zi7ZVyxqPMIcATFRXUb1CKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

On Sat, Oct 31, 2026 at 09:48:40PM -0700, xiaoblac wrote:
> From: Cheng Yongkang <teel4res@gmail.com>
> 
> del_nbp() flushes the port's FDB entries before it unregisters the RX
> handler. For a normal port, br_stp_disable_port() moves the port to
> BR_STATE_DISABLED before this cleanup.
> 
> That does not hold for an MRP ring port. br_set_state() ignores state
> changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
> the port state alone. br_mrp_port_del() then restores forwarding when
> the bridge is up before clearing the bit. A frame received between
> br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() can therefore
> create a new FDB entry referencing the dying port. Nothing removes that
> entry before destroy_nbp_rcu() frees the port, so a later frame to the
> learned MAC can be forwarded through the freed port.
> 
> Remove the MRP and CFM instances before disabling the port, so that
> br_stp_disable_port() actually transitions it to BR_STATE_DISABLED.
> With CONFIG_BRIDGE_VLAN_FILTERING=y, synchronize_net() in
> nbp_vlan_group_unpublish() also drains receive paths that could still
> learn with the old state before the final FDB cleanup.
> 
> Found through an LLM-assisted source code analysis workflow and
> reproduced on net with KASAN and CONFIG_BRIDGE_VLAN_FILTERING=y in QEMU.
> A diagnostic switchdev module accepts MRP objects and delays the
> NETDEV_CHANGEUPPER callback for 1.5 s, holding del_nbp() after the FDB
> cleanup and before RX handler removal. The reproducer floods the MRP
> port with rotating source MACs, waits for the port's RCU callback
> through the module's rcu_barrier(), then sends frames to those MACs
> from another port. The unpatched kernel reports:
> 
>   BUG: KASAN: slab-use-after-free in br_forward+0xb1/0x820
>   Call Trace:
>    <IRQ>
>    br_forward+0xb1/0x820
>    br_handle_frame_finish+0x148b/0x1e50
>    br_handle_frame+0x90a/0x15c0
> 
> With this patch, three runs of six cycles each reach the delay without
> a KASAN report.
> 
> Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
> Closes: https://lore.kernel.org/netdev/20261022090431.3641707-1-teel4res@gmail.com/
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
