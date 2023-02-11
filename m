Return-Path: <linux@weissschuh.net>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EF1841A67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77FA3419A2
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1676086359;
 bh=xCR+Ptx6qu9QePzl0md5Tsxq8IclLdgajMp2skUDWSc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tjJ371sCoO1zJbo7cmqZNdMb2QRhvV5t2iWk3im7znsFjqLfTX/pxHH+uAaL8a9T3
 //NN5GCYPGBaQNtuHZl/sOPwyAbUxmGvYLUk2mOQqZiNNXsxDLa9gwihMyiRwev3bM
 lsI/Jq58r6WgjI+MSMGDizgdXvwVN9El+6D6fZl4=
Date: Sat, 11 Feb 2023 03:32:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230211-kobj_type-net-v1-1-e3bdaa5d8a78@weissschuh.net>
References: <20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net>
In-Reply-To: <20230211-kobj_type-net-v1-0-e3bdaa5d8a78@weissschuh.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676086354; l=853;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xCR+Ptx6qu9QePzl0md5Tsxq8IclLdgajMp2skUDWSc=;
 b=3aDYol7gtnPLDHJSwXBlVN4BDObAVRLqF9OMQ5NSZZNm/Q0NK+m80glqETx4nA62qGsG3Sn2R
 BipVF0Z8vquDqfEi5RLD7lwkMmJIy5wI/KI1M5EXd10qNp9hM5WxpaY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Subject: [Bridge] [PATCH 1/3] net: bridge: make kobj_type structure constant
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

