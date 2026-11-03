Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692488;
	b=jsyJnOrH2GhGoR/SKT2VYOSJihuiEURGPx+s+/lGy3erpXXWmba6krLgTchNPcVGI+XA
	 71CzS8PQO6Ri6k3gWNAd4oEQD50mKtS5yuKGzIfp9vb8ZB5jLQMTjXB8TjT0x5Hv/9QNq
	 yLkqeZmXtmYj+7OJ7DoOARy4NeRCVt/j2OOtFtd/lMLSUprinIvuqlp2lJUofrBHczm2f
	 WyTwX6+4dgT/BEq/cpV7n7abAg5MebOGXYHSk8mJMn+WMGOYpG33r2ionAhywBSCLWIDk
	 Sjds8MQXKfmu83iQwEPD3wpwz/Chgrikq87zBgJ+4vcZ3zrk211chTGsxIw+XS+p/Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
	b=RVmZec5MIDgD/zc8gpy7XnY1rytFcMmPxGeBR8v0GgDljlMUEoi+OlSQDeEKCsna9j5g
	 X/RF2FtV7g8KV+sA3o+2zPJa/zTXdEW38LpD6mnHaGrAESwGjSPwZyjkpWVoFiVVlCKni
	 CouHcqY7jBNqNwPKh2U+tRSreFjSUfK6cxj4yJZ4sl1HR6TezQK45b2UzWoT6g6AFeD12
	 2sJ1J7JGi5yGvNyq7MYFSqSbFckhswvCfnDyaoE50HDnUNqFMAWGxQlGs/p157hpwBaf5
	 50eScHpXLFUeQ2ChFujOKKIwmlSbd+RQCY3fMApx8SZuP+vtgnYAj/fkwARMIldpR/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTSdNjNr;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C5606D803
	for <bridge@lists.linux.dev>; Tue,  3 Nov 2026 07:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 504C5606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MTSdNjNr
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1777091a91.0
        for <bridge@lists.linux.dev>; Mon, 02 Nov 2026 23:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692488; x=1794297288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
        b=MTSdNjNrDgDbImGveor6ThmbnW8NooM2eFU2fRHnpVPZonimGkNHlsrYZb2Ur8drmV
         Seou4AAkQ2uRLrRcXo94BT/aryD4ozjR1jMHyhXNkvaFpXlEDCRJvOTfQ9ZJEu6CjG5a
         jE84O5WQNqzXc8Sviua3tTVuliA+lZY75ZxbaIHywU73vzNqCHKK4oQmNcIzpCINy1Qk
         PskjOR2WCVPn99Zh4HsABuYl51XHLug+hjPy5JSkj9w4ulAX59xmleo+5wKrpMEWbfzP
         JjU+rt/CRUdzm0MW5kZuQw7LeudU/rnwCEoS0mM3ihmrzEsyRinYpmYDnmyjkqH3McUD
         qMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692488; x=1794297288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrPtbrewofDNM9Dsgj1ZDWN+FRXhLMYsDsPjwvet0xk=;
        b=EApx58yJ+uZMV5SCc4JrAw2sDrAODRmu5LGqT/OozWa+lH+GyqVoHvCEHefzvoSKX5
         3l71Ty/VPhgUaaLgA+IupJMb+V65skeKn1YZLFfYbK/3HN7Kia44nVrBRlmbLeUHKd3T
         X0ayvryL6MUut5zrCtIubc4yUWh0MOe9M65iZqYu6UL3pVQxhmXvrwpqNr72hWqqtGoG
         TPiZJDHPJ4v9AJVwD5EACvGhTJCNg8jfi8rJkxV9xLf28b387C1XADt8fPYnUhnSPOzN
         50HO8IAUWOeGXSWuzJ/mAPj83z/XXd/75FjNULuO7n8XlzjkTNOu8Hp2kt11G60lvqdw
         4nWg==
X-Forwarded-Encrypted: i=1; AKwUvBycEsjRpaVAUcMTBrc/QFartu9kXldOX1zTlsTbGSZVDrUyWIp4X5cL2AgOg0csp9xGQaR8SO4=@lists.linux.dev
X-Gm-Message-State: APuU4Z+YSv2h8GN7m5A6WPxigf8BNH0dIJ3mJFl1kJWX44EIXTvvnzUw
	dBSSMqSBQJVlO+oxqsFhicsPJPc7ZDTT6MWPpztTiqdadhdxFQxVPey8
X-Gm-Gg: AYBFou1AQJDXhrwFQ+PF0uGX6LLQ8phL8S3emjBlrI9i/Thl1bIWVLqeybAwZwD4g+/
	52Wk51ZEdz19zeOl4rqaph6wAOUlfPSjpL9gnsLvbXoe1bIU8z+9aHx832VgzBsMmfMM825vzwS
	PakCUaXoK0ux9E0uMLg8pZs5A1i70tzqbaiRQ4C3+pUXuzIuM+GuBrNpLW4GZqAdpMRoP1COHLm
	LYtGRucWbw3neo78lQbNrqT10Va1RwyS0Qb3ZJOqj3iXn6HNSjVzZNCGJHaf5H+yUaJMkT9CmSG
	FU+uXM0xu+TVH7xqtUTY6My2qvdDvul37s2k3xGg+AgV/NB1nk5i7AJwiCB4SXPIOXpvdqlGy5l
	+HjV3paCGaSPymJPDjGExaz20ICBTharsp/cBilzNbAq7Ur2KlfV+n/Pdccl9dawKAp5f04Kbj4
	7m7pYjlsaDkp9p+YMlnwSz58uuLM0HyAe7wmVv+FzTaZmOdXIxS2U0OgC41VyRizvjDTaFlNGzh
	A5XVIB3e7GN54JqBCaizs6zreddCF6iqYhU017BP6M+0A1HQabNTZFdcDxBYMe23VVI0/On2+fz
	fjHhvbAD/mB5DS9qdpM9m8ZtdEqbGG0vm5C0W3S3GwRDkl3Yt/ZbDXjudfGlowptK/CuNepARjy
	cDqZXjlXLMLCaIQ==
X-Received: by 2002:a17:90b:57cb:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3ae897f6192mr10394588a91.26.1793692487076;
        Mon, 02 Nov 2026 23:54:47 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364a987esm829086a12.22.2026.11.02.23.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:54:46 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@cumulusnetworks.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] net: bridge: use one headroom snapshot for ND replies
Date: Tue,  3 Nov 2026 15:54:37 +0800
Message-ID: <20261103075439.43644-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Jun Yang <junvyyang@tencent.com>

br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
again to reserve its headroom. When a port requiring more headroom is
added to the bridge, br_add_if() can increase dev->needed_headroom
between the two calls. The reserved headroom can then exceed the space
accounted for by alloc_skb().

Take one headroom snapshot and use it for both the allocation size and
skb_reserve().

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/bridge/br_arp_nd_proxy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 87a40e2f1c50..985ed43f7e30 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -262,6 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	struct sk_buff *reply;
 	struct ipv6hdr *pip6;
 	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
+	int headroom;
 	int ns_olen;
 	u8 *daddr;
 	bool dad;
@@ -271,7 +272,8 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	if (!dev)
 		return;
 
-	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
+	headroom = LL_RESERVED_SPACE(dev);
+	len = headroom + sizeof(struct ipv6hdr) +
 		sizeof(*na) + na_olen + dev->needed_tailroom;
 
 	reply = alloc_skb(len, GFP_ATOMIC);
@@ -280,7 +282,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 
 	reply->protocol = htons(ETH_P_IPV6);
 	reply->dev = dev;
-	skb_reserve(reply, LL_RESERVED_SPACE(dev));
+	skb_reserve(reply, headroom);
 	skb_push(reply, sizeof(struct ethhdr));
 	skb_set_mac_header(reply, 0);
 

base-commit: ffdf678dd16610e3f006dac904bd37c09684673c
-- 
2.54.0 (Apple Git-157)

