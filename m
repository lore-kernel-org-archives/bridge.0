Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794747752;
	b=XoiWC5Dr+QKoczmNoT3aiv2xAdaTxN1Hb2XOS+6myrcmSsYvio2ZPtyD1GCcMI5hJltg
	 EcwN6TJAMy10hMUu5SVr99VHWWFgkFwf7/Bp768utCm8isHNQQVSuTKO/Ge8c5mUAnNI2
	 yfVKs+rmxeF31nkAlJfBVLTz6nNTR4f9Kfnpk23ad0Awl9cJmXH8KumV1s4fLU4ZEVO3j
	 bgCQGESmA2FHhLTkXvxYNY8KKsP9Onh2Dvt7eCzEaTi4JdPOIPAfGLr7ofiHDNZn+7YHk
	 lsVUrMjhAnpysoJzf8eInv9HJiOD7l8wK/fZjgD4cumxvQw4gCXOsqOAY3rjiSuRv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3tJIKpc8AwX5cndBfqHiESi1n0+LeUDLJZqK1Qyg4iM=;
	b=i2gNVdOT47mKgkHPnZh75Ry1jaZmQcrG4qq/MKLeU5KXS8juqrtBlbv8ftff4axQ3z6T
	 rdwqTkrsI6SE7juW0gTg5WExi1obTpCW+QXj4QlFfipBhH5+iESFpgWrElyfhJst/gf+U
	 FAP8KjJwQRL2gKEaPTNbpVZKWINXJZ/VTiN1ZjSldHupIbX06jzXG1M8SJ1TlXkK33cON
	 1IMrL/MnDAqZTzDvwxIu9ljV5OREWnyMrAhbUmOXBfAH1dMoyJAdijxxdTI9qYrHKexds
	 9lcXDW0tdVPgYwr67NjCRGjbb2RTy+vwdVKbTSotqgVZH010gNVjv33EjAcrcyJ+gLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqMtlAJW;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AF606A32F
	for <bridge@lists.linux.dev>; Sun, 15 Nov 2026 13:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 002AF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqMtlAJW
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cddac941ed1so1154236a12.2
        for <bridge@lists.linux.dev>; Sun, 15 Nov 2026 05:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794747751; x=1795352551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3tJIKpc8AwX5cndBfqHiESi1n0+LeUDLJZqK1Qyg4iM=;
        b=OqMtlAJWqN/QZKKD6HeyTmUH007gY7fMZe9nqk60FVkaHTaRER46+9wPsup9mFKe5i
         IZBATousAuIZaMZPSwzti8/O0UUHCCPDRlKfFPfUO5ixyVFUeWipTwOEMsmNJoCd9/po
         223485r8uXBGET36sqt1avvx+pWEyDs2wOn+bfpAk20I1/TNWbFZEb85FIjtdKrf6wyG
         KsqIevRVqNkc8C3IMSyGa3T4SILah0TAQWW0UGazL4n3mq7N+jKrLA3518QSLg1QUdfo
         WfEF68mCNfzwMKmIABcAmcYFxDO8nG7oIk/JxsiaOMOcsI00wrWSk6D/fhHKAksAkiCv
         2BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794747751; x=1795352551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tJIKpc8AwX5cndBfqHiESi1n0+LeUDLJZqK1Qyg4iM=;
        b=QQ5YsC91PPmpVF9wk5PRJAB712gOUnZrNs0qkbmxVjTtF+nqHnvH6cKTZRl6aGV/8h
         MsqNsd7+U5EbxTXuW1CMMDY/iEfztgzNPtdkPiFvnzdRZDTaDIxGBeD3FrzZQ6ROcks9
         Omv/5GJnN97ixtcjo0BTuI1k09koWXty+1YsQn1hBeFjZW/69sqW3NveWtPTw+/gJFhZ
         maCUDl8TmODdwCL7CV0YFwGtF9yI5HyK8dBfXqnPFlkkw8ZBDvSf5Mge1MApxgaFGja0
         aVIbOUBWXMPReIeQqbX+WI9TdRjNRu4n82bADBvct13l1vqTjmiqcn+yRQaR37k5zZbR
         w8EQ==
X-Forwarded-Encrypted: i=1; AL+hErE+i/755pYvlbuW5EVD5HIBOO5O7zU6GSeFIHesvi6czbZCFRNVQdNt8Om1tD8edaSfHMKJI1k=@lists.linux.dev
X-Gm-Message-State: APuU4Z+aMab9FpscCuYuh37TGBIDl9h3CzdmkIJkkahBN3Tld8fo5/8h
	xkSzub/smPVZLQqNKUWRViYLjXunh2onNGIP/OK3wC5PVKDpUpKlwbmy
X-Gm-Gg: AYBFou14srlzo6/rAfdtWGmQG8sWPweZlMZY79DZnSg7X10nog+cTt8UUxPFtJBUV88
	AWcz/rDtq8+ssItdhZiUOr90MFQgZDgYWwuhXymEVAXDE1Js8nCy4Hkmr2NwExzKXBG5z/qezzp
	avPl02uwtRrL6rKO1huXw3mUUxNd8PdgRWOeYUbuCc4GYobq+sVNeu12dB+ZQ5tx/C37Lsqj7gJ
	EeEvsZHIIZUjTIKPt5fys26FPXm3uJGEOY/t6EI0FRLp9fhPQp46C7cProxJ2uLqkKIOoNOyBpV
	xdH7lCBIUi4XwcbudhaQQeo8LbZu6rLFOMK72FnoZ+XELBaszrppOkU0Q2e1d3CutNzWsGILTeL
	5FcO/u2d6OTxmZCnqi5sgtHgAT11gkSUCGRP3M+mRBqOe0vBNmpVZO86qWk8Dqo8quKaeEPCFE7
	EU7RY5hHFdrXH68j0MKAbe7pbsXVG3sDvMAKOFQHDYPzOLv3lVzfXmr0Od/qM5xzOIprAQuMkkV
	h58EOTJHpsAXNpoySb58ET3HKB67NB+6TxGAvli4THLhnqdjTdiv7V3efmkdsOBOEBO6VHWG28Q
	uWTkLIS5Rq3CFjx/V8VbMNH7d3RvtauDYDfJICzG7o+KY3DIUroNgsC3wgMkNT5m7CH8hE7734s
	KrqP+Upr5i9g6Nfv7bvtgsBDNh/V0s1pLiMlfSElrwYUAowSX1I2TFtV6M/2xlT8ckDwzQYSSl4
	BaMEXzam8kDjiitaHmCl36TfYSQHjtO0ujVi9qQi44tHmfGBsTk65VQH7Jt/DAa46ynI5sh4VMw
	Nc99Sw3kFcKRQ38Mq4l2vVsKt+t+rhpfFo6q1BTCqJzuw+5sUzcqvT7o60dZw25
X-Received: by 2002:a17:90b:54cb:b0:3b0:ac2c:1619 with SMTP id 98e67ed59e1d1-3b1b0a5064cmr7142317a91.39.1794747751079;
        Sun, 15 Nov 2026 05:02:31 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35ac2sm17691691a91.17.2026.11.15.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 05:02:29 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: fix skb leak of reinjected link-local frames
Date: Sun, 15 Nov 2026 23:32:11 +1030
Message-Id: <20261115130211.7724-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

br_handle_frame() passes the link-local frames it neither forwards nor
delivers (01:80:c2:00:00:02 to 0d and 0f, unless set in the group
forward mask) through NF_HOOK() at NF_BR_LOCAL_IN. Since commit
3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets") the okfn
only learns the source and returns 1, which becomes RX_HANDLER_PASS.

That commit sent the nf_queue case to RX_HANDLER_CONSUMED, which is
right for the synchronous return, but the frame comes back: on
reinjection nf_reinject() calls the okfn and ignores its return value,
because every other okfn consumes the skb. This one no longer does, so
nothing frees the frame. NFQA_CFG_F_FAIL_OPEN leaks it the same way
with no verdict at all, when the queue or the listener's socket is full.

Each frame leaks an skb, and one sent from a local socket keeps that
socket charged, so neither it nor the network namespace holding it is
freed. Bridge, rule and queue need only CAP_NET_ADMIN in a netns, so
with user namespaces an unprivileged user can exhaust kernel memory.

nf_reinject() cannot free the skb on a 1 from the okfn, because other
okfns return NET_RX_DROP, which is 1, after freeing it.

Call nf_hook() instead of NF_HOOK() and do the learning and the
RX_HANDLER_PASS return in br_handle_frame() on 1, as the 0x00 and 0x0e
cases already do and as vrf_rcv_nfhook() does. The okfn then runs only
for a reinjected frame, which br_handle_frame() has already reported
consumed and cannot pass on the port, so it learns from the frame and
frees it. These frames were not delivered before this change either.

Also set *pskb before the new RX_HANDLER_PASS, as the other such
returns do; skb_share_check() may have replaced the skb, and the commit
above added that return without the assignment.

Discovered by an AI code review agent and reproduced on unmodified
mainline under KASAN: an unprivileged user in a new user and network
namespace bridged a veth, queued link-local frames to an NFQUEUE
listener that accepted every one, and leaked an skb per frame. With
this patch the reinjected frames are freed and nothing leaks.

Fixes: 3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
Tested in a KVM guest on mainline b3dfbde62cf1 with KASAN and
PROVE_LOCKING, running as nobody under "unshare -Urn". No kernel
modification, debug patch or injected delay was needed to reproduce.
Before: 192000 bytes charged on the sending socket, unchanged 2 s
later. After: 0 bytes, no KASAN report or lockdep warning, and
br_input.o builds clean at W=1.

Not tested: NF_STOP, NFQA_CFG_F_FAIL_OPEN, real EAPOL traffic, the
netfilter and bridge selftests, CONFIG_NETFILTER=n.

Applies to v7.2-rc5, v6.12.117, next-20261109 and 7e1392a42ea2.

The Fixes commit was checked against torvalds/linux: it adds both the
"return 1" okfn and the RX_HANDLER_PASS return without the *pskb
assignment.

 net/bridge/br_input.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index fc2e381..b5bd9d6 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -257,13 +257,18 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 		br_fdb_update(p->br, p, vlan, eth_hdr(skb)->h_source, 0);
 }
 
-/* note: already called with rcu_read_lock */
+/* okfn of the link-local NF_BR_LOCAL_IN hook in br_handle_frame(). It is
+ * only called when a queued frame is reinjected, after br_handle_frame()
+ * returned RX_HANDLER_CONSUMED for it, so the frame can no longer be
+ * passed up on the port and has to be freed here.
+ * note: already called with rcu_read_lock
+ */
 static int br_handle_local_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	__br_handle_local_finish(skb);
+	kfree_skb(skb);
 
-	/* return 1 to signal the okfn() was called so it's ok to use the skb */
-	return 1;
+	return 0;
 }
 
 static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
@@ -424,11 +429,14 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		/* The else clause should be hit when nf_hook():
 		 *   - returns < 0 (drop/error)
 		 *   - returns = 0 (stolen/nf_queue)
-		 * Thus return 1 from the okfn() to signal the skb is ok to pass
+		 * On 1 the frame is passed on here. The okfn() only runs if a
+		 * queued frame is reinjected later, and must consume it then.
 		 */
-		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
+		if (nf_hook(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
 			    dev_net(skb->dev), NULL, skb, skb->dev, NULL,
 			    br_handle_local_finish) == 1) {
+			*pskb = skb;
+			__br_handle_local_finish(skb);
 			return RX_HANDLER_PASS;
 		} else {
 			return RX_HANDLER_CONSUMED;
