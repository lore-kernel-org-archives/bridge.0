Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652240098A
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756359; cv=fail; b=PZcnVRXt/7Dzb3HLoZsuNfc0NcxYjYeU9RpwxW/665Y05Slgj6PlrLBIkZDQsRX1QFGp0DRSVk1K9L3hIAZxftciqmXAEw2uOxHSXfdUsSBjnVJ5JHX5PBl1vZsyozkSyvhK317QPI+NwcavGzCHhw+JeMQsKy7zzM8Ogkgiwp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756359; c=relaxed/simple;
	bh=83MwDv0nWH8CHIwKB9Duachby2/ULdRktnNChBa5nCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGbFSK+iPD/tGjmqNdAGs2FLQtbHWgTa8FmVpUOBoPz8LIL9UgJjNmI+5GBcqK5m2dg5eq48PEk0kmhN6wOh7M4TJJPUSh+bcjSdgtgbqMvD9nuhMf9iI/+B0kiGFVv69RxMrLlrAVS23rR1ccMGpf2AWfnpG6D5plcj3S6JKw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/W6pea0; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/W6pea0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSsl7eiVK2LQ5IKhIyh/faJkBY9NegCGo59Nd+YIAKhi/zZ6Hj4EBRPeGa/7nXup5/A3iWPoMhEtEPiQAD4SMDUl3jY0ow8BNd6CtYribS+p9jaVeLn7VYu3twf1wSrWdGE8jKkIUhXFfljaldeMyGVeg/K7DKrTdiVhflY0NhLxBClduQikbRvrPwz43ucUAIoee9ZEaABHQYTe9NE4xxe7FWrce0vb4f2lEttdtBuXdYXBOcIFfeAO+YykSG9Ti7YcLc4KMTM/UW6ZDjEV8QVKtqF78LWCfrYFDGUx2nSKRARY1HRKgh8Pa0MaYzK/bSRdNgkDoET/zLtWp2+E5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXmOSz6Ur7jkTUHVZ47kDsNsZULxtmyOw0XVN1hN8f4=;
 b=gcQOgUpFqh0DWf/ZIDzBa8YjcjBWJMwfqZD8HRMmCOy5jsmXM4XnTi5xMWr852V77uC0G+GMe0aA+uelmGBGKAl+Ae6XDWrMDjENqGLIogbYj7AuigzjHJyidBya71l8RKWNlzQCaGucTAX+O3TdJhX0KfPC2gSULfr0TP9Qf+ay+thTIiXnvdpebIwZs3X0EUf7zBdgTfQtuRA0Yd6MhBMvNNQjTVb/hv9WW5ShXUO5vN7X65uykxDGsksa1JlMVIX+7YKETY6yiTTkMYvk+p8rox9TKB31hDjB3+VSEXsX8tIh+bIZFkmMxm5Srs9SJs2wAciNpOArpJQqncYXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXmOSz6Ur7jkTUHVZ47kDsNsZULxtmyOw0XVN1hN8f4=;
 b=O/W6pea0B+uJ2hw3lJR9Pi12xB9ZOJjspB0sr0W3Z7GekDkMdcUPlf3b6J07ciO+lVjlC8DJ0g781wgRbFjJEHCbiYDNc8g2HQFmpb4BIz2Cp7C180zD80D6WAmvZLq8eYgJIYBydQj+aJYFOo8KWnTYaQkwji54MYWOW8eNIem9N76wz1tjhlwmHoZCsKYNfPUrv6ekJGTX3Pj/zzjCtHqSnv8/sW8lF88mY5MJOZ9CQSA/Z/vLz+72u45d10j/wsEKrhxQDtWKMdcr7SN43XeU87E6OWib3BsxOApTwZUsU3F59cnz7PseG9BPEUMisNxFuLP6Xu8nvjt4DPJKHw==
Received: from BN0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:408:141::27)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Mon, 3 Aug
 2026 11:25:48 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::a) by BN0PR07CA0028.outlook.office365.com
 (2603:10b6:408:141::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 11:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:25:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 04:25:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:28 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 2/5] ipv6: ndisc: Add ndisc_check_ns_na() validation helper
Date: Mon, 3 Aug 2026 14:25:02 +0300
Message-ID: <20260803112505.613873-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803112505.613873-1-danieller@nvidia.com>
References: <20260803112505.613873-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 862d7fb4-00f8-4a13-07f0-08def151f7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|10067099003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Jago7OUvGFM00bKdEyKMIgPyvi06QN2Vko6yX7ESCJLIUvponXO8CFZz025FOQvYfyG8QVXgJqOMDtaYxoeIbUAnnT4jyaxTeQHlLAShb0V/E4x+cGt2TTazwix2GO71XqpXl8pXGw2efbsTewnVYbOOamkj6U1U2Gz/7KleyDfuv9EoMVe4EF0ey06+qC1tgnBCvxpjTIWmO4GjNfc4fMxrdAPYx/anCcFbF7wyvtCVKJ41yRfM472DttyXA122Sh8Xk0NyJJtU2qIjrlIOmdhNcUG93rtIqrVfOIKLEPqCEYo9zb1O9NbF4ggqxLlXvh0JBNK1j6a0qDf9aWvByGynH8fBsR9nN7IdNa9SP6v/N124FApLOyyA70C5smCKRomfTMzsoYzN1dhKcTjKJuIyU/XvOXPVcmZ67/ZmdVV9L+DO7IqhTP1vGxb3RBp+VlzoVapG2OSta92RwWu5g9r6WN8tDusO7qyN4bPGzY2NtMbUNET/j0TbIcDgWlVeyqg9S4fU/PEvrTfqJFBUSbuWZEPO3+UnvMNU6TTqrKtBz+ua6P22DYJU3ZgLoYFB+/YCi+il06FI0ttx10fOLNg7bm85F/H+NsCks1hbVKLrWssGqT2S3NZJMGZWyS0un7eIEV5HC7MS1DBy9x6WI2ixqFhGSN4oML5LqksJG7q6ONC3M8UoOdXoFrImFPCjpzC78CtpKwlcw5gXa3rUfQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cTKVC47sPIPK8a/3akYyJajTmFw3PeX5cb5txX0Pdcs5rnGAMhMy/n0imTXV17eGabRZHvUQyFQuqA58VJQKbC42kHPAadKjs/0csPHpeqP16W59QwZ1OTCjowFJ7itiAQspMo3g5q786g5QyWTogdG0f+aPoFDDt2dsovMzKTWBGMtiAF9wlmy+gyNT7aQhZiiqp/ctYxjkRS1MRx4H3NYrmrgQZtJmFxcObvUK0W4PwtpcLYnHGe5rIR+lb9QljtliWgvcDyyzV/9g2Hvjnz8Ei997y8stL8swcDCRgsb1u0mww8U4gAnh66qU1ajfIZGJo9cub+g6MH9fwF7pV+lL4qcM7kBUOCAHHBLF3GQNDW/4rOyshWyMK8RcO/sM3Se8/dBbpr8aTz8sp2oyh87m/N47Pfpveb/z6JeuUAcZ12xg4F4QftrtsAUFzlgb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:25:48.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862d7fb4-00f8-4a13-07f0-08def151f7ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Use EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL() to export
    	  ndisc_check_ns_na().

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
index 000000000000..fa86528d5cfe
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
+EXPORT_SYMBOL_GPL(ndisc_check_ns_na);
-- 
2.54.0

