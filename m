Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3F2E7372
	for <bridge@lists.linux.dev>; Sun, 16 Aug 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878140; cv=fail; b=GW3UTLk3cKh7enE6N44JGb1iopWYB/cmT8L4xeBRdIIjUEwwQ2kOXc11UkphDOcI2i+fItnrrLJWuQnsz6CX0KpD+M5hvAnXjHLSmTx9PoiC/Stnehv68winP7Un1A8jC9mSvZ14WICw/33rGBLtRooPkuvJ0C4ytfzg/NnHICc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878140; c=relaxed/simple;
	bh=uptUbX+u/WwnCstXItwYcXruy+6FSkB3RuETAVOaYog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxUsd1+CAB9L7nSl7Qu0I+HaDoErwyowt/1DqkdXwIomxq2pHyWvl/UzXZplzSFXqab/R6aZR4A2jWUyiRbVtlU6Ub2iKhSxQVWLFzJqACcWCRZgtAKMScZzD5ZBuh3WZl10k6ELIverjz2bBM9b6IAYOKQAXKowffkae6EFp2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbpE7+bv; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbpE7+bv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEpT8dvXkyNy5LFhJPknbmWBNOZkhAH17MYDep8nUFT4YFxYnUeQt36UfYO/1bh7N/NjkJI/OzJtA7UekutXGlXmaj+YeuDsHJRyI405ubGJLZBi0nRJ5OaLJQKj4DM9JapQH3ufpbhono3VW9pc5bQvZzxQUblhMN173qxH7o4nptlBuctzkC4gvmvCBz1gPTRBrvje+j2N6MxSDCzjO8LwIRZN7bQTNYwxqEmJ9fQEshsczigqGEJoe7z/e9SJBVYV/8hjSIG3p41fZVUPqK5QY+77qjhfIUKCYBKzMG7iFMbcCV0KkwcoRMov7o8bhL6U15oI04Uj/gSAlLFSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PSDWfh8NcFZBEqCz/4rR9OrgMWqmhsW0lA0y9GvXLo=;
 b=RjYpYC0LR6gy1huMKl6iCcjGKi7JB8hozKimtZ2TPa9Wtzo8wFbYtTR1I3+CNTMB75ZuxgEEVc5rPg0+1LWAEEv0kt30oBmTtR5Wg4PWN8yrwzjoKpTAN746AYVK2l6clc1ePgmQ3KYX2o1pCjuD8Nk0FlIzppFYwAu876QeE2k2GEstKq/Rx2CxMdGhzfj5cfW0EEq5jG7h0ssJsW9m6AssYsVX25Q86TT9Vp8Bxh/2PqBKRJPNw1Ksud2zWY9xoRvh9zwx9wnhcnHEWv8PBy3g1U8T6eEkfeoABsenzgRW3y41nZJWbqU8TfRMb+0O46aSxEHIj1tD2t6/3WU+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PSDWfh8NcFZBEqCz/4rR9OrgMWqmhsW0lA0y9GvXLo=;
 b=LbpE7+bvWt2AiGX93kHxtz16pOufAeTluA1MWRMuwT98VfLXxnnLpKMq5bD7Ml740m6/OM0Sc52/vAyDYjQo8TTUE8BrsP8VmtURjB5rR59QSEgFrke25DeOp38cSg5Do6W11fGt5X4qAI82SwcVljNXd5gKnpw7C/iY7rBOLapIRIQ1/sv0SCb/GIcbBwNt8vc+OYF4+/QFfBBnGRVwCWK+VSjEedhs3KqkTuCIdbI0POWccbir0c8lbOxaSPET/eQdA+xBcV9mD8LUTq8RByqR7lmgqxIe32Rh9HP4YEhGq+5ehhXsoqvMsBxR1cRFN6yrxk+fz9VBTOR5w9GS2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 11:02:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 11:02:14 +0000
Date: Sun, 16 Aug 2026 14:02:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: vlan: fix inverted default vlan
 notification
Message-ID: <20260816110205.GA17866@shredder>
References: <20260814141640.64958-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814141640.64958-1-razor@blackwall.org>
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: c9461b69-5d1b-48bc-7ce7-08defb85d428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j9hFdy/WG6gLdpw9OwU4GMdMiCo0I77Tq86XrFZGnsbVVxmUaLsIQC2/bygqzPoTAWzC1PGpF8quo2lg8kTGTIp5c9rUPlrtGyrVqFr8DCXPFIMghoQMEp7FTK1ZmWiSCJBRpWP30t/w/qv2bZ0bqhJLMlOrSYMSGGtW95vD427eFUjBlONI7qNmOjmJzFFZ4o+Wl+lSg+4fWfS1oDuOM7kZaoSG8avjDWgz5F0IdJs/CPeNTfSec68kOqud9nXtpETyi9zPWSY24VFgQOiW9tTPstOJi9rO/LLbnAH0W6HcoXYeISIpjJ0/7/e8Nf1snu50699T7orsIHLcSSkE9vTLMI3wu7c8fxKVLkpb6CwYTnO0vSFCGtJ+LUnrhtP/0y/bAPk+wlGXiOaLc3MXpXEq2EN1PN/IljtBy+O68fq1JiZqGftig2SZ9KaxjciXJfXndzkmUgS8VxaiKTgEIF3r1p5mHx8OYwFb7UTqCkCc2h/HBj3WxmOf+VLav6lSRqe2nZGALx+YQZvDKeS8pVqwcaiCU63BNyiDzrg1u/EoYtqjNOWHLMG8OifY2ulyw7tObJhYq5lh80mbUhLQl8nyUBI+1dBMx4lr8ADkjQkShCCyU8ut3JdK0Ud6kaBaFHuhxY6ZhzYAD7BWzdvH2rbKernoXmrzUJMwT2h9nF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+4iqDr/ILGWJcalFyfKObk5bt5wtiItwKBWF8csu8juOA3LP9bwyqYkjSL4?=
 =?us-ascii?Q?jSbodtefPknXBWLGFhqZlGkC4I/NXZ1fXgVGmhVbG7AZuPtPTnBJyCvZ/owr?=
 =?us-ascii?Q?FEFDGtNFKlKWS0kZQ/B3bp9lLC6znyhGeMD+DwdUgdBsIKqG3h72pjtOWW9T?=
 =?us-ascii?Q?wR7l2+Q5vrkyuyHvCaFDv2i1h9TdLWaO90GD30VB9XzJyAUz3jWGs/paE2Oy?=
 =?us-ascii?Q?ZCm/8kUa8EiKuEX5eFjJTOXEjO3bG5TO4ybYTFJq2GEcNGUiwC5vlAenXKGD?=
 =?us-ascii?Q?sQlIuJcjY0zvtE8nNDU56YC0fMu/8A9uLVq3LRuqjvfvUSOTYzv6VUNWSSlw?=
 =?us-ascii?Q?4rV8xfXD4QwbVS02Pr8OxY5ZHjG6fkWDQm/mKOpRHgomvoXnBKt+B1rATF0r?=
 =?us-ascii?Q?zJ9Imoa9gUojJmS81xjDOuU4I9uvAUG6SHzKwtbhAiJITADvIVy4spuj2L16?=
 =?us-ascii?Q?WnESwrCbypHidQmogqMOi8KZHQnQ6mlQdpLimYcuLkEd15fEGqS/ImonR4e6?=
 =?us-ascii?Q?OF/S0ZOwpaa38NRC54a4Q+ybE2MdR6JuEnW+d2Nxyt0VxF8rAA5d5m29x8xG?=
 =?us-ascii?Q?sd2OHx5AOy76syuOuNtEENi0JnjHs6z8Azk0R2mnY+rPaopusxDDTeWAX8UA?=
 =?us-ascii?Q?YBukxgHFeOzPYniwYXotG3gdLEby9J9FzUR4zTOEJ2BLERHJX51avm6em4+z?=
 =?us-ascii?Q?UmRbhK+meI3SSRkmDrmxmPhoHyVCwGGHlhExDB2V0LoB/IQkdmK+0x6rpDr4?=
 =?us-ascii?Q?vkSHnO6vbyyapRax1k7UkVC6b6EQ8CN7aLnmGQZylxTAPxHZWWNm5zSpul2m?=
 =?us-ascii?Q?C/XbqrNWBbarJqPFhc2kpIa82sZQeA6pu2If3JxJVO8kGyAdHqGmo3cx3zfF?=
 =?us-ascii?Q?EkxKX2TFwD/HXWs/iwyqrL2cisiHVVCinB29VXyyaYZhEQE5jJ1w03ZRK0io?=
 =?us-ascii?Q?Vtmkg1bjHWqvqbpiIGkab3nREC4r2VsO0wZPSmm0CkP77YCqPghJGryGctzy?=
 =?us-ascii?Q?bLq9uiYQUH9Tikc/6Ud4/Hrp7UrNv9OS4Rf2x7MJKmWUT8v92S9UC5EiaYqS?=
 =?us-ascii?Q?IyEIKetz3AlvWZT8Tx4l+1ceIlr8J+dBpshbUmpbxE/VUSUsVoPgZROewLQz?=
 =?us-ascii?Q?8jCw/an5xx4zfSkkuM9szy97/DL89+CezDkwvrURuuti7HunKQmmEyC7RoDw?=
 =?us-ascii?Q?7/+icEwraistc6yD2hJMShPimi3x/KFbWZmkiRGGUiljL5k0SFbCQsO1DCv8?=
 =?us-ascii?Q?J/Wu+dAvJnDJsz9KtmcWSjUksIK6tcQ+feVnSCj2mV/rsh9WiHdotuGn0yWX?=
 =?us-ascii?Q?LD1GZkj+jbUTJm7Z84Aq6lKgvdSu/MYoEbeg7yDDrF8VpaytDPOq90rvuNbo?=
 =?us-ascii?Q?E8Fr0vgdLzamcWyywptilR0YllBXkn09E/Q/47laOoipTPEyUlZyjBMyk6pb?=
 =?us-ascii?Q?YPiWa2QMAvuYjH1/toTMpQVsB5Fig+iUtd15MQDAmL2JBVFnz+BvhLh4xi6A?=
 =?us-ascii?Q?+WlC6TYb3qEaFO+J3DnQq4shPEqGdJa3dQIYEC2ANTrmHJ4Q8NOPXfTPNh6o?=
 =?us-ascii?Q?2ywyDAwzeCPKjRd4xEmgAUSpKXAlqTxVimdiPhKX1SBnE49rW5G3HXkMyeQS?=
 =?us-ascii?Q?nlYlFT55hN+pabwK/p0wpP5TFxEFhs1aLf1Ai6WqbKAqDRxlMyZ6f78QQFw3?=
 =?us-ascii?Q?mFrxCYZpEhwZQb7GVtnd9JaU2TCscGZcRYTCqzlqCbr4N4bH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9461b69-5d1b-48bc-7ce7-08defb85d428
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 11:02:14.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvsyJHOTzsofnpQmZcqTWG3IKLoKDzXtsocVt23v/S0MULwAEt2KlVep1vTN+6LG+Ei3xuvP2TMXFdI7w7RuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

On Fri, Aug 14, 2026 at 05:16:40PM +0300, Nikolay Aleksandrov wrote:
> A notification should be emitted only when the vlan delete was successful
> and not otherwise. The proper check is if br/nbp_vlan_delete returned 0.
> 
> Fixes: f545923b4a6b ("net: bridge: vlan: notify on vlan add/delete/change flags")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
