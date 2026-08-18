Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B73AF657
	for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065694; cv=none; b=qc9TLFtleRMnpoR3eq0f7RxObPNRvkEdHUwJtWBiLvBUASZWlwbIwHb+vUGYwe8rdDlHxYDuvRyDi0HcP5IWe/I2TZBiw9eBnTFtM6dKRgClXZfe9e2wm9IBmwsDqNoCTjdvsTgno3AIXyxVXR9NDyU3aChbxsQ5kCfaOBRssFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065694; c=relaxed/simple;
	bh=t+JIdzgNDB+wXkLvzEVmEGCGBEGugUb504qbpH6q2Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py0Ggkwud39ToRcEZOxpLr7mHmaYfgs773SIzp7C2PP9INY3QfAoNBEH2Uuh7WC0aWxhUsshmvM7XRwYDMhuxRG0dvxeFXWalPLCdypnycLAbUFTaXNDmlbPCWjh/YMaeT21l4isL8NiJ/ThHD3DE+HER3VW5l1l5ie/b34Ke64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LLadrFDR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LLadrFDR"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so3139566f8f.1
        for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787065691; x=1787670491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsJTTJLMftxjOk/8vHlxHx3gsMZIHruqB4aZN98cgQg=;
        b=LLadrFDRsS6lqkrzHxnv2qiWIVv2Gidr8gbi8iPZibIe2tWSp5v0t6JSgsgLuHm4mF
         y0eTwKXvul4p/LK1PClaF5nwex0JXVxrSnrA6DIcgb8V1wzqXX2gKlIHkATfC61cqiky
         Mbjc9/sO62UzZSFQGnoSMGXjbCId5tJPDTi/Sm1ATA+UKc4QH1zxPMDLSX9jJMHRAlRF
         P4EpqKoZtjiF/plROslKkGsUn5le4K20yuspGqHGE9DfgDT0dT+qMOdWABQ5z8thRGXX
         yWs1T5+/MSyEXZJGgzIharVYfqPeCCdPVp8JvYSvV47SvIxI/iens5KwbrQDfWLGzlno
         zAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065691; x=1787670491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsJTTJLMftxjOk/8vHlxHx3gsMZIHruqB4aZN98cgQg=;
        b=E4srrwVf8Sd8/eJuARbgyr8UXgCtsVPwkIPRGPYuX0MfvR+C/ly/VaUdJQ6s6QugZQ
         sJ9uAmdxUao3H//RngK6TSzbVbGk503OleyM7v4IgcCSHMj++x6n+w4+JeJYgbS8Ri5W
         StQPj/Ycbviw893o15WniBjokzK4enE0iNeBlWCdXnV2vbU4tH0xSW4nSXRNIUy1+aB/
         jBt3VUnF1/ZnftGZUfCfgLDsBjV5bZHMLuIw1ho40y9gIEJ7RXEOQ1y7o9eI6Bv1j7Zw
         /D1/+I+QgCvVcikm7q0cSJdZVSInsBpBbp/yuwvxlkPjD/BMZCkWEfuVN0pc1mBsFT+e
         9ksQ==
X-Forwarded-Encrypted: i=1; AHgh+RrP3ImJkKxZlrvK+kfosG1r6RrWRdds7DtjQeSaDAfDEzmmfiKGy78+WYvwHypNz5GZRql6RrQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1XMAJTOti3TizvcjPqgxswfJ+tAnJR30JVv0JYpHR60rNf3gg
	u+lKKhNvueMfRbXWCezm6Ty2rN7SkSpzijIDbw4vAuikS22TVIyyS72CxAHpIfygXVY=
X-Gm-Gg: AR+sD12mcVtuXkpQnNnWBJJGAZ4C0CVTmKn/P0ez95esxbrZdB2xrauFXj92XBB3UYT
	KrRNkoDnclY5sxw3m+vXf1RhSC7J6eQQdD+kpEnrU5FiPv8hPzzwuPlQqfF1jhTWIXh/PUJEmsu
	3+K69dFWb1YYPMUBQEEYyldd2RP7thJ8CtWnnW8vGqUW3etI0DXTuqWVmf0B8jc698QS7LH7x+/
	WnzpkR09zg3XmuJKWDxaeCyTcE8N8Eg7TZzAmBsTIvs7Is0KkK1z2vss7f7dVLL43qXDh91n9jj
	pSVY5XbTFVIK1WYx4L3bZgSaT4EuTWym939qJnYXPLuA+Xlc3+fQ+AhZz/IZmiXx2zeZlXgqVbf
	OW6XGmEUcEQZ4qxRkAvvy2C0qm78o6Xq9RS4kdIvtzq3YMyjl4hDoZAv/SkUgyx5sI5Vi3hdHR3
	lRsgiGlhSWImU5/gtg997TMayLI5Cxi0rexfwgi+dltk1CpMR2WEpP+64PomP82AxjEHu1QTSK3
	2ZutEtpqjw=
X-Received: by 2002:adf:fd0a:0:b0:481:51b7:290b with SMTP id ffacd0b85a97d-481607630fdmr42455679f8f.14.1787065691040;
        Tue, 18 Aug 2026 08:08:11 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5a3157fsm12203428f8f.3.2026.08.18.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:08:10 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 2/2] vxlan: fix reading neigh ha
Date: Tue, 18 Aug 2026 18:07:56 +0300
Message-ID: <20260818150756.890025-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818150756.890025-1-razor@blackwall.org>
References: <20260818150756.890025-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently arp/neigh_reduce read neigh ha directly which can lead to
partial reads while the neigh is being updated. Use neigh_ha_snapshot to
take a stable snapshot of the address similar to route_shortcircuit which
already does the right thing.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: - use ETH_ALEN instead of MAX_ADDR_LEN, the bridge devices all use
      ETH_ALEN and vxlan allows arp/nd reduce only when not in raw/gpe
      so it also always uses ETH_ALEN
    - align ha to 2 bytes because ether_addr_copy() expects it (Sashiko)

 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 824144bb7774..a94168f7a18e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1881,6 +1881,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
+		u8 ha[ETH_ALEN] __aligned(2);
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
 
@@ -1889,8 +1890,10 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
+		neigh_ha_snapshot(ha, n, n->dev);
+
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1902,7 +1905,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		rcu_read_unlock();
 
 		reply = arp_create(ARPOP_REPLY, ETH_P_ARP, sip, dev, tip, sha,
-				n->ha, sha);
+				   ha, sha);
 
 		neigh_release(n);
 
@@ -1935,7 +1938,8 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 #if IS_ENABLED(CONFIG_IPV6)
 static struct sk_buff *vxlan_na_create(struct sk_buff *request,
-	struct neighbour *n, bool isrouter)
+				       struct neighbour *n, u8 *ha,
+				       bool isrouter)
 {
 	struct net_device *dev = request->dev;
 	struct sk_buff *reply;
@@ -1981,7 +1985,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 
 	/* Ethernet header */
 	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	ether_addr_copy(eth_hdr(reply)->h_source, ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
 
@@ -2010,7 +2014,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = 1;
 	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
+	ether_addr_copy(&na->opt[2], ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
 	na->opt[1] = na_olen >> 3;
 
@@ -2051,6 +2055,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (n) {
 		struct vxlan_rdst *rdst = NULL;
+		u8 ha[ETH_ALEN] __aligned(2);
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
 
@@ -2059,7 +2064,8 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = vxlan_find_mac_tx(vxlan, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2068,7 +2074,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		reply = vxlan_na_create(skb, n,
+		reply = vxlan_na_create(skb, n, ha,
 					!!(f ? f->flags & NTF_ROUTER : 0));
 
 		neigh_release(n);
-- 
2.47.3

