Return-Path: <linux@weissschuh.net>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A53AF40A91
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A492400D0
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1676348597;
 bh=COVcQB5cR6h89Wr/2J1rv/M31I/gbeQf6njLyVKwSIM=;
 h=From:Subject:Date:To:Cc:From;
 b=E8NFdE44PufttVZMbbCzPFCjNkIW64yBxlo4sJ076a5J/345Syyya9BaKdHxf9HcS
 p1a42BsThSSLSWd+RKYCTKUjV7wS64PblTpkxX49I2xARHiMuFaFZIs3VD40UJh3Rw
 SZW6o2fvvcKnXlNIO8vWIanZ14fjvoKaZEGmp+WQ=
Date: Tue, 14 Feb 2023 04:23:10 +0000
Message-Id: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676348594; l=897;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=COVcQB5cR6h89Wr/2J1rv/M31I/gbeQf6njLyVKwSIM=;
 b=mzJZEHszcanAOUqAskTyY8zp/N2ygwkPwET7vB6F566gjMRd1fsDdE1lDINz6C/IzArbj7Pux
 QLn3gil8v5CBhjijG9ctohjQrB1DvCy2GToIrTo8seYprEPPypyg707
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Subject: [Bridge] [PATCH net-next v2 0/2] net: make kobj_type structures
	constant
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- drop sunrpc patch from series
- use "net-next" patch prefix
- Link to v1: https://lore.kernel.org/r/20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net

---
Thomas Weißschuh (2):
      net: bridge: make kobj_type structure constant
      net-sysfs: make kobj_type structures constant

 net/bridge/br_if.c   | 2 +-
 net/core/net-sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230211-kobj_type-net-99f71346aed2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

