Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680487;
	b=McaRGLHuAR4bYOBBfEdveDcgIjJ3WmO9IQn8DeXkHwcet9WmV1F65zsfGnAqfKHXmRec
	 8dCQN9yyCXPzc7Me0ApNYKlHFbRVGTUq1y4MzzOtfTCzQqv8N1xu5xWq4uWdZlpPf7hZ1
	 b3Am3wsHzREFbQ2USHEnbcv1ry1XdCaPBLN1uHa6uc0uwf+GYI/XatUCTI/x6wT3O+STx
	 Bl4STFRFG3JIQRDl2zJSn9dHeYa+pOdvb6vwrG+ih2yUvxCVQKrPMbNHaIjuBr6qEeVM8
	 3KTaSmaegtizxca6kS/6WMmVY+O6gFLy0MUyqpa5TDT7tO4xutD0leuxNn2jEQQusNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680487;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Q+aM+fy0D+ySuVwoLewJrpKeHZuTfIKKugBaktrIbvo=;
	b=v2dl7NIjG983aKA/pmdUrCtUAtKjTyLY5RXkXskpKOOhs4RpNO6YBLnIrX4jX608qgdl
	 bEzk96G33oJtuHbkMplFZTZA2Vce+gYdahulyh0CgKQ5TuVDAzGvObkVu286Y7JNiWaDm
	 wuuoDKQaBbBpCYHocGCnXFZ6P5ULttL/OUpWjC/yZ0XyOtelmOxBGy4cQaW5xacASLEcW
	 1clqFqkFMvfcgTz9astlnqq9OtNEkb/xz8qc0Q9sqiWSpCY68+gMNZrhsMp50AJJyKwZO
	 /NwM3uYHo30hEWWTh/1S5MJmpnHntlqIQJ3QKD0/Sy8LztFJ5Z9+z7ASaNT0BTklLsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HI5knbmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6633606A321
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6633606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HI5knbmb
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DD99F205A77;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+aM+fy0D+ySuVwoLewJrpKeHZuTfIKKugBaktrIbvo=;
	b=HI5knbmbTSFXE3sl/IZttPR6kUKMUq3qACHiqPP8rMVCSg0CBSGfJXmkZBPTbl9sWdJfSU
	EmszcfgOE/OHB/fWUdJpj0FU0ueC6UNPUCPrCPHTomWsN5yLt+A5Llia4RO9u6UywoYa42
	JO3vqAYUZ+NUjm98sU0GwINOE0asPn1rVikn7BHAwJBYD2NOAMTc1PzbTO5zS/TsyPdni2
	NiwoKUVyHtbc7QVtgXqHMqofdPl/7mqcJYhjRQ6GYUQqO6idwwWBKgYN2SOLl+REA2vqx+
	6hSTUnvEOiQhx1K/O4+O9IG6M4fUvPQEz/OyPJKxD58ZycEzpMzWmUwGxVOdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+aM+fy0D+ySuVwoLewJrpKeHZuTfIKKugBaktrIbvo=;
	b=IDm3O9s8nEL6gXqVGwm1H9UYcqwn5zwREiYf7+sTb4OkMysKzJmaJtw9IyyTQeKfZ7cuOs
	ij0kwKznAfcnJshidcwvVscVz8TcEbqXO3Y3//niqbbFbccg1ns3f7ZGbkvqmI+Px6CWiS
	hzoQ0eVaxnuznMHIi0GLq5jnB1PIbNjyT6CZOsX9Q1ajn/vvWPhDxQE/S/MNYN3p36Jy/c
	eqoRs2EW8qqbcLz/UXwo86nIK/nR/9TaZ9VdHy9qfaOscptKifappJlmSRe+E8R70DB0vn
	y+VzpjVg5dnzNN+1PvpMN7HnQ3i2O6RP3G8P+6fq0ZfktUmoftgYULJBLKq/gQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=A3YDNf7qwu0UrvXVRH+wg/e6yHDdcouoJgAI1y3lhnmWbU9ID7L0c1f8e3ihM4iT3AP9wU
	BssPuqZAIV5X68eHtvWSVRWiQk0pEUSFVcJZKltX9r+v6MHPgU/N68NYE8EJU7791W0dCa
	JTLhXI0qoSBCJtMDXqc7iDFrl1r2CmrfG7tuw4ontuBHs6WUCmsEoITvocmlRuHgnhpyKL
	fH4u5bWcf7ajh7F5ZHuMm6OnoktpT7VywJxKCjjO0YKJL15sBH5EN3tHyNAVJnxDy0XNF/
	+RWOf6JP1XmKzIrTtlCKE5brwJlVQWaaPc3Ak8/66tmr+rbgN5XmrEXzJi78oQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B9361380C95; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 26 Nov 2026 09:07:52 +0100
Subject: [PATCH net-next 5/5] net: dsa: microchip: ksz9477: report the
 trapped link-local groups
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
Message-Id: <20261126-ksz-stp-link-local-v1-5-39aed15f6271@pengutronix.de>
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

Tell the tagger which link-local groups the KSZ9477 family and LAN937x
trap to the CPU. The tagger then no longer marks these frames as
forwarded in hardware (offload_fwd_mark). The bridge applies
group_fwd_mask and the STP state to them and can forward them to the
other ports of the switch.

Tested on a KSZ9893: with the group_fwd_mask bit for 01:80:C2:00:00:0E
set, the bridge relayed 20 of 20 frames to that group from lan1 to lan2
with this change, and 0 of 20 without it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477.c      |  1 +
 drivers/net/dsa/microchip/ksz_common.h   | 12 ++++++++++++
 drivers/net/dsa/microchip/lan937x_main.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index b972c9fab55c170758dac97bda026e1f29e487f2..3dee81d89c1d7e64314a073980fb648431126a09 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2109,6 +2109,7 @@ static int ksz9477_connect_tag_protocol(struct dsa_switch *ds,
 
 	tagger_data = ksz_tagger_data(ds);
 	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+	ksz_tagger_set_link_local_to_cpu(ds);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 7b96d110b1f64f4226ee7a371da38cd7e5b3767a..1f96b91016fcfa20f99599c10d4095d7f384f7f6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -7,6 +7,7 @@
 #ifndef __KSZ_COMMON_H
 #define __KSZ_COMMON_H
 
+#include <linux/dsa/ksz_common.h>
 #include <linux/etherdevice.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -836,6 +837,17 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 		dev->chip_id == LAN9372_CHIP_ID) && port == KSZ_PORT_4;
 }
 
+/* Copy dev->link_local_to_cpu to the tagger. Call this from
+ * connect_tag_protocol: ksz9477_enable_stp_addr() fills the bitmap during
+ * ->setup(), and DSA connects the tagger only after ->setup().
+ */
+static inline void ksz_tagger_set_link_local_to_cpu(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+
+	ksz_tagger_data(ds)->link_local_to_cpu = dev->link_local_to_cpu;
+}
+
 static inline int ksz_get_sgmii_port(struct ksz_device *dev)
 {
 	return dev->info->sgmii_port - 1;
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 7971d120630d173a1bbed6fb98683cee27d8fe89..7452b8c6a73552d9ae4f410dead3b968f22124e5 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -924,6 +924,7 @@ static int lan937x_connect_tag_protocol(struct dsa_switch *ds,
 
 	tagger_data = ksz_tagger_data(ds);
 	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+	ksz_tagger_set_link_local_to_cpu(ds);
 
 	return 0;
 }

-- 
2.47.3

