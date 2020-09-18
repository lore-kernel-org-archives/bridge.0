Return-Path: <rdunlap@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=IuEQoXED3a1R2JhR0RJXE+dYfdFfK1ROSygKFuifAeU=; b=AWre/EoYMeFkLWe9v8Vc5zUU1D
 zb+KiSBFpyivVhWI2oM+iS0ezDFO5UtcryC/1hcc2b9ueGoOrqZfh6KK0NdUZaN3UwhGihFt2bNWe
 HUws8lkeVvWKTNMBQud5x5Ji4brQ8pHsCU/zn/e/aAxdy2In4F7i+Lnvq4i+/xTxEbWpdjkN6JWEP
 v9H5OF2Zbc8jqFnnd96e1VsLY5dcBMl2f7fY76AlUI8AIp7fCC3GOMnf8zQNCRBmJHHMaubLjywca
 8G5RpH00cX4zl1nLytDk6ce81rAtluv7MVxlyWSsUF2Xyk+YhrWcaKHFwIugWz93nwkrzj/SNzIyI
 iAWod5ow==;
From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 17 Sep 2020 21:35:21 -0700
Message-Id: <20200918043521.17346-8-rdunlap@infradead.org>
In-Reply-To: <20200918043521.17346-1-rdunlap@infradead.org>
References: <20200918043521.17346-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 7/7 net-next] net: bridge: delete duplicated words
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Randy Dunlap <rdunlap@infradead.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Drop repeated words in net/bridge/.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: bridge@lists.linux-foundation.org
---
 net/bridge/br_ioctl.c |    2 +-
 net/bridge/br_vlan.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200917.orig/net/bridge/br_ioctl.c
+++ linux-next-20200917/net/bridge/br_ioctl.c
@@ -103,7 +103,7 @@ static int add_del_if(struct net_bridge
 
 /*
  * Legacy ioctl's through SIOCDEVPRIVATE
- * This interface is deprecated because it was too difficult to
+ * This interface is deprecated because it was too difficult
  * to do the translation for 32/64bit ioctl compatibility.
  */
 static int old_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
--- linux-next-20200917.orig/net/bridge/br_vlan.c
+++ linux-next-20200917/net/bridge/br_vlan.c
@@ -140,7 +140,7 @@ static int __vlan_vid_del(struct net_dev
 	return err == -EOPNOTSUPP ? 0 : err;
 }
 
-/* Returns a master vlan, if it didn't exist it gets created. In all cases a
+/* Returns a master vlan, if it didn't exist it gets created. In all cases
  * a reference is taken to the master vlan before returning.
  */
 static struct net_bridge_vlan *
