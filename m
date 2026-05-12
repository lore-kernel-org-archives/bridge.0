Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229D383987
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582058; cv=none; b=KjaauIfUNnGt4AezKRa8Jd8mPrphb8630hs1axYPSJFnAKPcEZEGBqmxo+5zYUT4vSHMXc3RIS2EWHnHZEEn0zxr9o7AvofUP7XHt0FS1S35ms7AD7/FqlRbO9UMuzp7IZmubechRGsZuSoFUw5jKxh2qIDd1Df+HC95kNntPLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582058; c=relaxed/simple;
	bh=e9ounumzMsc0PFMj8de38rXvFznFr3brdooDiKsmj28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUkG1cA8TqIhSu3m1cAtuvktbFDUN13zo783yGNTkeqiBo0mghTXlkrHwqIfVY6kRie8QxaydHM+Zq/DiiT1Ux6qZNgrzxYLOfYLHOkOblJl+bvVpkQn1QLmvw7JjgQfEM/TyLq//uwxFi6K4Aw0sPCyWOcSbFyrIfzqhrQd/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVhMbbbI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVhMbbbI"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso9478324a12.2
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582053; x=1779186853; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOP1vXEoJfnkmimPCpGl1dwzuJKQLFvAXHQhPIbHakY=;
        b=LVhMbbbI5n7Lj/7DKz7dglgzXmopa3t55J5BV/KvzVp/5Ugn3Z/jo1jCk3fkBPOKCo
         1j/h/5Fr3paAKkprA2/TCF3ZlutzQkFnbo9r2QdGbrIHcIFTWPsQ8pRZjDYEYqSkwmft
         TbKLll1OJmHTwcv6wXqZsCRLdkGccs5K2aRYSSKcpjj4re40zOTFdPON7MBbQuRzscvv
         qBtcBf3M+LNTcnNOlrNRvStxVZchM4uP99WBId36gI37lKEU2klRjUGqK9Y2nnrI6FVX
         3+8GO92IZKHSxHVnxoRJp9ftFOXqBbyW93xwpQ0eAUf5C8Chnk9Wh5HaE95v6cT13zHs
         HFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582053; x=1779186853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOP1vXEoJfnkmimPCpGl1dwzuJKQLFvAXHQhPIbHakY=;
        b=h6KmxgxnnBAiGDD1oBqbeJ4mWE8EigH696uu79SG0VxS20aDYhYTrF6v0FjwlhKB6X
         NHKmsaaXyVoKy64G+jaqdkPiSFN0XnS7JcZkwjTY3/vOjyj2i7jShTA2bcFqM/igC8v2
         1yJ3GWNQk2MHMayZsB/uwj0p6J/SYWGmiuobfYcgZCLHzKBFC7QFl02SRf/gwShx9s1T
         6fn9UO265PfmkKhDoWL6ZGSNRSo1Stdj/rj0wf5rDM+BwoqaRs2DLglCgtYyA9VWbjYB
         NAQxRnhiB6Qw+wiLk7Q09vAcMHMgs1hAURWRZXxkwNBgXSlQPDIZwv4cwzJl0yttOiTt
         amlg==
X-Forwarded-Encrypted: i=1; AFNElJ+BkKssxG75dBPKnK7BAH2OX2Zct0QCFDiVleaHzkewnFk4GPmK5bbVvistVjm90jCgkRqGU6g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+ebWhHqZKXqJiXCtrHEFxoaDD+eNEnu9Wc1tzOEc/GcV8wZtB
	XTDdRsPNO/gzQ+D0se6J0WjvSNuc+yInJ0znVbueFyBpRowinVfORwk5
X-Gm-Gg: Acq92OFBxVBgvDXjlCaTRFnr/lRgTsyOzpqF8zQtmqpJyZrMF7sSQFlxnlHMekKRjX6
	Yo3L4Xu/fmgAdKSM7Ucpk0gp8Ls9WmIt3UY61DrDXUZBnNtwPJSLjRydwmkYASv/2ZLNPpSm5uI
	yqgn/jnIkULVZQrUC7x2geUxqne9rG3oydRHU/wt7WprJk2PhA/B1b0iQq+KMX8srrWqhfaGsFs
	8pQSRZbNWqA/SVgwLI19niv8GeL+uxJoogHyANHg/y9DuCNNO4eKx97zrmJsKeUXoqNrkf69mQ+
	JKs6WYlhx7ofPAQXiqqf+qEoB31yDYQQCCBmi+uZ5mUSTHEK5BAmlIZiT74xqDOiWW/8aklXbey
	DFuzEpq1vJvZHmP8U9bEWMDsyyY48bkuoNV4tG7yeAkLUKEnST7nfbzf7QFLhGu4osLwTXUzTK6
	3By/spgPPy2P7byBaCOUbssddnM3MATSs6lv/dAkwyMI57fDGJTgav42PzIg82gY97xZhx1HYc6
	xPpd+zNSkzfl9jZOpPsGMAO5HZtPRTSwzfE71PW/iUMOAcwf/UXPI4=
X-Received: by 2002:a05:6402:324e:b0:679:223c:d191 with SMTP id 4fb4d7f45d1cf-67d642b24b8mr11741995a12.13.1778582053043;
        Tue, 12 May 2026 03:34:13 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c044sm4629218a12.27.2026.05.12.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:34:11 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v20 nf-next 1/2] netfilter: utils: nf_ip(6)_checksum(_partial) correct data!=networkheader
Date: Tue, 12 May 2026 12:33:46 +0200
Message-ID: <20260512103347.102746-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512103347.102746-1-ericwouds@gmail.com>
References: <20260512103347.102746-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet(),
nf_conntrack_icmpv4/6_error() and other functions alike are accessing L3
data. These functions also calculate the checksum using
nf_ip(6)_checksum() and nf_ip(6)_checksum_partial().

They in turn use lower skb-checksum functions that are based on using
skb->data and will fail when skb_network_offset(skb) is not zero.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 29c4dcc362c74..b738444c9cb6f 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -10,9 +10,18 @@
 __sum16 nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 		       unsigned int dataoff, u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
 		if (hook != NF_INET_PRE_ROUTING && hook != NF_INET_LOCAL_IN)
@@ -35,6 +44,7 @@ __sum16 nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 						       protocol, 0);
 		csum = __skb_checksum_complete(skb);
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 EXPORT_SYMBOL(nf_ip_checksum);
@@ -44,29 +54,47 @@ static __sum16 nf_ip_checksum_partial(struct sk_buff *skb, unsigned int hook,
 				      unsigned int dataoff, unsigned int len,
 				      u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
-		if (len == skb->len - dataoff)
-			return nf_ip_checksum(skb, hook, dataoff, protocol);
+		if (len == skb->len - dataoff) {
+			csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+			break;
+		}
 		fallthrough;
 	case CHECKSUM_NONE:
 		skb->csum = csum_tcpudp_nofold(iph->saddr, iph->daddr, protocol,
 					       skb->len - dataoff, 0);
 		skb->ip_summed = CHECKSUM_NONE;
-		return __skb_checksum_complete_head(skb, dataoff + len);
+		csum = __skb_checksum_complete_head(skb, dataoff + len);
+		break;
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 
 __sum16 nf_ip6_checksum(struct sk_buff *skb, unsigned int hook,
 			unsigned int dataoff, u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
 		if (hook != NF_INET_PRE_ROUTING && hook != NF_INET_LOCAL_IN)
@@ -89,7 +117,9 @@ __sum16 nf_ip6_checksum(struct sk_buff *skb, unsigned int hook,
 						      skb_checksum(skb, 0,
 								   dataoff, 0))));
 		csum = __skb_checksum_complete(skb);
+		break;
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 EXPORT_SYMBOL(nf_ip6_checksum);
@@ -98,14 +128,23 @@ static __sum16 nf_ip6_checksum_partial(struct sk_buff *skb, unsigned int hook,
 				       unsigned int dataoff, unsigned int len,
 				       u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	__wsum hsum;
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
-		if (len == skb->len - dataoff)
-			return nf_ip6_checksum(skb, hook, dataoff, protocol);
+		if (len == skb->len - dataoff) {
+			csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+			break;
+		}
 		fallthrough;
 	case CHECKSUM_NONE:
 		hsum = skb_checksum(skb, 0, dataoff, 0);
@@ -115,8 +154,9 @@ static __sum16 nf_ip6_checksum_partial(struct sk_buff *skb, unsigned int hook,
 							 protocol,
 							 csum_sub(0, hsum)));
 		skb->ip_summed = CHECKSUM_NONE;
-		return __skb_checksum_complete_head(skb, dataoff + len);
+		csum = __skb_checksum_complete_head(skb, dataoff + len);
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 };
 
-- 
2.53.0

