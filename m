Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701140;
 bh=LJtDaUHH63i3o2EMXP8szuWYRpl83P553+fUvMeSGK8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=inKXSx7pu4OlpdzCD5Ep6OcHlKJRGvMAxzNAl2slHhIwVAxkcTQLSF9WIdiliNBcA
 WWlqw4cwyVvis73M4kp0tBT0Ckf0DK+JRoz8CDsxpgTTnZ4bqmS86gVWOviRFkdiGa
 6uIquNqkO2we+L3RPOsWxawVmwrOMXxbf3eUuvnA=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:38 +0100
Message-Id: <20201106221743.3271965-24-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 23/28] airo: use ndo_siocdevprivate
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

The airo driver overloads SIOCDEVPRIVATE ioctls with another
set based on SIOCIWFIRSTPRIV. Only the first ones actually
work (also in compat mode) as the others do not get passed
down any more.

Change it over to ndo_siocdevprivate for clarification.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/cisco/airo.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 87b9398b03fd..045b9bb4db5d 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1142,7 +1142,7 @@ static int waitbusy(struct airo_info *ai);
 static irqreturn_t airo_interrupt(int irq, void* dev_id);
 static int airo_thread(void *data);
 static void timer_func(struct net_device *dev);
-static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static int airo_siocdevprivate(struct net_device *dev, struct ifreq *rq, void __user *, int cmd);
 static struct iw_statistics *airo_get_wireless_stats(struct net_device *dev);
 static void airo_read_wireless_stats(struct airo_info *local);
 #ifdef CISCO_EXT
@@ -2668,7 +2668,7 @@ static const struct net_device_ops airo11_netdev_ops = {
 	.ndo_start_xmit 	= airo_start_xmit11,
 	.ndo_get_stats 		= airo_get_stats,
 	.ndo_set_mac_address	= airo_set_mac_address,
-	.ndo_do_ioctl		= airo_ioctl,
+	.ndo_siocdevprivate	= airo_siocdevprivate,
 };
 
 static void wifi_setup(struct net_device *dev)
@@ -2768,7 +2768,7 @@ static const struct net_device_ops airo_netdev_ops = {
 	.ndo_get_stats		= airo_get_stats,
 	.ndo_set_rx_mode	= airo_set_multicast_list,
 	.ndo_set_mac_address	= airo_set_mac_address,
-	.ndo_do_ioctl		= airo_ioctl,
+	.ndo_siocdevprivate	= airo_siocdevprivate,
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
@@ -2779,7 +2779,7 @@ static const struct net_device_ops mpi_netdev_ops = {
 	.ndo_get_stats		= airo_get_stats,
 	.ndo_set_rx_mode	= airo_set_multicast_list,
 	.ndo_set_mac_address	= airo_set_mac_address,
-	.ndo_do_ioctl		= airo_ioctl,
+	.ndo_siocdevprivate	= airo_siocdevprivate,
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
@@ -7650,7 +7650,8 @@ static const struct iw_handler_def	airo_handler_def =
  * Javier Achirica did a great job of merging code from the unnamed CISCO
  * developer that added support for flashing the card.
  */
-static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int airo_siocdevprivate(struct net_device *dev, struct ifreq *rq,
+				void __user *data, int cmd)
 {
 	int rc = 0;
 	struct airo_info *ai = dev->ml_priv;
@@ -7667,7 +7668,7 @@ static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	{
 		int val = AIROMAGIC;
 		aironet_ioctl com;
-		if (copy_from_user(&com, rq->ifr_data, sizeof(com)))
+		if (copy_from_user(&com, data, sizeof(com)))
 			rc = -EFAULT;
 		else if (copy_to_user(com.data, (char *)&val, sizeof(val)))
 			rc = -EFAULT;
@@ -7683,7 +7684,7 @@ static int airo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		 */
 	{
 		aironet_ioctl com;
-		if (copy_from_user(&com, rq->ifr_data, sizeof(com))) {
+		if (copy_from_user(&com, data, sizeof(com))) {
 			rc = -EFAULT;
 			break;
 		}
-- 
2.27.0

