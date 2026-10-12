Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68956481238
	for <bridge@lists.linux.dev>; Mon, 12 Oct 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808269; cv=fail; b=Z5cGJv1aM1xfGJSOnMYxe/mU/HENwKPlugIRuFfryAC34ju1zeYkEtjykpFQKTz3dVBQd7SrUBPJQlE5kZY5FjYgtaVERBRPZ+hFv6al6w7nysV56HUZnDNkxAl9CwB9aOVwAhpYBD/oXkFSie2CNgALDq9qf7HsQMtPPj1m9dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808269; c=relaxed/simple;
	bh=M6i1HbxqBFQbWZ7MpcbXJ8Rneci25Od9vNvk2+TJb3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRruhzYXbZMhGFEePGlHnJB3zMTgIqHvIqqcowLzNNHmcw1mOruV9Tm/WfpjLVgtC055qG+4YBqzNKsBUkJLmR1Y6v1h9MhOLfT66P2rcRumIyniyzY2tsNbWBGhKoBRC5oQjCzQJa1mVgklUT1ezRyezpvkdHdShkObHkItR48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaCnBNCD; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaCnBNCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9iD6MLMQCQpQOyulKsX7kK5rHqGrlKavQj5V6o/8W5cpR3f5RtoLfSxs9JdM2nVb9i5LteQm3zXifw2KlPl8SzQvxXZZ3m8eTHpo3h5zCDGsSChaHrjOG3irywogErihVCDtF+3haTaNqiuwqvfcs+9DJn9jE6XWt2D4SZw0jmiYe3U1v+TuIORYBXUGDtTlWacJDgoqjHaoarkRDVRT4xwRddVGo3f4Wn3RlFJH2+s8k8ezyKlzUbWoVndw/i/npPo5wL/pTuUaRWTUvjkXedfcLpmMSADL2HfT5cJH2KlA3qDsInetnrkj1fAn7hD5AgCOiIX7Sc+Ax3X2dGOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C8IkefF70lqB8kwZKdnTS6YIzfNryigm/9IvPA1SOg=;
 b=RxOB4NRWLz91XU+uSxXeymW9GFQaIj4pUPU4t9fQcDkrMG+p0Tir8Fvk13AZKx8F9+4XHFyB3a+xr4NuA97iCjbikNAYmBHh3xAnzK9o0p1j5OhBmc4HrbZMU/Gvb7ZHN9GS2kUq2O4qWeP9potjB9V6JskOI1N2vzQZHURIU1a+LoHCaJ+KPULZYg7OEFIk4N30u7XiyRy9fDKzh8DJrMwtTL3fFa2RF1UHz3UsjnBxWRsOK/4sO+UuhWDreTW9OVD6uNZJPrIN+oUsl9WqOEnYRQl+QHZm3zU/HKFzuwvCUMy5LMgu9o3ktUoN7WswAN8MJj5y+YhNUB/F3RDEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C8IkefF70lqB8kwZKdnTS6YIzfNryigm/9IvPA1SOg=;
 b=UaCnBNCDi5O/pftihiJRdSjQ6j0V6WumaX8mu3Sv0FNVckuL7JtGQSyX4CaXskuayd7E0uMjyvTgePvskTNG2aYKqHPSGYhSHHyM531jRdEbvBHjAejzFiNum8GFZitMREsakKFrVbdZJDQzF80iNYF3Gp+AzQ/iQYqjpuboskjNRuSxSYQXfCQsZVWIsvevsZs7OqGANN6BFzQj114yejLtjpdRKYcOwKPqJhujBy+ly4T70vtgJ4gwYsAcWOGnDGrht7FiQS/pL1ufW4T3sCxRA3LLQVFY7vIymolFJ2tDkZ/7K4qyJMuiEd2+JOtYPSM/90uKET+5D0hgfErHrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 12:31:01 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 12:31:01 +0000
Date: Mon, 12 Oct 2026 15:30:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jun Yang <juny24602@gmail.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	horatiu.vultur@microchip.com, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] net: bridge: don't re-arm the STP port timers on MRP
 driven ports
Message-ID: <20261012123051.GA714215@shredder>
References: <20261012080357.29015-1-juny24602@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012080357.29015-1-juny24602@gmail.com>
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bc64c8-fbb2-483a-2c02-08df285cacc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OjcOpfrJLQDLF0epwDBSC478DsSrEt7q9LVP+6xtVaFbcVLXAR/XcIa4clIYQc7vzHftEJhR2z3LZjrOdpIM3fyKExh9+9Wb9xSdfFALp8i1U2e+vVyFB9u9HjnsdXR2+rDC+QEDTTU48i6sI7FWipIJZ6NSBX6paYFmFwCxelhNt177A5YVXu4H5bvTTECrNzV2uG0NIy7ucfMadLwp89lMoTcBK8jFJbRTz1RUR632OAsaF7CQueUtlVZgOnd+/NFR0jHN8lxAlGERViRqK9+twZkz7IQoT3FThMPEfBhdifI9BJ2WIYw+V7aXT1ImOzIavcJVv50q1pYcGw6KSsidfLNMptXk9KREPeAd5BYpJW3i8QGy4ZdJVHgXaKgtN36y3jtZXx2wSLYpPpvGs968y5S3WnVO7yl3dBm0Wm3TxaF4sZLQ4R3s4MY7dlvCg9g4TtHtk44zr44RoMDN75DQ2UGDkd/VzAlv0XDQAMbDKL00CrpUzf1WjDRztme2lwe2BL3QQOfE10SCXqaL0aoHGUv7xoIwkZFJmWKRy8UkhHYX1eRBD4LgPEwu+lSkaGLB7YUi/jLvyBV9yLlj2jw8zY6MrcEXHGUp+ef6cQnIHt22yRtxg1SXFiSxLV6XJ3/Qg5h8b1exIwXncOiOBYiK0ugUtdyZDkppZn/hmco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6hV/NINAZ4ggbtUiZrv0xA+xhNvIGUP1WBOsxphWZ+tpHw1I837CY8mhfg2?=
 =?us-ascii?Q?56GzKHJCKlfFKokygzqYkN/mDvVMHVNSDI8yF/PfcPSXBvPUHM2TRvPhaLem?=
 =?us-ascii?Q?w8PLlTDmnWOl266YRPvPKkfOn6x2CGDT8XcIB1bzKxIvOoUvERqSFFpQLf/P?=
 =?us-ascii?Q?/YwZNSYrkJhyr/Uhdc+82TIITa5ckrdR0SYLZemqsBDZp9SC465Yo/TvWqqe?=
 =?us-ascii?Q?NMvpjQB1UCABOZ6eOiPJdR9gZuJPVLF/7YNJKdzoTu5qs+cSR1iCltul46vi?=
 =?us-ascii?Q?UAVOd3t7wcEQP+DHvyxm19enMhGsTR5HISiN8gVZl2T0i0Dkeez1JILi3CZd?=
 =?us-ascii?Q?UYRlPoYxNgyBGIYuw4BRieCHuVWflpCjruMCYywNHUkVIl5QVUVetD+QCZNX?=
 =?us-ascii?Q?PmXCLRttfCF13yyTDNCCm8Sm0awP60ndHpTd2puUAVWwoKFE4jNQ0976V6LW?=
 =?us-ascii?Q?EtPRZYi7xdAHXabyUhL3R3a+2RnksaplJwSBNrtgR6z7Twjl5g5JSlYXClMS?=
 =?us-ascii?Q?IYGSh26Mxu5m+GfXIbuhnWVZ37SbON9w2zuI5Sh3ZonaJJXV406Mktkh8ZBs?=
 =?us-ascii?Q?2y9Heu/Il4sexUWWL9jwkupHDUHZV4hJE9w7O9O1paQrzhmu57O2hAWp3Fh8?=
 =?us-ascii?Q?Gm00ELZJE1NFPozYLzN04hwEk3EpIqelmm3CGod0WP/UBInuWZJYA+3nQ0Ue?=
 =?us-ascii?Q?oVQ0wL4PIgvH2jVO1H/fOsSgWgLUg+c90HOQHSKItFr9CUwH5N0nkQUI6yU0?=
 =?us-ascii?Q?3Pueb0tZU3wJmZnran8vJNr8eavGvHpHVSNZi7Z+drQkEduLmArLilq0/ERH?=
 =?us-ascii?Q?MdtlBL9+dv1jsbQ3nqvWi/RVwy+7+q8Nni2gJYnnwE8hvXPAvrrWYU8KKLUr?=
 =?us-ascii?Q?ejQeUEv0Y/+WyKilX9Mpxn/blCbskJD/HagnYkJ0RCijwA4MH8e3DNfZmKAl?=
 =?us-ascii?Q?W4qfvkWIRZ8Tg2U6Med6XoYV6SYFqTKdUNUocgU8DzjTDQuNHjB3cSZpnIiB?=
 =?us-ascii?Q?6LSpo7tf5+WfWxVd93QHznxW2qAPCn9WrOQlrH83TO8okq4f2um/IbUIzz5F?=
 =?us-ascii?Q?3JAb4DjvAyDcw7aUtLMfhLvKl2090Kb0HSY3P/7jJaQyZ2AtF0jzqYVYtBo7?=
 =?us-ascii?Q?RN1PDBZnjxKrGg1l8n5p6rcPsgsGkpOR5wiEhQWZVIbMkM2ROK/9nxyPyTLO?=
 =?us-ascii?Q?5oo/zoUH5zGSvD5blTZOEfGZebMaV9wP4WEbtXHD/G3n748o0qBqLx5osJWv?=
 =?us-ascii?Q?eTJHciOAKeOQWtCbOI8f6vXwXmHCxOS+8EVOfdlXsD5ecwIdL4hdvGPdTovr?=
 =?us-ascii?Q?3t1j+QfUNwKVlwF57nKqJTh4McX1qp9dEAhtlvZhWVRhMaVvcpx+LiOKQbQt?=
 =?us-ascii?Q?WJR6H/6kZY4hK2qgt/bfFp/Ma3GHedy3YP8uzABHdkJN+oc+RMVevJ60MQNi?=
 =?us-ascii?Q?xqjXBMxB/ujnHhKX021qU4jCjfIaqS2SNj0H9TfXLZZ+9uj2uejd9u7bDctT?=
 =?us-ascii?Q?4JkQuK68lkPL64E1j5Xm817Q68JkyvarMQMFLOl08jN0iaxvN+K1xv2SPk4O?=
 =?us-ascii?Q?dAgM4xPd11D1Hpp9l5fDQFegbaGKQfu3uNx+p9I1UJP3jyWADC4OJY9OhU5H?=
 =?us-ascii?Q?ibC9hmT9BCNMGGunekN5guwwpJQ0uar4VgraNi4iflETcVg8PjPGpXO42Lg3?=
 =?us-ascii?Q?5eDHEUjbujGgnEtG0o5pTWrPrbb7DW+Ww4tmgDbBwtBnsVOe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bc64c8-fbb2-483a-2c02-08df285cacc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:31:01.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6K7fhvOy+P7XRNwwKtwt29Dn+vG3xNEE9cUyc065Lm8tuoumkR78VOlV1mNbjzNm4Nc3e2vJdAdOYcG9+OikQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On Mon, Oct 12, 2026 at 04:03:53PM +0800, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> br_set_state() returns without touching p->state when the port is MRP
> aware, so br_stp_disable_port() cannot move such a port to
> BR_STATE_DISABLED.

Why not fix that instead? With something like [1].

Please wait at least 24h before posting another version:

https://docs.kernel.org/next/process/maintainer-netdev.html

[1]
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..45642b6a5866 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -340,13 +340,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	nbp_delete_promisc(p);
 
+	br_mrp_port_del(br, p);
+	br_cfm_port_del(br, p);
+
 	spin_lock_bh(&br->lock);
 	br_stp_disable_port(p);
 	spin_unlock_bh(&br->lock);
 
-	br_mrp_port_del(br, p);
-	br_cfm_port_del(br, p);
-
 	br_ifinfo_notify(RTM_DELLINK, NULL, p);
 
 	list_del_rcu(&p->list);

