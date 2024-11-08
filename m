Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC83209
	for <bridge@lists.linux.dev>; Fri,  8 Nov 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038154; cv=none; b=eM6W8PaVy8rGi1rmdU3o9d5rlzxyC7ce1aCYhzwYQHs2Yq/r/+UK9AuCgWcfHyl4KR9ekiVngJqmoho427OUIAmA+sFQjMNu1aEUpVth5BAkuZs90w1O0kmMdC2S/tiBapq3F9YDw2pU3oRLoRwZX6mNJLKpwkunozkn+SZNoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038154; c=relaxed/simple;
	bh=YMrctbw1c8R3RzPTQDDEZOuhyCBaOYgqjBxZGhv4cQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgqTv2bTcOvVtgZsRmImGBBW4ZMVt6KkILTaCUrBuZZN/EgTywspQQCWz061d6kzOufURKllRzIkXe6kxmGAYEG2QNfWFwZArOa8dN/hfpM3mUWSe9+zvqASCxsRgGcvgQ8HSUjwHRylfIX8U+xtvSyMEg2VSXVBChfZxfiHANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ud4zCwLA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ud4zCwLA"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E79D12C0540;
	Fri,  8 Nov 2024 16:55:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731038149;
	bh=FH4TyhrfFCr/gDhS0N2GNEgDrOb8sb3PDbcTgaa0Rho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ud4zCwLAm6RpHq6cdsjdbfO5NIkqHdsulsp1PRqaYF5XUaspMLfrr7t4ZfkJ7XqHH
	 ihq+JFxjqy+oZMEeXhawU/XlF7Ub5l7mYnUm+s7PDOY9HNan2ZTIBGzYKP28B76ILa
	 M85FBX6YdcFhGz8+bp3pURxV7QnyeEGoLyDrgcHmkpUlVwjrlyMvIpCiARnnQ7a0uL
	 prpkqkkC4WVWXzR/HbrlDHRLfqMGhAwpMmcjpdSJO6irzLe9E87Mxt5DIXO4icOb1j
	 owpmtm4hIrDWApAiGi4a8HsW7eZD6OLKF00eoy+4CHKIUV473zJWgabkDtF5BYkxal
	 skANzJdYca1Aw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d8bc50000>; Fri, 08 Nov 2024 16:55:49 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id BBD4813ECD2;
	Fri,  8 Nov 2024 16:55:49 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id B9A033C0263; Fri,  8 Nov 2024 16:55:49 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Subject: [RFC net-next (resend) 1/4] net: bridge: respect sticky flag on external learn
Date: Fri,  8 Nov 2024 16:55:43 +1300
Message-ID: <20241108035546.2055996-2-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d8bc5 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=m422leTbPw5OI5gFfpkA:9 a=3ZKOabzyN94A:10 a=ZXulRonScM0A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The fdb sticky flag is used to stop a host from roaming to another
port. However upon receiving a switchdev notification to update an fdb
entry the sticky flag is not respected and as long as the new entry is
not locked the host will be allowed to roam to the new port.

Fix this by considering the sticky flag before allowing an externally
learned host to roam.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 net/bridge/br_fdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 1cd7bade9b3b..72663ca824d3 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1457,7 +1457,8 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
=20
 		fdb->updated =3D jiffies;
=20
-		if (READ_ONCE(fdb->dst) !=3D p) {
+		if (READ_ONCE(fdb->dst) !=3D p &&
+		    !test_bit(BR_FDB_STICKY, &fdb->flags)) {
 			WRITE_ONCE(fdb->dst, p);
 			modified =3D true;
 		}
