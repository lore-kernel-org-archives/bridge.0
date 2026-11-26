Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680485;
	b=zvQ+4X+zUgIa0Af8OHm6kUQPm/e+rFjAcU+Y675JWliDSkN+d/LfKaZANFIr0A44WIVw
	 tF4D/CWDa6kUOJUFrkhDv0zpVE+sNLFwZASW2PCXUntmBtgloLZKEse3KwhQnG1tDAfR7
	 F0ztktN4bksZff6UQVtwBTR/qkeLtYCvIwEPutzLHOzCXACDf1ashN6TFNPk/CQPgwzf/
	 VJEQ6r1gxowAhsjg563EcgvmzZGPQ5J//fnKpWsHgLyR+2+Wj3JgOuaaCrW6RIv7Qo6Ik
	 0j0byXh343igMccwMaImzFLA26D/U9HSOx4MXVuzjr322YnQHtkNCDnvQoCDN2HxnIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=raaNMw1b1+qbfeYf4Sx2uW/rpWKmRrAw1X2GGZpJzjQ=;
	b=rHQMBaPFcvJT2V+uLF7scIE+gDQPOOA4v4hERR2R7cCXKRBPH9AY2DUqAEYiIfn3gj/U
	 MyVEiJNCHUdSW4TjwQLISpvrpqlzCtjbn5CeOP9XBu6pw8UJe/i+I9CX3dmTtWm1M2ntx
	 rJ7Nrb+ArsXZZFxgsgGr2b5cugksGnWAvQzKq1I+PSxqP7xAkNTDo9l6M8yGCpXUh12nW
	 cjQGwnqA3cNxkICHLkFgoCKg7/LiJKMWlqHvLZvpJG0CDkPhw+1dHVgLx2jymUPqEPsMd
	 ixFOn5oPJzbwVO3+l2Rdlx44TfdLgARjZLjbbxyLt4b4ooG4GbkkoOj87r2Z4V2ZyQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MOoFwcDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544A606A32D
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8544A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MOoFwcDM
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C982820583D;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raaNMw1b1+qbfeYf4Sx2uW/rpWKmRrAw1X2GGZpJzjQ=;
	b=MOoFwcDMipHsYsMytC6GSxUZu/VL0pzcT9KTMUJ14cfiLLUtRitsO5Ho+njFJuBc6Jyfcr
	hk9AeaTvuWC1UiLsJLczSiflW7BMyrgC8GaCfeJjj4LmslQZHSX5ZNudD3B3SejW/hYU3L
	0AzFSCqzCe5tjwEc1r63ok0+H+RG40aVKb77cHztsNFVhnGNWNUp6SMjDi+EujtImuyviH
	3eD/MKaeGWdTHNOhrj1tRPH3V5dlkXHrRSt+R8ocHSkeO02zltZW3mDHOiIm0olaCoZHrL
	e4f7vm5xszpEfMFAGdfTaKoBMD1klw9X3ZtR/T1gIn8UJNlxhqzg56DnkDFt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raaNMw1b1+qbfeYf4Sx2uW/rpWKmRrAw1X2GGZpJzjQ=;
	b=QyVvRxakUx0/ReD0r6rlVkmOPrlUcD+WuR1MYS+BML1bOJY0bS6eZef+afXwdMQ5yVUbwB
	zdMbQL16ql4jamwjU/vRSo/W/OokyYYuUEHH2olpIs/vfvZ9RsSPPZEaBF/NSxb7Jqf+Za
	DtgsN2LR/WC+NpRDKYxcOjelJ9yR40z8/GrHsyF49BUdEfBlMptRxBGPbCmCfYjkYju4Kp
	irDxtIzFo7+QlP0f/pOV+XDJ+TYLjFNZw/IGCPhVYMW3jteGRpUjbnZkckDpWxxk9EDe27
	/wERvnvIG2zABroL31iEu7QUCLdTlOqCtyxXiiHzQY6XZV17EFBM83ztkDcT3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=DmPgm0t8VoUfrJMJZCVsievPj4KPwundBp5tT5UIiUrZkUO6qRg4ABNMPcqHp2a0CHSKWX
	Rp1idwzZ0BFk6e3dRW+TG1OsczMSEC9wXc2canlqQtcCN8DpM7vzXKVPV8TMWksQwPgxRN
	8/dveq3lveLx3B1G4XFHDRZJBL8cbKPw21QgF6QE+Knt6IQv2pYnW7cpbwrSyrCZ63K86/
	bRfP29nLVyY1zoF7kpAIJMb8SvYd/yPxpglIvmAseFa2aI6WbqQFFkcLsF6bYb313Y7iJD
	RYpfwpTU/5QjWeyVVsid2EYwfcVpRwC6Cw3Je3awJi1qbFIZOuIhkOTCQhfbGw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B1556380122; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 26 Nov 2026 09:07:48 +0100
Subject: [PATCH net-next 1/5] net: dsa: tag_ksz: do not mark trapped
 link-local frames as forwarded
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-ksz-stp-link-local-v1-1-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
In-Reply-To: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, bridge@lists.linux.dev, kernel@pengutronix.de, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

Do not mark trapped link-local frames as forwarded in hardware. The
switch did not forward them, so the mark would be wrong. Whether such a
frame is forwarded is policy, and that belongs to the bridge, not to the
driver.

The switch traps frames to some of the reserved addresses
01:80:C2:00:00:00 to :0F, that is, sends them only to the CPU. For
example:
- 01:80:C2:00:00:00: STP BPDUs
- 01:80:C2:00:00:02: LACP and other slow protocols
- 01:80:C2:00:00:03: 802.1X (EAPOL)
- 01:80:C2:00:00:0E: LLDP, PTP

Some link-local frames must still be marked as forwarded. The KSZ8873,
which uses the same tag as the KSZ9893, traps only 01:80:C2:00:00:00
and floods LLDP frames (01:80:C2:00:00:0E) like normal multicast.
Without the forwarding mark, the bridge could forward such a frame a
second time, if group_fwd_mask allows it. The tail tag does not say
whether a frame was trapped, so the switch driver gives the tagger a
bitmap of the groups the switch traps. No driver fills the bitmap yet,
so frame handling does not change with this patch alone.

Give the KSZ8795 tag a connect callback that allocates the tagger data,
as the tagger now reads it for every KSZ tag protocol.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/dsa/ksz_common.h |  8 ++++++++
 net/dsa/tag_ksz.c              | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/dsa/ksz_common.h b/include/linux/dsa/ksz_common.h
index 576a99ca698d13cc3debd41a310502b29fc85c63..66d480c435c2f98b5a77bc64422b43414946f143 100644
--- a/include/linux/dsa/ksz_common.h
+++ b/include/linux/dsa/ksz_common.h
@@ -32,6 +32,14 @@ struct ksz_deferred_xmit_work {
 struct ksz_tagger_data {
 	void (*xmit_work_fn)(struct kthread_work *work);
 	void (*hwtstamp_set_state)(struct dsa_switch *ds, bool on);
+	/* Bit N is set if the switch traps frames to 01:80:C2:00:00:0N
+	 * (N = 0x0 to 0xf), that is, sends them to the CPU only. The tagger
+	 * does not mark these frames as forwarded, so the bridge, not the
+	 * switch, decides whether to forward them. Only the switch driver
+	 * writes this bitmap, from .connect_tag_protocol, before the tagger
+	 * receives any frame.
+	 */
+	u16 link_local_to_cpu;
 };
 
 struct ksz_skb_cb {
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index b0340a7be8c9a6dcd52a64117e10fe3e134026e6..16da9daf774904222bd92f771086aa74e1bc390b 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -48,11 +48,28 @@ static void ksz_disconnect(struct dsa_switch *ds)
 {
 	struct ksz_tagger_private *priv = ds->tagger_data;
 
-	kthread_destroy_worker(priv->xmit_worker);
+	/* Tags without deferred xmit have no worker */
+	if (priv->xmit_worker)
+		kthread_destroy_worker(priv->xmit_worker);
+
 	kfree(priv);
 	ds->tagger_data = NULL;
 }
 
+/* Allocate the tagger data, without a deferred xmit worker */
+static int ksz8795_connect(struct dsa_switch *ds)
+{
+	struct ksz_tagger_private *priv;
+
+	priv = kzalloc_obj(*priv);
+	if (!priv)
+		return -ENOMEM;
+
+	ds->tagger_data = priv;
+
+	return 0;
+}
+
 static int ksz_connect(struct dsa_switch *ds)
 {
 	struct ksz_tagger_data *tagger_data;
@@ -81,6 +98,19 @@ static int ksz_connect(struct dsa_switch *ds)
 	return 0;
 }
 
+static bool ksz_link_local_trapped(struct net_device *user, const u8 *addr)
+{
+	struct ksz_tagger_data *tagger_data;
+
+	if (!is_link_local_ether_addr(addr))
+		return false;
+
+	tagger_data = ksz_tagger_data(dsa_user_to_port(user)->ds);
+
+	/* is_link_local_ether_addr() limits addr[5] to 0x00..0x0f */
+	return tagger_data->link_local_to_cpu & BIT(addr[5]);
+}
+
 static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 				      struct net_device *dev,
 				      unsigned int port, unsigned int len)
@@ -96,7 +126,13 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 		return NULL;
 	}
 
-	dsa_default_offload_fwd_mark(skb);
+	/* The switch driver reports which link-local groups the switch sends
+	 * to the CPU only. The switch did not forward frames to these groups,
+	 * so do not mark them, and let the bridge apply its own rules
+	 * (group_fwd_mask, STP state).
+	 */
+	if (!ksz_link_local_trapped(skb->dev, eth_hdr(skb)->h_dest))
+		dsa_default_offload_fwd_mark(skb);
 
 	return skb;
 }
@@ -360,6 +396,8 @@ static const struct dsa_device_ops ksz8795_netdev_ops = {
 	.proto	= DSA_TAG_PROTO_KSZ8795,
 	.xmit	= ksz8795_xmit,
 	.rcv	= ksz8795_rcv,
+	.connect = ksz8795_connect,
+	.disconnect = ksz_disconnect,
 	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
 };
 

-- 
2.47.3

