Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E34EBAF2
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776517; cv=none; b=NIK9eM0WdtQ56IUlKb1tafAz7bA1WUyrPRKEmG516Yk1A/DKcifLudF2xoXacgEh7dcADCYhHI/ArDiF2fSmBVvRpH8EbWzSs3Sip9MpuSVjmof1PFGVy2qnJehJ0nL7rcEfLVNhdujNtlKiJ+mX3MMOery4OhmQpIDGHbstVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776517; c=relaxed/simple;
	bh=BJfJsH7u/KabYwn1gfaXZQgkK+c70GaVRNQoge0+bb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeaGTOWCi0kXgp+MEZ++MwQdFV6uvFyL6nY52PFuHMtRazg+ZABj6UuXG26IriNFkRZJNWRCPpiWjjLhxJ8yr3CzaIVl7mpBpMv5egdsFWyrQm843bUdRJPuxts3ytgBn4aJWthZwWa+ZccLL1EhimBRyZzmjf+mHhjEdo+Y4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ffn0jxXI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QGx3eoOq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sigd4OPe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TxdzZxjq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ffn0jxXI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QGx3eoOq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sigd4OPe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TxdzZxjq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0A5721E2E;
	Wed, 30 Sep 2026 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRoojsHyvekZs9GgNbVMT/6QqrOZO2xI3J+SCUqf6U=;
	b=Ffn0jxXIe69rM5jjvakNvSFlXFFoCiX9IAVwxqPztfarNe2GEMHi1m0aKwTov0Am0Kwp+9
	pHI6gwyGsFiKvt3OeimZ4+uJr9jfhAEoOSh74O4/wJonda1+pVACXKBjaJmSJ9xHOIP6B7
	dBJ/Y9S+4lcczPuzy18DS1EQDq/Yipc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRoojsHyvekZs9GgNbVMT/6QqrOZO2xI3J+SCUqf6U=;
	b=QGx3eoOqEKOEgTpgc8QImWuVkWhXznDaeOEjZRRgiKX4sHCy8/+KCdItDLJMinuWcsolyQ
	efajyIX/oVqxffBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRoojsHyvekZs9GgNbVMT/6QqrOZO2xI3J+SCUqf6U=;
	b=Sigd4OPetYhkz9sfmodxT6cwk5EZwEiZppDRlehirYdk2C+QOQKQa6obsIf7/eyyi4qfHG
	bKbIWjWRjKXndWfGiUNuSa/y+uaZjeYXu7CxJvnn7IcrKvAIv5HrdmYYC1ENNoPYH4Q1J+
	FGBWZbzGzm0V+KnIvYF2/nSWyLAXIDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRoojsHyvekZs9GgNbVMT/6QqrOZO2xI3J+SCUqf6U=;
	b=TxdzZxjq8B1U4CmTBPj7oUb8HVy+wi+8ulf2CMWYqMOkBaAqueOGUGxcA1cZYAapW+zzTm
	tBgvz50FNX/7j+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 247DE13ABD;
	Wed, 30 Sep 2026 13:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig:T14
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:54:46 +0000
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
Subject: [PATCH 13/16 net-next v3] net: bridge: guard ARP/RARP proxy and suppression with CONFIG_IPV4
Date: Wed, 30 Sep 2026 15:52:56 +0200
Message-ID: <20260930135334.4739-14-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260930135334.4739-1-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.76 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.16)[-0.823];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.76
X-Spam-Level: 
X-Spam-Flag: NO

Historically, the bridge subsystem relied on CONFIG_INET to guard ARP and
RARP proxy and suppression routines. As CONFIG_IPV4 is decoupled from the
core stack and made optional, relying on CONFIG_INET is no longer accurate,
as ARP and RARP are exclusively IPv4 protocols.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/bridge/br_arp_nd_proxy.c | 2 ++
 net/bridge/br_device.c       | 2 +-
 net/bridge/br_input.c        | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index da15f4d7c1ae..1809648a883b 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -56,7 +56,9 @@ br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
 
 	return br_is_neigh_suppress_enabled(p, v);
 }
+#endif /* CONFIG_INET */
 
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

