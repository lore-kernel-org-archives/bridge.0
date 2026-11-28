Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872904;
	b=FPu7O33tfpXV1tyB7hq0Z7mJqZMV+6RUz5Ob2A4MeWpdEZduQKJI5coiVDa2iOe+Q/DV
	 1H6PGrE38GSEvRFFBnQ7nokFQlkiEGhYyHPzvjFsf1M5q3pWlhfyKn807FsSYQsMMp5tD
	 anJAWxOru1oRcHmVyvcE52Z0my3tnNcdW+L40ANgEG5rLZ8Ez7OM6n418QmBShWrLPQY2
	 e5Lom0lHYKHVXyOr8SggpGFlaoX7N3VhDs2+5bA9dNQbM1W7uH3hYTPQe8NHpus/4ohQ9
	 tAK/C2C5r8t0ffFUaIqJmSQcL9AOxoc5eWgovUJ7n7PlS/2KC6iwu7DE5cLi4OrSPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pb5cBp5dUZxwGBeRkw3J65oThTXF6wchKIazw/qlrvA=;
	b=f8FXcL55F40zJM2tfCnEuQm4UaZxSzNw6wzW0VCO9Fp9S5JAk5urEDoqOy0eEqmWQlui
	 PRWaqs8Dlu+bexzYETvWClnYf3MrXplOwYWvGKOU1uBYbhaxH2ewrSFhS3uDxlFFMax0j
	 nCmyO2s6Kqcyr9s8FrUXEtpSyt0BgP4xUfbU5ACRUpDlc/BfEFTso+ore8OV/G8WeFgSV
	 wYjM4rHwJsEfn1PWDJJlay7WjMd42CtURVxr3yVEHMdtGuuql5TqQPhEZxsFgOHpZO0MG
	 vp+SGFankUJCa+olmRzDUVq2U2OdEzW5agTnrwu+tLFlLdbJ/Ofc+6ekaKcyVkpCiew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Jpy2n1hs;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D28606A31C
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D28606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Jpy2n1hs
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so13979198a12.2
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 05:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795872902; x=1796477702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pb5cBp5dUZxwGBeRkw3J65oThTXF6wchKIazw/qlrvA=;
        b=Jpy2n1hs2dL/WavgHnBBCyfoPC8XpDxWe5s7s4T2TzPW1cS60E9PhtATIaB40N8mKd
         I9Ns2XQVYKyXlSVI98s5X4JZyJHwzzwXBFVwiYkdYczvqaK/vzEZ9C3h2iftrgqhCuQw
         ynwIlxzBVT1Ai5nHon/iSQyWLTKvjvvNKUpoa20nsKbMAa64WN72kzGWLSNyxvAnKPaE
         21In4uzb02G0WTRGCzly8Cvp/VShvLkR9ZdNC72+jOgjR2OfqKxBUt5FWmgrjXmDYF8F
         kXgRTBM0bM7nzIbdgYRwzSFFokrqoirL+8CZ5lgRAAIVn5v2yuE1sp2oxsocTBM0wWyd
         qbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872902; x=1796477702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pb5cBp5dUZxwGBeRkw3J65oThTXF6wchKIazw/qlrvA=;
        b=NC39ZGOwDch2o3Q/cTwKc8Yl57c0xJzRXcTDqiLd28IBm3hbnbWJbEkIx782AnmiIB
         XZre3lTAvFlB6BUnkSK54jO05FdCnSiSzGyjuX224VteqNEl7DXP+b55ekWwgtk9Dfro
         SbMlz1DT+W3GxsDcLsOT1Kd+p9BXEkLo5bm3fgYd2CQ03B+YnBdbw/YDjZAXJic1HvWq
         rIm5wOkHNVtiNbhl3dXCulUOJDs+0VJ7uZyXugWTUqcmWn9M0wSYEEdDI1G49pwi5Ziw
         InBfH5Jw5p1QFboIOyK5QU1ckfSEDBCuqNeLkK4ADwNTmj/7csKS9zithmpidccw9sT6
         aM9w==
X-Forwarded-Encrypted: i=1; AL+hErEw9VPaw2fRKTuJZ9p2bMdsAT9mdZOIaExE5N3MSlhxwH5kVqxplldLgTCU/z1Ss/yDxPyZGV8=@lists.linux.dev
X-Gm-Message-State: APuU4Z+lkQjCgso6VPfMgeS5jl4bT3VGgVlC3lil88hWJjbTpW8c4SJV
	/z8aO5CjykrdY799AWKqrAnvGXWGh1mydCEHGoXaKWeEaZDxpMgnwNCvl6BtZibDfQ==
X-Gm-Gg: AZFdTZeNnEmIaJelSiJJnEiZGqb6MaZY/XL31mFzFFB26+aDYyqTeLiWOYv/l0gi5Yf
	+gpUkDQDWLE4YSPTWD0f3cV8wy9+CxdVZliZ8Vb1UtKDHvKq9lYZzKHhv818tzA/zwHJKnTo83X
	C2fXJhiayWkWfNMGHEkn72d9LDa40ScW97EqFH0uF5e4vp9Bh1xB7zk5AsEl6WdOhvjUF4owcQF
	o7ARkP4XHslqDdl9RXGin/hgDQGVqgsms1Np8s5yixGstQ9h60+hA3njRvGptsrmP2VN17OO+1J
	msqeRbCHedcnbNG5uKaceA/9XHuxpuLsfFM9vxmweGhKijXSEJlxLXl/6Rp45/P3/fYis5WhxAI
	YLpZWzYDmxULSn+6iAIUqIFB732lb8SRYSIAY2EVD0xjZUeWxDsq4askV10kycXSTh+q0LwhNzL
	+ZAxQozsD4+tznBWlLJ0q3ZtfDnrd/eBIDcs1WW/RlizZf5aLGOJOK4oj2bpervAnnT+HgSSNW+
	zQUYAe5pLb29QZwB+no/wiiFgkfAPW7XMM/OvNHoQLQfpYNJ7wZ2gokoa6TaV3kghlFdeIzcSqH
	VDRWF7SqaZaSdtV0eTOpM5ry3Ye94LTj3fUl7Wxc079sDUYqhSO6ndTW2g1Qk11ueLgt94wE0aA
	2hJVUAEPtkzYuPIyphy65Ig/pjlDKKdqSm7YOad+YN5KxXFBm3dDt5NkWO5RGsweKabqWj7R4qZ
	2yNHE0QDRJa74H8BomBVvxA8bq2dkCdvJ1h0F4z6amLMBFu6Z3ayC1CgHMUymYHCi1ji73KbIHM
	aJLpnCTIdVteLusUDrSHUN8egQ1Si7JychdPaMIyP0Zno1O0yTu5CN0sOicJ5pZEy1aUgbZSkkt
	4USQjZJ6d28mrE9JgjIltDn5zJeJM5ISRRJh1Mbv0YOg0OsE5CrJRvXq5K0vJSb0SmxuCHn2I2A
	=
X-Received: by 2002:a05:6402:370d:b0:6bb:2a86:1a37 with SMTP id 4fb4d7f45d1cf-6bb2a861c68mr9404086a12.31.1795872901813;
        Sat, 28 Nov 2026 05:35:01 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247080f000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4708:f00::a27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm5282111a12.26.2026.11.28.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:35:00 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Linus Walleij <linusw@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net v2 0/3] net: dsa: FDB events and tagging after a port left its bridge
Date: Sat, 28 Nov 2026 14:35:00 +0100
Message-ID: <20261128133503.3887987-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

Patch 1 drops the FDB events still queued when a port has left its
bridge, and frees the bridge only after its lockless readers are done.
Patch 2 holds the device that a queued FDB event reports to. Patch 3
makes the taggers forward a marked frame on behalf of the bridge only
while the port is in one; it relies on the grace period that patch 1
adds before the bridge is freed. Patches 1 and 2 change the same exit
of dsa_user_switchdev_event_work(), so v2 sends them together.

Trigger, impact, and what helps until the fix:

1: a bridge join that fails in the FDB replay (an allocation failure),
   or a bridge leave or switch unbind with FDB work still queued, all
   done by a CAP_NET_ADMIN user while the switch learns addresses.
   NULL dereference or use-after-free of the bridge in the DSA
   workqueue. CVSS 3.1 4.1 (AV:L/AC:H/PR:H/UI:N/S:U/C:N/I:N/A:H).
   Nothing short of the fix helps.
2: a bridge port that is not a DSA port (veth, Wi-Fi, USB NIC) is
   unregistered while an FDB event for an address on it is queued, on a
   switch with assisted learning on the CPU port (mt7530, felix,
   sja1105, rtl8365mb, mxl862xx, motorcomm), or with a static entry on
   that port. Use-after-free read in br_switchdev_event(). CVSS 3.1 4.1
   (AV:L/AC:H/PR:H/UI:N/S:U/C:N/I:N/A:H). Nothing short of the fix
   helps.
3: on a switch with TX forwarding offload (mv88e6xxx, sja1105,
   vsc73xx), a tc redirect from a bridged user port to a user port in
   no bridge, or a qdisc holding bridge frames on a user port that
   leaves the bridge. Kernel oops with the sja1105, sja1110 and
   vsc73xx-8021q taggers and CONFIG_BRIDGE_VLAN_FILTERING, a FORWARD
   tag for bridge number 0 with dsa and edsa. CVSS 3.1 4.4
   (AV:L/AC:L/PR:H/UI:N/S:U/C:N/I:N/A:H). Until the fix: no tc redirect
   to, and no queueing qdisc on, the user ports of such a switch.

I used Claude (Anthropic) to help write these patches.

Changes in v2:
- Patch 1: the remaining lockless readers of dp->bridge use READ_ONCE()
  (hosted Sashiko review of v1, Low); the tagger that reads NULL it also
  reported (High) is patch 3, the use-after-free of orig_dev (High) is
  patch 2.
- Patch 2: rebased on patch 1; v1 did not apply after it in NIPA.
- Patch 3: new.
- Rebased on net 28a371228d4e, test runs redone on it.

v1 of patch 1: https://lore.kernel.org/all/20261121185821.1471559-1-julius@bairaktaris.de/
v1 of patch 2: https://lore.kernel.org/all/20261122173347.791590-1-julius@bairaktaris.de/

Julius Bairaktaris (3):
  net: dsa: do not run queued FDB events after the port left the bridge
  net: dsa: hold the device a queued FDB event is reported to
  net: dsa: forward a marked frame only while its port is in a bridge

 include/net/dsa.h           | 10 +++++---
 net/dsa/port.c              | 50 ++++++++++++++++++++++++-------------
 net/dsa/port.h              | 26 ++++++++++---------
 net/dsa/tag.h               |  4 +--
 net/dsa/tag_8021q.c         |  2 +-
 net/dsa/tag_dsa.c           | 15 +++++++----
 net/dsa/tag_sja1105.c       | 23 ++++++++++-------
 net/dsa/tag_vsc73xx_8021q.c | 14 ++++++-----
 net/dsa/user.c              | 31 +++++++++++++++++------
 9 files changed, 113 insertions(+), 62 deletions(-)


base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.53.0
