Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A943F7882
	for <bridge@lists.linux.dev>; Wed, 22 Jul 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739153; cv=fail; b=tiayV5PNXANZMPTE7ix2jn+7ZN3GZ9QuQlZ8BHKcBgLaFZVUUi7OAFD0SOzm7oe5pXo06EcRd532C+xvj39NOst3LUPasCkJJbk5mQXjjzkJdh4KPD+QbqaKyiJK70a29gTJ2QCCTsUELAsS4SmJaOmC0q4dXyzW1PBluzvFsew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739153; c=relaxed/simple;
	bh=a9Mmp9GXSjBxEwH5dZ5IHG/oOPQwR4/59Qnjf+SfOdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akAhMO6hAROM9Q9gjK7kurtim9iczpF/X87Eqyb6W32FNM3uEa2jairel9aizTQnSFpZ2DAdRSh5bDT5WHPsthNSKRcfvXT1Zi+sdx6Q1jvdBHfjPxoOejzWhPQeFX5JQ98VEgvI0K7eU2LEJcIOp8/LcAV7jZE4zazQ3Bx3gRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RvHTbGT5; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RvHTbGT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ43uO1DvaZjb3koOB638SHQUkpizRtMZ8mpD7Zj/Yq/jDdL/hpv7SAk8ZUWto+NdcBjpJriODLrh48T6+3nyYYMsRtju0BkO3p8at7973jCKPmXyMwD3XeZCjO43GFdApq1gfLN8taYVx0Uq4tUuVirMETfJUYeEOYke3bjtkSUVoJo3EPWK7SztPhLNXSgbYucE8ljFSCQXMBsu8TrUVVgckEWhuVNmYcGZ92H0WNQq4UrZv0kiamyP7iXudabnG1uhbKbcBTGakyQALHuCz3S5EbnywfqSD1s9gXgjGXUzzdO6oEqvdsE3Lr+AKdW09YhXXdXg/htoxYTsZvULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc0bBd89PVjM65GpA0ClHnK8Uw9ufdy59ggelpmY+Q4=;
 b=cSubrgufyHnvIeErrCMe7Dj2N2MswkTf4NrRiLJfd3P9fRzFIXeatgmTINmxYWW3zret/QWUD/m/JOhP/b1eWro8flWFFoD/1tSYzxf97ZqET39xiiFMIV2PR7jm/mpj0oBsjiyrPfPLXSOrkLfZ8ye62VmzbGAGGnePYO2IJNastyw51TT13mP8sT+pIfQmlBVntKUDT1Zwrnp1DW9EGBq49hovLgwco3IiGW179R5ZZr8kKzV+bBjGZkZuh5CVEngvROiLeGKYtP8gEib4a1cwllUkvlvDPca6bA3fqqJ7UMrAYZxLvhWXUKx+h7oeSmbrUc5myl/9BvYjdmwx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc0bBd89PVjM65GpA0ClHnK8Uw9ufdy59ggelpmY+Q4=;
 b=RvHTbGT5SWsJokkER9H13TpDI7OOfbR0cz2KUhk5x3LljHSAiIStYpt/8MC3kKGgtkFlxVm8k86nnuM8vgAApGwjkbrd6CA21Nv8foYcodmUFa21vamhIXzIlV2ZlbLYrhlvLifxz5GyU1TiBKlDyB7IZXhgIdfmnDqqrbq3fDXl5CGqc2wHEL5489dwtQ8duMGcbvDiLKVoYvU8kaIDjGYqA/ZzRanqWYn1KQkH26NN5led6Xc+nbcm5XrW7XYjGprvpXX8o7+ECWWDRu4CXj0pWdk3+q69vHRrbhtciAL9tTk1yCS6dYIrnHw5HwIQvYa8K6FF5qYn8uullrtiKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 16:52:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:52:26 +0000
Date: Wed, 22 Jul 2026 19:52:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net 2/2] selftests: net: bridge: test ranges with PVID
 VLAN
Message-ID: <20260722165217.GB3080508@shredder>
References: <20260721140922.682265-1-razor@blackwall.org>
 <20260721140922.682265-3-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721140922.682265-3-razor@blackwall.org>
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: be06abfd-d6b5-4045-8196-08dee8119bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3QuY2bE6VVZXCSElnSieQh/pkFdEYxLwToasu0avylzl7mvq8+EbiUU5cXCBCtV8v4kkTEG0JzuyhCdHjWULcgQOKuoQ1qviHgymCyclPtbIm6SOqmRIsPnQDjN/W/ICHJEAKIGR9yEc8MYPNps+s03I6KiJPmuE/rwBtfOQmNJF8tuEs8WHMC9uc8ZACZzlJu54qRLnZYd43koDzelrhgGh8DlQz9e5NI/QtnTVGMmppIerMmWkW32Sy42cpAd9Zd93A1WoGrfGkkm85zBkebnJxdTuwqCH2IOz4KEw4sg8iL9CB+OQ+oRFXJtNr8UUiJR58ZQf+wO8lYAJ9UWOvHmzD/UjhJWTUF+Z40jZNcK4v5EdJsgFAuZSyrXViRFZwiTfWKwsh36aCEG/0iN7wF9pxxgLDd4HN0pyAUdCM3mslIDQ5B9nsW8W1UunOeDfUR4jRdIVJxVVAb9Pa+IHVppdwf/X2E0fy4cwhtNA7aVzxv/iAy+GMBUmc+sSjF2xrAxrxg1AvPn34BorO5HhiPbW6QpA/cEQH8GRohhv67BPgUcAVqcixPGHBwcznttj2vxKdWrnINYGxcaPEWzHHIPq/kTdPfv1TdFCu5p2Wqf92lG2uj9jd7MmhUhcgQZOlPro3CbiuZcTEh6TgjD4bcKx7X+TQFHFxgkyRAHDX8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zv3qXjDhjzlXrU0ijN4oxkGv+CDZRojaDHboFy6j8RFBML1HSFgThi+kH+Km?=
 =?us-ascii?Q?cxyFsKZHM7vzoescml5vGZllKzgntJC3Q/f+6ajHe/PuOffmIOhZRx6nKI9l?=
 =?us-ascii?Q?MSzgzUTH5pQeCPNNbaGI7qJ5lxIumcCMWhU2qiFvqQVIq688fJIvqUkIHqNQ?=
 =?us-ascii?Q?cXWucgNDBnr7snUsshXPKxB0yRgfTwj6/d66V8OWCn2S1hkoIvLZuf3LaoX/?=
 =?us-ascii?Q?lMInGkbgIUwTu8szms3J8Oq0duCCtaXNfmyHKry0ALL+DVrtx00Os+UuQO7P?=
 =?us-ascii?Q?pZF1+br4rJrLIS/X4wbkpWe4fHV9RIP+UwfhN+ADDwUGxk2n+j0hAst1npZX?=
 =?us-ascii?Q?rGqk3L23+wAgXUz2zA1hX5WOBKus2sGCwX7BKz+M6HS0IPA0YM1Ib3m9AqlI?=
 =?us-ascii?Q?QIsUqXcNf1xhO8zDeoZuI9FKJooKlIFzU1waQJczH9UbTh+jZfwvaQKzSszJ?=
 =?us-ascii?Q?X1sreW3n8kwVyQ/RIe12XG5OWoscUjiRcfCzOid0PlN47KPWOMp7i6M6ngRb?=
 =?us-ascii?Q?vt7oGEs+QbXeR5WR3WeFhwnTevjq4IIHGPEnVotW7ulGmoWojT/RZWBb8+HP?=
 =?us-ascii?Q?OyEh3oPeI8e7+/Hy97PM/xRFS0k1E+cwbk7MuGbcLoPfFRrFAZk1BbCjatDD?=
 =?us-ascii?Q?Bh5XQbqTLFyg45md3mOEPQnJlJDhAApeiXsKvQE6KHJLGQ7cBGkIKoZi8vjx?=
 =?us-ascii?Q?YTiXK4IhrE9vWwTlibHaf5nLv8nFDH+obHHjRAkkDGXTt18i9uAoSAF6aVz1?=
 =?us-ascii?Q?+n2kCRG0CJ+zuHYjCDG257iGHQmxXP/5GuCH+tsSJ+RarfO6md9zqUSy2zzR?=
 =?us-ascii?Q?92Nm6/eYrpYJy+AmEmdsDCA1OmOHoWuvPbR/HxXljwoHi4O7hCSd5xkxMezJ?=
 =?us-ascii?Q?/svXLUaxgzUftpbYNZl9hg2ViTM4LFxA2xedib1YjWAt52aiVlb+9o67vHk3?=
 =?us-ascii?Q?HlaA8iC+iNgCjhVXo3X01IV/+QVEFwy1HnhfuuAAOl5iH4XfotIbPTRb99jL?=
 =?us-ascii?Q?zaQh4SdB9K0fHGDbCOujrBqFtXwShFglHP9R6T+PSfgPZbY/DDMGPRe2Zv0B?=
 =?us-ascii?Q?LBzDpiF9NXRUfesosCSMf9lyYtzRZgF5ST0+0oFVYGLMrkLLUwJlMpqFsZh6?=
 =?us-ascii?Q?340ifRZ/GAeKALjUOfRR7ZrJ/aZ7pRxV3XsJxeIB3lrbadTiV/zy6VMwfyr5?=
 =?us-ascii?Q?N3gQoQoEJWj9TOWnr4LF5JJWtS3M3pfTJF3MzLQTOJou6W4cwWQg4PNgWX0k?=
 =?us-ascii?Q?H2d9cIdtx4gYXrYxWPL+2+AR/IxqN4mknkjkEwXZ4D28QY2lRraSmyrj23ed?=
 =?us-ascii?Q?ZDONJ0tFkOD1PmbwHCQlKjycV0SLzza4jroMAOd3o8Swq1gLE5Ynju3Z6881?=
 =?us-ascii?Q?/zeKdDdD0n7cR3cMrcM6f4z01EelT/k/ysgbtHit0DQL+4P2FUNPpfDUApVl?=
 =?us-ascii?Q?oNmLefwYkAuPcyBlReYR8+Gu6YVGo4lKxBfRzCkYQuH6qgbKpCth9ET/zsDK?=
 =?us-ascii?Q?gA+xc3tCi6wximK5/dRaA3am+eSs95kGmgQQA8/DXxo4LMkZgA8mzgMaWp1Q?=
 =?us-ascii?Q?FMG/nglkLbJ5JtmBbaKtm5yV1o4yS+o7oC8GXLMe2QiqPqcPZDAEKXWPmWQ7?=
 =?us-ascii?Q?mYXHnofMREA+6KvFqPIrRK6zXOYdvdP5U7OSdLWClGEIta89sZQGgdVAuDB2?=
 =?us-ascii?Q?XW5SHxVEv5Q1ycZcDYBh/2LzuYIxIunAWVMP9+4jUNES8gF+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be06abfd-d6b5-4045-8196-08dee8119bf5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 16:52:26.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iniJC4UHBRCwy0oGfZ3caL2dG5mtEXk7IEIGcgYQ9EgtELFhwbrFiqoDlmvkILXssSLc5k/vrA6WB12vIZ11qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

On Tue, Jul 21, 2026 at 05:09:22PM +0300, Nikolay Aleksandrov wrote:
> Add a test with PVID VLAN that matches the flags of the VLAN following it
> and check if the range is properly dumped. PVID VLAN should be on its own
> and all VLANs should be present in the dump.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
