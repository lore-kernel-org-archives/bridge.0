Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701151;
 bh=HjouUAoEbv0fMI8xUTp5LuywhWHtVz/DrEjJeJXaZ4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l61PuB19EoIDJZjY/OHKZxkG09zPGFkevmFhYWsFiBqosQE0ecG7xL6atVeYECwMo
 DxMtxYUguIBvP4yLPd+c8cS0A3QN8z3HxXeTwnPuPiLb2SRN67oZltz0EcMBaHMB3K
 iR+t+muAhkns1/PKithlvzGD6M/1YHQcLqsvxXxE=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:42 +0100
Message-Id: <20201106221743.3271965-28-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 27/28] ppp: use ndo_siocdevprivate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

ppp has a custom statistics interface using SIOCDEVPRIVATE
ioctl commands that works correctly in compat mode.

Convert it to use ndo_siocdevprivate as a cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 7d005896a0f9..c39ba3d27283 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1342,11 +1342,11 @@ ppp_start_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 static int
-ppp_net_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+ppp_net_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
+		       void __user *addr, int cmd)
 {
 	struct ppp *ppp = netdev_priv(dev);
 	int err = -EFAULT;
-	void __user *addr = (void __user *) ifr->ifr_ifru.ifru_data;
 	struct ppp_stats stats;
 	struct ppp_comp_stats cstats;
 	char *vers;
@@ -1454,7 +1454,7 @@ static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_init	 = ppp_dev_init,
 	.ndo_uninit      = ppp_dev_uninit,
 	.ndo_start_xmit  = ppp_start_xmit,
-	.ndo_do_ioctl    = ppp_net_ioctl,
+	.ndo_siocdevprivate = ppp_net_siocdevprivate,
 	.ndo_get_stats64 = ppp_get_stats64,
 };
 
-- 
2.27.0

