Return-Path: <linux@weissschuh.net>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AFB1402D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED227400C4
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1676348597;
 bh=xCR+Ptx6qu9QePzl0md5Tsxq8IclLdgajMp2skUDWSc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QK+U+tAOYrAj0sZrQXIL6TtxMwQeg4kIi5sIYz4bQjcWHzm7tb1L98L5OuIJDUv8h
 3c0T9CeDXWqfd5DZ1TwhAKyijk/GqoVUVgch1Mol7sIMuVOUlkZhq2YawRDBfyueAE
 gC0Eb5ZDh84ZcACRBxf43N9Ef9a9cZIMf3fnB8c0=
Date: Tue, 14 Feb 2023 04:23:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230211-kobj_type-net-v2-1-013b59e59bf3@weissschuh.net>
References: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
In-Reply-To: <20230211-kobj_type-net-v2-0-013b59e59bf3@weissschuh.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676348594; l=853;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xCR+Ptx6qu9QePzl0md5Tsxq8IclLdgajMp2skUDWSc=;
 b=NWW0VjzsZXAn/xhCKGtkf9tdTULpu3c716ULCSOoUHvm0eU+6lpfQCeutakurBowPQzWRjAJT
 lXTqu66KFNgBXsiemMukK36YHwoVoJaWCkKdOOunCAB/+D9lL4lNrOD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Subject: [Bridge] [PATCH net-next v2 1/2] net: bridge: make kobj_type
 structure constant
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

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/bridge/br_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index ad13b48e3e08..24f01ff113f0 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -269,7 +269,7 @@ static void brport_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t
 	net_ns_get_ownership(dev_net(p->dev), uid, gid);
 }
 
-static struct kobj_type brport_ktype = {
+static const struct kobj_type brport_ktype = {
 #ifdef CONFIG_SYSFS
 	.sysfs_ops = &brport_sysfs_ops,
 #endif

-- 
2.39.1

