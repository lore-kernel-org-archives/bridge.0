Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549044734C7
	for <bridge@lists.linux.dev>; Fri, 16 Oct 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145732; cv=fail; b=J+8SvJ0EiSvMaJVqtuEHoz3UjIvRKKf7ScqLxGFiFPPENHLAQU2jHtEoB/+JF3qVs5X/aQaH0cJpxbUnGKXYdkp/Y8WMOaRn5xzkT+pq3SNn7MLBOx4KhhcCTDhBp9JH5QQvYn2P+ReJi0yFi8H/LNNayIksYjTUFtZKvWlKu0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145732; c=relaxed/simple;
	bh=9+bdzGU7egt48JnfWvc2MpWr6fuzxpWwbkbRd7Gdkjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsKlDREE9ibzFIO3b2qyF2UCbUbuZpJqpS3FkMahvIR10J3vWVID6TbBnDSnsDiOfYYPceHexOCyRJJV+JxEemDJbRd2JG6SHCqhYlFXeOneXzBgAz6cRTLTZGHo28D9S73OWFPN3HLikGA//kgz9s23IxsooagpPXja4rq5GLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cANCJ3ad; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cANCJ3ad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2wwzyKZyHZv9ESAdfS9EZVld3KXa88vKAjpd6t7YKjozFSJfv2BSYTLna9sqMzp6xbC6Ek0zipqEFhG+3o044GdpOcmX+HlWG5w/yKnwq9KfIJzssP0NMKKZJiMaO3lVb5p2zAls8l7qrDpG25pTTUwHAdJioDFAqw2gLOB/Eqlgnicj20Sv6B3NPOM2eRN0wIVElNAq5AhVZ0XoSpVxoOQ6RxsJs3LemjAvrEXo0hn6fJYhAMiX9FdHfH6P0pZCkv0KvS7H77eBOcIpYElTfETTdVyZBYIamZSsvhLG8ZA8R0Ea3MdVSdTBjS3J+bX/i0FY7RpGEGd67u1pHC64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSXP3196zy1H10CYCT75ldHKeC1sG3nJdxiM3xcPzC4=;
 b=EO76hebm2W6BTInX+oO9HzjKTShry8+yI5ZZu1FikJ8KBbj4/8ryHi2KXQlFP8QxDsydy+QIviDWgoQpDUQBND9OFGIPw+fYQ+A8LtrtlMsAO+LT8pCQcIsy4yyAF2WZhubBSjSPbNCdH5bYLS1xnG1M6JRzSXzkS+z/oT7HvScuiKY6ahcz8XECe1aj+P57sis9/KXlztAeHZx63rjedpmw64u+1+hfYcmD7mgfEDHmgbta6aAGBKtd7aKxGQAcEY5t1UCR4+iF9Xb057NnpkysY6yDk87Q04B64SOiKf6ybrr35nOotyVlWZpgcCt3AUMlBsF4tQN2VnUGKXqx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSXP3196zy1H10CYCT75ldHKeC1sG3nJdxiM3xcPzC4=;
 b=cANCJ3addiPY2WMxKccRJDubrdS89eOF9zeo9OpfOuqr7dvih3HUOV5Fxo/pxETjcU64yyR3yDItRD4/YiQQY52QmCjsIOPfljHC2cak9q8ZdDO/FA4jyntcbXgf8gZOurJFB69CdMJBZ73rsEtrQ3WhFuXf2fiTupRpbOoPiKvC8EsrdOmVrwYcImLWluRY6ppQJ0mIxWMPKEJR6LxA2Jy0CBa7fT+A0Xi7WOl5LFuWLiL+4R5zPheSyW0MWRkItuRFn8MamsmHzpy6SmqC9L+/8U13dLIQ974sT2uFY3OUMLHV2X5L7f0fd/cTDQMa80vhrc7gcMC3j/eGrf/Iiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 10:15:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 10:15:25 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	razor@blackwall.org,
	horms@kernel.org,
	petrm@nvidia.com,
	yunlong_ma@buaa.edu.cn,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] bridge: mcast: Delete empty MDB entry when port group creation fails
Date: Fri, 16 Oct 2026 13:14:06 +0300
Message-ID: <20261016101407.2030133-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016101407.2030133-1-idosch@nvidia.com>
References: <20261016101407.2030133-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd4cb12-0486-447d-90ed-08df2b6e64de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|22082099003|56012099006|18002099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	dl6U+ccWI7I4Vwy/LGShweD2e6Ve0KHK03ZEklQDXL2bcI/I4Avbr92YKHFNxfMjYZP9LsugB1zYG0XEOTeATapG9jPudvxhHI5QiDD+aMuQqFX17n+QPi5X2c9R6BPMzF5P0PRnCft4pZkmHWab3tKgY5A/IcQQ9bFHfJc4iNgMFBFBXlQzGjCjzyiTUHWKDLDD3EN3BgP0ojomvHpmx26AuntlWwQKVXACxCbh1hf7lH76msTR/ZoZCcDc835bv0u1MuL8KqK+H1KuYgl8K5qGTwANfX1R/kSNCUwkLJUovORRDpA+avRWSxcZJ9RT5qziMz/a0HF3OpXa/koPkZlO0Cb9IwN60yZXUraPu84GFTRRBe2u9Sv9+C1aIEpjouNrEy+yglCwYw0gFlqY9Ig8GCvmZNFAA4WcYAzlZ+RSgqdPigaEiosTNJHT6Rj9QXK1N1R0cSsrgtWiRmDUwJ/cLViNfSNKNA/n3RzZIelYwz6zZlPbVVezy66mF+ekoTCfaTWdLDLZO1tWvXcGpG9BgKkXZAel9zYHezv4dk88Bce+0j6cX7j2ILSRBw0jbNTyEUpD0Hui0XHd3LV/mG7h0tEHvsfhf7U2cGgI+P17VML248N+yTwg4esML+tBJ/31lZi1jtCgkmXuVq/Ct0xlgDSAKZXRoIH+FD0Pz8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4KHT1FAaWsYVMwdV749ITuPdFvfZTQXdrFO5I5MNUn2Ar/sH8/Rl/qhq31Y?=
 =?us-ascii?Q?rIvqKpVLTb0saQCY5RTcOkS5OL8hXJ5uCqTww/v0Fet4pIudihysG2HNvl30?=
 =?us-ascii?Q?d+keDZ5jLpJ4YUCA4has6RH8q8wDQ4FyaprKS8GxDf/0aAQb+7fxp3/iltZ7?=
 =?us-ascii?Q?4OoG2EG1AIt4Sp+B00Rm5GgmbYJhs1f5ljoQhrSEgzR98J/Xy+pKk7ciyUyY?=
 =?us-ascii?Q?Atks6MH1FlDOCTftDLiG36yI3CQwFWlh2U84LuVZxdVSQ77AMvkHCKTmTdsD?=
 =?us-ascii?Q?IYWAzYs54far0hU23vbfa4z8RRp3+bFRTxPAgirYoKNwch7H8uQfXu80RSEm?=
 =?us-ascii?Q?zt1jYl+2qm8wnYGfH3tdTB7Dz1AIv8Y6MZjoXLRtBaxyEoNmKkEeoDkdq8RG?=
 =?us-ascii?Q?neBypu8D1Qt7y7hy3FotJlAVNEglWSl40kdhD7eXBgLf9NhHnnxq3LcBNEUV?=
 =?us-ascii?Q?B3eqlUi1vx2QjolHNUsXJ5lehZcxta2L3H06fGhd682JnZdB/MsScLqnbg+i?=
 =?us-ascii?Q?5LfitkonzKWViVKAUVaVr1cIWu1xwKpoNp4zeTNEn8GREQxeIqIsSFmrDY6J?=
 =?us-ascii?Q?nferD+QhsvAMtT0TXYMKf82luavnqBj7WRsR8mg+EHtbfIpc4TCIWajiJ0jv?=
 =?us-ascii?Q?V+UEl9Ak5zFRPb3rdQVkheRtgF9V+ICgwizZmKfSuPq8lM3ahtQMPySu8vcU?=
 =?us-ascii?Q?qGt+l3uKqIdtCEmE/xyAGmCZyPabquPunASgPRqDxQyasvDiUb9n5UGBcoUF?=
 =?us-ascii?Q?QtbnGqkXeVutYWobugM0xJ9A2TRXIRnD7jTlndlZs9eTlsWSh/A16Sxsc314?=
 =?us-ascii?Q?ftv/i47uCXv6FuQJFDAPbVqMJ3/YG7i4AQ3jelYu0daCwg1nx6VP6cCigpDe?=
 =?us-ascii?Q?Pa+rnHGeHQXJSEVgxJ4lg7V6eendGO+53Y95Xyhqo7mCG2xEhyH+oQU+iKwc?=
 =?us-ascii?Q?1Pz3ez4UZeJkEYUqytyGhvHKcZAtKbYZ65fjfkPvdK95ky2CsAPw2o37m7LB?=
 =?us-ascii?Q?ZMR9i67cTRegIoc0BgQwsLmGIgwv773OYB2Om+3CodeoYLuK2Ifhq41C8JWm?=
 =?us-ascii?Q?5bYVM6xdsH3w07hGGfOP0x+JaskG/L+qIWiWzTDLvhPnjb3E8JOPD/pK94/9?=
 =?us-ascii?Q?t50MVr7LpGjQ9FM3ItcCM3lr8U25RofVvUWo9sh4wWuSWSJ7liLZ+xcmjKLY?=
 =?us-ascii?Q?KdBH6kYhTo8CoNfVJ2ibzSZCXMnjtG6o3v0xQoiRqym9xhA0NNBQ9XpsDtX6?=
 =?us-ascii?Q?grcRielVwv+4kRodRnyS4zZYC88Htx2pt5EfBq36TnBNq8diUtqWtByx+Uy9?=
 =?us-ascii?Q?2dHqQpy6ot0sAXqFMmb3Z15IUTXTNVNia/KENEBxkgOiaoRFJcNhA8R/60pM?=
 =?us-ascii?Q?NV5K5utJ1EZdP74xrvTOsXhEaCIHfjaLuwKfOFEzBqV198k7YsQ1cP1d6r9u?=
 =?us-ascii?Q?xILKc0TfgwwaLof8MCT+xhM3OdakhdMKtI6HHSikA8/FuT12Z/UVCR7UlfI/?=
 =?us-ascii?Q?wdZMxBRGGmppIkMThjCcaURzn+0UWw9lucS82xu9IvkGvUsKo/Zkth7v3SyF?=
 =?us-ascii?Q?PwLLioj11uCBYuEjvzdPVrvyAkvN9tjTa9Ybxqksrju7aSSp89IaF8jxWU6q?=
 =?us-ascii?Q?/9mDZANv4OyNIeHV46RNwOxbmjkUwy/4aDBDLBD0wZS/krSDQH8ATKeDaS9N?=
 =?us-ascii?Q?R+XWsQYa3ppunqswzrZegmv8qM5qdeVrlzJ96jsu6nMoTu+sKKBvQZj8KIIY?=
 =?us-ascii?Q?cQgVQG6A9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd4cb12-0486-447d-90ed-08df2b6e64de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:15:24.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Goh/1E+10vKJ09dFfoMqTxCLxi1vbHzCFXJQNcbpXSQ2hUd5Z6BBVrsVa1wntAa2MrTeG+RzTUH3MPdwfu4Hug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

When a port group cannot be created for a new group, the MDB entry that
was created for it is left with no ports and is not joined by the host.
Its timer is never armed, so the entry is never deleted, but it is
counted towards mcast_hash_max. When this maximum is reached, the bridge
disables multicast snooping.

Since commit b57e8d870d52 ("net: bridge: Maintain number of MDB entries
in net_bridge_mcast_port"), port group creation also fails when the port
reached its mcast_max_groups limit. A host behind such a port can
therefore disable snooping by sending reports for new groups, which is
what the limit is meant to prevent. The RTM_NEWMDB path has the same
problem.

Fix by deleting the entry after a failure if it is unused. Delete it
immediately rather than arming its timer, so that it stops counting
towards the maximum right away.

Fixes: b57e8d870d52 ("net: bridge: Maintain number of MDB entries in net_bridge_mcast_port")
Reported-by: Yunlong Ma <yunlong_ma@buaa.edu.cn>
Closes: https://lore.kernel.org/netdev/2f5b61e2.1e71a.1a11fcb3809.Coremail.yunlong_ma@buaa.edu.cn/
Assisted-by: LLM
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c       | 16 +++++++++++++---
 net/bridge/br_multicast.c |  9 +++++++++
 net/bridge/br_private.h   |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index a01bd280c722..0adcd1524ab2 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -819,6 +819,7 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 	struct br_mdb_config sg_cfg;
 	struct br_ip sg_ip;
 	u8 flags = 0;
+	int err;
 
 	sg_ip = cfg->group;
 	sg_ip.src = src_ip->src;
@@ -842,7 +843,11 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 	sg_cfg.filter_mode = MCAST_INCLUDE;
 	sg_cfg.rt_protocol = cfg->rt_protocol;
 	sg_cfg.nlflags = cfg->nlflags;
-	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
+	err = br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
+	if (err)
+		br_multicast_del_group(sgmp);
+
+	return err;
 }
 
 static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
@@ -1047,6 +1052,7 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 	struct net_bridge_mcast *brmctx;
 	struct br_ip group = cfg->group;
 	unsigned char flags = 0;
+	int err;
 
 	brmctx = __br_mdb_choose_context(br, entry, extack);
 	if (!brmctx)
@@ -1073,9 +1079,13 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 		flags |= MDB_PG_FLAGS_PERMANENT;
 
 	if (br_multicast_is_star_g(&group))
-		return br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
+		err = br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
 	else
-		return br_mdb_add_group_sg(cfg, mp, brmctx, flags, extack);
+		err = br_mdb_add_group_sg(cfg, mp, brmctx, flags, extack);
+	if (err)
+		br_multicast_del_group(mp);
+
+	return err;
 }
 
 static int __br_mdb_add(const struct br_mdb_config *cfg,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3fbad7b59769..ecc74b73a3e1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -647,6 +647,14 @@ static void br_multicast_del_mdb_entry(struct net_bridge_mdb_entry *mp)
 	queue_work(system_long_wq, &br->mcast_gc_work);
 }
 
+void br_multicast_del_group(struct net_bridge_mdb_entry *mp)
+{
+	if (mp->ports || mp->host_joined)
+		return;
+
+	br_multicast_del_mdb_entry(mp);
+}
+
 static void br_multicast_group_expired(struct timer_list *t)
 {
 	struct net_bridge_mdb_entry *mp = timer_container_of(mp, t, timer);
@@ -1554,6 +1562,7 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 	p = br_multicast_new_port_group(pmctx->port, group, *pp, 0, src,
 					filter_mode, RTPROT_KERNEL, NULL);
 	if (unlikely(!p)) {
+		br_multicast_del_group(mp);
 		p = ERR_PTR(-ENOMEM);
 		goto out;
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b01997ea9508..ff746f036f54 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -998,6 +998,7 @@ struct net_bridge_mdb_entry *
 br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
 br_multicast_new_group(struct net_bridge *br, struct br_ip *group);
+void br_multicast_del_group(struct net_bridge_mdb_entry *mp);
 struct net_bridge_port_group *
 br_multicast_new_port_group(struct net_bridge_port *port,
 			    const struct br_ip *group,
-- 
2.56.0

