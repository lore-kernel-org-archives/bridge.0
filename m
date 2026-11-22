Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375279;
	b=P9qMUr9PrSC2oBDIU6LmP9LicEQXSJwqWAaqAGeoNl/xDn/5NVZCHYQKjOb0lRplwmI0
	 yRMxOc6iQLdybNeK436vMeoLRUVDtXQCWOG5UujfAQxMuGGd4oKxCdfWKI1jIyosNkcZk
	 7mQLc47jCML4TnJrfVfEz645kdn9D+gcXklxxO1iOcpr/rgUIGdB3qG8dPvLYhiCgfFVZ
	 8h6SahkZQyWeddgmPNMwmXIKAx8bgORp8QC/FmM/CuxARsdn5VR682MjJbzuUlTZfUET8
	 r40pbo/VlzajeBspNkIsv2rdudMKiAFrM7XkMGH32uOKIIeQ1KCtSYxDuIElsFT9KUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ssnD6CL/F3PNz4sQoNGHOMcyfKPQ1JKhxPVaQ4iOjeQ=;
	b=CNywk9VCPdtAebYwSra9il5rGTB3n2L06lM37ImagMnhMOd4wECgqXNL0wfYbt3q9Y8J
	 +QA6fJE7/875DJ+t18sBWjgQez4sskhUoLmt3ZV/BCoRlh/TZ3uF1x9nkuQpz4gkPdvgW
	 XPL4XXHdGDD1vSpzQ5yw4bTbgCiimLvbhGM7Mn5pkcktOGr28KhD5+BS85fS8f7a9XGh4
	 jDUhvyfJgm6HQiPw+kOReAVoI3FPjmdO+LLQqdH1ZHvXermAwsGiOQ3v/9dJvbnOxbSCD
	 zhGAT2V4/meMauz4mNjG+tDXVlzrUjV8/Dxzn53Fd3Hm8JcE5bnF5URGey6Ar/fdm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pVwwXJzm;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62317606A332
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62317606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pVwwXJzm
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50e26763a4so476405666b.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 11:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795375277; x=1795980077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssnD6CL/F3PNz4sQoNGHOMcyfKPQ1JKhxPVaQ4iOjeQ=;
        b=pVwwXJzmDzEoMGVbBXrEcOGeFT2CNGE7c7XSIfGO/ylc4VkxuKOnXZ/xRl4Hlw6rUF
         Uuesh4pHmhS7MdrJCnioR2w9uE84YvaFiSwYM5g7IjgZRj1a/SF/Z/kQs2GEwgU+GOvc
         r/DGczrMmwIwNLki6pNwRExUvleHF8UmjJ2xxxmc4dUtILzEhVjuix5ngGLuCsaeL/TF
         RK8x1kvUYZ5iR0eA4uVKPcO1BbH7itR4JvXER0A+MkfoKK/Lok+9ckqiCkca26SNJSsB
         Rbfp7PdCG4f/04SWYDz7QLl55aPaYXbJxPUXFahEdnKyOyqrwmcJMZkHsXG9NcnugI3B
         EPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375277; x=1795980077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssnD6CL/F3PNz4sQoNGHOMcyfKPQ1JKhxPVaQ4iOjeQ=;
        b=UgIZAIUMkoJXv6K/lsbZmtVZcM/p6j/cgyzteGENKqdOYcs7Rpao4bIFFg7GSljNec
         cqAY2p5ASCPFd06gGZ07CUE264mSZQWz3eE6pAurXs9i+dyakIyPMsjUi8EzC0NJD84r
         A8qZaD+6PAMqpHbqMyMo3OUX2Z2Z2gOk6vRADea5ZX52EER5RgYmUxABqAPKqvzqJZDR
         mJqt3iNAsRpL3xFTS2lTfJoBrMOxQHpopwj0zI45+Ql8ZSkmkBqMoCA3qyiRGrGwEgaj
         VrcTOJqY5djyB8O3hcBKDaj0W680qCsxGLNwm8P+nlwmhESUWEEHq2OZJVAzwJbUqD2J
         oGwA==
X-Forwarded-Encrypted: i=1; AL+hErFRc+MoMWF0VQHtfJJMnfzZmCmTIANjMcT9Un6ggcDwZqeiyEJBivt/2ZgTkIkRLH7DiNj9FTg=@lists.linux.dev
X-Gm-Message-State: APuU4Z86kl9Pu0WB4CA/G4yfs0gWqeJxQH3QRuza2BQUgiRqyUJSKG5G
	qNcL8jABKVPndlGqfCwEVRBUdbA6CgFC3A4x/eJEorUJh27DosShA8az7gIiE/HgHA==
X-Gm-Gg: AZFdTZchL+CXhg/r5fQ4tQ7OpkiYX1EZ7VlkZbQdpfCC8hJC4qRRFLsHBusSnt4zuq+
	6ZBLdF5I7U1UDhgDa4F76Zn0kkPcH1Hculfb7rf9Tq14H68yTkK3KCmqALNJGomyHHCEF7FyAnC
	5m9tYMPpTtGM7v0i/bRbCByse1uyfk7rgXS4E8DdLQCB8QSqdlEGegX8LKgHjA9urdK/UfRbvb/
	BKdr32W7Q12k8FAEQjt0sbldTBPcCHg/DP8X3WDBn5r6gWipH75s9U5lc8UoVTREEmr6mEMJjVS
	3T5CaZqaB2M1Ds7j94vazaBl1VGEh8NQH9prC3AdgARRZUhnuLIALYEUqAuYAMdwVI1LLQhyrw8
	nh+lUgUn1DSogDUlILUin975YOBkxPaRY7pZDIl1UJCflfbo+pCsg7jqdZOds3J96Flye8eB3C2
	d6tI+yBS4ovLyqITG0Gk5o7mxKpQ8UF6NGN35L657Mnx9lIpFdhXjeISYCu5e3DWpkpmLqb7GDc
	uIulcTFZC2UwG9clYNkdTtgMlIqM7C9RX/NBVQjkfF5R5mIrfDfmvqPHzNsEZpITQ3JoG6Mz1xx
	ZagQK+JpSCwLiO65A3ts0ebFjxja+eK6m3DSVJLTWbx4BAfeaYcn53K03D9OS2OO2lYvUhvICqX
	HHSlvO9+9JKjpogJRqH3V6cEoNJ5xkqtMBndKmk5f/qf/6i+8FhGStdt17VyHoTvAhxbn4y3SUn
	+sYqDLJdVNJwma+w6m3lUi43c+ICm9cphehfhIDqHz927SFEbqW7AWeRpX1CGvuSZV2b2F/LrNu
	Ph3kguuJyzHTX6ujfwgwQ2FS6zXzAPXGVZ423TBup79K9U6Db+tBBdsKcC0y0tb0QS+IWghpelw
	Rypj8agAlyjQi1GjzbE1Sp9Z3R/vjMv673vNo+XT4UNS2Jt3+Z2rKC+2Tox9N238Bz4Y0NW/+4Q
	3
X-Received: by 2002:a17:906:f5a5:b0:c46:6a50:40c2 with SMTP id a640c23a62f3a-c513ac7e167mr774036666b.39.1795375276713;
        Sun, 22 Nov 2026 11:21:16 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f24713a7000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4713:a700::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeca8dsm338808566b.75.2026.11.22.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:21:16 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: [PATCH net-next v2 0/2] net: bridge: switchdev state of fdb entries made dynamic or roamed
Date: Sun, 22 Nov 2026 20:21:16 +0100
Message-ID: <20261122192118.1204290-1-julius@bairaktaris.de>
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

When the user turns an fdb entry that switchdev was told about into one
added as "master dynamic", the bridge reports neither that change nor
the entry's later deletion, so drivers keep the entry after the bridge
dropped it. When the bridge withdraws an entry from a port's driver and
keeps it, which that change and a learned entry moving to another port
both do, the entry keeps the offloaded flag, so "bridge fdb show" and
"bridge fdb flush ... offloaded" treat it as offloaded while nothing
holds it.

Patch 1 reports the deletion of such an entry to switchdev before the
entry becomes one that is not reported, and clears the offloaded flag
with it. Patch 2 clears the offloaded flag when a learned entry roams,
right after the deletion is reported to the old port.

Both were found by an LLM review: patch 1 in a review of the
series "net: dsa: fix host fdb refcount when an entry roams", patch 2 in
one of __fdb_update() while patch 1 was reworked after its v1 review.

Trigger: patch 1, a local user with CAP_NET_ADMIN runs "bridge fdb
replace <addr> dev <port> master dynamic" (or "... master use") on an
entry that a switchdev driver offloaded; patch 2, an address learned on
one bridge port is seen on another, as when a host moves, and the old
port's driver had offloaded the entry while the new port's does not
(DSA with assisted learning on the CPU port, entries learned by a
switch). Shown in QEMU with dsa_loop. Impact: patch 1, the switch keeps
the entry for the old port after the bridge dropped it; patch 2, a
wrong "offload" flag in the bridge's view. No crash or memory
corruption. CVSS 3.1: patch 1 2.3 (AV:L/AC:L/PR:H/UI:N/S:U/C:N/I:L/A:N),
patch 2 0.0. Until the fix: delete the entry and add it again instead
of replacing it; the wrong flag of patch 2 goes when the entry ages out.

In QEMU with KASAN, with dsa_loop given FDB operations and assisted
learning on the CPU port, and a tc mirred redirect that delivers frames
to a dsa_loop user port (test-only setup): a static entry on a user
port replaced by "master dynamic", and an address learned on a veth
port, which is a host address on the CPU port, replaced by "master
dynamic" or "master use", are not deleted from the switch and are still
shown as offloaded without the series, in 3 of 3 boots each. With it,
each is deleted from the switch and no longer shown as offloaded, in 3
of 3 boots each. An address learned on the veth port and then on the
user port is still shown as offloaded with patch 1 alone and not with
both, in 3 of 3 boots each.

I used Claude (Anthropic) to help write these patches.

v2:
- net-next instead of net, so without the Fixes: tag; the commit that
  introduced the filter is named in the first paragraph of patch 1
  (Nikolay).
- Patch 1 clears the offloaded flag with the withdrawal: a "master
  static" entry the driver had offloaded kept it after "replace ...
  master dynamic" deleted the entry from the hardware (Nikolay).
  br_fdb_offloaded_set() assigns the flag instead of toggling it, so the
  clear cannot be inverted by a concurrent report.
- Call br_switchdev_fdb_notify() directly, no helper (Nikolay).
- Drop the comments in __fdb_update() (Nikolay).
- New patch 2.

v1: https://lore.kernel.org/netdev/20261121191638.1724620-1-julius@bairaktaris.de/



Julius Bairaktaris (2):
  net: bridge: withdraw the switchdev entry of an fdb entry made dynamic
  net: bridge: clear the offloaded flag of an fdb entry that roams

 net/bridge/br_fdb.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)


base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d
-- 
2.53.0

