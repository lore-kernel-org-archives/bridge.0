Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C664F93B9
	for <bridge@lists.linux.dev>; Mon, 28 Sep 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623950; cv=none; b=oTkvJKWFRAMOBz3E2v2FFxycralPYnxo7VIp4/sP5z5gLc/x+KNMlPmvTVTpo5mJm5D++NW8p1lnQVKJUby0xhNROO+PK5oUKHnFSObtsU4whFezptYa9fIv9mxbnnjgwf2CiWq+M7DCKWkzHmChBnTnzhtPcKcNnnSLmfwHmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623950; c=relaxed/simple;
	bh=2ArWc7PKEsYEx+mNuhgkZOQUdQG2ojj+JQqjWtrHnB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhxx45X4AxonTQxJoFC8uJageOlapSFenodtjuFzWyvxT0wFJm8Rw1VNzHmbZBwSkx0pgU2IfVizusEO3r0nCXl1PwLaDAwW+bOpyB0AsOLNhhMnCq50AiXS0RYobpqpl5LBjoDM8Ldgc37KYC1H33n3cwrxdWCWwPPfNrQmFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HcaselTZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1NTSBWTO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nh4+NyJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=awFvs/Rf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HcaselTZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1NTSBWTO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nh4+NyJ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="awFvs/Rf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 662F121BF1;
	Mon, 28 Sep 2026 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8h5Jzz8XpngoZnKBoT06ZAWwhOL69A3yCz3x1aRlA=;
	b=HcaselTZPkQclKcIFmpORAAhKEsYYzXgdTIcP9iut6oCnZ8S/tLEAljCWMnF1K9WfEj0Ad
	VjzYV/Do1UNUDziznAi2v9FPoCLdhvyLjJCRg5fs8At7Oqr59xBcO3n/VgSPmuMQhtsWlg
	wmpgncDEYXkk5bRLAb61KguBXzmEUjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8h5Jzz8XpngoZnKBoT06ZAWwhOL69A3yCz3x1aRlA=;
	b=1NTSBWTOL5jM9NYam5D3QAOejgEawc9czQLxWXPx98iwWxsfK4gkSO6M0gixjus0I+eBk0
	P5sLoZSRZVUZsZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790623938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8h5Jzz8XpngoZnKBoT06ZAWwhOL69A3yCz3x1aRlA=;
	b=nh4+NyJ8mmYRt5TqEMmBvpEHOHx8QynfIuYDVh5tkF6d2sH6+lT1yTrmIcFVZVuork2QyL
	BVs5AW12doU92aFHUOjygAGg+ERAQglV1BkbcSd7ZtTwBK5l2mvbDE9HBGhJcAq9dUpg0Q
	bWQeijJD4vLpXUR80o8nnQjmCZC3TWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790623938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ8h5Jzz8XpngoZnKBoT06ZAWwhOL69A3yCz3x1aRlA=;
	b=awFvs/RfPrlCPz4TJ2/m3tybU96vNvANo4sUBSpN1B3g2esqIPnUX3pqx7AyZdXvMHygZK
	4+IuDffXmwFtv+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9413D133F1;
	Mon, 28 Sep 2026 19:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RBiFn3AumpWOAAAD6G6ig:T14
	(envelope-from <fmancera@suse.de>); Mon, 28 Sep 2026 19:32:17 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/16 net-next v2] net: bridge: guard ARP/RARP proxy and suppression with CONFIG_IPV4
Date: Mon, 28 Sep 2026 21:30:09 +0200
Message-ID: <20260928193046.6698-14-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928193046.6698-1-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Historically, the bridge subsystem relied on CONFIG_INET to guard ARP
and RARP proxy and suppression routines. As CONFIG_IPV4 is decoupled
from the core stack and made optional, relying on CONFIG_INET is no
longer accurate, as ARP and RARP are exclusively IPv4 protocols.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/bridge/br_device.c       | 2 +-
 net/bridge/br_input.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index da15f4d7c1ae..d739b8697429 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -39,7 +39,6 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_NEIGH_SUPPRESS_ENABLED, neigh_suppress);
 }
 
-#if IS_ENABLED(CONFIG_INET)
 static bool
 br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
 {
@@ -57,6 +56,7 @@ br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
 	return br_is_neigh_suppress_enabled(p, v);
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static void br_arp_send(struct net_bridge *br, struct net_bridge_port *p,
 			struct net_device *dev, __be32 dest_ip, __be32 src_ip,
 			const unsigned char *dest_hw,
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ce9ea9ac3d0a..a3e5a521178f 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -69,7 +69,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				&state, &vlan))
 		goto out;
 
-	if (IS_ENABLED(CONFIG_INET) &&
+	if (IS_ENABLED(CONFIG_IPV4) &&
 	    (eth_hdr(skb)->h_proto == htons(ETH_P_ARP) ||
 	     eth_hdr(skb)->h_proto == htons(ETH_P_RARP)) &&
 	    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 4357d78524a6..584ac6c2215c 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -166,7 +166,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
 	BR_INPUT_SKB_CB(skb)->src_port_isolated = test_bit(BR_ISOLATED_BIT, &p->flags);
 
-	if (IS_ENABLED(CONFIG_INET) &&
+	if (IS_ENABLED(CONFIG_IPV4) &&
 	    (skb->protocol == htons(ETH_P_ARP) ||
 	     skb->protocol == htons(ETH_P_RARP))) {
 		br_do_proxy_suppress_arp(skb, br, vid, p);
-- 
2.55.0

