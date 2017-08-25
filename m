Return-Path: <bhumirks@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8s+XzZR2rzGJhiLqDw1XkTf5y07VPafipiDWvwbOtGc=;
	b=EbfRPPG9NdYke6ZkQD4w1xzTS0GnBx1rDc0clprCZaX3GAvFHBrTYFfehM9fQxjBHv
	iCFDLuYCioBfeHmeKEkdtGJD5AY4cUpXvXaR7Sb1qvdlESkOWNTVZ4wvNxXzHILNWalW
	ilOzu2dVUNM6F8D+tLF1LkPXvNq176VJL/p1zvIdxkWUiWa0Ezn8KPoPqmR2eRt46yuM
	5ww/9GiAB+FMR1jki9a+y24qG8q9Jm2BhnKky/GFCk4b3dexrVBT/d4OSRQ4F+PpJzLZ
	B3cgSQjN2JrzfjiW1ZOuAkejt5g25aS4D+Do5Y85FCDjDr3kHw2NbOo/J96PVwI3Afh9
	rzzQ==
From: Bhumika Goyal <bhumirks@gmail.com>
Message-Id: <1503670907-23221-2-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
Subject: [Bridge] [PATCH 1/7] Bluetooth: 6lowpan: make header_ops const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 14:22:49 -0000
To: julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, santosh.shilimkar@oracle.com, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this const as it is only stored as a reference in a const field of
a net_device structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e2576f..50fcdd1 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -581,7 +581,7 @@ static int bt_dev_init(struct net_device *dev)
 	.ndo_start_xmit		= bt_xmit,
 };
 
-static struct header_ops header_ops = {
+static const struct header_ops header_ops = {
 	.create	= header_create,
 };
 
-- 
1.9.1

