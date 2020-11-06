Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701125;
 bh=quYL6FmY9NRqROBT7gD89RdIR4mWBVj5mvB8k4ghwsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uVkT2rV+ZZT8ggUQJXoUIn5wGJbOSDXoR0riPdF5VpQNgUs0rm8nAK2xhnjcj2+Jh
 89cGeNC9su/aAcdfEYlzDhyIFeeYoAwgYme3lMgV7MGsw2axEx44564aq2qTQDGbv4
 tM3+v8w0ekwBHLWs19yiX2m9XdxkpWf7ku35ctsQ=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:33 +0100
Message-Id: <20201106221743.3271965-19-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 18/28] cxgb3: use ndo_siocdevprivate
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

cxgb3 has a private multiplexor that works correctly in compat
mode, split out the siocdevprivate callback from do_ioctl for
simplification.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 84ad7261e243..c79a70d370bd 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2135,13 +2135,18 @@ static int in_range(int val, int lo, int hi)
 	return val < 0 || (val <= hi && val >= lo);
 }
 
-static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
+static int cxgb_siocdevprivate(struct net_device *dev,
+			       struct ifreq *ifreq,
+			       void __user *useraddr,
+			       int cmd)
 {
 	struct port_info *pi = netdev_priv(dev);
 	struct adapter *adapter = pi->adapter;
-	u32 cmd;
 	int ret;
 
+	if (cmd != SIOCCHIOCTL)
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
 		return -EFAULT;
 
@@ -2546,8 +2551,6 @@ static int cxgb_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
 		fallthrough;
 	case SIOCGMIIPHY:
 		return mdio_mii_ioctl(&pi->phy.mdio, data, cmd);
-	case SIOCCHIOCTL:
-		return cxgb_extension_ioctl(dev, req->ifr_data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3181,6 +3184,7 @@ static const struct net_device_ops cxgb_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= cxgb_set_rxmode,
 	.ndo_do_ioctl		= cxgb_ioctl,
+	.ndo_siocdevprivate	= cxgb_siocdevprivate,
 	.ndo_change_mtu		= cxgb_change_mtu,
 	.ndo_set_mac_address	= cxgb_set_mac_addr,
 	.ndo_fix_features	= cxgb_fix_features,
-- 
2.27.0

