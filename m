Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377D2FE057
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366564; cv=fail; b=XrRTsT5XfTmHv0xHDGPyNPAjksKQY9z+3mmiPQgkA2swgvyyWZ8ylWIKgUa2mWMyGWmfRWg4TiacGhMxlAlCX7S/dvKnX/2sS0Q4sGG4Q7AiQfUPQfCepFhu33NAOeLzjHcj2m8DzEJoMdFSB9meJA9dWUgnU54LDac/+ImqS90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366564; c=relaxed/simple;
	bh=rA+PyGV/ZKVhguAFA3pQVGSvG31cZGpCstejK1ePCqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MHgycdBecvSO5dWuWK1oR5PcZAPR+TT6Iitmy+SMnHZeHZWvzhEpwGXUJXz8BkrG2vQXmLFPtbdxj3I0HynsxEzm/kMkQ8RmMdoSoRmg8vUgC3RcoJaE7dySBl1hzOfpRK3Gf6B5+LJZf4z94BUdOOhVTaqcIL/4iNaX0LLdgG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/cIIPgJ; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/cIIPgJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4L++5RU9iOXKR4MpxJL1kKQ/BhZ/IQ8eC2VzsKJEy3kKidh5WLXdCS1d7XB894sFZAn8y3qKx7pSeyBiYtw/u4taxcO8DNad3GbNIIe6/uyEjvURX63e/CvWxkrAHwz4spcZymaLvNCBx3bIrPwdMDHV+OFczDtIY0WFYawes1Tkdx4fwuGJSUx3TkmocZWBm9tkDcxyRYHd05tesAyJLSWtR/73//qRTrP+1nvHqlqzgit/l5bZU/31yyRcb438LtiwOZzWSzgVEpbu85DtU2FyyCoVsTOFqqOZ4JAVoIeHEsogV4TbnIl2UrZWGksbfv6Wuuwqmkq1DUxgQBgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e43Bjdlsr2iSmKqzJi0ByvqzpzO3OPvcLouQ9LNrgXc=;
 b=k+xgSL1YNeFEuJuDQbq8oWbYbnY2cZxuMnZvOOyinISRjwsbqX7TGfJaiklahRGZp/NlVqVO2pz93y8UXB47qPgGEs4Cq7s56sZju59yX7gAdep+YiiLlTNdv0O/znaiVylF9EP8EbH3agjxGAa7lkoYbGqGVfDcj90OTQANbMJcth9wSmbsiiqcA2M4epUW7Jw1roJs2m8VK0Rf61RahKlIVjsGmebYsV9c3qehIsAQ0xoI+nywK49tU2Y50EltI7bi+I4yr2gpp1FNyLz7aoSmWesiivbcG6BlrpJF/t+qmG2q1q3uaTqHW7wcz8rjBRPE2AjYT41AriHoRPK2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e43Bjdlsr2iSmKqzJi0ByvqzpzO3OPvcLouQ9LNrgXc=;
 b=B/cIIPgJCYvFpDtMFyAqChlAPhW7gl4CfHvFZ36s34w76gG/eBYuDpslKP39/pP/8OP9LiqYIa+46ctWcX4fhQE3rrP82y5NIGfaiOq2PrnhBgnrIvUQh0eHA4o6LtLbz23gFG1L3LNAImPVN9GvnVjNOdwbLpxO4+XMZnlrrNgvFdXcpB3ZmDk9S68tJjAsqZKvUnrTMM6HqE4/Hx03+iZCK7lQZKNkmxYtgH2ys3w3tEaO1kc0A6n1mIBV+JnaBGLePjyDuSCot9Riis+CbMlULx2+nFKBF9G0Wmn6gFSVlnXgYwO7tox5Q87wAZfPkG/UUZlW+L5oRKzUZ7PVAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 06:15:59 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:15:59 +0000
Date: Mon, 14 Sep 2026 09:15:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	tobias@waldekranz.com, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Message-ID: <20260914061548.GA132848@shredder>
References: <20260911105021.1385934-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911105021.1385934-1-razor@blackwall.org>
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 147786ed-f9c4-4f40-a159-08df1227a4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kK/GKluN5DcKSZMJJep3QVV9U2UO/T99WvE56syB28hOBh4RWO21EUMIFsj+Dg0uuhfSdUVg5+y8KJgxjKA9TyQ4V++kD2sJocnpH1IvrZX5LqT+pqtbTCgB2G7gw3qZ2gK5hSSHOrEJbpPK5a5DocpO69c0zVg19OcEgZQMCuwjS/RJ+E3BhdytWF63ouOa682/8gdjFrZdPTJzn8fNmZkfpqPkVHRN7HIX0BLe+3TXIPNlL2m2YHvJIQeG623UF83p7SMlfdKjFBj5wlbCKf4BC+CEJn8atikeUDpyheugIJSOvHiyY6McN1Kf5WWgFyKpHeyrPqbIBFuXarYxoP7kV/Qf9mMfo3+bPKG0Mk8GSjzHTVpFO2ujotaHYEgy5JC40uog4wlQRcIvfxe8dqsGTvGydgwGdVNwAjiBiPrW+sAMnMNQ2HyUiLZtnxA6er7vCWcABNvpa0itpme8GavTQglegI6GSOlpLjBIQPMW7e6svnZhyKklbTxKIHDmpNR3Nm8i4hyQapl6jOeGlJZT7G7JFummvHIagpLWMtUHDh6ZpfcGnld2wFYlXn6X92v9napVMhycGDV/Q4bUXWJU8XQFHfuacDYfJF0IxRTpTNWa/dVkDmWvlWteJOWMzDUwqZ/aEY3hkApuGkwC2ZlAXT6XIGcuoNKFvQYY1p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8MCFzd51no/52FyQtOZlq1MAfKB9fkzmgUAb7HWcyIHUJW90SGp1/weaKejx?=
 =?us-ascii?Q?3KJbclBOQpfltNquvvd/0/VxvKD3qxOxvED6rDA8uxr/swNqRocHGaBcbJaD?=
 =?us-ascii?Q?4ssZ3TYyxxjdngTOCBza6mLShJaLzDwXOtVml1rDlpdKQzeR5qzPlGsTwyCA?=
 =?us-ascii?Q?ffZkRkUDeeln5v+8rjA4Ho2WON44ejJ2RQb7GuAN4ASK0oXaDkRGHYraJ89g?=
 =?us-ascii?Q?jgD/M3vrya9l4rFMKhBqn2A+4vQngOWnLjtU4KUrX/sCA1RufhSiiKV0NaKO?=
 =?us-ascii?Q?LaSkoLy3GY49ULODg0mmz1fpD0ydm56QZswPqDK2bpaUTHk/k+O7UxMC4cIY?=
 =?us-ascii?Q?22RLiJCXKU67FrEGe+jqWK9777pYdHDoUpIKiqkq2/D/v4A57WO+iWY7ILQX?=
 =?us-ascii?Q?RJDkWnLNHvxtFUuJ5Lhgsfc85NLkO5Fe5HNrRkDG/tfPz8L5fsKfI04CCGM9?=
 =?us-ascii?Q?yaceynpV0o+U4YdWzdcGR997YpWPX7nwszM+uRqhllg/qV+MZb3whnzp3ONv?=
 =?us-ascii?Q?vyEV7c5riQktA5gyXiOuwgSjJJoHDsfDXa/8Lc1k88QQiJ+0kMV/DdHzxLbg?=
 =?us-ascii?Q?J9OlVrFJF2siL0Bt3d/O0u96BSZemX3seDyNQw5/2dYCKQNBhJMnt++vqxM3?=
 =?us-ascii?Q?3KxriurovSn0ERLGLEoEa0pJqyV9GvwEA0M1JBSWEe744+1CdW6V45xwb4B7?=
 =?us-ascii?Q?agQk4cM65K4PX/PpIfTjRMr3WNE6KdHU/dwIR8ER8zYNo2bQM7NVFJi6SsmC?=
 =?us-ascii?Q?g+eDMdhSx29Mj3B66V78QSyVrHCS/Yo8N06rb4fN3zNJOhJNGFfiLo0oJJum?=
 =?us-ascii?Q?5ZibrrPx9KJTxezJ+MCBmOmPNv6HKq0MxLXd/oQnBbivhThwsD8nQvJzV8d5?=
 =?us-ascii?Q?bEDO5iSvncHer3gfjS4Er576EskYJWnLnk8I69/es1/A/OFC2RSniROuUMvn?=
 =?us-ascii?Q?FW2ktWPBQpFtWz+RSctyuPVfDyqUqxRmCh9QcxAHhUWHczQ3c3DrHNhmfmeA?=
 =?us-ascii?Q?cuIFAbocB+R4N0r8edBZi6K7Va9DzUcyzcnaCjvru2Dbw5pmspmUGTWm1wtb?=
 =?us-ascii?Q?LD/1yiFHitCRli9yTgu9lrbax8F7URjX5/tskxnqc062cBMqLSooNuc7ByL1?=
 =?us-ascii?Q?u5fn44wcjZExXZmUMnjac6QD1QijsU3RpKagFHwfR19MHiB03p/dNSQF53le?=
 =?us-ascii?Q?+NM/J6MELqrsIdQjx/OabuU/P2jn1S9lU8TekNWuEZtsK5NhigGfHtyv5zNW?=
 =?us-ascii?Q?KjfO3Hedz8dBEFpfzNTvC0Z9hUH+rpjwp4W33mVX263mU2S3OoBQjgkaNRee?=
 =?us-ascii?Q?ydm74tcCPmCsN813mo6o0b3Jf1swUlM417jIl8dq3ZhGQiBU80Z/lUdGd88G?=
 =?us-ascii?Q?1/WiscdyV8YR2d03bzwTaq1Be4Cdm9fCECB+WNeHTQd7hLQOoYEmEbIE3GsB?=
 =?us-ascii?Q?YcsQ6yFn2E6Zgfdy19fWsPZnw4o28a1Mg+u64cdkAArGtizhloPLv92rzpRL?=
 =?us-ascii?Q?vEaCxR87jQk7fLpRMfdVIS1eU6naoS4QFlikNnRhpEibm+x07hSI4LIKIlwQ?=
 =?us-ascii?Q?CHU/LpULNPwVe55OQEoXuofZTulZbdrdjS3JsbLafABMBiWbfZC2CJfKRsus?=
 =?us-ascii?Q?fS+MntDs/LLs+dmomgXpyyNclP2BirLc585da0x1zcVN7rImzjuEuaBG9err?=
 =?us-ascii?Q?FHv6b/jxzGBMlj8ZJnbv8co8nDZSVDvxzf6Ioks8zhl3u7p4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147786ed-f9c4-4f40-a159-08df1227a4d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:15:59.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnaKCAqGfeoQuL+F4NOF0r2vCJKrwn4+6U5+2xwmd3gmEVhlPp6TM7b9rCuZFIAPB1VhlyuLJlKsvgq+Pfr3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

On Fri, Sep 11, 2026 at 01:50:21PM +0300, Nikolay Aleksandrov wrote:
> This is a follow-up of one of sashiko's pre-existing bug reports.
> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
> while holding rcu_read_lock() which invokes the blocking switchdev
> notifier chain and may sleep. Nonzero MSTI changes come from netlink
> with rtnl held. Move the switchdev call before entering the rcu section and
> assert that rtnl is held.
> 
> The call cannot be deferred because netlink needs its error and extack.
> Also DSA reads the old bridge MST state during the callback and checks it.
> A deferred callback will be late and will see the updated state.
> 
> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")

Nit: blaming 3a7c1661ae13 ("net: bridge: mst: fix vlan use-after-free")
would be more accurate, but in practice it doesn't matter since this
commit blamed ec7328b59176 that is present in the same release as
7ae9147f4312.

> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
