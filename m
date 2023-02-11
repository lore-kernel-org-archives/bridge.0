Return-Path: <linux@weissschuh.net>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A432260B0F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 780146079E
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1676086359;
 bh=gzBuoXGq9tQc5AaxNhk1VWOvumRFnGBblnycbvJWyFk=;
 h=From:Subject:Date:To:Cc:From;
 b=WYNsqOfKHKuu4lC79pCVMNesQpvp0pK1J+qFFrhoCXy/5YctOa2IJE/MM5Dn36nbj
 WItVOR/PAHwH+rBqNbIv7GJbzfVyo74LLYMgyfp/ifN5JF2DVayKM4kPEdcwSmiQeL
 nJ2AeK2q0WmLSPwp5EROdwaDKoyTmd5XN/2L/kyg=
Date: Sat, 11 Feb 2023 03:32:28 +0000
Message-Id: <20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676086354; l=856;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gzBuoXGq9tQc5AaxNhk1VWOvumRFnGBblnycbvJWyFk=;
 b=xX0CkdDijrUBiNzg6vc3DnLgreltHIv4mngEpLKCXrKvVPpiEB3hy5yPX9JXK4wAPbYk7/OAk
 BcBpw3erVeFCvso6U5P8RezqihnY7RLGCCUIXL2/gM8Y3gAWHyvI3JH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Subject: [Bridge] [PATCH 0/3] net: make kobj_type structures constant
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      net: bridge: make kobj_type structure constant
      net-sysfs: make kobj_type structures constant
      SUNRPC: make kobj_type structures constant

 net/bridge/br_if.c   | 2 +-
 net/core/net-sysfs.c | 4 ++--
 net/sunrpc/sysfs.c   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 420b2d431d18a2572c8e86579e78105cb5ed45b0
change-id: 20230211-kobj_type-net-99f71346aed2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

