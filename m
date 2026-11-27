Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800035;
	b=V6M1qXLhSuYPpBxN0RuC5J/c5271NILsP8q716aDn3wEhz+7EsqIQPFtFTbN329zN+/L
	 dE7ptO2Vt0XvjSB4rAws8rWZ1HTqw5PaQ3SWIhQOAiBFgzoXHutTktoUX9Nw3srYEBAsV
	 XcnMcOuNubjbWeShWMuNR53T61W/FWKdt90aUBccEEwJJ9CTyRxK4Edbe4ETZuk3e0MeZ
	 JwQywqDOMnwOYi23CSgioKAuzDYn1i1DPLjp91LHMz7wxfytjgrBKQM8qDWtYa0PpFd6V
	 rbHSqlfTIAMHI80kmean7oREqRbjRAwBUUL5C5Dd8vnf7UudcvfJIsWySqDyYy9owJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800035;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=rz7+56DcQZ669uhOYmPdyb0yc62fQtoJngeIKjsraWE=;
	b=Biqc8xu09L9jQhbKttQ2vRrrnayppCBaco/bMF7MWzvVNnMRevuna5heDtmAkHKKyst9
	 pMF4J76HIMuMYMKxxmVuhEe2/nTroqM77Od7ykYKehLtW3alag6VAOhLGixtzVCdypQyG
	 wQcjdyV/SYkOA8TzswsNskU5SCvvp/SM8mxF8Nc7pZ6Qms0bRitBEFK/9Of7fuUsDgudr
	 tNmBwGppQneo7gVV+qbqNqixzFtkzU6RKhpc6DdQg33NktAvlOOG5PddRHoi08pN+lZkc
	 GuiGgEqOYFPd3oVEqbmGk8x8xxZbPgMXPJlDXk9PaGsqFJDdvZDc+GVB7NsWhJqcmbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDF606A339
	for <bridge@lists.linux.dev>; Fri, 27 Nov 2026 17:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BDF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 958D32295D;
	Fri, 27 Nov 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D439E13432;
	Fri, 27 Nov 2026 17:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Yb1MH67CWuMAwAAD6G6ig:T14
	(envelope-from <fmancera@suse.de>); Fri, 27 Nov 2026 17:20:32 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	bridge@lists.linux.dev
Subject: [PATCH net-next v4 13/16] net: bridge: guard ARP/RARP proxy and suppression with CONFIG_IPV4
Date: Fri, 27 Nov 2026 18:17:58 +0100
Message-ID: <20261127171824.27362-14-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127171824.27362-1-fmancera@suse.de>
References: <20261127171824.27362-1-fmancera@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 958D32295D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

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
index f306cfbc1679..695510d43733 100644
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
index 0a1ce9e59a4d..8210042d975a 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -70,7 +70,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	vid = vlan ? vlan->vid : 0;
 
-	if (IS_ENABLED(CONFIG_INET) &&
+	if (IS_ENABLED(CONFIG_IPV4) &&
 	    (eth_hdr(skb)->h_proto == htons(ETH_P_ARP) ||
 	     eth_hdr(skb)->h_proto == htons(ETH_P_RARP)) &&
 	    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b5bd9d6808fd..1641ab547705 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -168,7 +168,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
 	BR_INPUT_SKB_CB(skb)->src_port_isolated = test_bit(BR_ISOLATED_BIT, &p->flags);
 
-	if (IS_ENABLED(CONFIG_INET) &&
+	if (IS_ENABLED(CONFIG_IPV4) &&
 	    (skb->protocol == htons(ETH_P_ARP) ||
 	     skb->protocol == htons(ETH_P_RARP))) {
 		br_do_proxy_suppress_arp(skb, br, vid, p);
-- 
2.56.1

