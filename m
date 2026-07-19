Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55752673B0
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468145; cv=fail; b=SYT3j1mAwapFkTX3wxMstttTyFk3CXfN/BQCvn0ziqT+5Cht7v51GOF3XdFBRkqglok2U7apBdcYWMPRVSTSXYwF+wwEjFFfsihaGwKBUmj+ihcOr+Z8ozNeDyq8EByCnQK0aVO1itGdfYP0EPWVh0t3KxCoTe6Qgc+0yT0Kf00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468145; c=relaxed/simple;
	bh=DNY7sFNO5BEtjcQcjRRDaNTfSlpsMejptcNJRMmNc9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE4UNfkPAsnQje9+0wGi/tJyzhX6ZslOyVj5Zlo5s2NUFCFuJb00fVlTxCHSs/IU3ZIgZyb1HwCufwVY8sZ9HXKmlGQOVdxXRduhL+GMtVLhNCn1GLbrVuhmyBoT+AoyECxDCds57VQ1SOyDjWbYMBwpb4Ki1OLFt9jdx210+aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6JM/2Wq; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6JM/2Wq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgvkty/uwi50QRgkoRyKqtsGflrt7uQ58s5nFabGDLPiYijtVFJvn6VcTgoa1COEyf8vCAjKk0nPfNFYfKD9dNomDLIR6Sr/PQPi5zv8iD+KT4SN997S4OUOTAJK0y3+9HvzcGszs84CRWZtMhQKZmMuH/ncqpA4w/iA3ncw1LktMOOUDFMx/KlG78sh0CsBNo2txIHyMZKp1R2nXQ3OBb4E5ESYg6szfCm6wIG8hZZ0wNSYIJUcDdfcHJ0Njp0p47ZyXP861H2XVYdUtorqI48DAM0wYky2v9wLyb0oBidprQD9cpHKjGIQitqV0WR+O4YHGPhd6kK+hNmtxyDjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpz+3c2YVt+4FGb/Hatv1W2zUAWmS6B/G1JFZPp4lXs=;
 b=SkgM0J9mfs57sRParLmALI9svBl8s77lLBNSg+AaTBrv+kJmIa17dxAGm/CTBIRklJO2rpXST3OXW/hFfxeE1/Tpzz+n7vma4643CFmTwdo1FWtrYmzABqEah2a5fcLNQyS9eRNh2R5hFyei4YAgEVtXpNOXg8TcTyg1ZazWRpBUXu4z/F4baWxUPP4lcGWnBFxKzrXlj8odvVYvlTuq8SgTBE62NlflJ19Ce3KZl0UG5sFhflY6Qvx6PjsYlFoUXrzQe4YnEyZDOwvrAUnjfPkzhN1fx+KUAnmVPHkpYsRYnhrqUKpPk97ScKdvFqCUq2cpTG6+l5kaAnJcacX20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpz+3c2YVt+4FGb/Hatv1W2zUAWmS6B/G1JFZPp4lXs=;
 b=s6JM/2WqMaXdxwIsp5YkF8FVj/uzughGTP88wSBaQ6VcC0q9cqbbSA9/3e1bdtPFAOxDirdm441RKmWvIHr3xUNSvZlNTFm0CXAOTrJHKSN5OScXjLYwIDVrHx5ovPO1jR5pIkfSFog21E+OSkoh08dB1DRSbsbBAthAMb7kqZF4+olybVblXpGpDvxAbXOenTKEkQsg9e3rpYxUWGqUP7lh5sEERMJZCuam1WzdVHfnfvdWJG8xXWUz1Xei4U8/8lxTXY5Sv066pRmRYL+yGiTwNKlAEv7laoMRyabG3SK7uDVj7kcB97TLUUOHg2vn4MvxShbrjCqbkcSP8MA6Yg==
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sun, 19 Jul
 2026 13:35:36 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::83) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Jul
 2026 06:35:22 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:18 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 2/5] ipv6: ndisc: Add ndisc_check_ns_na() validation helper
Date: Sun, 19 Jul 2026 16:34:52 +0300
Message-ID: <c7f894446494462bd72f717021aa4b6373f31131.1784463131.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4351d7c8-84b7-42e2-970c-08dee59a9d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8m0FEvE4B2fA4fFuojZEmbL4F7td02sxiinBsOckUOvMShZBzC8458eZxS3T/zWBh7/6yi/R+R3JyEX3U/uoa60EuavBtjk5otSBkgpN/ZOeOWGRJWoY4GVg661bQqIjsFD4UvtjZFdd9g4gzm+RLaawvDDgRPh9uh40dQ4CMEDipRQMcgATm4ojrFd2f3Xe6bzAefosP9rRzP5smHbVhawcKeI7glLbmxMItH4pRGPx+phQWWKZRVxzRE4JoLBibq2a79TKdvrdjR824ZA237KQskf+LL7cJH05+3L+njLlNT/RcPoLaRVz4gZNmS2GeOF17X0rvm/iahf2Y8YHUeQ/3E57suiFbPNxk67l6cy261/rULPdGswFXO2XG5AGS/Y+yAjK8ivIYkTgIAaSR77meL3t5tiWi31VK0Ukazhx/pJ+1lLUd6EDB5psTjycv77ptPdVnRyhQOqjxry3iNSBd2bbRGSducdPUhW7SO59n9VNGr9fgVetdZ1eovZP4c9X7eSLktR+x+LnAZADPFNDDvcnpwI9VQ3xmWvbGszkRqC+T9iu97fUiQVjgPR/bZjHcdEhyAm4p/Pl0J5W5010AlCIv5ADLn1KJ6jE5dWYaGkaBobfmYin0QH/psL1DPVW2vkMro5aKKt2wgvsRCd8jnUgIzbBkKngnUyv675CUCqmdizIZvrDS74jSQTmtZy8U7dVLRh+0PKz5pO3aw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IyfL/EnFR58FigtiSzzDBIQZavg/LsjHxtmyHr+Le8+GpXIxuZV3/jbnj+F4DpFLHEOIA+k5O4FUTUVyBB3eTk0QNR3t80eKrKLMsZO0ikFr//TATR5s7ZWsWxW+r8USc/ZMHQc598bFtS4dc3X8zVBNwX1SOGmk6HguAVpD9XhGbguOmZc0+//hF74GKrL4LRy2p+4Iu8luy2HvPXt3OsdzKUyfc6Wc0wBqrFQN0F3RQS722H+ExpwdediQCahAPCRDqE3LWXzRr6XrU0gDFyKtmuLbrLLs8kDnlL57ug2ai0Yxy//Cw+mW3LemKaE9WiBUtC16zmrs/JniEsLKv72GDb0zXWK7lOPhyMozpIRje2dbgI2XsRhcO59z7g45FNcTUVbcTPQnh+oKIPzgNSY5irw1Pvl1x5FsvIUpfLNSBYcpzaIOn9+qpImm8mUP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:36.2139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351d7c8-84b7-42e2-970c-08dee59a9d83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733

Add ndisc_check_ns_na(), a standalone NS/NA packet validator modeled
after ipv6_mc_check_mld(). It performs the RFC 4861 section 7.1.1
(Neighbor Solicitation) and 7.1.2 (Neighbor Advertisement) mandatory
checks that are relevant for software operating at the bridge level,
where packets bypass the normal IPv6 stack path:

 - Hop Limit must be 255 (packet was not forwarded by a router)
 - ICMPv6 checksum is valid
 - ICMP Code is 0
 - ICMP length is at least 24 octets (sizeof(struct nd_msg))
 - Target Address must not be a multicast address
 - All included options have a length that is greater than zero
 - NS/DAD: destination must be a solicited-node multicast address
 - NS/DAD: no Source Link-Layer Address option when source is unspecified
 - NA: Solicited flag must be 0 when IP Destination is multicast

On success the function sets the skb transport header and returns 0,
matching the convention of ipv6_mc_check_mld().

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 include/net/ndisc.h    |   2 +
 net/ipv6/Makefile      |   2 +-
 net/ipv6/ndisc_snoop.c | 190 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 net/ipv6/ndisc_snoop.c

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 3da1a6f8d3f9..9e5379ad2d8e 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -430,6 +430,8 @@ void ndisc_update(const struct net_device *dev, struct neighbour *neigh,
 		  const u8 *lladdr, u8 new, u32 flags, u8 icmp6_type,
 		  struct ndisc_options *ndopts);
 
+int ndisc_check_ns_na(struct sk_buff *skb);
+
 /*
  *	IGMP
  */
diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
index 5b0cd6488021..cf5e01f83ce3 100644
--- a/net/ipv6/Makefile
+++ b/net/ipv6/Makefile
@@ -51,7 +51,7 @@ obj-$(subst m,y,$(CONFIG_IPV6)) += inet6_hashtables.o
 
 ifneq ($(CONFIG_IPV6),)
 obj-$(CONFIG_NET_UDP_TUNNEL) += ip6_udp_tunnel.o
-obj-y += mcast_snoop.o
+obj-y += mcast_snoop.o ndisc_snoop.o
 obj-$(CONFIG_TCP_AO) += tcp_ao.o
 endif
 
diff --git a/net/ipv6/ndisc_snoop.c b/net/ipv6/ndisc_snoop.c
new file mode 100644
index 000000000000..a93eed27a1f6
--- /dev/null
+++ b/net/ipv6/ndisc_snoop.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/skbuff.h>
+#include <net/addrconf.h>
+#include <net/ip6_checksum.h>
+#include <net/ipv6.h>
+#include <net/ndisc.h>
+
+static int ndisc_check_ip6hdr(struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6h;
+	unsigned int offset, len;
+
+	offset = skb_network_offset(skb) + sizeof(*ip6h);
+	if (!pskb_may_pull(skb, offset))
+		return -EINVAL;
+
+	ip6h = ipv6_hdr(skb);
+
+	if (ip6h->version != 6)
+		return -EINVAL;
+
+	if (ip6h->nexthdr != IPPROTO_ICMPV6)
+		return -ENOMSG;
+
+	/* RFC 4861 7.1.1 / 7.1.2: must not have been forwarded by a router */
+	if (ip6h->hop_limit != 255)
+		return -EINVAL;
+
+	len = offset + ntohs(ip6h->payload_len);
+	if (skb->len < len || len <= offset)
+		return -EINVAL;
+
+	skb_set_transport_header(skb, offset);
+
+	return 0;
+}
+
+static __sum16 ndisc_validate_checksum(struct sk_buff *skb)
+{
+	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
+}
+
+static int ndisc_check_icmpv6(struct sk_buff *skb)
+{
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	unsigned int transport_len = ipv6_transport_len(skb);
+	struct sk_buff *skb_chk;
+	struct icmp6hdr *hdr;
+
+	if (!pskb_may_pull(skb, len))
+		return -EINVAL;
+
+	/* RFC 4861 7.1.1 / 7.1.2: the ICMPv6 checksum must be valid */
+	skb_chk = skb_checksum_trimmed(skb, transport_len,
+				       ndisc_validate_checksum);
+	if (!skb_chk)
+		return -EINVAL;
+
+	if (skb_chk != skb)
+		kfree_skb(skb_chk);
+
+	/* RFC 4861 7.1.1 / 7.1.2: Code must be 0 */
+	hdr = (struct icmp6hdr *)skb_transport_header(skb);
+	if (hdr->icmp6_code != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ndisc_check_options(struct sk_buff *skb, unsigned int opts_len,
+			       bool reject_slla)
+{
+	unsigned int offset = skb_transport_offset(skb) + sizeof(struct nd_msg);
+	struct nd_opt_hdr *opt, _opt;
+
+	while (opts_len > 0) {
+		if (opts_len < sizeof(*opt))
+			return -EINVAL;
+
+		opt = skb_header_pointer(skb, offset, sizeof(_opt), &_opt);
+		if (!opt)
+			return -EINVAL;
+
+		/* RFC 4861 7.1.1 / 7.1.2: all option lengths must be > 0 */
+		if (!opt->nd_opt_len)
+			return -EINVAL;
+
+		/* RFC 4861 7.1.1: DAD NS must not contain a source link-layer
+		 * address option
+		 */
+		if (reject_slla && opt->nd_opt_type == ND_OPT_SOURCE_LL_ADDR)
+			return -EINVAL;
+
+		if (opt->nd_opt_len * 8 > opts_len)
+			return -EINVAL;
+
+		offset += opt->nd_opt_len * 8;
+		opts_len -= opt->nd_opt_len * 8;
+	}
+
+	return 0;
+}
+
+static int ndisc_check_nd_msg(struct sk_buff *skb)
+{
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct nd_msg);
+	unsigned int transport_len = ipv6_transport_len(skb);
+	bool reject_slla = false;
+	const struct nd_msg *msg;
+
+	if (!pskb_may_pull(skb, len))
+		return -EINVAL;
+
+	/* RFC 4861 7.1.1 / 7.1.2: ICMP length is at least sizeof(nd_msg) */
+	if (transport_len < sizeof(struct nd_msg))
+		return -EINVAL;
+
+	msg = (struct nd_msg *)skb_transport_header(skb);
+
+	/* RFC 4861 7.1.1 / 7.1.2: Target Address must not be a
+	 * multicast address
+	 */
+	if (ipv6_addr_is_multicast(&msg->target))
+		return -EINVAL;
+
+	switch (msg->icmph.icmp6_type) {
+	case NDISC_NEIGHBOUR_SOLICITATION:
+		if (ipv6_addr_any(&ipv6_hdr(skb)->saddr)) {
+			/* RFC 4861 7.1.1: DAD NS destination must be a
+			 * solicited-node multicast address
+			 */
+			if (!ipv6_addr_is_solict_mult(&ipv6_hdr(skb)->daddr))
+				return -EINVAL;
+			/* RFC 4861 7.1.1: DAD NS must not contain a source
+			 * link-layer address option
+			 */
+			reject_slla = true;
+		}
+		break;
+	case NDISC_NEIGHBOUR_ADVERTISEMENT:
+		/* RFC 4861 7.1.2: Solicited flag must be 0 for
+		 * multicast destinations
+		 */
+		if (ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) &&
+		    msg->icmph.icmp6_solicited)
+			return -EINVAL;
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	return ndisc_check_options(skb, transport_len - sizeof(struct nd_msg),
+				   reject_slla);
+}
+
+/**
+ * ndisc_check_ns_na - validate an NS/NA packet and set its transport header
+ * @skb: the skb to validate
+ *
+ * Validates an IPv6 packet for compliance with RFC 4861 sections 7.1.1
+ * (Neighbor Solicitation) and 7.1.2 (Neighbor Advertisement). If valid,
+ * sets the skb transport header.
+ *
+ * Caller needs to set the skb network header.
+ *
+ * Return:
+ * * 0        - valid NS/NA; the skb transport header has been set.
+ * * -EINVAL  - a broken packet was detected, i.e. it violates some
+ *              internet standard.
+ * * -ENOMSG  - IP header validation succeeded but it is not an ICMPv6
+ *              packet.
+ * * -ENODATA - IP+ICMPv6 header validation succeeded but it is not a
+ *              Neighbor Solicitation or Neighbor Advertisement.
+ */
+int ndisc_check_ns_na(struct sk_buff *skb)
+{
+	int ret;
+
+	ret = ndisc_check_ip6hdr(skb);
+	if (ret < 0)
+		return ret;
+
+	ret = ndisc_check_icmpv6(skb);
+	if (ret < 0)
+		return ret;
+
+	return ndisc_check_nd_msg(skb);
+}
+EXPORT_SYMBOL(ndisc_check_ns_na);
-- 
2.54.0

