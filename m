Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0093AA19B
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372514; cv=fail; b=uBD/OyLeGoBPkB1uClhoa61KV47lNVnxQIkLfFvBvFD2d6xgmiLAlnsnLh3WXWJR4Q2kMxXOFuqZfCOekugiQ+r/PYNCzRbk7qoV+1jK/yL3aj1NpZSaDXZs4flDJhQcjdzJTGp+TNMioBiivBbQ6YPVK+nxUdzz2SPL5C+67dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372514; c=relaxed/simple;
	bh=BoiGcLtkwDwh3mUB6kNMnSOA1CpcQ6AGos2wHQ1AiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q/1fBx9XyH+hyimPhFMUOdBstROvE6ypAckMKThWjFDys4axT9cDccVxAdFNMRcmeolwdpvKJav2C10ridkfENvOEHy/9UeOKR/qidFZ0qhyT7BC9jNaZsUmMUYBOPiElIR+GsvP+L4EA0CajN4vKHIDR3VDS9FHJ8iJ7SNv/B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i1z0q7pz; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i1z0q7pz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5DRN8oBfHqyQuc8h8q5WNd/WSzXtPhvtWsH6QAkAncb2qiJFslJBeol+3PP4JRaCKLac8MKBCJoWpUaBgo2gmss4NzApm8ulWktG126rNkSIZuo07DZBGTbdVgQLmKCXQb8crkGWSME4cEuyTVixAj0vDW9+UQdopD6wmWZJmxIujWiHvR+K0Ec17JogZx/LeOYorxpAS1ykNfb5U4/WKqeRz+ixwnHSzctrArNRxXOrXV/q7MLfPDrUaCkho603AT0N+i+rB9trjaEVQIjhwwHV+cYQ514iSCqpPcbKq0y2RVU/Hl7YBfmCsb0EjLm0sb/bauSqvYk+wnXfDUbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXiTM60YxOfIzBuuKVpxH0ncO2WSnpyRIIKDQ17lHb8=;
 b=Qcacx+1jGJkoTSqkfAEn1j1KPuI+NySf+2P4vVOeIsp8ThjFmurPAgeCJt2TwXH0EA1uxqoik3Vjp4lcn71R9lh3osjEwjkfcL5J8SI6EL/Kwg2cdsaHSu8N7TdLeQsh2A4Q1eg0nn8ODEc+1U659yK8ttg8IzNNgZr76FMXUrBwIRyVRLcKSWgf+3tOZyhG2pSxJU+de79dKYL/e3PIJowk4yrvuAZOOIFn/P1vvgJkBsJ2MAIZeTIkMP/Tw3y/OnMrHPN8+pWfWZTAoGBGJaxo7PB7HyRmCPHejhetZT0jCAN2AGw5ZVy6gRZmiAlC1QC01kckr8cODqKdloDJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXiTM60YxOfIzBuuKVpxH0ncO2WSnpyRIIKDQ17lHb8=;
 b=i1z0q7pzUxRVPXRhVfJoypFzKJx+Z3oPidDajedj3pVE4H3fkNZrcKGZvhsP2ovF+n33125ywE2+p5qOMbmup4UPhazW6p6OmB2s4XjeIlagvun9hlu3AOR+XBj0RhlEXtxGq7DnG893E3xAOxvWcbzR1ZfgnGh5iPWy/z+2/uo2YoTOzQhm0op+aj6BCbKh/p9PDYcoudGnDDzXpZH/+QQVPmu41RSPuTjo0aLvWvk3WEoJlwRYfok7CyOQYRKYqPA2heGKaqtoKA5FgCkHl+C16cqqFeL/G8yQG1D5ssHjfLSvou5whLNSU8qHlv6rrNSO2AbUvcSfoIfUY7DBpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 07:55:09 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:55:09 +0000
Date: Mon, 14 Sep 2026 10:54:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	petrm@mellanox.com, vladimir.oltean@nxp.com, bridge@lists.linux.dev
Subject: Re: [PATCH net 1/2] net: bridge: vlan: fix leaks on switchdev
 deletion errors
Message-ID: <20260914075459.GA179479@shredder>
References: <20260911100645.1360386-1-razor@blackwall.org>
 <20260911100645.1360386-2-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911100645.1360386-2-razor@blackwall.org>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: e84ddf59-2fe5-46b4-a638-08df12357f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1+X99nuSh+isj4/VVL1uJi7O2MgqB/intlFBj304jRX2ZtYJ5HC35CyNmJviwArDiXlVEBYXJiKoicCFjzvVAfhAm7LUlEO5UGhkk4QBKXW9+YjEkJLHFuyiCXVuFt061wQNM1bxMDH97FfgMs+yIWe+GMp4Edjz39CWTnrEckTPwcO9aNo8AYMLs19MWsIXMSMAwgoIrRkx0mNHDL6Q9ms588RLJrST8dbrQ0rbOYIqqqzhkHLYei5mS17EZTkZL5LubBUC4uDBOI3zK31aJLn356uRh5cFFiheDgGm51r/mEqndxMf4AGrpHSkSKFR/TJQhPXN5pKAniZJHyxgNlDpOsnqx1Xgufdio0rX1HHTZetENrFzOLWNw+LIZaqKujj7uphOXwy6M0DFnTLXyiLBOx7j+Tz//7MA1ktlCmbnCihlTYiYoJ5n2gjTE/6P38OOcnwnPpIIiGbk95QOQrv+ofFAlM+XGg23WxjVmh9K56KaB608KeGD7BWujQhBCW3HvijU+cSMxOhCg3vgBL7d+Fmz71k575Xux362ipD9+4oBfcPpIbdILI1BFGAMR6/484Ho3Krd6Ry5SP3ScFvO95sPy1HgPdzGBfE6jc2LkXNPJaGcjdD4dYQElvygpFkpzndLlbTVBAK2dt0ZrLkhCIFI4gbcR+VQIoxcVik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/7FrBO0De4Gului8fOcsZ1uoKuuFtcZ7cCME0xyd/kVTqfqZk6jHJfMYr+d?=
 =?us-ascii?Q?/PuQZ1+aJsNXG0YAPXYzNkXmDJKvAr3W1YkuHyEuc5xHsor5ufS0snzbILdr?=
 =?us-ascii?Q?L7pUgWOPTa+LIEWRKxGNPzlcFTSaFJlEjI4SkPn3tskYk24hucWfBI+PtI4U?=
 =?us-ascii?Q?zHo/1ZUIkPffOavDMTFf3lScAHGpApDucVixOhTC/zdYYjwuRQzfy3H1WgrN?=
 =?us-ascii?Q?ucHcl71IYnMM0son5cUN/hOoBpk5xPCkny5PfNB7NkogWitfgfi2zmgoYA5A?=
 =?us-ascii?Q?1bzUnKGhIpHu0McKMf1z/hibF+InvJuEYVSOVJmcfLHUqggaHwmXYa5yosuU?=
 =?us-ascii?Q?EXnjfjWmUKTEbMfYGA9rx46+fyNNcD1aBJ/Jc/EqxeefCLNFc433DU3Lpq4U?=
 =?us-ascii?Q?FgBPgTNCoYM+UPcZD1t6+dmR7QTPl1UhevJh95ml457lNA2geZV6Wt2AuQAv?=
 =?us-ascii?Q?iBRYbK/rCt41t7njt4x5jCNDs4vNfeQhtUg4xS4jZRQEchpuTIiHzqAj8Qu0?=
 =?us-ascii?Q?xNmg9MRzqquOpbi0ipwb/1oDqPcwuRk8Lw8ewrGUmd1F7OMJucTUxEUUV9Bx?=
 =?us-ascii?Q?40EkqhlwSkzQ4KqRAKv7QTIbFuBUO5mPNqfN9yTWiiY26ZAOf48lpx0vBezS?=
 =?us-ascii?Q?bj80kda0zynLuVZ+Njbh24CcKhGSrWFZMJcJqLlv9gc/08Q3S+JGtbLRdcvA?=
 =?us-ascii?Q?QAZ2ZCRQQCZ5jZaa85oaXrty7IrfBQwpR0gIQVBOqBJ9WJLEfcCD8NTtgo4I?=
 =?us-ascii?Q?g3XAl4hzO8NUJUFTFKS3JXwnDIREyG1xyVbAeS4dzcdRw/a2DrVi2kd9N2eO?=
 =?us-ascii?Q?mAgOQ0MUJlHpH+9Z8jqeMklm0ZrnqpJ94MWmUGrRvHfhf1Ogx7LuU5HKcQS1?=
 =?us-ascii?Q?7dwUtPAW076j3ZUWLlZeRyY/upuuD9CvaMU5fAzBGjU5/TXEA2dixMh+Kq6K?=
 =?us-ascii?Q?KVYxZFArYROId8Zcu1Cc3FQ5jP8eEscbaqLweIIgVjDXMnD2Ub6wZZJlvaBm?=
 =?us-ascii?Q?+IZDsxboE7V01ObLLYAOjmvMJBisQCcjrJLzrDvYCp2Eb0Aty1KMCpE/8nv1?=
 =?us-ascii?Q?HrmHmuXdaypYZL/mIL6n24BCXJ+DLk0gstxg7233ycJBZw2aAS8IUZRcwU5b?=
 =?us-ascii?Q?GuUfh7KK4il49QTlc3bhcHp0MTnNDIIirNGz+KpSJ79fSbMm0oT+xvxKjmdt?=
 =?us-ascii?Q?PYSqDEHUZhysJPJ2E9euu6dZ2tq5pGZqg4BEoQ7ZJuodkXYSY7ADxmbS+0M/?=
 =?us-ascii?Q?EZ8YP3S3aUl0seYnpqK28M4hWM3mjB9dxKQbY5ZvoPC9YhV7xh1kwNHGMtVZ?=
 =?us-ascii?Q?N2opGz21nyNzq4N/CDftTB2eNzfJu6x57KUpwwEqQ+ZoYaww+zmA86Q2bVjS?=
 =?us-ascii?Q?cSUGcjntG40aMiUWwGFSo2th9EfHp9EOteKOg8/7r69IYiTSorODbLXl1jsJ?=
 =?us-ascii?Q?mhPXx6sOhWzamI8iGVajr1LOPcLgbKNuBEnAJg5H2/xXoRA2Nq6ZB5ruCRfo?=
 =?us-ascii?Q?zilguPAcTZwFa06S4yS1EjKgjq8T/VEHALWEK2pw1LbQo+YiTYRSippYWmG+?=
 =?us-ascii?Q?xzZrIFTNdRXmURMdg/cdpxckEvrHd93fHk6e3geGVTSbikoWnoEHVY7cUxpc?=
 =?us-ascii?Q?AIZFZlp0JDsTTBAfS5U/qWQOpb/WS4flYhT28fLTPyPHmHL56q4JgyncIBfQ?=
 =?us-ascii?Q?yV6LjOC/mZ783BwZRh1+oEhfPV1DT7QmxOKkEQYV1uyf52Bd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ddf59-2fe5-46b4-a638-08df12357f24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:55:09.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYrYi5nN3bqlM7IOEBYVdrz06zrPm4rwd+IH4KVokWUERxZL97DFkFfbzzmd2gLewrZBl0g3oAxRdp/C0ta2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

On Fri, Sep 11, 2026 at 01:06:44PM +0300, Nikolay Aleksandrov wrote:
> __vlan_del() stops the software deletion when the switchdev operation
> fails which is ok for an explicit VLAN deletion because the VLAN remains
> configured but not ok when its VLAN group is being destroyed and everything
> is being freed. __vlan_flush() always destroys the VLAN group after walking
> it regardless of individual deletion errors, so aborting the software vlan
> delete leaks the VLAN object's memory (and potentially its master VLAN, due
> to references).
> 
> Allow teardown callers to finish the software deletion while preserving
> error for reporting. Save the VLAN id before deleting because the VLAN
> object can already be freed (queued for freeing by call_rcu).

I think we should only log an error instead of aborting the operation.

It's not really valid for a driver to refuse VLAN deletion and it's
inconsistent with the 8021q deletion path (i.e., __vlan_vid_del() ->
vlan_vid_del()) which doesn't abort the operation.

Also, by the time the switchdev deletion fails, the affected FDB entries
were already flushed and the PVID was already cleared, so the state is
inconsistent.

Something like:

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 1e0e436629ec..92b3cb621a26 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -387,12 +387,12 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 	goto out;
 }
 
-static int __vlan_del(struct net_bridge_vlan *v)
+static void __vlan_del(struct net_bridge_vlan *v)
 {
 	struct net_bridge_vlan *masterv = v;
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
-	int err = 0;
+	int err;
 
 	if (br_vlan_is_master(v)) {
 		vg = br_vlan_group(v->br);
@@ -406,12 +406,16 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
 		if (err)
-			goto out;
+			br_warn(p->br,
+				"port %u(%s) failed to delete vlan %u from switchdev: %pe\n",
+				(unsigned int)p->port_no, p->dev->name,
+				v->vid, ERR_PTR(err));
 	} else {
 		err = br_switchdev_port_vlan_del(v->br->dev, v->vid);
 		if (err && err != -EOPNOTSUPP)
-			goto out;
-		err = 0;
+			br_warn(v->br,
+				"failed to delete bridge vlan %u from switchdev: %pe\n",
+				v->vid, ERR_PTR(err));
 	}
 
 	if (br_vlan_should_use(v)) {
@@ -431,8 +435,6 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	}
 
 	br_vlan_put_master(masterv);
-out:
-	return err;
 }
 
 static void __vlan_group_free(struct net_bridge_vlan_group *vg)
@@ -449,7 +451,6 @@ static void __vlan_flush(const struct net_bridge *br,
 {
 	struct net_bridge_vlan *vlan, *tmp;
 	u16 v_start = 0, v_end = 0;
-	int err;
 
 	__vlan_delete_pvid(vg, vg->pvid);
 	list_for_each_entry_safe(vlan, tmp, &vg->vlan_list, vlist) {
@@ -463,13 +464,7 @@ static void __vlan_flush(const struct net_bridge *br,
 		}
 		v_end = vlan->vid;
 
-		err = __vlan_del(vlan);
-		if (err) {
-			br_err(br,
-			       "port %u(%s) failed to delete vlan %d: %pe\n",
-			       (unsigned int) p->port_no, p->dev->name,
-			       vlan->vid, ERR_PTR(err));
-		}
+		__vlan_del(vlan);
 	}
 
 	/* notify about the last/whole vlan range */
@@ -837,8 +832,9 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 	br_fdb_delete_by_port(br, NULL, vid, 0);
 
 	vlan_tunnel_info_del(vg, v);
+	__vlan_del(v);
 
-	return __vlan_del(v);
+	return 0;
 }
 
 void br_vlan_flush(struct net_bridge *br)
@@ -1368,8 +1364,9 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 		return -ENOENT;
 	br_fdb_find_delete_local(port->br, port, port->dev->dev_addr, vid);
 	br_fdb_delete_by_port(port->br, port, vid, 0);
+	__vlan_del(v);
 
-	return __vlan_del(v);
+	return 0;
 }
 
 void nbp_vlan_flush(struct net_bridge_port *port)


