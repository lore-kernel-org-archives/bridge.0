Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334119;
	b=YNjJMqJiFyYnZXIOHMBX25YWNx9SkpTgLFbclmP/4eIzsCGzY4W+izOBfNr5D3nZ4Okb
	 OBd8NFT87k8usB4QbeDorFi9Cae4YVPu7s8w19x9RJyWL2WD01S7/KrusyWi4o/NnPjrn
	 nTDe927XJzqfAtLKPAyC9NUWjyEstwi+PzX+3df1itsttKbls4cHTyqJp6+onyFVOfuSK
	 N69Cr6DLHgJ2xI+oS4J9H9tjHWyT8ttWUkH1VnoEHrp8CVmT+OW3+VqH3SXNuaN/wZOH4
	 i7J4Wrv1gZMYl28Px2n8+zWUCfjAHtxWs/hJkezkjrjUDq7Mqejw6nZMuM2HxYaeH8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
	b=LAa5BL7h/qiDGLosN0R+CVFMQePvGLfr6EneHziLn2htg4bN+edOgFjqRFNMyK9C3Whi
	 o4kXma29zYm18dSWP7uBDA9tVVoJAvZbWsIyRtMe3dC6Mg1XqMgGk9NBIM1YlC11qKHqg
	 iKDSykTJ0BH8xTZ4KlW6ZdHz+LtZTqc9fQQUvcY7MRvmrgdh7my9/kxEi6E+zIDLsq/uD
	 nu4X9I6SDfNU6wbnjewb7vVdkETg3zYL6lptdRtD6YDZ7xNVtnogldCi6tWZOc/ej9Vyh
	 WLEPTncptQJObsmOfmnh69V2sW7Ile593XNmrldncfr2bn5rPaHvP+UHAS3cOcIdbFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=L143xo2G;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819E606A320
	for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 04:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1819E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=L143xo2G
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b28d7c729fso176431b6e.0
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334118; x=1793938918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
        b=L143xo2GjopDhPySsgHoEDT/Fv1mXGlRTxfRphagjmoGXAxFw4zbsWZiNueHxr0UBf
         g71MjadGC5Rdze8Rs/O5vBGynpUjYidwisQRd3JYegYkvoeylajaQivHIISHkiXoAn+5
         dhJa5MepnZf+XnAUTAxbHUHK8rghnvWHFzdp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334118; x=1793938918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
        b=CA8OzQ8gwE4ea1Q2c76yG2GRg90CIqSdwEb1DCKB8YLD0/8hT9Yh0QTLCstdKz97HV
         ujwLif0J0+Gg/XdF/h0rVdiEwhV6SMW1nTosWmanw6w8jOmY6TnJNn8pNTC5DOZhads9
         izlYjUHtx/jTXJS6HFnSf6DQazcxWxhQtG+uS6H7Sdle0v5PyiM7Zn4gGtRbA+ceqFG9
         UlQcHYUwEENH5tTzu2OE6lKsu9hkWjQ0MiKk0ATK8CsBe9KnlEb8pUBIRXa1Cm1vqjbK
         767yJ7rYk5edC6N3ZkJGWEYYhS0aVKnewKl7nu6/aYmOCLZZynfRLhASgjF2y7BTnAJ8
         ABjw==
X-Forwarded-Encrypted: i=1; AKwUvBwn2Z3rmhVBJK/8Mf8H+yzpxkJsNhc73Ym8TF90y/t+eSJ/gjIUhOEWbq6N5cNnsa6272on6DE=@lists.linux.dev
X-Gm-Message-State: AFq9FYIjfxdJ8C3FCkZ53fOP9z4kpDUjctTtm8Axn3byWNGNXYBKbovw
	xLGfk6eHZSgGhGQPnK5z8FIpkA4lVySZK6uzydiqFegSJOJ2JRUIRaFdt7T2SyS8iws=
X-Gm-Gg: AYBFou0XGM6JRFgcQuh37BGIi58Y4JcIt0SImfQVmB8QSIeHrCab971pzhhMdaHEeb6
	fhmg6FBoYMporflnDeivVGBZXl50ao5Zg/1YsS0HxPY9QGPCy/O5euijPNBcnPPs6DXvqTVMm80
	kDNggeKv/cARq+IXZiyqNdUhlAJ8hteTSP5U2CbmUnoGVHkwcZezAr+ntM7TGdgJe1W76ZF2M2+
	MD6cd3ymWCuHKickrMkum8cgzgnwo7JT7Im3HmxeYSGCwhLX0aJBnGCbmAO0j7E8DOsBWATMDqe
	ITfAh+mQovkFaeNs2fb3GmubM2CBtQpXlUo2pf5u0M1/+JvDOq+Jj4kdqjufDxGAEz95Obs3s7i
	LmgR4HvoO0UmSftP1nmEyQpohqhb7DuGdbNYm3kw235YQCI2HnkXO4xRU4GGRhC+PN01t71McyG
	+KH8I+mTmtaS3y/TQu/j79Sve8NB5YwKwrJRN3gc4UJTi5UbgyzLmzbUy63P7cxM5DgF3tyq1hN
	oEqOw6tsHvCSmyuGxxlxcv4ZryLpycpRapLyjpuae0C2tUNxz77PQzxZJMGU7M2xlmeh5oWOnre
	Oia3BAf6rjuZbh9Wq7rAb1DxWaLrY3wi7qUSx/osbZrrion5FQuxDH9PqfzeYWtDhijjoaFypPA
	q5ZZU3WfEwkt0bglsJxiKjWZldEx1hA==
X-Received: by 2002:a05:6808:17a3:b0:4ec:4c7e:37b5 with SMTP id 5614622812f47-5640ddb4f38mr841806b6e.29.1793334117847;
        Thu, 29 Oct 2026 21:21:57 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd9888bsm764152b6e.5.2026.10.29.21.21.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:57 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] netfilter: br_netfilter: reject unsafe neighbour devices for DNAT
Date: Thu, 29 Oct 2026 21:21:55 -0700
Message-ID: <20261030042155.73844-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

The IPv4 and IPv6 bridge prerouting callbacks classify DNAT traffic using
the logical input device saved in skb->dev. The physical input port can
have a different bridge master when prerouting resumes, for example after
an NFQUEUE verdict. Netfilter reassembly can also combine the first
fragment's bridge information with a different fragment's input device.

br_nf_pre_routing_finish_bridge() replaces skb->dev with the port's
current bridge master, but looks up the neighbour using the existing
route. This can put an skb with skb->dev pointing to bridge B on an
unresolved neighbour of bridge A. Deleting B and resolving the neighbour
on A then causes a use-after-free in __dev_queue_xmit().

Before calling the neighbour output method, check that the neighbour
keeps skb->dev alive. A neighbour holds its device, and a VLAN device
also holds its real device, so allow a VLAN whose real device is the
bridge. Release the neighbour and drop the skb on a mismatch.

Doing this in the shared continuation covers both protocol families,
including a queue in the remaining bridge prerouting hooks. Leave the
cached-header path unchanged since it does not enqueue the skb.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/bridge/br_netfilter_hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e15355ff215a..726a2d17ed3a 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -307,6 +307,18 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 
 			ret = br_handle_frame_finish(net, sk, skb);
 		} else {
+			struct net_device *dev = neigh->dev;
+
+			/* The neighbour queue must keep skb->dev alive. A VLAN
+			 * device also holds a reference to its real device.
+			 */
+			if (is_vlan_dev(dev))
+				dev = vlan_dev_real_dev(dev);
+			if (dev != skb->dev) {
+				neigh_release(neigh);
+				goto free_skb;
+			}
+
 			/* the neighbour function below overwrites the complete
 			 * MAC header, so we save the Ethernet source address and
 			 * protocol number.

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
