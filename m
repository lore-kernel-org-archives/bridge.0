Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696807;
	b=z9th3OdKT1DhlLHylfmK3VRyR2/p7uH1gcrNOX3gEgQVMeQN6U/w5/Etkk8+1RVgz6w5
	 HQX0iMVXCrMZgMi359vb3k75lDGjuZnwBh+ZdPyhWSjpxrC6UzmMW5y6r/90Vf/k5Wajy
	 p6FDWuvaBI4daFf48HAZk+irOR0WQ2i7R7f/QU8L3K9/iv1SdxUXfIbp3fH5tDtXua8fI
	 mfW3QQQAkkKuzJg8nAWMF+I4CbkNPynblmDBQeXXslJSO7OyTvQJ0u6VXNAE6J39rSUi2
	 P8UEg96hsLOS/Q2ucMr5UreuUklcygSww5iwctiYmrbF1tzy+0lFFBkuEFvaMR+V1tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=exfZeVrV52B6ZZlYVkb/BqLRDCQ7cm2Mxf5PCJH5I9g=;
	b=wgomtcnlCyBZulKwfrMR69GLRrpjB2+JzdxLur8lrQuP7gi+eG0er1TKVDPV8R1fncaO
	 y8CUnDqVZL4joXQbQeAbcesRFOr3jHyLquKshYgW38iUj+iVIzlV33xDknisrEyZrPEZ6
	 ikxnXk6S2QtJpiju9eO5r/h881TOWbEDCrj6ukDzMoppGVES4D71u7MZt9VyqCyv8+tpi
	 gOkUFgG2GmxParVQXC+CJyD3ilA148gbHLHdI81wXNFUIGt1EKqezzcC7CQOuj0GFQN0n
	 koN6U6g58lt/YQkWtutMazjGjjmRHS0ikXiZJfp1LPv+A8KYSRjmiI2ec3Sq/2iAK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Co7XZvID;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FE606A323
	for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 22:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56FE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Co7XZvID
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so3469246a12.2
        for <bridge@lists.linux.dev>; Sat, 14 Nov 2026 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794696805; x=1795301605; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=exfZeVrV52B6ZZlYVkb/BqLRDCQ7cm2Mxf5PCJH5I9g=;
        b=Co7XZvIDRAmxUHH8F7UOGUHP0GOCyqQoJQcMYSnGmgh8UZz72zbJo9xjKbPph3v6Ng
         lpYChuZpQQ0VlIQDhkQuFEFmTwY0iz2vB832xapQIRJZ6Nd015nh8RoScEQoYz0j4o6p
         hWyxf1SJ8jzQgX2iNDpEGdo3oSPGq1KaqZ+F4hrrBcrIRTlrlmV2xOB3zdl5Ml7qQqMS
         LVT0C32iclrrFaZrTr6uLlCYsDJorS4wU/mLe7ymsb3peOi5ARZAZtpjSYpygskHS6dd
         g5LTWG34kv95DaDK39cpL1VyqpiiG16skQJAIxq1Xra5yj6eW33gMCbVU2BnOqT1fhPo
         AKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794696805; x=1795301605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exfZeVrV52B6ZZlYVkb/BqLRDCQ7cm2Mxf5PCJH5I9g=;
        b=WAhd6e4GRMOT3cCVXMnScbWPuNEtdjYaBh+wmX4p/YII4J/2ULug5UFEP2cYVG49aN
         okkULHBoyWJ5CsyTI86vXERqr3m2cE8qiZWj9jny++8UhqbCCzp12aAwxiSMzcUvidtk
         0dcptMeRDIdRzggCTtGa6N+h6N3XBarc9adh2wFGvsQfJav1JPG0Jhjnkbg4in5pak9+
         TaDpcTWYm0O2e/yqWT70BoJzXa1512/Zj+mf6MBf7bVeujl8idi6xbQcfTS5bt2WmG6z
         a9oXcMdHZk5zbrRaYmsEvv0334kDHwmFuqmG9IbLsYiz/00dmHKv51VccoBGeF2a6lNC
         gV0w==
X-Forwarded-Encrypted: i=1; AL+hErF9K0EsIM3cyO2/qUIltqWxBbzy2e1Iw0hfV9Ac9dITjAQeHw2wzYZq3rwNWsJUOORHhPZWcZo=@lists.linux.dev
X-Gm-Message-State: APuU4Z8VAW6Uctj0J3XKydFQH6edNPfZOYPkr6OZDhNaOfBYLvNPiVgJ
	yViquqSncIDVUQhn5YImdBBnUkdZSgtruUUYDmyCEGROaaM1Z9ipBSofrfsF0anzMg==
X-Gm-Gg: AYBFou10v5n7XSb8ZhpCZI3slqmWOnIRTYAncUcIy5cAFvkkEL/IsfhsQt6E6vDznCG
	hoqMro/5CM/Zklj9H31OG2+qnKNG18Zr4ekSxn4TORvRx6uNLrxJ/hlz4hHtYcWehujgNgLLPpb
	xXRWXvB/NaHFS3L1o7RcSvuZuVA0xvFJoIYMrTN4mKH7kPk1x2LCaMLC/tetD0v9xQaO/Uwm8cU
	+fM6i0LvaemoxjQ6S/u4ED7ez5heM/c9TQ91g1Hmv9vVlnUHgXHLbWaHQwebENjj7UjRbNYwQbP
	EK1kTl3BCJGIB74mGHseYykuXthX+CCBS7ZOJfAUmi6IU5l7cc1AyzI9BNytUz+2+cRUdIpvtOz
	YYkkipuuqoHNyV6JTh7UnKIw/NgQLKPph3s9VjGwkaTppJerTpqDmXMxRmqWEtHdGGO4C27Z9eM
	RV3MQeLWr6oasHIZYmU8gBizm1+ud3A1WcZ5y2ZJWeZBX+Z6X15BMEWCDvTmCPtLuFhs9QthULb
	I4k5QhrBa/Q0C0wpVZuely5Cwja8MCXy8NN8N4QLcvwNhJxsdk4tpWcfV7z717ua7oaky1FR5uN
	MpqETwWBMz+jJ1CO38lEpLKJZmsgTFQnQvC2YOrZiY69ORyt83g1yh/wkRwlMNBYHpUqNjTJFWP
	e885WwCBNeduI5JCdElYMqorlHDj7EHcyackXRmty74HccSj3piRZKTl20mADh6TCb3V1/QoZbp
	ctuZNNC4yB7pkmjmeksfnprngZrVerkUNz+vxaxE2cL5+7CMxU6vraTBhlPSwxrcRKC2BGhbgE2
	S7H0BSTy86a2kOqpAP9Ul4yI5nBeH93JNSvJ0DhglXlxv7l7Egii4s6Qy8ygHBS13xzRFyDDzZ3
	1vJJSUi74jgjspy4SfJ0nt9AUsezc7dwlitiF5eXQ6CKnZ+sAcqyYtz7C9lNVgUz
X-Received: by 2002:a17:907:968d:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c50963daabamr462013466b.35.1794696804711;
        Sat, 14 Nov 2026 14:53:24 -0800 (PST)
Received: from Desktop.fritz.box (p200300f24709e8006da21e9e53ecde1c.dip0.t-ipconnect.de. [2003:f2:4709:e800:6da2:1e9e:53ec:de1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm262479666b.47.2026.11.14.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 14:53:24 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sat, 14 Nov 2026 23:53:21 +0100
Message-ID: <cover.1794696608.git.julius@bairaktaris.de>
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

When a bridge FDB entry roams between ports, br_fdb_update() notifies
switchdev of the deletion and the addition without a lock. With two
CPUs learning one address on different ports, DSA counts the host
address on its CPU port more or fewer times than the bridge has it,
which ends in "failed to delete ... from fdb: -2" or an address left on
the CPU port.

The earlier attempt took hash_lock in br_fdb_update(); Nikolay rejected
it because it slows down learning and roaming. This series leaves
br_fdb_update() and the rest of the bridge's learning path unchanged
and fixes DSA instead: each user port records the host addresses it
holds and, on every event, checks where the bridge has the entry now.
Patch 1 is the only bridge change: an RCU lookup that DSA calls from
its workqueue. Patch 2 replaces the counting.

The counting has been exposed to the race since commit 90dc8fd36078
("net: bridge: notify switchdev of disappearance of old FDB entry upon
migration"). The change redesigns how DSA tracks host addresses, so it
goes to net-next without a Fixes: tag.

Tested in QEMU with dsa_loop given FDB operations and assisted
learning, PROVE_LOCKING, PROVE_RCU and DEBUG_ATOMIC_SLEEP enabled, one
source address sent from two veth ports on two CPUs for 5 s, 5 boots
per kernel: net-next logs the -2 error and leaves the address on the
CPU port in 4 of 5 boots, this series in none, and it removes the
address when the user ports leave the bridge. A "bridge fdb replace" of
the address onto a user port leaves it on the CPU port in 5 of 5 boots
on net-next and removes it in 5 of 5 with this series. In a second
test the N-th allocation of "ip link set lan1 master br0" fails for
N = 1 to 150 while the bridge has 40 FDB entries to replay: v1 oopses
in dsa_user_switchdev_event_work() in 2 of 2 boots, this version in
none of 5 boots, and no address stays on the CPU port. The kernel log
of every boot has no lockdep, RCU or atomic sleep reports.

Changes in v2 (Sashiko's review of v1):
- An addition on a user port releases the address on every user port
  of the bridge, also of another tree, and before the entry is
  installed: the release no longer walks one tree, and no longer erases
  the entry on switches that keep one entry per address.
- Local entries use the same lookup, so a "bridge fdb replace" between
  a local and a foreign entry leaves no address behind.
- The lookup applies assisted_learning_on_cpu_port, and reports whether
  the entry was added by the user.
- The release is scheduled before the lag_fdb_add check, and only for
  ports that hold an address for a foreign entry when a learned entry
  moved.
- An entry is not reported as offloaded when its host address could
  not be added; the conduit's unicast reference is undone when the
  switch add fails, and a failed delete drops its record instead of
  repeating the conduit delete.
- Queued events no longer dereference dp->bridge after a failed join:
  they read it once and drop themselves, the FDB helpers take the
  bridge from the caller, and dp->bridge is accessed with
  READ_ONCE()/WRITE_ONCE().
- Patch 1: kernel-doc and message state what the lookup returns for
  local, locked, "master dynamic" and driver-learned entries, and name
  the DSA caller.

Changes since the hash_lock patch:
- Leave br_fdb_update() unchanged (Nikolay).
- Sashiko's finding on that patch, a deletion that races the locked
  roam, has no counterpart here: DSA looks the entry up when it handles
  each event and treats a deleted entry as gone.
- Of the three findings it lists as pre-existing, the MAB and
  BR_FDB_LOCAL ones are in the bridge, which this series does not
  change; the peer-site one, a "bridge fdb replace" onto a DSA user port
  that notifies no deletion, is handled in patch 2.

Link: https://lore.kernel.org/netdev/20261004124254.3525496-1-julius@bairaktaris.de/
Link: https://lore.kernel.org/netdev/cover.1794134495.git.julius@bairaktaris.de/

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (2):
  net: bridge: switchdev: add br_switchdev_fdb_find_port()
  net: dsa: fix host fdb refcount when a bridge fdb entry roams

 include/linux/if_bridge.h |  14 ++
 include/net/dsa.h         |   4 +-
 net/bridge/br_switchdev.c |  72 +++++++-
 net/dsa/port.c            |  50 ++++--
 net/dsa/port.h            |  26 +--
 net/dsa/user.c            | 353 +++++++++++++++++++++++++++++++++++---
 net/dsa/user.h            |  22 +++
 7 files changed, 473 insertions(+), 68 deletions(-)


base-commit: 6964ff21c5d8b75649211a52dbfd92753e605649
-- 
2.53.0

