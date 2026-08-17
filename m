Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70643B6DE
	for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977400; cv=none; b=op2aXhrukEMQjNOq20+MqZ+R7cOGKbwvesRr3/TZpo5cr2aq48uT91On6092yjeEgce3h99q9SAmSc3KQHr288eRc4cU5q3ho0X9/XNWwjhJQb1wqZK9nUsBc9o6lQtvvorgpZUsH+IcawofCsNdDKmiFKnvYPgJL4x9v/IUxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977400; c=relaxed/simple;
	bh=sPFAD+uo8IMND4QzghXVp2u1uXHoKLiKjili6fsUfSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V20fiBE4PEt4PxHLDqhHmueUq6ZAyNVjOSPddvdlo4XXYYm9gBgMR0kVi8aCAM7G1QxXssIj3T3Ho2ad/5mylELMXtwxGUgGoAZgVI6I9gMTXTsKgCSJS8uuEFBEvgzm61uh9kgiXg2Xf9R+C0KSWkaVrTjxNGjzraheakfgxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Y1W82eyn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Y1W82eyn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so2437111f8f.2
        for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786977396; x=1787582196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9EuLf3DhLkqiTmLxGnPjFranl+WvLWJf72aAVoAZP0=;
        b=Y1W82eynpFWHTFpUfopXohkaJOeDshCw9BOMXkn5RgrvBqt95PShti+ipJfFK5aAkQ
         6wBf7j4vHrFtZiGiizmXcDf8419EBPHjrAGygiwrkAF9bX+VeO28o+AsNLM0itPCiwCt
         Sdwkn755rFeUdAXLICYk72nWVfKrlEQvo1pvKrKNO/i5nEVHtVtO5iGDWDY0e4BUW1px
         pDNXt9EIaBPcK1dCnV3MmorGf5eNBwabe/W6Hmrf0GlpHuMKr83cApd10p4DR1DvjqEE
         8VCwiktQ5YWhAiWJaX2hslhkjEXj6bowSoWZay+qFPQy9GbQX8jO4mJsrPuu5PqE4rZV
         Pg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977396; x=1787582196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9EuLf3DhLkqiTmLxGnPjFranl+WvLWJf72aAVoAZP0=;
        b=PGaqlpmUHdRiUK4Q9RsLdFpBDbzzeL7wdwU3PfOVbkDzUJlDI3aC2datVX0gcvhGhY
         9+OFGshBaMM0kxkVdLsYuZCg2V31+l8rRrNbIMFkIUuF4zbIMRJmIkGkdsXVgrql2b3m
         d7TEGq3b1fJJMZElZp+AvBDnITe3qF2mCuY532+kkuXu4KJ50q/+YcU9KJaMX72dlG0S
         8DFQBZGjJ8Y+/pPXxPav2aD/oz6Tf96uaGem7W+zvP9ZsomzB/NwvZ44D3GSMKjAtMZS
         kWJTLoGklscjg8twiByy4nfRBA7EtrL/ArLXYiuxcaLywqY42dKHLX/zXOyU6vla4jbK
         n48Q==
X-Forwarded-Encrypted: i=1; AHgh+RomBGhchDi8G9fWS+E4wzZHYxWhqTaug+IQ+U2w8cQ6oNVH+r1NQ44qS1JOe5rrx7hwm6PCyeE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6ivuqokQK46DJ4UHyYswfN+HMK91g2jWtB5ZMBxWaKeMXJyYO
	+SoMW4pfJn5WAibj4vpcJcQh5ddeyrUPBQi1AFiGCv+V+EWbnizcQLohtZI46r0TUpc=
X-Gm-Gg: AR+sD13b0sYMWZEWm7f7Pvu2UmkZAhSnqdsWjO/iDyFrv4A/LoGiIrygcpgkCnHzBoe
	rdnd8dQjHRlWBMO0YGK7CwDkG8I2l28udXWv9UgakA1aN1dI4GTdNaVjXUAxRXgG8R7ybAObkjW
	0RDvZ3Y7cQxlqicl3o3DlhMva4bY5LeEMo9pfkzKmSPQ3HWGGdbwh7qWcBGoFnyfBlTl/KKdFIq
	HcDAcktCYYJcaoXMoigYHtJ/95g/Irs62Dp88seZyahOlPj74sDdIFotWTA5YIXnOleKaNNSQFm
	ELCoVkB49ZmhUKVxee0MmUmNO07AypIVKH5lYu1NLaK07A2U5FGAH4M8wH72Ja+YL+nOWmi/Ep4
	qF1kq7zljJGednLEiJ7QcAY0tbP1jQ59wBGV0oFmlowTRZTuZw86Lulfwigt3uzoKKIlYn0uKG2
	ax8QMO5qzY0NVd/i41FHV+zJqedt3j/8mpe70T8HsgBz9aXUHsPQf4lzHC2ctmXsC+Tuy+mGjcp
	zwQuNJjZQ0=
X-Received: by 2002:a05:6000:288d:b0:47f:9de0:c27f with SMTP id ffacd0b85a97d-482a8fe9b80mr1239936f8f.1.1786977396119;
        Mon, 17 Aug 2026 07:36:36 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5b783c6sm4599175f8f.31.2026.08.17.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:36:35 -0700 (PDT)
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
Subject: [PATCH net 2/2] vxlan: fix reading neigh ha
Date: Mon, 17 Aug 2026 17:36:13 +0300
Message-ID: <20260817143613.685769-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817143613.685769-1-razor@blackwall.org>
References: <20260817143613.685769-1-razor@blackwall.org>
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
 drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 824144bb7774..2e0d25fe607d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1883,14 +1883,17 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff	*reply;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_CONNECTED)) {
 			neigh_release(n);
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
 
@@ -2053,13 +2057,15 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		struct vxlan_rdst *rdst = NULL;
 		struct vxlan_fdb *f;
 		struct sk_buff *reply;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_CONNECTED)) {
 			neigh_release(n);
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

