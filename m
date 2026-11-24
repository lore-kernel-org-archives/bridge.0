Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528521;
	b=jUhjN00DJAM/45yGSvD//81sVotJIrEniZRMg2KqGA68V9AEHYi6clOscZoM75z3PynO
	 Kass+X6yoWCV0J5kPk93N+ZnUImB4iu+zGgA+AulD9QG86uW3FxrlN/L8RwRvzIokVfSC
	 JvIz074RxbK4wW1YtzdqwmzPXDq91WWX/7YcJdHzhfpA8V+8uYAam66430xIw0+1+svQr
	 KLNytICy9BpPGJyGONSg5ofWKl2fr0ccyQK7Gn3ktwyDfAHRakOnasSpHyt8yPkXJC/Bc
	 fic8w+/1WI4lzGmbzWi/PqABQRqk0jraubEg9zfI0yDLQxRk6RwBMuZ4vpZDMyiulog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528521;
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
	bh=OCVPCWRhci0rtmjRqh+iK/91nx30d3Qmj4pm8HL30xY=;
	b=wrga/pYPeFnTWfjLtO7B1KJSeoV4p+0SuqKIFyeazvK0KxuI3s9TvDnyImzp5vE9J7PB
	 Wi539w4N8h6BARG/nhPvIYzKR4aWS4T4l3mfZgFssle4ZT6M0DbpjbzfVbmU6mrYN4Ds4
	 Qm2pQHCBonGbduPPXM0HnF8xFBc1blipOnq+aVne/0TdTQ/Z5PsysWZUZ7NWgJ/GMZmRQ
	 lXqNz8K6rJQ+r0MUw8e/x8H6aZC4A0CuRyBLYpBlVoPfSFjDa9ixAWqa8rrJphYFoPQld
	 tzNz/Nnu2uWN3nX7FXlrVlzxQzwTA54Y/NKMVgf5Amb2BaZDwFIR8JrF3n/9pehbWtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="HQE/lxZC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.4
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C602606A321
	for <bridge@lists.linux.dev>; Tue, 24 Nov 2026 13:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C602606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HQE/lxZC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIwj4csW2uzVivddRAH6LeMiQOtmbojBv111J+kfXBRuKSS/nYD3QY/6qroCwGBjNiX5wl5XcewNfyVThb2gk4ke7rdcXCzCqLHvk8lz21y+9MiClFSmU3wrfGwKC39ef+Q84QFnDiy2+qJOc0+r/N7pc2duotCFlWks9ZOCvQtXYsCcHeJbiZeZxtKWGklJd85eRu/LB4FTHvwFyC6jdr31Av6f22F8bQWKtIyT2SiFn5wD+KOhLG5vGOQudqlfcpsHYLvdPN69Fjo9EGumzk5pikaie1Kg0sAFdMheep+oRBXdWvEC0O7Lff4zrwrgaZVMJ3qfoYfLlbx8IVwGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCVPCWRhci0rtmjRqh+iK/91nx30d3Qmj4pm8HL30xY=;
 b=uboSdxdjMBsClaECXmwM843iPQblNW0jhAEfxryigyMc1f8ySsNNnmJ7tMJj2DIp8bHdRSXjZkkR+9iWwWOWKgHmpZHyjihexfBKSPS2m06gnbewoozmwlqHWhE1CutECrww1E1vHLRhAiVb9ABWiVXN4x4elbxP7ok/lIh9afdsbLG5dCWgr4UgUtmSWHVTDfYRSWP1RwFttxGke0HGfYX7JBCmkj4T4eOYuwXmxkyqS4sBfUb1ch4M+KODk8vBxz5w9W06FSXvRY1V8JTODK6QV2aN3h2oQ506GAMtiR71a1hAHOQJmA+YuO4l5FVD4GfwECufXSqxZB/vQkAexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCVPCWRhci0rtmjRqh+iK/91nx30d3Qmj4pm8HL30xY=;
 b=HQE/lxZCHs2X1jNvYu6Zq3cOXqrwP6qA9coy3c0RIgsbjjP/mFqqgtM0tojFby37ULW+TLp1XWRIUHsjOWnButUm4n9l//J32qkTSX4gXx9RkJbudUVE3bYD9LYfV1x1mxRPhw6Bjy/AljspUA9qvcPGF2MNuvyVqnNB8tANBklx4c21cUGrgynYG4v/WMStvWAdVVLLOJif46R8U6FrsBsdJl8uidVIQzvdFg69q3b7Cpn0tPmPPemgEtVD6CkWiZIHbvavyZhdyVu7AYxG7OW0sBTZ9RSayuNd5OdGk/4EgkBzSyFwhFwNK4FXuL0s0uC7GMze3/CKJXPrUCnhVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:55:15 +0000
Received: from CYXPR12MB9385.namprd12.prod.outlook.com
 ([fe80::f8b:8279:83a9:3591]) by CYXPR12MB9385.namprd12.prod.outlook.com
 ([fe80::f8b:8279:83a9:3591%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:55:15 +0000
Date: Tue, 24 Nov 2026 15:55:06 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/3] net: bridge: optimize vlan multicast
 forwarding
Message-ID: <20261124135506.GA3882860@shredder>
References: <20261123102833.924427-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123102833.924427-1-razor@blackwall.org>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CYXPR12MB9385.namprd12.prod.outlook.com
 (2603:10b6:930:e2::13)
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
X-MS-TrafficTypeDiagnostic: CYXPR12MB9385:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b956afb-2c2e-45d1-de32-08df4a3290e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	u0PT32YSZUecQ8SFzu2CkEuytwfujLfXkbKfwpM/LZLH3e+1USLAn2+MzWceum4atIHGacYw2r8biRJxfrAo+7po3yr0G4MPi5qsxNz8fCr4qdGx7gcr4QYPCvgQhVrCXoDX9tSNIzD7M/zdEu/JdzuTkikboEus/SZ7DNc0pcEDzYuHb2AU8ealF8eK4kobjZ3TS/wVzGnQkZRhTSfxH9IEnLuuhmOCRe1xnR2c+OAiPj6Zul9Ho/yB07lhCZPRTM7hsURbviL3XWzIZ5BKzEa99/htBvpt9zkJovf8pqgpDClKuL8UsXPZaQIQtVjg2ZAXwSbxT/EImnVJZ4fBxlrx1zf2JTVesY4cbo0uLprs6TWfI3wZx53N2LDHRRL7p+DwAaBdE4yWUmUHWs8LsCu7F7Ohq6hvSBCzeVInxramuInj8LC3rr9cb2tH/S/FIi0fB2aq9kXPFBwp0IF0kqKNoPpCvD763IAA+kjo4a1tPGBqqtXWQNd5ZTrAo3BKVugrf1ONJiqqVTs3mWv7a4Ii8a4a3/haN94QJjfgDkL0KCH81FHMaaVuD9icglk/TpM2Xn4sWY68HoQXRHGH9H91fRHqgKBKy1LxAm2HkDwZ8O5Z1xAZYcq66vPigVfeXex6s51royGevzQWsajZ0zzIWbl6dfNH01h3KDHsR3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1aqGRNLgmbJ9YmM3iqYBYXRdv9h1CLCvihChvDQBL6jCVYtUVHt7I++dNQn?=
 =?us-ascii?Q?Ivo1wVEMzD8BLJJYcWWGNqUw+LJ0tSIoXiqDDv6Axz6C+vC59xwvWb1swxw0?=
 =?us-ascii?Q?1Rw2Eh/RGEmZsfsTD1WmbVbmlkMSwQQWq7QO4F835FcGGmC5QJusgKVrBeIh?=
 =?us-ascii?Q?f8Pzcs9k4mUUzbdIYT1yaERCBQOCnkVhbawLOoIrqplL8lZCYUKNbD8krYCt?=
 =?us-ascii?Q?97cvDikGFRZE2Vlp+oiIoO11M7XTyxzL+QZ7n2ruoq8rV6KVln74vlZILEkD?=
 =?us-ascii?Q?LXYaOBBwr9rGk28NjNzCVm8OwvGoLBnXIxm+qgn1F0Vy4bdlJWlmPOEW3yKL?=
 =?us-ascii?Q?WADV9SNweMQr7EFSz72DNanT3kg4Z4q7/9Hm6Zw0buTVHsWEkXfx33oo3SEL?=
 =?us-ascii?Q?+HzXCUNIipm+V9uX1qJLevdwvbXsZJdBoK5GevJug4ZNi0maQzh5UHLXr6CI?=
 =?us-ascii?Q?gFnyTZvWAbPzwRuLWbWbY+yyoBHFzQaxieMKW/zGIIc6k8Q4MFwvcXl+kmFl?=
 =?us-ascii?Q?R8Ah+irrYtyE0qvIYsQX0P9TJXypRwnkCpNyh02elNtJOb1p+SgG6Q9ZIUC/?=
 =?us-ascii?Q?JVhWf75y2YX/5pAXYWx4zkDEAJFkwbmq7phZg0qUjOMVRBa9m5KuJyUjMgt2?=
 =?us-ascii?Q?2B0VSWgN/h9Ibjqb2LCINlEYGlZuiuuEtyHNOnRMGkuhUy44Rh4dHnt2PP1r?=
 =?us-ascii?Q?bja4uEImAPtJRczyelOHiM2HNmRXXrV86t/AEKYNeJ/A/DUiqffN4+Txy1WV?=
 =?us-ascii?Q?T8rhuqAWsfaHyOhYTTCGyhl9gpwTCcuZwYDcf6F/bdPI5ai2BB5eq3Ktc0gb?=
 =?us-ascii?Q?UVjAoC9sBaN7zBmm3t8ZKAIrckhC5f9ls4CZQjlHvYgiGCYOus7S+RrnB1RK?=
 =?us-ascii?Q?TK/92YSbXwy2GimWAX1uzMEBiaqu0HTcu0Q68FNHkuAObxECZGMDvd2ZGk8t?=
 =?us-ascii?Q?Y/RXUmEA9WvEol6gzCwZOpNEJ84yyFhYYzgUXfzbf1uSMme7+fZNxvjA6DDG?=
 =?us-ascii?Q?Ngsd6ETxlJ1T3M5RwHM21S2W2r7c4PMEmJGGbodsVAKFoqGR+irDj/1da9io?=
 =?us-ascii?Q?CF+OLMhFtaqL1QMBwGyhccWfa5BBTHMEpACYtPdfvyNBtbhV8VCf6KRzy32p?=
 =?us-ascii?Q?wN4NHS4U6/Nehwy+qFj6OOsEnwXFiQOuTc8Q5x1skdaSXIWornMR/6mA1Brc?=
 =?us-ascii?Q?Q2uac14ZTLJnnG7wdFjZgF/3IEafR24rX3Yb/BtD16uT6ObDJVpdL5NAiHq1?=
 =?us-ascii?Q?MWDmmx6BT/Uv3HUTEnv41uEK4opnDLDnX2TfMlHET2/n6/ECsV9eY88zTYJq?=
 =?us-ascii?Q?oxLDLkcNvYqKmpC7DOW1Iw5+cINsTUh9ZZApD1kj+teZLey2P0QPkIk34mcO?=
 =?us-ascii?Q?SejFTiablS2oNrKDWQBuC+muDRyRc52PfqR7Zm+DonZEfitkPSshUFc0x6+I?=
 =?us-ascii?Q?44VeBExVqWb7gC/XGbTc4NcpnfQnZPxseZNtrGcaFH03SYDQl3bfvPyEzQ3p?=
 =?us-ascii?Q?fKbVDnqilwEId6J09PR8+TgbyFsUckaWCJ4fJWCCC3FCcWikRZrgLOhoH/0D?=
 =?us-ascii?Q?0GXmjBVMJL1NoSJq7I2KdzkbK6teKvpjxrmSt8nZK4KTdDEx1Uzt+wnidQZd?=
 =?us-ascii?Q?O2ZEvWSj8O2xNX90FHtEOSnqMfF3mJfl3bxwTgnVY6ikNjzEkuKwYNyNDDXZ?=
 =?us-ascii?Q?f8avaHmSyXClQPiO2bCkLpnzsTTkUqTIf/LSB4tvnhtYjhg7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b956afb-2c2e-45d1-de32-08df4a3290e8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:55:15.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N70cpkjnucQwb5edAZPDmCGSC7E4+znyQKF/cbOtWgEXHW4HYEWEfMLhYmU/ETRXe2je9fEGoG2XVPESmLC8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On Mon, Nov 23, 2026 at 12:28:30PM +0200, Nikolay Aleksandrov wrote:
> Hi,
> This is the last part of the patch-sets that optimize forwarding by caching
> VLANs. It adds the forwarding optimizations to the bridge multicast code
> and also optimizes vlan range add (see tables below).
> 
> Patch 01 - use the vlan already stored in the in per-VLAN router context
> Patch 02 - use a small hash (64 entries) to find the port vlan groups
>            without walking all
> Patch 03 - cache the port-VLAN destination in mdbs to avoid egress VLAN
>            lookups

LGTM. Patch 3 would have been a bit easier to review if it was split
into a control path patch (adding / updating pg->dst) and a data path
patch which decodes pg->dst while forwarding.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
