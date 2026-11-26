Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680485;
	b=25ePUrJ951m0XOivox0gfNvUtdXFg433SZYA8r7f9ZWzidMLwrESm8y7z/s1849+YxmV
	 STg+DH7HxJhWYcMX6cYTCLXpkBs71HTEK7l+wbmmIo5KovZKqMiLYer2PYQEDzU+luT7Q
	 O2A0SyFyV3A+rCFJgMwh0y1wlDsvKNx7qar8xEPROjD5cjMEq0ejFH2aKhQSTkanFJjoV
	 SR599u5LsVb6oFqseo1dfURbSJsgBsL+MvUgqqfQBK6HQ7z1GVRxMiTxCd307ZAktThYy
	 UOY1e5/jNT0ng8eLz3LinusGHJMm8vCJbOqniZNEGtiPxeDjwPo+Pah0eV+ovBWz4hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=lxKcCoDZx/gqVTq1dzs2u8Ielc5pPpYIq3Edy4HmxHQ=;
	b=TL9nho5wbzaUZJNyjx/a+l/AVbMXuP6gwiURCJ9eBpcCWTTrIHmmdefN8Eucqj6ngMqp
	 FZ2DonJsd8KZOrN1S+HlfrLmqvJIVnjkZfsa5d4X7nU+cPTvalDaWqEmQUdeaD+YPpsee
	 jhzd3mydDFZItIEDmgwHdI9OlSspXo0TocvU7mqLmU/gb1k5uwVsNKSGvTQ4tUxunlZBn
	 8Nm+7/ePeWL4HE3ptpVWPPlFe0PeY8PKgficV3m5y4a4hynBcx4AQCdlVYrPpBE6n6Nm6
	 rWmVEHbiuUv1MsoJpcOe8nhh/9c1nbBZ3rFY3p6M5atwe+rbBmRVHFNrS4BBAfhsbhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SyWK7dQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA8606A329
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82EA8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SyWK7dQo
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BBCBF201223;
	Thu, 26 Nov 2026 09:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lxKcCoDZx/gqVTq1dzs2u8Ielc5pPpYIq3Edy4HmxHQ=;
	b=SyWK7dQoYgwOqSnF5g9EEMTWI/3moeNbZZ8+QkQdOrgtOWLVlbcBFtD8vMz9JcNBanZaRe
	R5pT8IvSoIZ62KDwrA8usJ2YTFPpqSl6DljTw2Shs1M6un91W6KavyrZpcLx+8ZvScf8n8
	vkNMv1ouZLP/FMk49z2Kn1+TCtNmBdugc5TvgNuzfher55we6t3mJFlXxctb173dDUVHjR
	tb8RLZ2os47vNUWA6tvgrhmuiDuNS47tvcvkt2lmeOxxK59uPUQ0GDSDCEbaeSp0x1p5Wq
	56rGnxpDdaVvIWa1M0Z10JJq+bCVSONqYpjzUnbyHlHLZ4ESX3ZH423FZgDBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795680480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lxKcCoDZx/gqVTq1dzs2u8Ielc5pPpYIq3Edy4HmxHQ=;
	b=Ojmquze82debA/t7vZ5630abEQHQTcwCc9gSUczJSRsOUjE01P3dXSGOFZyEzDtHSwyrdJ
	XoW86kVFBJuonAAwvg1TZ8rgvgrDZXMvejHd76ZJBiZ1mqjmvUv7rSG9roel8q0H/gT7qE
	ZEIc7FXiATbd0TbxXKYkJMsAAtsVUKLdwUHMATye8f+B7jnd189GwnQ6G3jQU4j2/C+GWj
	bYWfWWC6jvfGOqH7Z9uieaH7dfjI6fK+vBEsMbGHU/klXIC0f9R1fDau1ye0VqF5KdIy57
	IieOhb6xTgNEHDtkRgYx6cHVuplgr6M5332Q4/kjCyuJjBEWmBHjC2x5XuE7RA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795680480; a=rsa-sha256;
	cv=none;
	b=DuPM5b8H/jePIohszo11W2LP1E9iwREuKI57AnmnS/lTVNFP+a/SSzwnY70qaH5rhI6m3/
	gnWtxNYGPwHX/HTFNu3Exh6rqWxzNgJZz4uIpEku6phJZwcGvNgQkpG7khMTyVsMD5BzGm
	pCUD6yf0e5p4sxNco5gy+bG0Otgd+6OhrTVjbMdNs1R7YDSRqCG0zC7aNMDca8tHAaChp7
	NQfgDhHpKZe5bTk8NN9fcRF3mFuWWDGuXbmfTmR5vZnMGFGpLH76uJAPXk0RO59h94758y
	xTYB1Ft5MV3rePmKCADERfkWEBRwoU7RIVB427iouz6cNfftPnJe5oR419sNXQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id AFD5B3802F3; Thu, 26 Nov 2026 09:08:00 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 0/5] net: dsa: microchip: let the bridge decide
 about link-local frames
Date: Thu, 26 Nov 2026 09:07:47 +0100
Message-Id: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIANToB2sC/zWMQQqDMBBFryKz7lCNJGCvUrqI47QOxlGSIFLx7
 k0LXT7+f++AxFE4wa06IPImSRYt0FwqoNHri1GGwmBq45rGWJzSG1NeMYhOGBbyAS3Ztu0cUed
 qKOIa+Sn7L3oH5YzKe4ZHWXqfGPvolcZvdPAbz/h/XGcvCuf5Acts/h+UAAAA
X-Change-ID: 20261125-ksz-stp-link-local-5c53396cc960
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

Let the bridge decide about the link-local frames that the KSZ9477
family and LAN937x trap to the CPU. These switches trap most link-local
groups (01:80:C2:00:00:0X, for example STP BPDUs and LLDP), but the
tagger marks the frames as forwarded in hardware. So the bridge never
forwards them to the other ports of the switch, whatever group_fwd_mask
says. An FDB or MDB entry for such a group can also make the switch
forward these frames on its own.

The tagger now leaves these frames unmarked, and the driver keeps FDB
and MDB entries for them out of the hardware. As the bridge then sends
some link-local frames back out through the CPU port, the switch no
longer learns addresses there; DSA adds the addresses that the bridge
learns on its other ports, such as Wi-Fi, as static entries instead. An
old FDB bug hits these entries often, so one patch fixes it; without the
series it needs a static entry added over a learned one, so that patch
goes to net-next with the series. The series goes to net-next as it
changes how the bridge handles link-local frames.

To reproduce on a KSZ9893, with link partners on lan1 and lan2:

  ip link add br0 type bridge
  ip link set lan1 master br0 up; ip link set lan2 master br0 up
  ip link set br0 up
  # 0x4000: forward 01:80:C2:00:00:0E
  ip link set br0 type bridge group_fwd_mask 0x4000
  # Send frames to 01:80:C2:00:00:0E into lan1. Without the series
  # none reach lan2; with it, all do.

With STP off, the bridge now also forwards BPDUs between the ports of
the switch. IEEE 802.1Q says a bridge filters frames to the reserved
addresses, including the BPDU address 01:80:C2:00:00:00. The Linux
bridge forwards BPDUs when STP is off, so that other bridges can still
detect a loop through it; see commit a598f6aebea2 ("bridge: relay
bridge multicast pkgs if !STP"). DSA switches whose tagger leaves
trapped or link-local frames unmarked, such as mv88e6xxx and b53,
already behave this way.

The switches driven by ksz8.c (KSZ8463, KSZ87xx, KSZ88x3, KSZ8864,
KSZ8895, KSZ8995XA) keep their behaviour; KSZ8563 and KSZ8567 use the
KSZ9477 code and are covered. The ksz8.c switches have one static MAC
table. It holds the trap entries, the FDB and MDB entries and the local
addresses of the bridge, and on the KSZ88x3 it has only 8 entries, so a
change on the KSZ88x3 can run out of space. Of these switches I can test
only a KSZ8873, so I left them unchanged. Their taggers still mark all
frames as forwarded.

Tested on a KSZ9893.

---
Oleksij Rempel (5):
      net: dsa: tag_ksz: do not mark trapped link-local frames as forwarded
      net: dsa: microchip: ksz9477: do not keep the learned port in FDB entries
      net: dsa: microchip: ksz9477: do not learn addresses on the CPU port
      net: dsa: microchip: ksz9477: refuse FDB/MDB entries for trapped groups
      net: dsa: microchip: ksz9477: report the trapped link-local groups

 drivers/net/dsa/microchip/ksz9477.c      | 81 +++++++++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.h   | 14 ++++++
 drivers/net/dsa/microchip/lan937x_main.c | 16 ++++---
 include/linux/dsa/ksz_common.h           |  8 ++++
 net/dsa/tag_ksz.c                        | 42 ++++++++++++++++-
 5 files changed, 145 insertions(+), 16 deletions(-)
---
base-commit: c2621b518b38ed38e280e008aa33e6c2d302f8cc
change-id: 20261125-ksz-stp-link-local-5c53396cc960

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

