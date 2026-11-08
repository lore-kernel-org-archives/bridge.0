Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136603;
	b=OS8LN/LbiXOOXsYujn9eUUkfReLKrpPX5I5Ky6ZoTf5/LAkyIwKNNkgOGAHb3V9bl++V
	 JvLY7595q14+SP3ukGzN4QMqVjTsD2eDbBfer5mvrTQBh8E/AXRmvSoCzCnlJgadxXJh5
	 vvl6I1uDcVZ3Ya/Z5fCw1bzIDOjNaV8n3+XIXCs+cen4kQMmhNtkcsXoAEWqUhFKexo0p
	 IknqpMKXINg0KW+Rw3XMCRXDN3Wx38rMfs6hRas0UuBV9Vj5npX9nVi18OBsvnJVJCiQ0
	 SiSDxQTl/Fm2pwYL/v/jUGNUOgYCQKZj1QwpcVZYr5UtodrGCWXe1ZLYa+qDG6a5MbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
	b=Gjb03eQm+oEUbTQJhgtrNs7PHgaJpBqZAslUCUWiiikDvusVT5YM+7vtSBrXUNNRN8yw
	 W6uZcbsp+zqfBNTrJIDu4Yw1/w3iCiCUXqXSAqj0OlFxybIk+B7HeA0ysEPR4cZUv0LRE
	 xlUkx9CHpDulxJ0jwIgFN1dEDXXP0VxHIQU0nQAhe5kgvoQc1YkOmJ2Tm8v4/BsJXSxOh
	 WEMc9yOVBy+E6OKMqvBRwGaEi0RkzJQFUKji9ziJ93YMKwvZ+P6lz9g5nriQgYRd7dqzQ
	 Ny9a+6meEWlELcItHrhfW4ni5BKKGa0mtV2UH+Yr2GoKiduYO22XaUiRwc4+gYErLEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=nLQCp3Ar;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C27606A31C
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=nLQCp3Ar
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c411e139259so3192866b.2
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794136601; x=1794741401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
        b=nLQCp3ArjVon5SptRx8bRgV8JPfciXNbEZhbR5wkYkD2rY6bn5h7//Wcf/KrFDGBmK
         PExyX6r+Wq/A9h8d7TSKBzVOidVwlk6ZEtb3gPYJnbFvu/8HPbvtOaStn4nFQFHRXY/M
         O0Uar3fuzEQpCtPIhY82r7XiEtHWs4sxAPdlrdyRSTyOi3oHyQfVYsRtmYIoPLGRFOtG
         7TqNA3WWKB1J2Nxsz2KctaMUjhwCbXzyMirH6wLZnPb74R2Oq6nyt0hRJMfBW6W7kJCb
         HokIm45qy0NEg5A2ta0PdWK8khT5OPQ4c7Dmy9169OO2jNMtyzJCt/bslZbGi7vSxmbP
         F26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136601; x=1794741401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqN8u8kP7ftmzydZ0UYjojp4J7UTI9IrPrNCjr6MjRw=;
        b=mWFMqgB7YKaxuChuwdxQDQeiBOnmshN9TWxKeOezH7+R4dBAo9D+e5j7MVBtLZzVTL
         tNVePSbDP+Iqj1F4cswmQ0ksOAEJ66dMbR/5W5yE9GyvNE6cBJAeyi4M5kCiEw4COL3d
         Z8lltT0sLjikNk0zdjAEl7g1k0uYe6UcagUTwiY0R60Ie+OzuEkz3H+YpEWZ92eTz9B1
         6L1Oj9JyH/KXaw4JnNra2OLP+U30OcCCOPEERuk2gis3pHWAo8XmcQUf+ZVS/ZSosucs
         xNZbyuPETjNyvv4Pv2kSwXtP4arWecmY7xZq6vWhFhY4En3QLrWkGf31LoWO5dEzwhqO
         zafA==
X-Forwarded-Encrypted: i=1; AKwUvBwpXTkn0s2Yob4jiqVUGItgIUFMYvxHseYkRBRX37V54Os2yPFh24N6uryk7sm8x1PoAWqqEyk=@lists.linux.dev
X-Gm-Message-State: APuU4Z88REM0tird3vYY4if5Gi08bZNbKV61E/32cBXhMp49ANlgGWQs
	6/FUgqM/CemH2wJXX1YWwTTM3TIBtc9FYdlF6KOSe52iuAipnMEpv/SS0SUvtE7UTw==
X-Gm-Gg: AYBFou2cb2zrV7vE7ZmsnuWxwrEZddmmCw7+0UNQ0lYuv0FXzyL06Kv5hgXX4edDAar
	STsnL4AYucAJzd0mmNyhupeHaZlrdeA2EahILphRhwNsXaJaDHnuAFyOnPnwmMMsZ+HkQ8uADMo
	K1ugEAYuL95e7qFMBE1h/qh6xM0I2pCbmkHeCv7+SnjUGgs8vKzX42VaIElzqufa9DWnaiMXcY9
	Z07zTA9+ipIvCjvac5u2FRiORv55WsWENH9VdTe/eh52JPIuLkluhRo4lo38hsCiFoPLvEzRZgH
	X+AhfVMTmnl31GUM9OpmJPDYa2Lsq82L0BLgPgDfPR1O7pH02MewNHsU2uCw1weUno9Jn4VdB1D
	A/M7c4xsKdzWTtzPRppCyrQOsmKDu96VVF1VKhJdZ4dV3g/g2XD41lDvlcJJN2swm/PGI4n9Tug
	V/nKDK5zlbJN9JELrAlbNwJM7S0LEAaTw5N3hlhqxON5lfyfJ9H9/CDrlYBtKR11wTN1XebDuYs
	yvbroO1oHkgjigTSys23RVenYZCPdi7B+ihbl7LU4PGDgtkMiA+iEINW6MJe5pLZ8/vPyuU/v1F
	WMbt+1TQyeDLTXs62NXTkzVYT9fgGvKLqRsD7OvP9Ut3ITcIR8RqbJCegNwVb4KSuCeaxtPawse
	F5f24sifUxv2pbGyzWI1d4AlKA5eZ8TaM3t870uqhLzpWkQOUeTXDUvVtOp+2P3BYtmX8v8dbK+
	3fp0ouU/bkaAH/l3DsoT4DUlHqDfs2I1Fn7Ygkg6Dpl8uc1TAA68VBfYvES4mcrQvockCxNlf+P
	5U51nCXyMS5yQa7dZnCV2ZlF2Yw6BxTuNRXCyMNQNhYOPLpA6o8GDR5ZS99CpCiWi9vfJOuIuGB
	F7/0/9IRzX1Cgv+0saKqhH5lupslaA+acbZSRRg=
X-Received: by 2002:a17:907:960a:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4d6d4ec448mr99416466b.23.1794136600876;
        Sun, 08 Nov 2026 03:16:40 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm54261166b.67.2026.11.08.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:16:40 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sun,  8 Nov 2026 12:16:37 +0100
Message-ID: <cover.1794134495.git.julius@bairaktaris.de>
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
on net-next and removes it in 5 of 5 with this series. The kernel log
of every boot has no lockdep, RCU or atomic sleep reports.

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

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (2):
  net: bridge: switchdev: add br_switchdev_fdb_find_port()
  net: dsa: fix host fdb refcount when a bridge fdb entry roams

 include/linux/if_bridge.h |  13 +++
 net/bridge/br_switchdev.c |  63 +++++++++--
 net/dsa/port.c            |  36 +++++--
 net/dsa/port.h            |   6 ++
 net/dsa/user.c            | 216 +++++++++++++++++++++++++++++++++++---
 net/dsa/user.h            |   8 ++
 6 files changed, 309 insertions(+), 33 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.53.0

