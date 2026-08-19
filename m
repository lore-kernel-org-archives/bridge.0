Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293793F6C4B
	for <bridge@lists.linux.dev>; Wed, 19 Aug 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128404; cv=fail; b=YIvdGXBFjF479IJ/MRxxluiCaQOmexgWlV1Tbp7AUENOSGEYqS1PhYZcFZKvzY8lJAoS2wLp+ps5A12cc8OMCqv157m6yYKr5//GcemvyhwH/ezzHk+n2Cj6cYFSfWhOdZcbpkiBliwbGNxAdeUdXCLx5VqQVhpT+wSRd3TDisI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128404; c=relaxed/simple;
	bh=a/PcnmCxgyfxR8M5LxISqtYbHWDHPcUIV+3K+uIu85s=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/CQy3+gVoCrLmdcQ7SIwWcHqGqZ5/e0zAtlVdtaYWBQ1Svhm+EF5YLgin/wm7kiIKd5MSLChIoexwiaPjweaCF8bPaZxsTm57zwg6l6T3rYkLMj2hyYIUhgLqZQ7+feZaP5cOuuVSk6IlYPctoOlJHTviRdCamej3TEW13w1o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZLvfSBH3; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZLvfSBH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9vJIuI58xATJ8JKUnQFf7I9aQQmGP9kZ8pIdfZCbgL23F/haXzs0ZX4E3M4RaamIu/CZd6Nm/0tqmcDBKM1ZQI7tCQthmFbK+a4/V0hcgtI48+0L8Xa2B2jaBnzJsp04PcihEsXlmx9BzYWY2WnEfUF7PvFHxP7Hc1UiEFREkP27ViXoS/uuABe9N6zh/Q32I57Aub3d9PvnFMuA/F7t4lRe1g/EtPMZddSpnqvhjl0Q1tF+VAkRKXfET3nPK11BmmJu3q+pP0tbRbe/qZEfj9hd3RhArRmZGQmllk9cgs5PdAWpaWu/gjurd8xIN4IZpSrDG3Jt2Vm2w6fYiIe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvernOmtZ0Z7eDrpugvveJamtk4VHEIzv1pRW2tCJw=;
 b=gguPKZNJNXJlCHPfwwrlei9VRNKg/tsdYvImagHByPR4AAc0KVrtTvq53aw6Ub4dt+ZlMzrrdxFmzkXlsiNCgxWUSI9m92AoNuXTcfwNxaB6O2zg2SRPFCwpBOfoxwHozyP2Z5p+4/XbjufWP60fW78AOsZA5kCRl7F+pyxwEK0caq/WUu+th9sl3lvzea/3xpxxrb8B32FbBVHvQWF+XYQQD6C0mNUCkyYF6BEpBRA6RTCrTYxpmHHDXHoR1TPRwf0k2HUJNrno8qJVqZqx0So5DR6T74iTFhXIrZNMbUCEFEc8dZPwfSSuJHON3dIdbpgnbmxVA/7b/WF0dbs+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlvernOmtZ0Z7eDrpugvveJamtk4VHEIzv1pRW2tCJw=;
 b=ZLvfSBH33lqTYpzrsum/nLuBVk6ztW/pkdXo4FRpXJm6RJLogbdX2XExN0v2e9iUjsp8hLhXIgQ9Q4lqnKh336/hpO1I3+LcjRfU1ugsjEnlab5n8unlmCKHcwzLJnKz5KPcXu6MYUTW//7Gw7xJsGPxVrbjH9HRUhTbYwVzAfVDDpgaEd02lWrKAJoNKRUERL/dlR12eH73Spugdlreeor0pJ4Teyze+5maaNxM8lmAXBXaPsHww8M/cDWUwoFuCwT2jC53XD60vFZMv7sBU1zd58pTlsOKl1iV3MnZmQW1wPx6xpSVl9ah6GN1ugi6NK2ER/rf4baw3jhGvaXF8A==
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Wed, 19 Aug 2026 08:33:16 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::3c) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 08:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:33:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 19 Aug
 2026 01:33:03 -0700
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Aug
 2026 01:32:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: <netdev@vger.kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <roopa@nvidia.com>, <bridge@lists.linux.dev>,
	<andrew+netdev@lunn.ch>, <dlstevens@us.ibm.com>, <amwang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vxlan: fix reading neigh ha
In-Reply-To: <20260818150756.890025-3-razor@blackwall.org> (Nikolay
	Aleksandrov's message of "Tue, 18 Aug 2026 18:07:56 +0300")
References: <20260818150756.890025-1-razor@blackwall.org>
	<20260818150756.890025-3-razor@blackwall.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Wed, 19 Aug 2026 10:32:54 +0200
Message-ID: <87o6ey7bnt.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0e67c6-e834-4d66-8a90-08defdcc8437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SmA3M11EH+mO6gOd1glkK8p5XlX/Bjt70YjGIrhlk0ZF5Rc7uVclizBmkWRP1REW5Fn4eqrqpcMeuSW1oHzXdUb6e/dkHy/QzfNBiwvVzDe3kA971rhOhi1O3CpNlaVQjJ5cET3AdH8//hsTVGVMPLI603yod3yvtt9KKVDbxLa1wgiqFnknmaqZIr8QaxNESk/p2dg6y6OMMteslQiytN6ypyk3NnoovGi4yme2qc5KRVRqW0fQFY2d6yk2bQp8BpWpGuzPPk9EAnet+q4u8+J5yo+UNtnsVZII6pCfGtSMfv3+XVcp3RH9NAnYNOUCSD4/att3lDsV4dDv/pQyi1VVGAgaXuMQWFuYbfbgsjyQhXBiDYWysWnUdtSuWI+aQdR6CbIyI6/v/OTUbXsE5M/7YwSiXb+jJc+3wGSMYtO/uyne6ZvQqXmBQx8m5jepiO6+w9NTcqgyHyzCzhTA5tbkNWK8RxWl07CzyXkRBs4ikTxqvNZc5eDgyXNo7yWSm5JWscR5sTHDQPITX9MMUvsVDhxGaUlr9a9pJFHsLHGBneQa3iQZ9/VkU5twaq8svw+mpXWqSA7/6UAdC9+ErHjQ0B+KiUujmBOKjmDHh7vOnPhkSSO+nGMtJ5egJqpsnrZ89kd76UU4D6pFI+C3aa7iR05Yu2VVmVHRQYT6BCLmd+WLbCHeDLo/9LM0EYnt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t5FBPS/WFLb1KUdQoTOO2QaOAjOZK3ZpRG5eq8bY5G9ueQdRc8xJABaB2qtx0DXNgpHY7t2/QETp6C76+4BfyENemF2tA/NSF3pW9xq0Z7VsyqZieNeDso6q8dNAnoDTJ8JFPrh9olU644qaX/w5qCUL3RSasT+FATDzEJ6xkgTFRYN2J5hXCd4K6wO7mfvtcv0I5NMOLz2IJ+neKF/YyZGaTAgHkAjJkYFtIGqGPx5Eu1Sp0umE3sxwK0seymH691lt9DH3Ax+bc7N+OP3h30ljTzQA0RLKrk2Hd5NnID3d2XGHknRqa9mSBxhziJPUylSUcifCO1S3J4+8/sxX+JKBgHYgQKaetGWtIBlhN2RNrSOupbjzziH0MZACo2dCTIT65bHy8iOPTodR60MkuuHL8jf87AcGNc3btC/RX1ec2IELxgSpnKEeFQX728yn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:33:16.5499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0e67c6-e834-4d66-8a90-08defdcc8437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

Nikolay Aleksandrov <razor@blackwall.org> writes:

> Currently arp/neigh_reduce read neigh ha directly which can lead to
> partial reads while the neigh is being updated. Use neigh_ha_snapshot to
> take a stable snapshot of the address similar to route_shortcircuit which
> already does the right thing.
>
> Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
> Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> @@ -1935,7 +1938,8 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>  
>  #if IS_ENABLED(CONFIG_IPV6)
>  static struct sk_buff *vxlan_na_create(struct sk_buff *request,
> -	struct neighbour *n, bool isrouter)
> +				       struct neighbour *n, u8 *ha,

(Likewise, I think this could be const u8 *ha.)

> +				       bool isrouter)
>  {
>  	struct net_device *dev = request->dev;
>  	struct sk_buff *reply;
