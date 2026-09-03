Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CA4AF15E
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441819; cv=fail; b=osQWBF3n7hakMgxOUwq+obIhNCeRhzgHxl2xCvQX2yZrzUi5/Xro29KuAf/hc4aLvv2MJtKZRO3xXcq+fnEw8pqve8/AwVZDKFRKgPOhPDfbSelNGdPqJqxsDaK+8Pr1PG2V5stvYPYT6yQ7RDOgwXEyCdOLUWL2k6A7tsw+lp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441819; c=relaxed/simple;
	bh=uBdqTsan0L8raRGyadQHHRVetolCH1u1+Tm2fF9NwAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJpL5KNnSZknXYltiSkxf/ZhS+R1LrV7bO2iuvvWCEdXqv6aokwynoFAkXqNNc+RI1r+BYTZYLlVVJaUCAxbLDBfkSyn7277Qoyt6r7wlTdPTYIbCo2Y8aXnVCgNAx2WWkmc9P1O4sXxafiV7X5iMRk+TtRGC99RB589ndw7zVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T1kuLHo6; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1kuLHo6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of7Uoo4sd28IPwBmbWP7dtiycsVhAWFNdkGz8EPNwbeUnUNLBbpiCS6BU9l2rcyooR3wgTnr4xtLO8attYfLkBeC0YVtZnRSwlgHCxbYYh6SHM0G1GkioTDt5TFgzJU9t4TVOTgKmzSPHBkLY4AyI68CjwhAb+QbQ7DiS9sDEVpgY3hd+oTwpLLvUDRG/R+wyxUXjAMJr1R53ZjFZMq3gxVSuRAvaDGPlzD8EWCtW3ZPS+RXjtPCOoHoQn2oq9Uojvhg85kLgJPQmK5DopM037oxWJLEwUxomqvqFd6/jaoBRDdNgEz4Ha1l1JJ3b5dO/xNjKvBZHcZBmP9sDYZGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/u8PchHAxAjLCF0Uzx4wg9wF+kzFSOnDGeSGP8ErMg=;
 b=ut7EQ+a2mg09mKr0DdJ4kWTZr2N7V798PWbubsqFZDWLJD0sEp+uspUsboWVTT29jGyW1REWjCd94k+PhNTQpQaHmhcTIvs9euXBbC37JO/jK0eLiMOhnTjpUv/cFYMY8eXPPNg0ooEGZDZqTk09Zit8bmjmxj6ckyt/qTfsTPeOYQIxNiVbd3GEC8QabC/8yp9oKNgkzI1mqU2+K92Q/WEio8G8dTW6M86Xi2DxlUA7ll5SV+rqCyW/UicvITRPXWFimjlMDVkWyN6Sk1SxqylJ9WFa+FMzpau5BaTNvtJEk0On5xOf1Fc62xV4LXkQKk38AUWJNs0Nh5eViWP0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/u8PchHAxAjLCF0Uzx4wg9wF+kzFSOnDGeSGP8ErMg=;
 b=T1kuLHo6Shmi88beeLSh0+o7oFBRh7SqUEnN03wOe1igb9xbznieSNgH730aQr2TdXnUSUZdJFZRno0dPamHRuT7mdT/+3EX/RF7PERvQ9QnosLweN0aBRBAmLwnO3SIvO9STbLlvaB6yUNCnCfe41fliCHprCXm+m64HjhT0lnu/399BeNFDfNhOcUlVkVRmlS6hhZjBWPinVbMKGqovFvD64w1P3xDzNPdyMdoMT6nKo/7Fem4k1g6toUkMjPKyLSDvQ6mWQZkE8wZ5+nVLGNPi1BDBd9qaoQWWHS6oSHgAN20MuDWXI3jsXmte3eq2IA3gT1FiJ/ud3qZ+hAKVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:23:10 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:23:09 +0000
Date: Thu, 3 Sep 2026 16:22:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linus.luessing@c0d3.blue, bridge@lists.linux.dev
Subject: Re: [PATCH net v3] net: bridge: mcast: properly convert mglist to rcu
Message-ID: <20260903132259.GA147946@shredder>
References: <20260903093851.1494297-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903093851.1494297-1-razor@blackwall.org>
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f664abd-6306-4f51-aaf9-08df09be7f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/9jewFc2SGJsYShYaDR7rqk44jQVRoTCfu9LRcuxPTNYCFc6lJWI0Beh89LzvpV0dy9yjqcA5HiCL71BNsYkomo8oZZLxf4cR575ICF2tV0fTskx1I5ZahIQfmAKgEQXiVjHWVKuLOzrwgsGu1wf49287PoDEeWj7K2LhowBqkZ0/dGSFjRic1ppWdUUrdgTHcXA3BmmPxXOQtP1qJjEu9XbQa/UaGgeRxW/EfAvNQmx1wyjjVYm3D6RFzQMJFp/WY9VgEA3tQHM9epA/mVD5433ii90QIFxiIFby9EYr6Ed5/z6BzlCLmRh1N4JZ1vu91pObCt+yI/vuW+MR1sWMFg1KCtwqt3v5+XjXB6eBpDBR6/otOzMfYANl2lrAULt5cpqbnE4ps9Py0anZKOgLccLMl0gP2/87efpU4A3338EE9jf+/OwWpKh7F/NqyFTBY++XkIcRQXU9IMhomMzDiV5yfHZxW15PZz86F3kpgnWdc6cxgVgiRlTvLbplKQOFGL3DcO0CazWIa3/FHAzBch7svnV9USC3tTUEX6KPHvyA2am7C7zRwI0Z/GS1OAHJPPbUNCxKIsDNMwXCbLHfJ4ppoMOdlMvZ1Xo+uNvNHrNQQFVpyhI8P4fdX7pMxDZhScB6uaR1NWVH1e4ByNDBoBciKPAzBoC7IrEKz9phVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Il0YZFbVPUFgKtbdLUhPqhrOUfPXTCDz0dt//cxxG+KIsaP48tlOW9m5ydeG?=
 =?us-ascii?Q?/Bv+C7tpRnwGKut3zD7DoyLNF/+TvzQEm/Qnw7yN9JipLX4Dtmb9Q1B/52lQ?=
 =?us-ascii?Q?NFnI+fG5cjRIKbRgTvKttOkCXa27W0ULjX6GxRU50HdOZB3WyhzCgfFW15UV?=
 =?us-ascii?Q?yU1AramWSGCPeJ4YSIctGdOMzQEgRPrLco9C+Ie2azPfrolDQHsf/r9D6Vxy?=
 =?us-ascii?Q?raOAZciyQCPcc7kgFxMAxO3g5n8OzI9TNPqIuBySVCLabE7kxuyE25y8xyVh?=
 =?us-ascii?Q?LyEJ2c9elnG7EsbiuEmU6WSTVQerLDmN//K5OGG2TEZAdodcdZYsVaJR9oeW?=
 =?us-ascii?Q?1AwlxlhqrI3IAWfjrCDuzcgghHE3/Y6jY/2HgPe2JIDKlhRqmN5mVCMy8URO?=
 =?us-ascii?Q?FouRWn6pnWn0zPzmL6eK8EGfFOyS8ZNXJBiEBkbg8wchla9cwxJCE0LfNdrP?=
 =?us-ascii?Q?IiPvrkvDVlnqdwTcMtHSeLqE0iYectpl1syJ3DBwuDlVyumDWusZhsNsaYip?=
 =?us-ascii?Q?ZVsqV2vqoKWMKF8439CHgbRnYvqxiC45r/xcje3qpuZDiaiWo5oWUcKobkZx?=
 =?us-ascii?Q?bZ1/QDhWJAp3Dn4AwFnXTj5nQ6Rhy8fuQB2BIFXKYtfcO35/cuyPVTErKynV?=
 =?us-ascii?Q?iQY6QuQVUbmYC0zCyMT9Ehe7J0s0D8S1euzlcCP/2y0vwWRpcvaRnLLQtngt?=
 =?us-ascii?Q?w0ZGu6p+1d+zVgd7tLyw1gdZpCdGZMluSABMm0QUbd7X3U40FFrmlNaBOgZG?=
 =?us-ascii?Q?b/xxtyjSt8jZFJSj9L2I/F1S4y11GDyhARxz0gdC/wo6vv1R6/c3FC9TTPtx?=
 =?us-ascii?Q?OwDnsmZNIha4rBa1k6klEZFLKZf5JUi3vYyT10tgVPqT/Jy3Y8zRhyLIj2IN?=
 =?us-ascii?Q?viotsU5ugm4b4N0IYOEa7VVfSUFif9vulDYFs70Y8KWii2Z3ED8PE8amxMmO?=
 =?us-ascii?Q?MruJdPfwYw3UTgK3VJXClXceYV+W8nmSXrQsrnY4G9vjv8k63axaHw8JlNxv?=
 =?us-ascii?Q?Q0idGQqWMST1Gob4vtQyHW7o/M27yWNfi3azrKnDyoYXcgKXVQ8g2KGiXegP?=
 =?us-ascii?Q?7/cPxDI9KkJG+wRQZlfCxlBDwTpYDLBCYSELpZ8a/eQoR4ZNzF4kwZZU7HLm?=
 =?us-ascii?Q?bHukaKWEyZFyVxXMIJMDgnHVP/ILmlaHJCHuMGC5GyE6i2XQa3CaR3x0WjrR?=
 =?us-ascii?Q?Ox9NHT98W6sKr0atDladN4Qr8AuNgAMUlT9U2UYp2blCaxCOz3VUlBYGGw70?=
 =?us-ascii?Q?/eUU7rVKogSTkAIgBTL6mrCVWeF0chw3Fffkhgj9JKptWvTAqtLTuh59yCnn?=
 =?us-ascii?Q?clC1GD68PPBRQhfWYwy5DndkP2026eiYCnMVoqgHcveDbk81fJIy/64nGp7O?=
 =?us-ascii?Q?2GYgQ69n2TX97G/Wo8gHJ5KRkOyhPNXqF1NtSC34KjtgF8zWWmgAil1yKhRL?=
 =?us-ascii?Q?o+2y1io1g7JNbSB0QyHWgiRFk6D1AHlxSW8DM09U+1+tT98eZBu11ewIM4fc?=
 =?us-ascii?Q?CsiE3FgMnLCTPARPL9xu7tGT0GGN+R/7yio2ViZ5P0GnHeLyGhge5NjuYIeC?=
 =?us-ascii?Q?211VzeGcMDnbs+/LvPQhYkC7Jsvk9O5QZKyZSIU1uTu4iQSk8XPf0adiLD9q?=
 =?us-ascii?Q?5LUWa0LmyRhOb9Rk2SLyGTo3YbQJXm8YkJId8r8AkltE6d2b10OHmkGBXmQb?=
 =?us-ascii?Q?R98mMVuczkM/i9RPlrErr3cpqVgqWiViNmp6fLD/7znGGe3uCU1v/gmhXIRW?=
 =?us-ascii?Q?CVHGplFjgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f664abd-6306-4f51-aaf9-08df09be7f4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:23:09.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITsqcX6AqUyJvN1CVW//5YxvUsjJ0SKMOSPPcaPF870X8MTVQVq4KxJXVw5okUWq9C+59AilknXDYOVsO6EXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Thu, Sep 03, 2026 at 12:38:51PM +0300, Nikolay Aleksandrov wrote:
> Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
> port group not using proper rcu helper that preserves the next pointer and
> after that immediately frees the port group without waiting for rcu grace
> period. The only rcu walker of mglist is br_multicast_list_adjacent() and
> it turns out that function has always been buggy because mglist was never
> properly converted to RCU. Fix it by converting it to rcu and moving its
> initialization after eth_addr's. Initializing p->next can use
> RCU_INIT_POINTER because we have a barrier from the hlist_add_head_rcu call
> later, besides we're initializing an unpublished structure anyway.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
> 
> Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
