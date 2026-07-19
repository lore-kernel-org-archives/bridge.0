Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1525E469
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468152; cv=fail; b=n+HhTyvzx+bdWG5OSKZeWEOrxkOcUg+nM52LQpYooHmRWKOJDqt/6ohpshkjccNhBABFd2S9c+55tprdZSWG6IYLYl8gWis1AK2ZoM5JcGvzW57oUC3iY35lcOr/XB23iChDUaaBg3Bns6YFYkMljYl57/RCa0dOiCJjVKiuwO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468152; c=relaxed/simple;
	bh=pjTng4NxRUecWBbCK062TptorfY95SyyKaJ2GqKgYP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoTJShdTR7vyOFmG9aqjgpom02caTpQ/9DdmJu9OUxKuajO1G6NfiLzNeEeNb7qYgP2abhoMmSQacGo9MSDy/jBA674/v6nqyuAepXa8KtSjqzfDkJlfkbkpfqzRby/HG5pX8OZwmKaEqfkWKFQXZSiMVxdWty2igFOYonfckQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZvL2sojY; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZvL2sojY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuILuwjO/eR37RggA4/7QhmEvVnazDyY7TRFzHtzP5jrJZwvvXtzMDDZvBXPEYeMh8bTVH7/FE1N7aEtw1hAN5To1HuPx2Vcc5O4zfY3gn2DOBL/D2buq4A0kRXMirlRr7gC7GTQ4YTKaUr7hBrz16NBW2+/zChQWr6HfAGuDmhvRjIItDWTTibAHKBjTUSFtG8KW8CO+FC+44a61K5i3J+nfbLnbLQWP0ZhyLP5jFu7TTTP2azqV34CZEu90pXyJQUx7+B9wxbr89O3mrm+L+LbhSVGMukPZYZHeFN1SbFVBWKZHjYQVyDCMAPBGW66puvwR43by1JsqTRR/m8+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V//h+8E0urO2Spfg/tqjEEC0CFHZhn9AfZtmQHo7swk=;
 b=wpkFasyJ7mLMyFK7Tabncc/Ly/q8vaSDJzcA/DJYVnEoSy+nrEMpfJDkxYsoIbcz8+Tgy2vV3ns+xxWiqn2Wlm6sVZthXxv3/6lwJZH+2oYxk8z1i/MeXrFlbvBxJSpMseyT4L7rrhiotIeK2+w8c1DxAIGbHg1t797DZ9KQiM0wMGCkMMTsZCeqQLiyu8SihHmAtXCuxPv+9k+9CEI8uihUVy6/X0N+PYF9AnSClB/NthMdpUP84AXXxPfAFFnH99Sz5rgCoaaDmbG3ivfPVd3AFHFx/NozXwycIRhuD1KRImfvsOrx9/n6RRU6FwKtgiVoo/aY+xQfoNgYyaRqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V//h+8E0urO2Spfg/tqjEEC0CFHZhn9AfZtmQHo7swk=;
 b=ZvL2sojYxaUu2kixcFx+wj5aF8vLOKpJCVxKNjVOuYSW/JRcny6Gd7POKpPSw+G0LDnF4RDbGfvl7M/Oz5RmdTfuUcoD63BE5GlnStRGFWe6iAWmpwyvpQ8B5t6uhRpYnNB4I4MD2FuUzGvYr3xEToXjSzCBI/n/T3B7onli+5N/9sLGrTu+koY2u1Ij35UQGACDYUy+4dC6vBsaR8vS3vmk/3emKb4+QGLu3rFLMLNhIqnT2YybvoIhUbRLaBgosRk9f5DwPBLcvko1xgjEyvND3slloGEQ7OLQ0jF596qO8j269BZnRAWdkOxHTI3E5dR3e3K8RXjpLtAVb3bO5w==
Received: from PH2PEPF0000385A.namprd17.prod.outlook.com (2603:10b6:518:1::7c)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 13:35:45 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH2PEPF0000385A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Jul
 2026 06:35:31 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:27 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 4/5] bridge: Linearize skb once the ND message type is validated
Date: Sun, 19 Jul 2026 16:34:54 +0300
Message-ID: <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784463131.git.danieller@nvidia.com>
References: <cover.1784463131.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 244bb362-5727-496d-62ff-08dee59aa2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	neJHm13xw1f6fkJ20/pFGGfBtaxJZR+Y7tp7NfokUoYkDMtPeVJPC25XEJUQnvZOGkXLx3/rI7K1Sk2aCuWVx4yNmafyKlReSnkoOtS9ARO3OVZPnFKEb8NLRSHAKYmnI+rM0zNcgknWazgZqTYywWYNd7AlKIueN1NRmGVA3lqFjX6JMTVjYNmWHXm/lnYnim/uqIgkV4DDFkfKiwF9hJ4ToEvddAjsVTpXDBOU8wKCecrHgsoXztC4MOIgQbRDivZEFDH93Bpxy+boEHAQw3Ho+NHYRBEsUE5TQP2/edqfkgbdwyIaGtPlN/KvVT0Obn8iq6Qi/6oXd2IR72GSJBX8ZLfu6Bprn+Ee4w8o8FWwM9ICYJUqgW5xfUUyIxDJRe8uGoDQ9TzMyvmKqV7zRRoiLYoqcAyPdPh+d7ivXYwWE0v8xi68955is25el4vo8DyRTbwNNo1mSV91+kuQpJhA8STFUhNN4atKkQQ3aAL2Q5WJkAefIQsDg4wim7fXLJMxFGUW1Tvp1pBOZ2vBNDafNCWtbI0J63Kf2ELJzJn+3+nXsS6Uj+xI0jcYD3W/+enKizZ+ICYVuEwqZe579oY56Xgsxrw4siXoJ6idh8gVAc93C02t5I3UNHhcw5acdQ9PgjivDhKc8jwWMhtgqUmPmlr2FTViJhw4MBDZbiktXOG5GjCiUPAThW2tSGQk60n5pFFqTO+Oaj74lnFReg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MEsJOJUlphmvXx7KPkoAHu+bSkOSIwj6PikFYp3mjPaEGWfRzRZgmp0CXSNYtK22hf3EwBQH+wpQZRxNx99OS4Xb/0tO7b7ckc5Hda8b7VaXPGn36si/MGbaTRPD0RyJpkUEX14HadHrqSrxwdZM9wkFq0hWGEwhN3t3zndhmJ32+3Sl2r9NksWg6aQ+AI+k9j0RXx3TJ6diwGPQJ3bKE8ezZUpaI7/B7nCV3L3VTI7anuS5nK7J0LtS2z+6otbDAAhp6cE872Zl2ZWBPzVXbd8WA5fbMmE7hgmZ3HmekMNgV/+lciCgbHmDT8lq8hi7WbKspb3HzwSdmwRgO7wRJVbA+vMjMlfg4ggxpR9RbpBYBOAqJ0UekixPQhfW5t6tdfGFw4N0dkO7x+cj99Z0Sfp+r5ySIo2P5dKlqiMiQyzNjnG+JXkqbhwT9ag0dIc3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:45.3024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244bb362-5727-496d-62ff-08dee59aa2ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949

br_nd_send() parses ND options from ns->opt[] and therefore needs the skb
to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize skb
before parsing ND options") ensured that by linearizing inside
br_nd_send() itself.

Move the linearization up into br_is_nd_neigh_msg(), right after
ndisc_check_ns_na() has validated the message as an NS/NA. This makes a
linear buffer a property of every recognized ND message, so that this and
any future ND message handling operate on a linear skb and cannot
reintroduce that class of bug by forgetting to linearize.

Since the skb is now linear by the time br_nd_send() runs, drop the
linearization there and derive ns from the transport header set by
ndisc_check_ns_na(), instead of recomputing it from the network header.

If linearization fails under memory pressure, br_is_nd_neigh_msg() returns
NULL and the packet falls back to normal forwarding rather than being
suppressed.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 445c930ed59b..46779d9fad61 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -240,6 +240,9 @@ struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
 	if (ndisc_check_ns_na(skb))
 		return NULL;
 
+	if (skb_linearize(skb))
+		return NULL;
+
 	return (struct nd_msg *)skb_transport_header(skb);
 }
 
@@ -259,7 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	bool dad;
 	u16 pvid;
 
-	if (!dev || skb_linearize(request))
+	if (!dev)
 		return;
 
 	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
@@ -276,8 +279,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	skb_set_mac_header(reply, 0);
 
 	daddr = eth_hdr(request)->h_source;
-	ns = (struct nd_msg *)(skb_network_header(request) +
-			       sizeof(struct ipv6hdr));
+	ns = (struct nd_msg *)skb_transport_header(request);
 
 	/* Do we need option processing ? */
 	ns_olen = request->len - (skb_network_offset(request) +
-- 
2.54.0

