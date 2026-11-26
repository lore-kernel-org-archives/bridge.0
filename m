Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680485;
	b=Z61+EPd7SWVdxumdyQbXK9v7oDl+YBoAEHGH9hRlBYIaz8gJ6RbujQgpSZK5UOKPyxgU
	 HhtIhGoCONDXLwVNCynPFjog657NzYSLR/gRp6PJqtwFz+l25hTojO9RRYkM1XP0jDw1G
	 QFenalGfz60YENlaIJ5115+q91fDlY4zxPUtRJQH8aOKsOLYlq3MKpwlEA2YX1319vh4D
	 h6k+7EUeXYrHh3qXlBY1PBRHBUyeWTYTSxffikOk+3FKfxcw9z9b8IaPFF0zVg1QRnErD
	 Nf04ZeUxbNFFlbNHFzJP20IDtShep7Bw4a1BJETg4Wp1t8ZsDQvn4qqj8x0KfNzpAhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=J5L7cdjb6qQ3NsyuVCvHf8W0Te3Ajc+ibnZSLdgukm8=;
	b=DLpTUhPUhL+iF9wtR9n45/jWNOf9+c6AGlOc4i318bWBd2uQYJDrhS7U3bAzH3FqVfe+
	 88IZo1HDGDBhfF67uytNcgexJ5ZAaRkIM8bDUULnRYmDqSLkWZiSK72TXyrQvGCJVuBW5
	 u8youBU+QcQEe8YlAeRlGn3ewiC9U26tavFQD6r5cRvqNn4Zhz+n0E9YNHex2YPVgk7PC
	 7pVBf4OVj3ATXoHqUiZ4SvFIXdN7sCanPiDAdWChT/mUycrpTON+hLU/F8MNEpt+b4byy
	 ixsgFpVP9bfgjRzJwAasZWNVohprrN8xxiP1MSCfV9FKC7eUl9ACx3bTRfXAY1Cp2TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="V/LGefiQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8C606A327
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E8C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V/LGefiQ
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C4241201AEF;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5L7cdjb6qQ3NsyuVCvHf8W0Te3Ajc+ibnZSLdgukm8=;
	b=V/LGefiQt1BlT3oDFveuoxfBINTf06Cm6xS+dP+UjjoMBdN0VI/gWJbwxReGVoWelq7FdI
	LCtH8W83sbMKClgvKtBq4Z/n/VVxRTjydluzj+1T6rQRr6dBTy8/+2pgzHqEJb1BvtNCvu
	w8uIQ3g3xskKtHrZTaR0nyCbod0VGJVsqE84f3yEbzZGZon17FrdkJDY2NF1S1+HYYAZC0
	t950yJofAz3Md3Cr6FWHvgxu1SfyjtwMi560P0+yy53qqqxffvRkIUl9OacvvT++mk2gIx
	BwFbqXQ7X7lVHUvcSK9kxAYfTf7S7zG9xQpVp9YDLQ+JqM/HsuDqHTvsa5eW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5L7cdjb6qQ3NsyuVCvHf8W0Te3Ajc+ibnZSLdgukm8=;
	b=WM9rsl6+QLo+H/WV/kTrEfLuJ9Kdbg+Ambrc4mwry49RIv+dHL7rBQqCKVXoPstWnlX68T
	iT53VJqCLOmo1jeiiwg2rnH3ICeEhIYAzjorGaMp4DZKM1vtinzsh6XysxcDs1tlkvKToL
	g6YwZawuCHaa1Tqte1Y1QyVhgKAR5114fBsdL93qCbLcWJpeWsbaplyYLD77FeofkVu7B/
	yftZ3VkGoOOCvrmL/iQn1NLmarfiOcLPuuklBxVaAqgRW3fGl3+Z3tBx0NzigD6PEp6M9J
	23GUzmVsfjViwv7Up386c+CRFQEiTf+6U4ZCaDSyCsbDucazn6Nljy3tmtdf0g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=HiJUPK4uJRY8lF0KiJN17zfK8TnnhsjpatTjAaISjkQDn0r385H882f61pT/bcQ+C/UYkj
	gqrd3Ux4iAG7Xd+hSo2qBlCFL16EpZi3xLKW8Y0fD71FWfPXWyGeYO2h9yMb1MIn+T25ID
	ptb4dOi1jh7NMlgiFCxuXiF/hiTaeLLwR+8VnXCFtf5BoHEInBMcXJQ+BKY0mB5QbVSOol
	tdpz3ETDg91Gd9aiIJ+CkT7nx+z0s7iGboYpSGcnDqQiNDQXIhNPlEcSqyZq8PEtPr3GoB
	zzS/iQBL29OKNDRcKbomsIJBuZE3J1MfR6vclAnX4wpLQi9lrFbAZDAbkcDKNg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B33E83809FE; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 26 Nov 2026 09:07:49 +0100
Subject: [PATCH net-next 2/5] net: dsa: microchip: ksz9477: do not keep the
 learned port in FDB entries
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
Message-Id: <20261126-ksz-stp-link-local-v1-2-39aed15f6271@pengutronix.de>
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

Do not keep the learned port when adding a static FDB entry.

The ALU table of the switch keeps learned (dynamic) and static
entries, one entry per address. An example: the switch has learned
host H on lan1. Then a static FDB entry for H is added on lan2. The
driver does not add a new entry. It finds the learned entry, makes it
static and adds lan2 to its ports. The entry is now static and points
to lan1 and lan2.

When the FDB entry is deleted, the driver removes only lan2. The entry
stays static and still points to lan1. Static entries never age out.
So the switch keeps sending frames for H to lan1, even after H has
moved.

The bug is hit much more often once the driver sets
ds->assisted_learning_on_cpu_port, which the next ksz9477 change does.
DSA then adds a static entry on the CPU port for each address the
bridge learns on ports outside the switch, such as Wi-Fi. If H was
learned on lan1 and then moved to Wi-Fi, the entry for the CPU port
still points to lan1 too.

LAN937x uses the same code.

Found in code review. Confirmed on a KSZ9893; with H learned on lan1,
run:

  bridge fdb replace <H> dev lan2 master static
  bridge fdb del <H> dev lan2 master static
  bridge fdb show    # still shows "<H> dev lan1 self static"

Tested on a KSZ9893 with the commands above and with our labgrid
switch tests: with this patch, no static entry for <H> is left.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
If bridge fdb replace moves an existing static entry to another port,
the entry still keeps the old port. This patch does not change that.
---
 drivers/net/dsa/microchip/ksz9477.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 972703fe7454f2892b98dc507a1cba0a5c91dabd..98211d9835734c52f25dcbf7494df45166bcc8da 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -800,6 +800,13 @@ int ksz9477_fdb_add(struct dsa_switch *ds, int port,
 	/* read ALU entry */
 	ksz9477_read_table(dev, alu_table);
 
+	/* The ALU table holds learned and static entries. If the entry is
+	 * not static (learned, or none found), clear its port map, so that
+	 * the static entry lists only this port.
+	 */
+	if (!(alu_table[0] & ALU_V_STATIC_VALID))
+		alu_table[1] &= ~ALU_V_PORT_MAP;
+
 	/* update ALU entry */
 	alu_table[0] = ALU_V_STATIC_VALID;
 	alu_table[1] |= BIT(port);

-- 
2.47.3

