Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1545405325; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=/Ug0rn2mSzhSVcrGieA3FkgIo5XxIlnOYm88mAmvaqM=;
	b=ERzX9Ip2wBAG5swHUCW1S3a0D6S03rnvU7eGSgIln1inOySbx9/TU4zkmQQOc7QCvwhfrr
	KeeuT7QjscTuRGbnKatA/GtcrLnpHxDeeK//PV+pKpeFYihiYtBMsr9SR5hpgxx7U9zMS0
	aTFybqh/kGKvf4Uf0QAruhKaDy+foT1jeJrN+IBflYCONsqPy7FMj+FJT0ULz9LWtFLI2G
	1iXm+qT+IDqoY0qVNaHXWPkyy/IST2nIAJ6KWc8vtpq0V6wnz/+zenQTxzkqkJopVIf7K4
	jsqRqxb44WqVvfCQ2keN7MCuFvkie+pAG8lo8LIG3vXC3k3vsQDvxKFbrzY4hg==
Date: Fri, 21 Dec 2018 16:15:09 +0100
Message-Id: <20181221151511.14923-3-linus.luessing@c0d3.blue>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/4] bridge: simplify ip_mc_check_igmp()
	and ipv6_mc_check_mld() internals
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S . Miller" <davem@davemloft.net>

With this patch the internal use of the skb_trimmed is reduced to
the ICMPv6/IGMP checksum verification. And for the length checks
the newly introduced helper functions are used instead of calculating
and checking with skb->len directly.

These changes should hopefully make it easier to verify that length
checks are performed properly.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/ipv4/igmp.c        | 51 ++++++++++++++++++-----------------------
 net/ipv6/mcast_snoop.c | 62 ++++++++++++++++++++++++--------------------------
 2 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b1f6d93282d7..a40e48ded10d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1493,22 +1493,22 @@ static int ip_mc_check_igmp_reportv3(struct sk_buff *skb)
 
 	len += sizeof(struct igmpv3_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ip_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ip_mc_check_igmp_query(struct sk_buff *skb)
 {
-	unsigned int len = skb_transport_offset(skb);
-
-	len += sizeof(struct igmphdr);
-	if (skb->len < len)
-		return -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	unsigned int len;
 
 	/* IGMPv{1,2}? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct igmphdr)) {
 		/* or IGMPv3? */
-		len += sizeof(struct igmpv3_query) - sizeof(struct igmphdr);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct igmpv3_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct igmpv3_query);
+		if (!ip_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -1544,35 +1544,24 @@ static inline __sum16 ip_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_simple_validate(skb);
 }
 
-static int __ip_mc_check_igmp(struct sk_buff *skb)
-
+static int ip_mc_check_igmp_csum(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk;
-	unsigned int transport_len;
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
-	int ret = -EINVAL;
+	unsigned int transport_len = ip_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
+	if (!ip_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ip_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ip_mc_check_igmp_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1600,7 +1589,11 @@ int ip_mc_check_igmp(struct sk_buff *skb)
 	if (ip_hdr(skb)->protocol != IPPROTO_IGMP)
 		return -ENOMSG;
 
-	return __ip_mc_check_igmp(skb);
+	ret = ip_mc_check_igmp_csum(skb);
+	if (ret < 0)
+		return ret;
+
+	return ip_mc_check_igmp_msg(skb);
 }
 EXPORT_SYMBOL(ip_mc_check_igmp);
 
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index 1a917dc80d5e..a72ddfc40eb3 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -77,27 +77,27 @@ static int ipv6_mc_check_mld_reportv2(struct sk_buff *skb)
 
 	len += sizeof(struct mld2_report);
 
-	return pskb_may_pull(skb, len) ? 0 : -EINVAL;
+	return ipv6_mc_may_pull(skb, len) ? 0 : -EINVAL;
 }
 
 static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 {
+	unsigned int transport_len = ipv6_transport_len(skb);
 	struct mld_msg *mld;
-	unsigned int len = skb_transport_offset(skb);
+	unsigned int len;
 
 	/* RFC2710+RFC3810 (MLDv1+MLDv2) require link-local source addresses */
 	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL))
 		return -EINVAL;
 
-	len += sizeof(struct mld_msg);
-	if (skb->len < len)
-		return -EINVAL;
-
 	/* MLDv1? */
-	if (skb->len != len) {
+	if (transport_len != sizeof(struct mld_msg)) {
 		/* or MLDv2? */
-		len += sizeof(struct mld2_query) - sizeof(struct mld_msg);
-		if (skb->len < len || !pskb_may_pull(skb, len))
+		if (transport_len < sizeof(struct mld2_query))
+			return -EINVAL;
+
+		len = skb_transport_offset(skb) + sizeof(struct mld2_query);
+		if (!ipv6_mc_may_pull(skb, len))
 			return -EINVAL;
 	}
 
@@ -115,7 +115,13 @@ static int ipv6_mc_check_mld_query(struct sk_buff *skb)
 
 static int ipv6_mc_check_mld_msg(struct sk_buff *skb)
 {
-	struct mld_msg *mld = (struct mld_msg *)skb_transport_header(skb);
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
+	struct mld_msg *mld;
+
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
+
+	mld = (struct mld_msg *)skb_transport_header(skb);
 
 	switch (mld->mld_type) {
 	case ICMPV6_MGM_REDUCTION:
@@ -136,36 +142,24 @@ static inline __sum16 ipv6_mc_validate_checksum(struct sk_buff *skb)
 	return skb_checksum_validate(skb, IPPROTO_ICMPV6, ip6_compute_pseudo);
 }
 
-static int __ipv6_mc_check_mld(struct sk_buff *skb)
-
+static int ipv6_mc_check_icmpv6(struct sk_buff *skb)
 {
-	struct sk_buff *skb_chk = NULL;
-	unsigned int transport_len;
-	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
-	int ret = -EINVAL;
+	unsigned int len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	unsigned int transport_len = ipv6_transport_len(skb);
+	struct sk_buff *skb_chk;
 
-	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
-	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
+	if (!ipv6_mc_may_pull(skb, len))
+		return -EINVAL;
 
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ipv6_mc_validate_checksum);
 	if (!skb_chk)
-		goto err;
+		return -EINVAL;
 
-	if (!pskb_may_pull(skb_chk, len))
-		goto err;
-
-	ret = ipv6_mc_check_mld_msg(skb_chk);
-	if (ret)
-		goto err;
-
-	ret = 0;
-
-err:
-	if (skb_chk && skb_chk != skb)
+	if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -195,6 +189,10 @@ int ipv6_mc_check_mld(struct sk_buff *skb)
 	if (ret < 0)
 		return ret;
 
-	return __ipv6_mc_check_mld(skb);
+	ret = ipv6_mc_check_icmpv6(skb);
+	if (ret < 0)
+		return ret;
+
+	return ipv6_mc_check_mld_msg(skb);
 }
 EXPORT_SYMBOL(ipv6_mc_check_mld);
-- 
2.11.0

