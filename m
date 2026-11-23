Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456859;
	b=yAFjDPU26emQxhxGS0BQqc8+dHFcs4s4dS8Sf4nqxLlbm6GyttShRptcyIdX4gAo465S
	 MoUc7odQKgN59SoIzkPPYPCIeH9+DaE0EOrsQnpUDx34CSLMqdYGwbiPAjIhu+yuLbmuz
	 R8sM3PKEt9L1yfkblKX/RZppubTRnokYvJl4br+rCvazB7Pfw8rXEgg3LEzz+xxgOjL79
	 6GAfegxeoOzGYQ55h/VIbXkPyqIiHfQmP1IilzHMFp+nWUUvuWc1ADWwLwED57IBNWyee
	 hqzstAp908xpaDLYKx17vzmVZMZSIZzpAgyWOu8tbtXzGalxZE65UwQqgKP6REDFfGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456859;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=twHfXvHELoquNvtqEU8KzmhORwV8NmZAmrqSE8GRoJY=;
	b=jZ/HI0ZvrSnGr6ZH8bscJyrodcSZm6rJY7WulPFxGbVncbeyg5qiI9MSewbfZutVMfNa
	 QL97i2VhSN/emdVqwSpcUAb/3c3h2bEoftDH8/IEpbZERgMZ9F3mu/jn6P/pJOu4tXqQe
	 BamIDOaMsll6iJZUFZNQaaN1Ntfb34qfn+qiXxmMA6qLpP/7vS4p4Qz46AncY5ZRgKmMQ
	 BPsInqvceTBS1ob4huFZuS3MSB5nOPj8HTDI4mul3UaBM08JIOEZKlj75Z0QQ1do463iP
	 GJa/8h5v47mFEhKEfxV/lKWDRl7IVoBxIyyJb1JED+FI+V4ryA16VbArppRuAPKeDVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oDglKPaD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.11
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC6606A31A
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oDglKPaD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYfbXSdSI6Q4udaki9mr2hwBy63CJSBxjxzHhHsytT0fuqV2/egpDGKKK7LqRPcrn8yxSdIVhcOH9iA/VadZv5x15nPb4ks674TftLOJps+/g8pGZmh6dPlc1t18J2W7y6JMtwZI8icnoS04dmlXAyAAedGS5NTvtffMWPs4EN7hVOXk9MWVeQnQsWEKbMxIRJKqnN6d+eb6/IxB77eddaAvQdqo5NPFChtuy/JVF+RsxpMzxvllgzTvvjZG1QXYB8+KRj2GQ5EocqfON78aeIn156AkkFQmAh5ofw/bOX9VVlz6pa07bEHyjQ0s+CWJxVoOPVKmkVtJ3XxuMS6+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twHfXvHELoquNvtqEU8KzmhORwV8NmZAmrqSE8GRoJY=;
 b=SnI8/CUIa8lQ0c7CzGGRWcjBeIiDb7RYRbZEQOeTIc1dP+0aWkXcP3TPDgZn4lpOPhHU+KfgrlVY5Glw0dZOZvkrPHp3+06FEpuSwMo1LnojCGjubjY5C9PJ25RxilJtLRukO58lYUAHQEJ6iyCzQSqaStYyQr4qXbN0ZsROxCYCrowTHKckSzVKfSdT0tuhDFIICbq8slAvZBLtPvyX+OJjj8+51CO5ZtWSnD/xWyz2EoxYUovZcLSnUHG4PkRok3Nhm1Mao8c5xFIu9jc7peaJ+ox2XIG2wbznhFBgfxFvkUGVv0ZFjpu8V6lF0xeu+tFG1cPbxo+zTNsWTvqByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twHfXvHELoquNvtqEU8KzmhORwV8NmZAmrqSE8GRoJY=;
 b=oDglKPaDRhYmwKy/yYlPjmvxmGFfsRddHJmp8nGH27Ntqj+wHviyHAc+4jm0+ZAGESB8gzxqzSpviDcE8ny3iP7zbfpE0u7Dw0BHlVQsfOKI8jGxUjiiBqsbCZT9AUeHlSOAQH8GonmeEnimX1WXezDbvL0DWoA1Kxqor8RNNQk8aqPPJcAXcsrT/h1kSS45zX+xW76PE/ub8e6i6VhACd/4TnKd4+8l5ag7tc8HGoEB9EiPdb1ifF7V0vds81pw9cRDFizpboSp4Ie2WErgJfaWbr+jdeTOr7SWTvxpyV/qpXFvK+HDEQq5kTxeuqOUVZ1KYFiNCM3AnavjxBhmzg==
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by LV1PR12MB399762.namprd12.prod.outlook.com (2603:10b6:408:50f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:00:29 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::9) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:00:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:06 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 09:59:58 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>, Shahed Shaikh
	<shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>
Subject: [PATCH net-next 01/13] net: Introduce struct ndo_fdb_parms
Date: Mon, 23 Nov 2026 18:59:16 +0100
Message-ID: <5889662e0c020bd1e2fdb37d9367c97ac4f00796.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
References: <cover.1795447450.git.petrm@nvidia.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|LV1PR12MB399762:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e4038d-7756-4445-92b6-08df498ba8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261022075727099003|261028144727099003|261026121527099003|261102123227099003|261026140227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PJju+1nmZmz9Jo2OMpwIG/EkRgWDmmtP8pxiYCbpHTq8NYQ5TGHyMlEu5vm128mbFjdxDSt50RujlC90N5RVJWH4IQYbB5siJLaN04m3/5WoFmFHUHhZy608paBzY7wvVPcx7esxmsh9v2BLjzMht6JiuRwzZwdRC3VNJvu9j0TW7KcKiASiYzaDrnXfQsgRnHOKF89SZ97JMLde6pOlIG/SyvRDloqSlyzUWiF+ts5n1ej+KG1s2lH1soazQBYtjABwInOdxtMScgT2NL6jhmwV72r8oPAaF1ZlVQoWxr6/2KGPIeaSbVWQZgyxcXNk4J/doqz3rzIoXh13Xi/ZgThngH8OVRCwx/GwCF+ONCE8AOY4dhvgWPGfUGPHjkX8XivTPEUy+BVz3HwCK/SLr82ELqVS1txiSH/+4JhlOf86WU+Ov8Aq8vYhVb5AwPBYnLoWPaJqrvzkxyYZKFOLfnmSKHuTyou9OF630iQ7yjSz1W3IZ3TBEu4BzLxdl5DI/kxNF8xDTg7cmOt2c+ye3maapvucwb3r1z+/e7+9+q0ADLxYZMMISSadDLpdwbL3ZY9xBBAL2jannID1wk94ZhqPTl6wAiO5vXKIa2r52gZ6fjzJrdW336rBnhii61fa2JJBMrqYVKlbLqp4Ofh9PJ08d9/mAuPOWcrCFx9x47NTTv19AsquKFOAeb2YOnTmfenXkjq0fM3Pkyca5687kg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MP3HQpekHmIxGUhmBZivVsxS8/J9q6PO4O+PZhaH9vcwz2QjkrL/8aHh0Usg6fe+xQhoQ5PKEF9k0ABMRy5k/JZRNDauJcEBsPcV0lKum3Nu2CXjpd+eNF14UblVAqORKCRc3c/ZNpiDWXHsXPiqixrINLjq5PwrhxKgLuy+5Xd4vm3welqpEU9i7BOc4vWxcdknV+NF6L9kPSmmAiu8aGdmNSE/OVEspNOzF8Q5RKgCe0xjFF/7rxCjRN17E4HWbfUL8AY6qnrhoBzE/iSghediOY4Duxt1fiVh/m9WbZ5GvnY1Kf3wqIkEiEJjZIlACtRQXsMLct0MIPe0ti9jKTEn/4SK8mdaN0m4qYHlxHcUChtWjXjG98L7UdNcQE2lILW0SzNHL44qWDMMjQiYztGjg2hmaVSPql0bJ0FO/9KaHJjvZ0zDkoFVQeN8s7AY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:29.0853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e4038d-7756-4445-92b6-08df498ba8d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB399762

The ndo_fdb_add, ndo_fdb_del and ndo_fdb_get callbacks share a growing list
of arguments: device, address, VLAN ID and, for add, the netlink message
flags. A following patch will add another argument to that list: a port ID.
With that addition, the prototypes get unwieldy. Any such change also
prompts updates of the corresponding NDO callbacks in several drivers.

Collect the common arguments in a new struct ndo_fdb_parms, similarly to
how struct neigh_parms is used for ndo_neigh_setup, and pass a pointer to
it instead of these arguments. The ndmsg, nlattr array, the "notified"
flag, extack, and for ndo_fdb_get also the port ID and sequence number,
stay separate arguments.

In rtnl_fdb_del(), the structure is only initialized for non-bulk requests,
which is where the VLAN ID and address are parsed, and the only place where
the callbacks consume it.

With this change, addition of a new parameter then consists of adding a new
field to this struct and a proper initialization, and avoids the NDO update
dance.

No functional change intended.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: UNGLinuxDriver@microchip.com
CC: Shahed Shaikh <shshaikh@marvell.com>
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 29 ++++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 43 ++++++------
 drivers/net/ethernet/intel/igb/igb_main.c     | 15 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 +++--
 drivers/net/ethernet/mscc/ocelot_net.c        | 19 +++---
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  | 40 +++++------
 drivers/net/macvlan.c                         | 33 +++++----
 drivers/net/vxlan/vxlan_core.c                | 27 ++++----
 include/linux/netdevice.h                     | 38 ++++++-----
 net/bridge/br_fdb.c                           | 67 ++++++++++---------
 net/bridge/br_private.h                       | 14 ++--
 net/core/rtnetlink.c                          | 37 +++++++---
 12 files changed, 195 insertions(+), 182 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae..c8337bef5dbf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13022,28 +13022,24 @@ static int i40e_get_phys_port_id(struct net_device *netdev,
  * i40e_ndo_fdb_add - add an entry to the hardware database
  * @ndm: the input from the stack
  * @tb: pointer to array of nladdr (unused)
- * @dev: the net device pointer
- * @addr: the MAC address entry being added
- * @vid: VLAN ID
- * @flags: instructions from stack about fdb operation
+ * @parms: common FDB parameters
  * @notified: whether notification was emitted
  * @extack: netlink extended ack, unused currently
  */
 static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr, u16 vid,
-			    u16 flags, bool *notified,
+			    const struct ndo_fdb_parms *parms, bool *notified,
 			    struct netlink_ext_ack *extack)
 {
-	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_netdev_priv *np = netdev_priv(parms->dev);
 	struct i40e_pf *pf = np->vsi->back;
 	int err = 0;
 
 	if (!test_bit(I40E_FLAG_SRIOV_ENA, pf->flags))
 		return -EOPNOTSUPP;
 
-	if (vid) {
-		pr_info("%s: vlans aren't supported yet for dev_uc|mc_add()\n", dev->name);
+	if (parms->vid) {
+		pr_info("%s: vlans aren't supported yet for dev_uc|mc_add()\n",
+			parms->dev->name);
 		return -EINVAL;
 	}
 
@@ -13051,19 +13047,20 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	 * ndm_state is given only allow permanent addresses
 	 */
 	if (ndm->ndm_state && !(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_info(dev, "FDB only supports static addresses\n");
+		netdev_info(parms->dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_add_excl(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_add_excl(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_add_excl(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 	else
 		err = -EINVAL;
 
 	/* Only return duplicate errors if NLM_F_EXCL is set */
-	if (err == -EEXIST && !(flags & NLM_F_EXCL))
+	if (err == -EEXIST && !(parms->flags & NLM_F_EXCL))
 		err = 0;
 
 	return err;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8f06c3d0fdf..396299d5d7bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6108,39 +6108,37 @@ ice_set_tx_maxrate(struct net_device *netdev, int queue_index, u32 maxrate)
  * ice_fdb_add - add an entry to the hardware database
  * @ndm: the input from the stack
  * @tb: pointer to array of nladdr (unused)
- * @dev: the net device pointer
- * @addr: the MAC address entry being added
- * @vid: VLAN ID
- * @flags: instructions from stack about fdb operation
+ * @parms: common FDB parameters
  * @notified: whether notification was emitted
  * @extack: netlink extended ack
  */
 static int
 ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
-	    struct net_device *dev, const unsigned char *addr, u16 vid,
-	    u16 flags, bool *notified,
+	    const struct ndo_fdb_parms *parms, bool *notified,
 	    struct netlink_ext_ack __always_unused *extack)
 {
 	int err;
 
-	if (vid) {
-		netdev_err(dev, "VLANs aren't supported yet for dev_uc|mc_add()\n");
+	if (parms->vid) {
+		netdev_err(parms->dev,
+			   "VLANs aren't supported yet for dev_uc|mc_add()\n");
 		return -EINVAL;
 	}
 	if (ndm->ndm_state && !(ndm->ndm_state & NUD_PERMANENT)) {
-		netdev_err(dev, "FDB only supports static addresses\n");
+		netdev_err(parms->dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
-		err = dev_uc_add_excl(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_add_excl(dev, addr);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr))
+		err = dev_uc_add_excl(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 	else
 		err = -EINVAL;
 
 	/* Only return duplicate errors if NLM_F_EXCL is set */
-	if (err == -EEXIST && !(flags & NLM_F_EXCL))
+	if (err == -EEXIST && !(parms->flags & NLM_F_EXCL))
 		err = 0;
 
 	return err;
@@ -6150,29 +6148,26 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
  * ice_fdb_del - delete an entry from the hardware database
  * @ndm: the input from the stack
  * @tb: pointer to array of nladdr (unused)
- * @dev: the net device pointer
- * @addr: the MAC address entry being added
- * @vid: VLAN ID
+ * @parms: common FDB parameters (device, address, VLAN ID)
  * @notified: whether notification was emitted
  * @extack: netlink extended ack
  */
 static int
 ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
-	    struct net_device *dev, const unsigned char *addr,
-	    __always_unused u16 vid, bool *notified,
+	    const struct ndo_fdb_parms *parms, bool *notified,
 	    struct netlink_ext_ack *extack)
 {
 	int err;
 
 	if (ndm->ndm_state & NUD_PERMANENT) {
-		netdev_err(dev, "FDB only supports static addresses\n");
+		netdev_err(parms->dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr))
-		err = dev_uc_del(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_del(dev, addr);
+	if (is_unicast_ether_addr(parms->addr))
+		err = dev_uc_del(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_del(parms->dev, parms->addr);
 	else
 		err = -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c75d78badf71..42b2fd3ed95c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2517,21 +2517,22 @@ static int igb_set_features(struct net_device *netdev,
 }
 
 static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			   struct net_device *dev,
-			   const unsigned char *addr, u16 vid,
-			   u16 flags, bool *notified,
+			   const struct ndo_fdb_parms *parms, bool *notified,
 			   struct netlink_ext_ack *extack)
 {
 	/* guarantee we can provide a unique filter for the unicast address */
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr)) {
-		struct igb_adapter *adapter = netdev_priv(dev);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr)) {
+		struct igb_adapter *adapter = netdev_priv(parms->dev);
 		int vfn = adapter->vfs_allocated_count;
 
-		if (netdev_uc_count(dev) >= igb_available_rars(adapter, vfn))
+		if (netdev_uc_count(parms->dev) >=
+		    igb_available_rars(adapter, vfn))
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
+				parms->vid, parms->flags);
 }
 
 #define IGB_MAX_MAC_HDR_LEN	127
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6458cb2e511e..26d1a7253cf3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10603,21 +10603,22 @@ static int ixgbe_set_features(struct net_device *netdev,
 }
 
 static int ixgbe_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			     struct net_device *dev,
-			     const unsigned char *addr, u16 vid,
-			     u16 flags, bool *notified,
+			     const struct ndo_fdb_parms *parms, bool *notified,
 			     struct netlink_ext_ack *extack)
 {
 	/* guarantee we can provide a unique filter for the unicast address */
-	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr)) {
-		struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	if (is_unicast_ether_addr(parms->addr) ||
+	    is_link_local_ether_addr(parms->addr)) {
+		struct ixgbe_adapter *adapter = ixgbe_from_netdev(parms->dev);
 		u16 pool = VMDQ_P(0);
 
-		if (netdev_uc_count(dev) >= ixgbe_available_rars(adapter, pool))
+		if (netdev_uc_count(parms->dev) >=
+		    ixgbe_available_rars(adapter, pool))
 			return -ENOMEM;
 	}
 
-	return ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags);
+	return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
+				parms->vid, parms->flags);
 }
 
 /**
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 4d45e136f08f..65f9dee62dc5 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -765,30 +765,29 @@ static void ocelot_get_stats64(struct net_device *dev,
 }
 
 static int ocelot_port_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			       struct net_device *dev,
-			       const unsigned char *addr,
-			       u16 vid, u16 flags, bool *notified,
-			       struct netlink_ext_ack *extack)
+			       const struct ndo_fdb_parms *parms,
+			       bool *notified, struct netlink_ext_ack *extack)
 {
-	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port_private *priv = netdev_priv(parms->dev);
 	struct ocelot_port *ocelot_port = &priv->port;
 	struct ocelot *ocelot = ocelot_port->ocelot;
 	int port = priv->port.index;
 
-	return ocelot_fdb_add(ocelot, port, addr, vid, ocelot_port->bridge);
+	return ocelot_fdb_add(ocelot, port, parms->addr, parms->vid,
+			      ocelot_port->bridge);
 }
 
 static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
-			       struct net_device *dev,
-			       const unsigned char *addr, u16 vid,
+			       const struct ndo_fdb_parms *parms,
 			       bool *notified, struct netlink_ext_ack *extack)
 {
-	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port_private *priv = netdev_priv(parms->dev);
 	struct ocelot_port *ocelot_port = &priv->port;
 	struct ocelot *ocelot = ocelot_port->ocelot;
 	int port = priv->port.index;
 
-	return ocelot_fdb_del(ocelot, port, addr, vid, ocelot_port->bridge);
+	return ocelot_fdb_del(ocelot, port, parms->addr, parms->vid,
+			      ocelot_port->bridge);
 }
 
 static int ocelot_port_fdb_do_dump(const unsigned char *addr, u16 vid,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 23ae76ca81db..85017de2161b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -366,24 +366,24 @@ static int qlcnic_set_mac(struct net_device *netdev, void *p)
 }
 
 static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
-			struct net_device *netdev,
-			const unsigned char *addr, u16 vid, bool *notified,
+			const struct ndo_fdb_parms *parms, bool *notified,
 			struct netlink_ext_ack *extack)
 {
-	struct qlcnic_adapter *adapter = netdev_priv(netdev);
+	struct qlcnic_adapter *adapter = netdev_priv(parms->dev);
 	int err = -EOPNOTSUPP;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_del(ndm, tb, netdev, addr, vid);
+		return ndo_dflt_fdb_del(ndm, tb, parms->dev, parms->addr,
+					parms->vid);
 
 	if ((adapter->flags & QLCNIC_ESWITCH_ENABLED) ||
 	    qlcnic_sriov_check(adapter)) {
-		if (is_unicast_ether_addr(addr)) {
-			err = dev_uc_del(netdev, addr);
+		if (is_unicast_ether_addr(parms->addr)) {
+			err = dev_uc_del(parms->dev, parms->addr);
 			if (!err)
-				err = qlcnic_nic_del_mac(adapter, addr);
-		} else if (is_multicast_ether_addr(addr)) {
-			err = dev_mc_del(netdev, addr);
+				err = qlcnic_nic_del_mac(adapter, parms->addr);
+		} else if (is_multicast_ether_addr(parms->addr)) {
+			err = dev_mc_del(parms->dev, parms->addr);
 		} else {
 			err =  -EINVAL;
 		}
@@ -392,15 +392,15 @@ static int qlcnic_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 }
 
 static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			struct net_device *netdev,
-			const unsigned char *addr, u16 vid, u16 flags,
-			bool *notified, struct netlink_ext_ack *extack)
+			const struct ndo_fdb_parms *parms, bool *notified,
+			struct netlink_ext_ack *extack)
 {
-	struct qlcnic_adapter *adapter = netdev_priv(netdev);
+	struct qlcnic_adapter *adapter = netdev_priv(parms->dev);
 	int err = 0;
 
 	if (!adapter->fdb_mac_learn)
-		return ndo_dflt_fdb_add(ndm, tb, netdev, addr, vid, flags);
+		return ndo_dflt_fdb_add(ndm, tb, parms->dev, parms->addr,
+					parms->vid, parms->flags);
 
 	if (!(adapter->flags & QLCNIC_ESWITCH_ENABLED) &&
 	    !qlcnic_sriov_check(adapter)) {
@@ -408,16 +408,16 @@ static int qlcnic_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EOPNOTSUPP;
 	}
 
-	if (ether_addr_equal(addr, adapter->mac_addr))
+	if (ether_addr_equal(parms->addr, adapter->mac_addr))
 		return err;
 
-	if (is_unicast_ether_addr(addr)) {
-		if (netdev_uc_count(netdev) < adapter->ahw->max_uc_count)
-			err = dev_uc_add_excl(netdev, addr);
+	if (is_unicast_ether_addr(parms->addr)) {
+		if (netdev_uc_count(parms->dev) < adapter->ahw->max_uc_count)
+			err = dev_uc_add_excl(parms->dev, parms->addr);
 		else
 			err = -ENOMEM;
-	} else if (is_multicast_ether_addr(addr)) {
-		err = dev_mc_add_excl(netdev, addr);
+	} else if (is_multicast_ether_addr(parms->addr)) {
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 	} else {
 		err = -EINVAL;
 	}
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c7afa736c472..06079c697772 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1054,49 +1054,46 @@ static int macvlan_vlan_rx_kill_vid(struct net_device *dev,
 }
 
 static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			   struct net_device *dev,
-			   const unsigned char *addr, u16 vid,
-			   u16 flags, bool *notified,
+			   const struct ndo_fdb_parms *parms, bool *notified,
 			   struct netlink_ext_ack *extack)
 {
-	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct macvlan_dev *vlan = netdev_priv(parms->dev);
 	int err = -EINVAL;
 
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(parms->addr))
 		return -EOPNOTSUPP;
 
-	if (flags & NLM_F_REPLACE)
+	if (parms->flags & NLM_F_REPLACE)
 		return -EOPNOTSUPP;
 
-	if (is_unicast_ether_addr(addr))
-		err = dev_uc_add_excl(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_add_excl(dev, addr);
+	if (is_unicast_ether_addr(parms->addr))
+		err = dev_uc_add_excl(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_add_excl(parms->dev, parms->addr);
 
 	return err;
 }
 
 static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
-			   struct net_device *dev,
-			   const unsigned char *addr, u16 vid, bool *notified,
+			   const struct ndo_fdb_parms *parms, bool *notified,
 			   struct netlink_ext_ack *extack)
 {
-	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct macvlan_dev *vlan = netdev_priv(parms->dev);
 	int err = -EINVAL;
 
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(parms->addr))
 		return -EOPNOTSUPP;
 
-	if (is_unicast_ether_addr(addr))
-		err = dev_uc_del(dev, addr);
-	else if (is_multicast_ether_addr(addr))
-		err = dev_mc_del(dev, addr);
+	if (is_unicast_ether_addr(parms->addr))
+		err = dev_uc_del(parms->dev, parms->addr);
+	else if (is_multicast_ether_addr(parms->addr))
+		err = dev_mc_del(parms->dev, parms->addr);
 
 	return err;
 }
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b37472..a9f6bdd52c12 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1241,12 +1241,11 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 
 /* Add static entry (via netlink) */
 static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr, u16 vid, u16 flags,
-			 bool *notified, struct netlink_ext_ack *extack)
+			 const struct ndo_fdb_parms *parms, bool *notified,
+			 struct netlink_ext_ack *extack)
 {
 	const struct vxlan_config *cfg;
-	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_dev *vxlan = netdev_priv(parms->dev);
 	/* struct net *net = dev_net(vxlan->dev); */
 	union vxlan_addr ip;
 	__be16 port;
@@ -1273,7 +1272,8 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
+	err = vxlan_fdb_update(vxlan, parms->addr, &ip, ndm->ndm_state,
+			       parms->flags,
 			       port, src_vni, vni, ifindex,
 			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
 			       nhid, true, extack);
@@ -1320,11 +1320,10 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 
 /* Delete entry (via netlink) */
 static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
-			    struct net_device *dev,
-			    const unsigned char *addr, u16 vid, bool *notified,
+			    const struct ndo_fdb_parms *parms, bool *notified,
 			    struct netlink_ext_ack *extack)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_dev *vxlan = netdev_priv(parms->dev);
 	union vxlan_addr ip;
 	__be32 src_vni, vni;
 	u32 ifindex, nhid;
@@ -1337,8 +1336,8 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		return err;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
-				 true);
+	err = __vxlan_fdb_delete(vxlan, parms->addr, ip, port, src_vni, vni,
+				 ifindex, true);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
@@ -1400,12 +1399,10 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 static int vxlan_fdb_get(struct sk_buff *skb,
 			 struct nlattr *tb[],
-			 struct net_device *dev,
-			 const unsigned char *addr,
-			 u16 vid, u32 portid, u32 seq,
+			 const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
 			 struct netlink_ext_ack *extack)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_dev *vxlan = netdev_priv(parms->dev);
 	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 	__be32 vni;
@@ -1420,7 +1417,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, cfg, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, parms->addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 694b6d29f680..0bfd36057d3a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1087,6 +1087,20 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+/**
+ * struct ndo_fdb_parms - parameters for ndo_fdb_{add,del,get}
+ * @dev: device the FDB entry is added to, deleted from or looked up on
+ * @addr: MAC address of the FDB entry
+ * @vid: VLAN ID of the FDB entry, 0 if none
+ * @flags: netlink message flags (NLM_F_*) of the request
+ */
+struct ndo_fdb_parms {
+	struct net_device	*dev;
+	const unsigned char	*addr;
+	u16			vid;
+	u16			flags;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1330,17 +1344,15 @@ struct netdev_net_notifier {
  *	Must return >0 or -errno if it changed dev->features itself.
  *
  * int (*ndo_fdb_add)(struct ndmsg *ndm, struct nlattr *tb[],
- *		      struct net_device *dev,
- *		      const unsigned char *addr, u16 vid, u16 flags,
+ *		      const struct ndo_fdb_parms *parms,
  *		      bool *notified, struct netlink_ext_ack *extack);
- *	Adds an FDB entry to dev for addr.
+ *	Adds an FDB entry to parms->dev for parms->addr.
  *	Callee shall set *notified to true if it sent any appropriate
  *	notification(s). Otherwise core will send a generic one.
  * int (*ndo_fdb_del)(struct ndmsg *ndm, struct nlattr *tb[],
- *		      struct net_device *dev,
- *		      const unsigned char *addr, u16 vid
+ *		      const struct ndo_fdb_parms *parms,
  *		      bool *notified, struct netlink_ext_ack *extack);
- *	Deletes the FDB entry from dev corresponding to addr.
+ *	Deletes the FDB entry from parms->dev corresponding to parms->addr.
  *	Callee shall set *notified to true if it sent any appropriate
  *	notification(s). Otherwise core will send a generic one.
  * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
@@ -1614,17 +1626,12 @@ struct net_device_ops {
 
 	int			(*ndo_fdb_add)(struct ndmsg *ndm,
 					       struct nlattr *tb[],
-					       struct net_device *dev,
-					       const unsigned char *addr,
-					       u16 vid,
-					       u16 flags,
+					       const struct ndo_fdb_parms *parms,
 					       bool *notified,
 					       struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_del)(struct ndmsg *ndm,
 					       struct nlattr *tb[],
-					       struct net_device *dev,
-					       const unsigned char *addr,
-					       u16 vid,
+					       const struct ndo_fdb_parms *parms,
 					       bool *notified,
 					       struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_del_bulk)(struct nlmsghdr *nlh,
@@ -1637,9 +1644,8 @@ struct net_device_ops {
 						int *idx);
 	int			(*ndo_fdb_get)(struct sk_buff *skb,
 					       struct nlattr *tb[],
-					       struct net_device *dev,
-					       const unsigned char *addr,
-					       u16 vid, u32 portid, u32 seq,
+					       const struct ndo_fdb_parms *parms,
+					       u32 portid, u32 seq,
 					       struct netlink_ext_ack *extack);
 	int			(*ndo_mdb_add)(struct net_device *dev,
 					       struct nlattr *tb[],
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b601245ad923..8ed7af3e410d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1146,17 +1146,15 @@ int br_fdb_dump(struct sk_buff *skb,
 
 int br_fdb_get(struct sk_buff *skb,
 	       struct nlattr *tb[],
-	       struct net_device *dev,
-	       const unsigned char *addr,
-	       u16 vid, u32 portid, u32 seq,
+	       const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
 	       struct netlink_ext_ack *extack)
 {
-	struct net_bridge *br = netdev_priv(dev);
+	struct net_bridge *br = netdev_priv(parms->dev);
 	struct net_bridge_fdb_entry *f;
 	int err = 0;
 
 	rcu_read_lock();
-	f = br_fdb_find_rcu(br, addr, vid);
+	f = br_fdb_find_rcu(br, parms->addr, parms->vid);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1360,9 +1358,8 @@ static const struct nla_policy br_nda_fdb_pol[NFEA_MAX + 1] = {
 
 /* Add new permanent fdb entry with RTM_NEWNEIGH */
 int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
-	       struct net_device *dev,
-	       const unsigned char *addr, u16 vid, u16 nlh_flags,
-	       bool *notified, struct netlink_ext_ack *extack)
+	       const struct ndo_fdb_parms *parms, bool *notified,
+	       struct netlink_ext_ack *extack)
 {
 	struct nlattr *nfea_tb[NFEA_MAX + 1], *attr;
 	struct net_bridge_vlan_group *vg;
@@ -1372,26 +1369,27 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	u32 ext_flags = 0;
 	int err = 0;
 
-	trace_br_fdb_add(ndm, dev, addr, vid, nlh_flags);
+	trace_br_fdb_add(ndm, parms->dev, parms->addr, parms->vid,
+			 parms->flags);
 
 	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE))) {
 		pr_info("bridge: RTM_NEWNEIGH with invalid state %#x\n", ndm->ndm_state);
 		return -EINVAL;
 	}
 
-	if (is_zero_ether_addr(addr)) {
+	if (is_zero_ether_addr(parms->addr)) {
 		pr_info("bridge: RTM_NEWNEIGH with invalid ether address\n");
 		return -EINVAL;
 	}
 
-	if (netif_is_bridge_master(dev)) {
-		br = netdev_priv(dev);
+	if (netif_is_bridge_master(parms->dev)) {
+		br = netdev_priv(parms->dev);
 		vg = br_vlan_group(br);
 	} else {
-		p = br_port_get_rtnl(dev);
+		p = br_port_get_rtnl(parms->dev);
 		if (!p) {
 			pr_info("bridge: RTM_NEWNEIGH %s not a bridge port\n",
-				dev->name);
+				parms->dev->name);
 			return -EINVAL;
 		}
 		br = p->br;
@@ -1416,19 +1414,20 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		memset(nfea_tb, 0, sizeof(struct nlattr *) * (NFEA_MAX + 1));
 	}
 
-	if (vid) {
-		v = br_vlan_find(vg, vid);
+	if (parms->vid) {
+		v = br_vlan_find(vg, parms->vid);
 		if (!v || !br_vlan_should_use(v)) {
-			pr_info("bridge: RTM_NEWNEIGH with unconfigured vlan %d on %s\n", vid, dev->name);
+			pr_info("bridge: RTM_NEWNEIGH with unconfigured vlan %d on %s\n",
+				parms->vid, parms->dev->name);
 			return -EINVAL;
 		}
 
 		/* VID was specified, so use it. */
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v, nfea_tb,
-				   notified, extack);
+		err = __br_fdb_add(ndm, br, p, parms->addr, parms->flags, v,
+				   nfea_tb, notified, extack);
 	} else {
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, NULL, nfea_tb,
-				   notified, extack);
+		err = __br_fdb_add(ndm, br, p, parms->addr, parms->flags,
+				   NULL, nfea_tb, notified, extack);
 		if (err || !vg || !vg->num_vlans)
 			goto out;
 
@@ -1439,8 +1438,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v,
-					   nfea_tb, notified, extack);
+			err = __br_fdb_add(ndm, br, p, parms->addr,
+					   parms->flags, v, nfea_tb, notified,
+					   extack);
 			if (err)
 				goto out;
 		}
@@ -1481,8 +1481,7 @@ static int __br_fdb_delete(struct net_bridge *br,
 
 /* Remove neighbor entry with RTM_DELNEIGH */
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
-		  struct net_device *dev,
-		  const unsigned char *addr, u16 vid, bool *notified,
+		  const struct ndo_fdb_parms *parms, bool *notified,
 		  struct netlink_ext_ack *extack)
 {
 	struct net_bridge_vlan_group *vg;
@@ -1490,34 +1489,36 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge *br;
 	int err;
 
-	if (netif_is_bridge_master(dev)) {
-		br = netdev_priv(dev);
+	if (netif_is_bridge_master(parms->dev)) {
+		br = netdev_priv(parms->dev);
 		vg = br_vlan_group(br);
 	} else {
-		p = br_port_get_rtnl(dev);
+		p = br_port_get_rtnl(parms->dev);
 		if (!p) {
 			pr_info("bridge: RTM_DELNEIGH %s not a bridge port\n",
-				dev->name);
+				parms->dev->name);
 			return -EINVAL;
 		}
 		vg = nbp_vlan_group(p);
 		br = p->br;
 	}
 
-	if (vid) {
-		err = __br_fdb_delete(br, p, addr, vid, notified);
+	if (parms->vid) {
+		err = __br_fdb_delete(br, p, parms->addr, parms->vid,
+				      notified);
 	} else {
 		struct net_bridge_vlan *v;
 
 		err = -ENOENT;
-		err &= __br_fdb_delete(br, p, addr, 0, notified);
+		err &= __br_fdb_delete(br, p, parms->addr, 0, notified);
 		if (!vg || !vg->num_vlans)
 			return err;
 
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			err &= __br_fdb_delete(br, p, addr, v->vid, notified);
+			err &= __br_fdb_delete(br, p, parms->addr, v->vid,
+					       notified);
 		}
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c7..0062bbe94d1c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1015,17 +1015,17 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 		   unsigned long flags);
 
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
-		  struct net_device *dev, const unsigned char *addr, u16 vid,
-		  bool *notified, struct netlink_ext_ack *extack);
+		  const struct ndo_fdb_parms *parms, bool *notified,
+		  struct netlink_ext_ack *extack);
 int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack);
-int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
-	       const unsigned char *addr, u16 vid, u16 nlh_flags,
-	       bool *notified, struct netlink_ext_ack *extack);
+int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[],
+	       const struct ndo_fdb_parms *parms, bool *notified,
+	       struct netlink_ext_ack *extack);
 int br_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		struct net_device *dev, struct net_device *fdev, int *idx);
-int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
-	       const unsigned char *addr, u16 vid, u32 portid, u32 seq,
+int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[],
+	       const struct ndo_fdb_parms *parms, u32 portid, u32 seq,
 	       struct netlink_ext_ack *extack);
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e141340172ce..b1649f1cb33a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4814,6 +4814,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ndmsg *ndm;
 	struct nlattr *tb[NDA_MAX+1];
+	struct ndo_fdb_parms parms;
 	struct net_device *dev;
 	u8 *addr;
 	u16 vid;
@@ -4852,6 +4853,13 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	parms = (struct ndo_fdb_parms) {
+		.dev = dev,
+		.addr = addr,
+		.vid = vid,
+		.flags = nlh->nlmsg_flags,
+	};
+
 	err = -EOPNOTSUPP;
 
 	/* Support fdb on master device the net/bridge default case */
@@ -4861,8 +4869,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		const struct net_device_ops *ops = br_dev->netdev_ops;
 		bool notified = false;
 
-		err = ops->ndo_fdb_add(ndm, tb, dev, addr, vid,
-				       nlh->nlmsg_flags, &notified, extack);
+		err = ops->ndo_fdb_add(ndm, tb, &parms, &notified, extack);
 		if (err)
 			goto out;
 		else
@@ -4874,9 +4881,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		bool notified = false;
 
 		if (dev->netdev_ops->ndo_fdb_add)
-			err = dev->netdev_ops->ndo_fdb_add(ndm, tb, dev, addr,
-							   vid,
-							   nlh->nlmsg_flags,
+			err = dev->netdev_ops->ndo_fdb_add(ndm, tb, &parms,
 							   &notified, extack);
 		else
 			err = ndo_dflt_fdb_add(ndm, tb, dev, addr, vid,
@@ -4927,6 +4932,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct net_device_ops *ops;
 	struct ndmsg *ndm;
 	struct nlattr *tb[NDA_MAX+1];
+	struct ndo_fdb_parms parms;
 	struct net_device *dev;
 	__u8 *addr = NULL;
 	int err;
@@ -4966,6 +4972,12 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
 		if (err)
 			return err;
+
+		parms = (struct ndo_fdb_parms) {
+			.dev = dev,
+			.addr = addr,
+			.vid = vid,
+		};
 	}
 
 	if (dev->type != ARPHRD_ETHER) {
@@ -4984,7 +4996,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ops = br_dev->netdev_ops;
 		if (!del_bulk) {
 			if (ops->ndo_fdb_del)
-				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid,
+				err = ops->ndo_fdb_del(ndm, tb, &parms,
 						       &notified, extack);
 		} else {
 			if (ops->ndo_fdb_del_bulk)
@@ -5004,7 +5016,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ops = dev->netdev_ops;
 		if (!del_bulk) {
 			if (ops->ndo_fdb_del)
-				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid,
+				err = ops->ndo_fdb_del(ndm, tb, &parms,
 						       &notified, extack);
 			else
 				err = ndo_dflt_fdb_del(ndm, tb, dev, addr, vid);
@@ -5327,6 +5339,7 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	const struct net_device_ops *ops = NULL;
 	struct net *net = sock_net(in_skb->sk);
 	struct nlattr *tb[NDA_MAX + 1];
+	struct ndo_fdb_parms parms;
 	struct sk_buff *skb;
 	int brport_idx = 0;
 	u8 ndm_flags = 0;
@@ -5404,8 +5417,14 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	if (br_dev)
 		dev = br_dev;
-	err = ops->ndo_fdb_get(skb, tb, dev, addr, vid,
-			       NETLINK_CB(in_skb).portid,
+
+	parms = (struct ndo_fdb_parms) {
+		.dev = dev,
+		.addr = addr,
+		.vid = vid,
+	};
+
+	err = ops->ndo_fdb_get(skb, tb, &parms, NETLINK_CB(in_skb).portid,
 			       nlh->nlmsg_seq, extack);
 	if (err)
 		goto out;
-- 
2.56.1

