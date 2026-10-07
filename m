Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFD44781D
	for <bridge@lists.linux.dev>; Wed,  7 Oct 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381052; cv=fail; b=Yo0GwgP9ymUQpttYe7umMHZwuzAVVHXHgkNcyxKfLWp1I9OPK3yNhmI219m77+p/eIUtWEv+s+iU4j088LUJfHlAjm4yVCQhZ8IkTlXcPQN+Y3hwi5DfXuSAw8o0rVRsR3nWoa3bVw+q3G3FBD52ek84DhHYFrcG9NSpy7ggbl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381052; c=relaxed/simple;
	bh=YskEpnkH4Xk6zPy5y03UkAzgCLQF6r1CSpSlxN1Hbck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GSvfnqDk2et/3k/nq9zPWtGRyohFbycFhh0nzF0SNf4Pl16oNR00++WDmcc/uNAjTaFo9ja+5sPIb33Z0+ZlBXEwqQyn3BiTJr1xUFPPJIkelSlAAxHJi+OijypBZqq+69eI8egFI9kdj+VP89EeAdaguAqf2AvjVf0ve01tLLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ue9tn/lr; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ue9tn/lr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnbtNcSXIb3UjFabXjnpA1iuk0nLQh3YJWk5Lfuhh5DHSo8/sawuNA6zxg0yqQ34CzhO+kOsIREPiuf1P3xiGHCClgVcEs1HaKUjl5RgPUJ9lTHjLdqOAtrIw0smF3NXlNUOpS5yC+wPh3FRw2odpw7eXUNvp51j3EJ7zAymUR0/qJit3sjNfUditCQ3yDtHaSXz1yAUL361mWc3kq+Zy8xK6ifD7XjDbIYE3UMLLqXuzo96CK4WVHSyigPItnAEuu2rvwO0d8aAgBbRCXdrgyoL8enyX2p9j8d1pNCndSBUF5aMjvHOrStkMWSBNpGkZMjmRzE+2KrPYSWstb+PGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YskEpnkH4Xk6zPy5y03UkAzgCLQF6r1CSpSlxN1Hbck=;
 b=jKoO8Yzitq+xDN19pxasQ21+vwltZCgEw76xxH1ZmPptqiWo4TbVFgs8Sxzyc4SnBVRKK87KgOAy02A0VvD6Rk2CKcQwE5UhQKI/Mf6o4gF/BxtTvdgcnm6bp/xSN77J56lO2MAqfAkmR4B3NK+ApceYwWrlaMceVeTdSJim7TmfWg7wvTwYvKwdFP5OYXRH/7Q6dmmXt31ky3yrh1saqqxVR4H20XoN0CPMTZnDS8FdWv8HYoynI6o4By6+2BWCxFtMQ8LyC1zYMgrKPA7xKPBWm0L00z0kAp2kxmCcprftkIVoM+dedVKkI1gy4/S0lBIcomgC/Lw8fE3+AVDBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YskEpnkH4Xk6zPy5y03UkAzgCLQF6r1CSpSlxN1Hbck=;
 b=Ue9tn/lr33at9x0bRXYc5FBaPPgJQ6obpZo/kCV/4V5nyo9Jc+oYYGzHjU3sr88av4f9Q42jsdpS8FaxTkZYU+jcP04Aa7FV+dOaykfFwtxcU/DqmxI88W1VTh6WBPL33Yrl0tTzq3QGbDHmabmFksIBGAYD1/Wv+jP6iFNFcAXV7ylX53HWeAjx45wCARcwMLxWHcufwaobT9tOCgQaGTaxv9RL6P8F6qBDYeWoXsxoHcvtBlItJH4yJj1v6Zqd0JV6lYFLS2dA6Yh5tXqE8JuUO+zm0kiYMIu2hPtNgWBte4+UbfhnklwCpwpB9fJaPz24/NjpgG3ji4x6LdnVew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:50:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 13:50:37 +0000
Date: Wed, 7 Oct 2026 16:50:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, horatiu.vultur@microchip.com,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: bridge: cfm: notify userspace on
 CFM config changes
Message-ID: <20261007135026.GA1066611@shredder>
References: <20261005043822.3106580-1-w453y.me@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005043822.3106580-1-w453y.me@gmail.com>
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d314a04-8b5f-4dea-24ce-08df2479f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xArf7El9SHw7b4sI0So07QzP4Z0rHpU64eNxyS2g9UB+5pJmYKP0H4LaWphukxHNox+7D95NgD5E9CnWI0IpKHHKddNyIlGmXidKo94iDw0CUJWIumBNoFtmKozC80shoJpRuv7ykwGGFQ3bOaSmsXeP/MrzndyxBX/UmRXJKRbwf5XA+cZVMDepK3Wdv5g1F2hWgYJeeCU3Ge4oXlkprUs5Q1bTJp9Na4m0mCGX2UwvnaxmzVK2wHdDmueWKuu1dx20eEhjeR1XPA6CALWUWh3gO7oJJ7+45LeK2OVLyCbLr93fuRHc6Duv4KS96YueEmyr080FJwYydvVTW8k3dBKP58/T66qPgWcvVmqOro0PiR4qRxdzgnaT/eDcUvNJy7WaXfeA1fhX36QrkbsriPYkqfmr/uu5zKQM5+Em3fKbEDyzoznfUa9ehXuKVRvOE1UO6E3l+UhB5Hbmp415LJcNbgz5GK9kP6EmYMu4EYVGf6Ts3AxYEM77tuV8sMdNR/bExtqKYVwUeZm6Mibn5PBlY3wjCYgOgP+1UbawYFJbQc/GVYDRS84FqK20feA7JIyRELnUxxl+RLBIFYnGDvwtWZfh53ctVjziv31D7LhdZLTdQaXvE4Ot3YANFVaPrPQkE+7YpCQJwZeT7aJ2RViYRTtBGr1UvIl5guOqaoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76JWU3F9FJ294z7gPaxW3dR1xPDdtEqBAFf0IAtfUj6LUk1awsQ2OnZzQx3Q?=
 =?us-ascii?Q?Poasx3nDC4gF3H8cMGCqLlMiw6Pgrm7baHpW7Lyh3Zkf7iCLFjOJLoYO9mVE?=
 =?us-ascii?Q?KtWDl+2ZJdbkN8pNET8ziAvgYAmdMrufc8dIx5QxjtqzaIWRQZv9EUEXIw1K?=
 =?us-ascii?Q?2aa9QOkUAY4xM5Oz5F93k6vvMhODNdRt5UuyYhs99ujjGIogsRFEHMWvnexI?=
 =?us-ascii?Q?2sl+Bihr1UzEQnmf0gep1TgBoFEPrcMfr75ltdyv4lcttNpkSJ3YkkJvLVm5?=
 =?us-ascii?Q?msqrrFeEEdF3J+67+Ysd4ivelCPgD0jkwUqrbYuymDyOPd65d4Cag9IU4fIs?=
 =?us-ascii?Q?lDFhyK2CJZjtFAr0hM111a4hUVYd1aODCbVWOxT06lWG4oRR1Ve7MeUzIFQu?=
 =?us-ascii?Q?oWv2RYNSyOnifmb/p2T3jw/7WikiYvDvGz29DGzm9w90duQo6VTkwjzKOayz?=
 =?us-ascii?Q?rb9gOPd1YH5nTEbnhWNv5gOOvlhg76IvHlFGur6M13x6ojrRIrJT33y0/D/0?=
 =?us-ascii?Q?4o2vEDTXJgI1/QAkLl2Dvr0ujAfSw8SewjJCbSPe9MjYfFNPa3tG8YgVN11D?=
 =?us-ascii?Q?fvLDHVVS20R8F6Baudwa7FbGj/7KX8nRmX+uoqbRXcCyAs6eojh5Di/mn55l?=
 =?us-ascii?Q?rI6p9LhnbFbY74WK5I2RjSi6CnawMFk4yMj/3KIu35OX++hLt5J6QJ5f4Y16?=
 =?us-ascii?Q?VsLTxmaUhgprWnc057QHV3Vz5Sz+MhfIKCW9TZNuHbMpK+DcM08mwdJXkOJN?=
 =?us-ascii?Q?fnFw18LSekkt0+kIRA+/tvz3S50Cp49CN18mwMy/ePqdXuRBRub3+iuRfvTa?=
 =?us-ascii?Q?vIdXJjuV9vorLlfaNFosebeK045RED/BC+yVt9BC6BK/vt42As+t+q6NWP1f?=
 =?us-ascii?Q?mqdo8jHM3lLed5NG6aR810X26w5ffQ/Ie3vouwhFqkTMdDsJrsEvVEPoj319?=
 =?us-ascii?Q?etAx7EWNGtaFHV8o6krlwXwFQi4r0WDKsiBi0aERVBU5yiM+hVufuyewQiPC?=
 =?us-ascii?Q?dteUGvnmBDNmueD7tWRGXTWr5QnsUqSBswZa72Fjq0N9Y72qx/dK0DVLguZV?=
 =?us-ascii?Q?sAzYqpCbiQ+rJbQd7RXcr2AlUavyMfP8FFuKROJWmhchd7zOAy0JV7DtXj8l?=
 =?us-ascii?Q?MhFcwIj9Tgu8Vnamrayb65Oy/AhS5/H34+nxwLkU8/IQhw61gmLa53ZuZG7w?=
 =?us-ascii?Q?qs65r0nhw9EHtw8Mn+n20N6ziMBHjd0Y/Fn8Yihau2+eI25gfr9Mp7qhV2vI?=
 =?us-ascii?Q?EmQWZedkukUuYKR8ao7UeT5ZDqB7h5nUTGlk/uvQve7MMDt1wvSbmcUfNTYk?=
 =?us-ascii?Q?LQNnmICSnaTeHK2w8hlfqsTemhUsU43auvvQ3f9JdXs5qS6JM9rHVG8m7QMz?=
 =?us-ascii?Q?brWv+Kh3NwkpKcOoVJBScrBs9ca59k91fSVwYqxwzXC6Dr+hYRsPteAtyq8A?=
 =?us-ascii?Q?eaYn9D1HyykkHQAUajnv3FdSHBCpEl0q7e9iOkKSrPkIocmPwjSQFpwbdIOK?=
 =?us-ascii?Q?l58wCdehxjON6q/683y+lEP+XHeKyTMA80bQ7J3ABEi40M8XGCHEU1/ykdHl?=
 =?us-ascii?Q?Hx3N1OVUoOVKMLdTNaxpYjiZqhA2TwUzysUee30miz+6m+Vrg+HpryH1gOqv?=
 =?us-ascii?Q?g0ypdpicX4Ng6sDUYIQpoqnI5pxrU6SjWHms/jiz7Kji7ACw6fX2SGYpCIpt?=
 =?us-ascii?Q?TC7yCPnUZyirbb/EoQDg/6UTnubX+0BNu3L+eIFhQbWjSJva?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d314a04-8b5f-4dea-24ce-08df2479f75e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:50:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VohInD8zVGvkiOej6+g8qEAj+OSPMfGvk5wVLsSFOwNBNsfZP6dbaU+156iyXzSMldnf5n60i1HW3Q5DPlWZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523

On Mon, Oct 05, 2026 at 04:38:19AM +0000, Abdul Wasey wrote:
> CFM status changes are sent to userspace, config changes are not, so
> the only way to see a MEP being created, a peer added or CCM
> transmission started is to poll RTM_GETLINK. Patch 3 adds the
> notification. Patches 1 and 2 fix the two problems the AI review found
> in v1.

Given [1], I don't see a reason to review / apply this series. Will add
a deprecation warning to CFM and MRP.

[1] https://lore.kernel.org/netdev/20261006134441.3696739-1-w453y.me@gmail.com/
