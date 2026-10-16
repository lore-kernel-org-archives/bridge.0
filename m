Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14A40DFD7
	for <bridge@lists.linux.dev>; Fri, 16 Oct 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145739; cv=fail; b=YOEd/VY52sEQjERevy+fWS9lCB/QXUtqdcCT+d0cfY8Lwry5/fR2DPmV7RsnXj3xd2X7iwo/BZoG7NAOyvrKLkSjSCJNHWIjo5PscgnI+MlqmHKHpzrjGx6POT6wxNqUvQS0t861ovecEUC/6MKNdW26K7YVPDfykq6FBIIdwwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145739; c=relaxed/simple;
	bh=nzD25eAaW7PVWgKX1V3VRxrub7sHc+y/w+SjzG1CGxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fV0nw/XnB3B8j0Gb7qywCz9d0/mzy3zlX+L9glMZTXhb+9q+va/hTqW3P7OxUwybnYQJgbR7Pk6aEQwGFSq+JiJH5dJk06CUYnJvGCt94paTf+XknYq62YL2r62fdUTRjAunzT730Ts0T1nbKpPZ0Ow6FVpJav/WQ0cunEIx5mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdPmTWk3; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdPmTWk3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8kCkujMcIQjd5qeLy8DhRbOTv8ohF00lpQoyka7Nbhk+s15Og5XU+xn+9Oq/aNgAo77Ug2e1+ldT2nvdO/R3T0a3tpBdfzwkIcV+M7Z33aSGPfGWg+Z5bzpGhOVJLO4gFIBg1EBJlsQOLFKEkfdiMNMkFehYOw4p7zdm9roKfcrIw1LlzTVxA6CQbZRsmevZKtdmbPeEtynwpgQm+1sB2p4Oyx4KBbUa9dsBIxkOfn7t5n75NW92eH9QqPvZVzU4uwSFkwzBPal7RIbRr34dis2Qi9IWPark4HeGWuzYvQHJJ8SO3JT5xsUxm1Sj0OlCMihAcrVkSNoGp8k3bRxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qjZJ+Dpvv+NMM7+Hw9ovMH2tToBNqk9/H2+WCNgf1o=;
 b=IT1qOPRUG/azZ0rpcGTm/RR9Nw2HoJWUzG9eKKWus9Rvl1z9/tZ3mNuClQUWAd5gZI6cuTtOVohMio9cWEx6ffGrz7PXvc6mHjBO4Ujp0Mu4Ex2I4P5IZdv7PvTUlFO4fBSxtKwb5HC7BsuQiYwFTMunaLd7jJsqp8qeXI8Vs3pwASDd3B7LXnEuPWCz/lcphFInY16zIubCMA99JeNJZCeREsTD3RpdqwDaF+XqbbyZ2/H59HAQdjs5r/2Y88SH3akXn3luD2bfAI8rCi/6ZR95RGf7+8AR9Z+o5g+Qg5EkZr+6TXPkIB/67iF688qjM4IB71JQCtsmJYiS2BtGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qjZJ+Dpvv+NMM7+Hw9ovMH2tToBNqk9/H2+WCNgf1o=;
 b=JdPmTWk3TGBaxttA1tl3r51lgDsvN9EjAEcae6PRYCDlxU14IaO1Yqq3d+hczTxGodVCssQTZ0la2ACt5tDV5DpHW3UJhu21I+zO7843WkGUiaOHb0/70WafJBxxiC5anfmJzokbXhRfwP3qmMLIkbbYHTy5nRwwvCdExVekdwBZb6uxvuoIc7guT2G7uAleW0oz78mVSxpFZ42FAt8Gncv3wsm7jSjdAV43x1JtufUezAu55Cyq28unBqqaxNjz4VXUBMfmtdmKGi9gSzvujkCieuonaeXHlhQij6npCDhSIkVdcdi+kITy+EJl0ytBltNSK7RFrXVMepcRUAK8yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 10:15:34 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 10:15:34 +0000
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
Subject: [PATCH net 2/2] selftests: forwarding: bridge_mdb_max: Add a test for rejected MDB entries
Date: Fri, 16 Oct 2026 13:14:07 +0300
Message-ID: <20261016101407.2030133-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016101407.2030133-1-idosch@nvidia.com>
References: <20261016101407.2030133-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0168.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: da5d4196-e741-4db6-8109-08df2b6e6a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|22082099003|56012099006|18002099003|20052099010|6133799003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Mjtroe+ZYz4etoIW7fTAl/i5DVBViuc3Gfom+Buaw7tDPpHDnVcEM2NfZiPnjGzD7hDZUJUQZTA7d2o8ssq/nW59cD19w2mg6TWfEey4UKWJ5GnjlBRvaJ5HjA3LcJolxPTFh5uzMAnfb8UyaOTty4lRRQHOwK2zw00YHWS5TyuQcaddnbFO4UxVmeeZi4hJcIFUh/Y3MRWcDvSCVTArGOOiehhep+hMJqNNKusqixb+tXZ6YvIy3hR8q7VlAOIxZZn45abVEl3ZYL6CSTuvu6wu3v+kjY/wvNHQCGwgwkroPCQD7ZPVnGC1+c08J2IjbjXFQH5eg4ZhL9CPfMQb3PjbxaLunnml7uQs2/NvHWe2JY9/zfnNrbEx9vRk1bH0wK9Zujcc9Xevq3DyNHLI3sna9FPxJKpdfmqPGP/U71KYBNmaoCKYNRiNsDdaTnj5j5QdDrarJHfLZddpYBFpL9wP65qmupoGx1vvnTOq4WbfoWemOcOyr+m6J5gynrnWjrqZu+1Y4jnifJoEMOD6MMH2AoVomBIgDEj8Pzzns8OgHcfPTJTTxyAhN5DWMfnWq9Ad8iayOyBLJNJeZkeQK5x/9HDLOuRqTnBX0lZhgUqayUmEfpT3ixPcJwIf2WYM/mcfoJGr2w/oUP+gtMG1THS5aw3fmWYqsZMgNBuhrDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(20052099010)(6133799003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTcAayQQ2PoBwo86LcNoHEougDje0lFf/rnkZjIx4yRGcdsRf8lWdbcxwDYw?=
 =?us-ascii?Q?LGKIap6jm2r3opsVihh49aeB3vQrzZFS2r5HTe8APur7BRTpsXGx3AycHg48?=
 =?us-ascii?Q?FGXNXZIvRoPhaIMIH++27H8EJ2nFXicfhMgcvMlv6Eol1tstRQX/zd60wyv8?=
 =?us-ascii?Q?RB3kItzLQv8zNyHuAklwPbqtd51149BKd7pzgmM9Mh/QXTTAcblgcGZF+I2y?=
 =?us-ascii?Q?LVbIndCPS2RzzdHcPuW4Z9BQFG8+W5X+nyTbOlPCmjT8jvjxXqh8+OdApTK7?=
 =?us-ascii?Q?gmzlZArm5V4YUL+7eQ5d13mJ8cUYwKGMvPN0zZ532DxS2/1cu/CUZFI2HVv6?=
 =?us-ascii?Q?fpS0AXlqN0pchV+XU4b2rV8FjnYbgO5NVdMC9LOsWjRexLn/zKNXBLoyy1mX?=
 =?us-ascii?Q?XUYsBumb012/fzzmGF7vukWQrkgchFafAhtL04kVlS2xV62/BDNtNQQzgxZ8?=
 =?us-ascii?Q?/BT/vsy89EpzB/FsGUdud3XHmAqFcZ9gRj+rLd2azPomPSGCd3SCy2XaHNOq?=
 =?us-ascii?Q?ExjiGEvgmesG73PJIug5gP44FtLTIwlLEjVfBxhcgSfSLOuoySLlYPtpbHwp?=
 =?us-ascii?Q?8XjOO90JlyZ+Wrd1lA7TCS8vvwhspRvdxA50vT8vyaPi2oabVaefNTOFkUor?=
 =?us-ascii?Q?EI7rq/e1WgYevURm0zVSDtTYbjXeCaRErxbf5wnzvmAbWlgkpsRO403rkHTj?=
 =?us-ascii?Q?KcWSZnlWGeknOWN0+yEPYsAl0IcaPsS1+JRJEXKznCIuV4AYQJLtmzV/ktXa?=
 =?us-ascii?Q?Av7aty4GDVQ1zTeHGv0OxHWO8hGsORD9DMxM2VqGC2NZkM33o1s8z2HcJdzX?=
 =?us-ascii?Q?ej1HbgHkJKL4w8e+6aakENSbvnAg5JplDOykZV4J0dePDHpK0PBFUYlsx+UF?=
 =?us-ascii?Q?elLDiIQdY2CwvsxEALB7XHeqNgQA3OVgI1dyslwVXBSR/QDlv/P0Gu5UdwN6?=
 =?us-ascii?Q?Z0iYAp1egmMT6ptoRjj0okjfIBKaEJv651FNLoUHgD6oYEfukWPlzHOMg0sw?=
 =?us-ascii?Q?IBj/EzDMpTAxU6BaP9tiAhqm6vTiXmVDg3BvzSIR9XP4hwdXOK9uYXZECc/I?=
 =?us-ascii?Q?EigTgWBRw1fXg6dSwQM3Jiw60ZxDGJzMnnV+TNRssI66frCF8zkW00DCdaxV?=
 =?us-ascii?Q?n6PMo0+jTvc7YYt/R2jgOEekIBWj+GsvmhilY+qokNoeVt46comRtfXi0qQV?=
 =?us-ascii?Q?QQRrWu/T8V+slhLebj4mv9KK/rTyiUvF6Xe9dKJWWreGCaJmEmZiDvBb7jem?=
 =?us-ascii?Q?wac8oLmHoU070IvbQ1xbTGgoks3MUfFrCHXSClWbgK+EwmNYh/EmUwc1mgAc?=
 =?us-ascii?Q?Y5bPV1CnE4tX37R6nbIGxSvsuUzZiLAw5+mBTGaG9uZj0lTmvXCitGECsgFh?=
 =?us-ascii?Q?Wh2VyURccKOoQx6rFmMmdIqNCGz0oHAQqgxFZFJbqHBo/wYnSj+pyHnun+4V?=
 =?us-ascii?Q?rvRJMT8abVjTvSxC5Tx0/Ja3LZW0UcWpNw2SSXqLBS9Bl3TvDfWK8ewo6QYo?=
 =?us-ascii?Q?5RoO6OP1MICg2RWHursbYxZ14F6Kk2Xa/FlUt7Det8aZJIJ8G0NtMGyaUf4G?=
 =?us-ascii?Q?NiLJvF4OPQjlpkkynuU36Hru9RqI5eYj+TZv3ulxCAKKxpZgia9O5+CJ5BSF?=
 =?us-ascii?Q?xLAfNQEO/J1B92RZedqsVldARzSxROUo5JQTlcPlw3v/stOuOTZeQeO5ZnX9?=
 =?us-ascii?Q?F5DZZ328NJ7MY8qMoZBik1S2Q6aKIUBDuattaM31/eDqCewICWUewrLT6Thd?=
 =?us-ascii?Q?QBteB9pdSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d4196-e741-4db6-8109-08df2b6e6a48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:15:34.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7xLVA77VRkN7RXE1KsfnF3eKMH9Wkqt18gUsY/1fFlcGZt02Kio+u5PUdUVovutXmyOZpG7WhKTs/8fF7NWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

Add a test that checks that MDB entries that are rejected because the
port reached its maximum number of MDB entries (mcast_max_groups) do not
count towards the maximum number of MDB entries in the bridge
(mcast_hash_max).

The test lowers mcast_hash_max so that only three more entries can be
added. It then configures the port's maximum so that new (*, G) entries
are rejected and tries to add four of them. Next, it raises the maximum
by one so that a new (*, G) entry is accepted, but its (S, G) entry is
rejected, and tries this with four groups. Finally, it checks that
multicast snooping was not disabled because the bridge ran out of MDB
entries.

Like the other tests, the test is run for entries added both by the
control path (IGMP / MLD reports) and by the configuration path
(RTM_NEWMDB), and for both the port and port-VLAN maximums.

Without "bridge: mcast: Delete empty MDB entry when port group creation
fails", the new tests fail (other tests omitted):

 # ./bridge_mdb_max.sh
 INFO: 802.1d tests
 TEST: cfg4: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl4: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: cfg6: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl6: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 INFO: 802.1q tests
 TEST: cfg4: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl4: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: cfg6: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl6: port maxgroups: rejected entries do not exhaust MDB     [FAIL]
         Multicast snooping disabled by rejected MDB entries
 INFO: 802.1q mcast_vlan_snooping 1 tests
 TEST: cfg4: port_vlan maxgroups: rejected entries do not exhaust MDB   [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl4: port_vlan maxgroups: rejected entries do not exhaust MDB   [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: cfg6: port_vlan maxgroups: rejected entries do not exhaust MDB   [FAIL]
         Multicast snooping disabled by rejected MDB entries
 TEST: ctl6: port_vlan maxgroups: rejected entries do not exhaust MDB   [FAIL]
         Multicast snooping disabled by rejected MDB entries

Assisted-by: LLM
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/bridge_mdb_max.sh          | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index 625162fd7e8b..4ebffe4588a2 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -399,6 +399,24 @@ bridge_port_vlan_maxgroups_set()
 	bridge vlan set $locus mcast_max_groups $max
 }
 
+bridge_mcast_snooping_get()
+{
+	ip -j -d link show dev br0 |
+	    jq '.[].linkinfo.info_data.mcast_snooping'
+}
+
+bridge_mcast_hash_max_get()
+{
+	ip -j -d link show dev br0 |
+	    jq '.[].linkinfo.info_data.mcast_hash_max'
+}
+
+bridge_mdb_entries_count()
+{
+	bridge -j mdb show dev br0 |
+	    jq '[.[].mdb[] | [.grp, .src, .vid]] | unique | length'
+}
+
 test_ngroups_reporting()
 {
 	local CFG=$1; shift
@@ -938,6 +956,114 @@ test_8021qvs_maxgroups_too_many_entries_ctl6()
 	test_maxgroups_too_many_entries ctl6 port_vlan "dev $swp1 vid 10"
 }
 
+test_maxgroups_hash_max()
+{
+	local CFG=$1; shift
+	local context=$1; shift
+	local locus=$1; shift
+
+	local hash_max n i
+
+	RET=0
+
+	hash_max=$(bridge_mcast_hash_max_get)
+
+	# Make sure the port has entries, so that max == n is not 0 (no limit).
+	${CFG}_entries_add "$locus" temp 2 120
+	check_err $? "$locus: Couldn't add MDB entries"
+	n=$(bridge_${context}_ngroups_get "$locus")
+
+	# Leave room for three more MDB entries.
+	ip link set dev br0 type bridge \
+		mcast_hash_max $(($(bridge_mdb_entries_count) + 3))
+	check_err $? "Couldn't set mcast_hash_max"
+
+	# Port at its maximum: (*, G) entries are rejected.
+	bridge_${context}_maxgroups_set "$locus" "$n"
+	check_err $? "$locus: Couldn't set maximum"
+	for i in $(seq 121 124); do
+		${CFG}_entries_add "$locus" temp 2 "$i" &> /dev/null
+	done
+
+	# One more slot: (*, G) is accepted, (S, G) is rejected.
+	bridge_${context}_maxgroups_set "$locus" $((n + 1))
+	check_err $? "$locus: Couldn't set maximum"
+	for i in $(seq 125 128); do
+		${CFG}_entries_add "$locus" temp 2 "$i" &> /dev/null
+	done
+
+	[[ $(bridge_mcast_snooping_get) == 1 ]]
+	check_err $? "Multicast snooping disabled by rejected MDB entries"
+
+	bridge mdb flush dev br0
+	ip link set dev br0 type bridge mcast_snooping 1
+	ip link set dev br0 type bridge mcast_hash_max "$hash_max"
+	bridge_${context}_maxgroups_set "$locus" 0
+	check_err $? "$locus: Couldn't set maximum to 0"
+
+	log_test "$CFG: $context maxgroups: rejected entries do not exhaust MDB"
+}
+
+test_8021d_maxgroups_hash_max_cfg4()
+{
+	test_maxgroups_hash_max cfg4 port "dev $swp1"
+}
+
+test_8021d_maxgroups_hash_max_ctl4()
+{
+	test_maxgroups_hash_max ctl4 port "dev $swp1"
+}
+
+test_8021d_maxgroups_hash_max_cfg6()
+{
+	test_maxgroups_hash_max cfg6 port "dev $swp1"
+}
+
+test_8021d_maxgroups_hash_max_ctl6()
+{
+	test_maxgroups_hash_max ctl6 port "dev $swp1"
+}
+
+test_8021q_maxgroups_hash_max_cfg4()
+{
+	test_maxgroups_hash_max cfg4 port "dev $swp1 vid 10"
+}
+
+test_8021q_maxgroups_hash_max_ctl4()
+{
+	test_maxgroups_hash_max ctl4 port "dev $swp1 vid 10"
+}
+
+test_8021q_maxgroups_hash_max_cfg6()
+{
+	test_maxgroups_hash_max cfg6 port "dev $swp1 vid 10"
+}
+
+test_8021q_maxgroups_hash_max_ctl6()
+{
+	test_maxgroups_hash_max ctl6 port "dev $swp1 vid 10"
+}
+
+test_8021qvs_maxgroups_hash_max_cfg4()
+{
+	test_maxgroups_hash_max cfg4 port_vlan "dev $swp1 vid 10"
+}
+
+test_8021qvs_maxgroups_hash_max_ctl4()
+{
+	test_maxgroups_hash_max ctl4 port_vlan "dev $swp1 vid 10"
+}
+
+test_8021qvs_maxgroups_hash_max_cfg6()
+{
+	test_maxgroups_hash_max cfg6 port_vlan "dev $swp1 vid 10"
+}
+
+test_8021qvs_maxgroups_hash_max_ctl6()
+{
+	test_maxgroups_hash_max ctl6 port_vlan "dev $swp1 vid 10"
+}
+
 test_maxgroups_too_many_cross_vlan()
 {
 	local CFG=$1; shift
@@ -1177,6 +1303,7 @@ test_8021d_maxgroups_cfg4()
 	test_8021d_maxgroups_zero_cfg4
 	test_8021d_maxgroups_too_low_cfg4
 	test_8021d_maxgroups_too_many_entries_cfg4
+	test_8021d_maxgroups_hash_max_cfg4
 }
 
 test_8021d_maxgroups_ctl4()
@@ -1184,6 +1311,7 @@ test_8021d_maxgroups_ctl4()
 	test_8021d_maxgroups_zero_ctl4
 	test_8021d_maxgroups_too_low_ctl4
 	test_8021d_maxgroups_too_many_entries_ctl4
+	test_8021d_maxgroups_hash_max_ctl4
 }
 
 test_8021d_maxgroups_cfg6()
@@ -1191,6 +1319,7 @@ test_8021d_maxgroups_cfg6()
 	test_8021d_maxgroups_zero_cfg6
 	test_8021d_maxgroups_too_low_cfg6
 	test_8021d_maxgroups_too_many_entries_cfg6
+	test_8021d_maxgroups_hash_max_cfg6
 }
 
 test_8021d_maxgroups_ctl6()
@@ -1198,6 +1327,7 @@ test_8021d_maxgroups_ctl6()
 	test_8021d_maxgroups_zero_ctl6
 	test_8021d_maxgroups_too_low_ctl6
 	test_8021d_maxgroups_too_many_entries_ctl6
+	test_8021d_maxgroups_hash_max_ctl6
 }
 
 test_8021q_maxgroups_cfg4()
@@ -1205,6 +1335,7 @@ test_8021q_maxgroups_cfg4()
 	test_8021q_maxgroups_zero_cfg4
 	test_8021q_maxgroups_too_low_cfg4
 	test_8021q_maxgroups_too_many_entries_cfg4
+	test_8021q_maxgroups_hash_max_cfg4
 }
 
 test_8021q_maxgroups_ctl4()
@@ -1212,6 +1343,7 @@ test_8021q_maxgroups_ctl4()
 	test_8021q_maxgroups_zero_ctl4
 	test_8021q_maxgroups_too_low_ctl4
 	test_8021q_maxgroups_too_many_entries_ctl4
+	test_8021q_maxgroups_hash_max_ctl4
 }
 
 test_8021q_maxgroups_cfg6()
@@ -1219,6 +1351,7 @@ test_8021q_maxgroups_cfg6()
 	test_8021q_maxgroups_zero_cfg6
 	test_8021q_maxgroups_too_low_cfg6
 	test_8021q_maxgroups_too_many_entries_cfg6
+	test_8021q_maxgroups_hash_max_cfg6
 }
 
 test_8021q_maxgroups_ctl6()
@@ -1226,6 +1359,7 @@ test_8021q_maxgroups_ctl6()
 	test_8021q_maxgroups_zero_ctl6
 	test_8021q_maxgroups_too_low_ctl6
 	test_8021q_maxgroups_too_many_entries_ctl6
+	test_8021q_maxgroups_hash_max_ctl6
 }
 
 test_8021qvs_maxgroups_cfg4()
@@ -1234,6 +1368,7 @@ test_8021qvs_maxgroups_cfg4()
 	test_8021qvs_maxgroups_zero_cross_vlan_cfg4
 	test_8021qvs_maxgroups_too_low_cfg4
 	test_8021qvs_maxgroups_too_many_entries_cfg4
+	test_8021qvs_maxgroups_hash_max_cfg4
 	test_8021qvs_maxgroups_too_many_cross_vlan_cfg4
 }
 
@@ -1243,6 +1378,7 @@ test_8021qvs_maxgroups_ctl4()
 	test_8021qvs_maxgroups_zero_cross_vlan_ctl4
 	test_8021qvs_maxgroups_too_low_ctl4
 	test_8021qvs_maxgroups_too_many_entries_ctl4
+	test_8021qvs_maxgroups_hash_max_ctl4
 	test_8021qvs_maxgroups_too_many_cross_vlan_ctl4
 }
 
@@ -1252,6 +1388,7 @@ test_8021qvs_maxgroups_cfg6()
 	test_8021qvs_maxgroups_zero_cross_vlan_cfg6
 	test_8021qvs_maxgroups_too_low_cfg6
 	test_8021qvs_maxgroups_too_many_entries_cfg6
+	test_8021qvs_maxgroups_hash_max_cfg6
 	test_8021qvs_maxgroups_too_many_cross_vlan_cfg6
 }
 
@@ -1261,6 +1398,7 @@ test_8021qvs_maxgroups_ctl6()
 	test_8021qvs_maxgroups_zero_cross_vlan_ctl6
 	test_8021qvs_maxgroups_too_low_ctl6
 	test_8021qvs_maxgroups_too_many_entries_ctl6
+	test_8021qvs_maxgroups_hash_max_ctl6
 	test_8021qvs_maxgroups_too_many_cross_vlan_ctl6
 }
 
-- 
2.56.0

