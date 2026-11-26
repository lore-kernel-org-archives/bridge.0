Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680485;
	b=bWrLzPU2+nlZ8mni2PFSmVubRSZSszQGolDkQwWcnDx7T4TRTmqTve/IUwiiZorKOuV2
	 KDV6diSx60rNvu8SPh95lZ8u9InRrbIuug5KEi+HqJ69vzydRYIn672NC9KoLjRolvRkC
	 7jyrIRHgRS9kkTRlajbUY84/eym1x8KOVhlp6mn4ggsEZNnPEw9P5YyXf92NnKjC86Rcg
	 Hu2NhoPed9JXEKV2L6/BQwfIdLbRMKDnP0l08oML7owlQaiJpUK5Nlw0iPCJXACEapcUE
	 wxhCq0ULO7GCQBJpYYMJ0OZzte6pijFX+oP4bmEDAGxdNKKfSHWHAj8VGqUWuU9Ch2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=5emaesRPp85GbypB4BiWqH9+QqRCcuVwTK4b2tLxYG8=;
	b=kMSKZVEY72txfzMKxN39gTkhAxrcLSaL44XOdWQmd2XAbiLCZPFx0mx8fa5VraPDefBm
	 FJs9SZjy9S+sFja8Gv0vZzGvDMJ6nTA0X+Ras+rs5zORdlVENtzbyteUg7DblqxY1dUqw
	 ITEi8SnYrekuOYahuum3+FsN5JG5Jk6imw4ehtWZG7DESCzERCjqX8q4fJBJ6g0PTGG//
	 /gnhnXTJngUvazLrTNMdHNSgpd7zz3G+AEAaSM1q98GSW7n7rxynYL0/+xp92NDfBxyJ9
	 l3SgaJkrz1kj0nbCI1eod2VjlFdwHpa0Kxie5CB26eze4EWn4qF5kB/WOyVz1F6zYfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ca+aD0Hf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5B606A31E
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C5B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ca+aD0Hf
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D24E32007F9;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emaesRPp85GbypB4BiWqH9+QqRCcuVwTK4b2tLxYG8=;
	b=ca+aD0HfLoMiuMglL7pBN9JQLeFw/pGveKR/egGTer2hq4/FuqZweY3AH2+rwrs7dLYvVa
	uDP5hDDQlk7TeHSjirb7zxJhCzWKA4DqmdGH5TD1g85m7yhm33VqR7GBJkx5zjEYgWD3+/
	TRaw+jQVLnVUdYgZVdZGO5W3cI1oStO5p6rsEe1Z06//XLN4YclNUM9r9NV/DVs+RWx67+
	JnBCitm5Meer3hz74OcUNBekZA3J/OggvvHsNpX06aBfgWK2wZyTftmW++SmPKRA8VaFUc
	jLCrOQjV6Icn9rDwZzhwIhSqFXFSTmnD2V2RBDO8ngC4bzahB7nChonSRjLOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emaesRPp85GbypB4BiWqH9+QqRCcuVwTK4b2tLxYG8=;
	b=LUAetap3cMxJeeCngx7qqvWhCbB/i+u55uLrT1ItMLggLEaguWFb/GCzsepTVWXo9I9xQy
	4pQuSMd/Q+oX77GZ4GFDeD42Pr6AkRluI7MQcXXUl0LOBPL0hcmaAmvABwGyZVgUdHUUwN
	sajWp8JcqE1Hf7wWjHGrqwoJfndRxPIINsg06v4azr1NJNZ4U6YLpGOtIMLaQqvVCPhS/P
	RRUVWU1Dst1ZnA8ycBs+DIHdrI8a1s8hXRTkAMfKYhPL2A8LS136gHlNSiuXgz0PLZkxY2
	RfvFMY0h4m/uQMtyjgeawHUAJX5x4MAron9QSO2vU/djIkJkJ1vGLs1wcmnvjQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=ZltF1Z+1gRdBaqYMemOjedLmkD28Tje4kKpB6Kqrv1Af70nRvUkcjdTO2OFvcMN06aFelJ
	hxbK+INq2k6648B+JGfEZRpby3CI2JBzi37ZV3ZIJsw1UPdQtzpNz8h3/YyO8clWGWa7/P
	4Xb/yaGALhY6os9WqkWnpfWDC7Es6sMbWbH9mcfdazAZTnBAXIkEdvjoGYVgp/FlN1kNLA
	+pYJMr0NdcQIkwq+ud4K+RAi3nimlJpIq4zcNwXZQWJ/FmdimQrCXcQuGYPg4jC04xvdJv
	/YY30eQot6YwIPlsx1YNWz8SllHB/B+KQnj37l6SEFnJNxhngPXyu72yezhLGQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B540F380B31; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 26 Nov 2026 09:07:50 +0100
Subject: [PATCH net-next 3/5] net: dsa: microchip: ksz9477: do not learn
 addresses on the CPU port
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
Message-Id: <20261126-ksz-stp-link-local-v1-3-39aed15f6271@pengutronix.de>
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

Do not learn addresses on the CPU port of the KSZ9477 family (including
KSZ8563 and KSZ8567) and LAN937x. The bridge also learns addresses on
ports outside the switch, for example on Wi-Fi. DSA adds these as
static entries on the CPU port, so the switch does not need to learn
them there. DSA already adds the bridge's own addresses there.

This prepares for reporting the trapped link-local groups to the
tagger. The switch sends trapped frames only to the CPU. Once the
groups are reported, the bridge can forward such frames, for example
BPDUs, in software. It sends them back to the switch through the CPU
port, with the sender's source address, and a learning CPU port then
records the sender there. Frames from the other switch ports to the
sender go to the CPU, and the bridge does not send them back out. This
repeats with every such frame the bridge forwards. I saw this on a
KSZ9893 with the report patch applied.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
HSR: the HSR ports are in no bridge, so DSA adds no host entry for the
HSR MAC address. From the code, unicast to the node is now also flooded
to the other ring port, where the CPU port used to learn the address.
---
 drivers/net/dsa/microchip/ksz9477.c      | 15 ++++++++-------
 drivers/net/dsa/microchip/lan937x_main.c | 15 ++++++++-------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 98211d9835734c52f25dcbf7494df45166bcc8da..8271bc742ddc5c92b925b01bedfcf876cfa14078 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1710,7 +1710,6 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	u16 storm_mask, storm_rate;
 	struct dsa_port *dp;
-	struct ksz_port *p;
 	const u16 *regs;
 	int ret;
 
@@ -1792,13 +1791,15 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	/* Start with learning disabled on standalone user ports, and enabled
-	 * on the CPU port. In lack of other finer mechanisms, learning on the
-	 * CPU port will avoid flooding bridge local addresses on the network
-	 * in some cases.
+	/* Ask DSA to add the addresses that the bridge learns on ports
+	 * outside the switch as static entries on the CPU port. The CPU
+	 * port itself does not learn: when the bridge forwards a frame in
+	 * software between two ports of the switch, the switch would learn
+	 * the sender on the CPU port. p->learning is never set for the CPU
+	 * port, so ksz_port_stp_state_set() disables learning when DSA sets
+	 * the port to forwarding.
 	 */
-	p = &dev->ports[dev->cpu_port];
-	p->learning = true;
+	ds->assisted_learning_on_cpu_port = true;
 
 	if (dev->irq > 0) {
 		ret = ksz_girq_setup(dev);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index f0fb9498026120b3069b31d01bd0252be6f15403..7971d120630d173a1bbed6fb98683cee27d8fe89 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -770,7 +770,6 @@ static int lan937x_setup(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	u16 storm_mask, storm_rate;
 	struct dsa_port *dp;
-	struct ksz_port *p;
 	const u16 *regs;
 	int ret;
 
@@ -843,13 +842,15 @@ static int lan937x_setup(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	/* Start with learning disabled on standalone user ports, and enabled
-	 * on the CPU port. In lack of other finer mechanisms, learning on the
-	 * CPU port will avoid flooding bridge local addresses on the network
-	 * in some cases.
+	/* Ask DSA to add the addresses that the bridge learns on ports
+	 * outside the switch as static entries on the CPU port. The CPU
+	 * port itself does not learn: when the bridge forwards a frame in
+	 * software between two ports of the switch, the switch would learn
+	 * the sender on the CPU port. p->learning is never set for the CPU
+	 * port, so ksz_port_stp_state_set() disables learning when DSA sets
+	 * the port to forwarding.
 	 */
-	p = &dev->ports[dev->cpu_port];
-	p->learning = true;
+	ds->assisted_learning_on_cpu_port = true;
 
 	if (dev->irq > 0) {
 		ret = ksz_girq_setup(dev);

-- 
2.47.3

