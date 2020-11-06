Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701083;
 bh=bFutEyBiizUw1vyhN3FC1qY9OXA4PL6N3mzvnxKxBMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RgH5g9UZXENjafYgeXhJ8iB+YNS3QNz4ojsxogvQnqu8e7BppmYHtlr3ungzkG6SB
 c4iA46D/E2vxsXG+Jt3DnN5FiDcRMcI29BNNrDhg1L1uQBmwcIgRklEayIoVlpbmE9
 X7noh7Fkg+B40xXdFUXI0fyvzcjl88OoaGItrITM=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:18 +0100
Message-Id: <20201106221743.3271965-4-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 03/28] staging: wlan-ng: use siocdevprivate
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

wlan-ng has two private ioctls that correctly work in compat
mode. Move these over to the new ndo_siocdevprivate mechanism.

The p80211netdev_ethtool() function is commented out and
has no use here, so this can be removed

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wlan-ng/p80211netdev.c | 75 ++++----------------------
 1 file changed, 11 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index a15abb2c8f54..6e85be994f1a 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -98,8 +98,8 @@ static int p80211knetdev_stop(struct net_device *netdev);
 static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 						 struct net_device *netdev);
 static void p80211knetdev_set_multicast_list(struct net_device *dev);
-static int p80211knetdev_do_ioctl(struct net_device *dev, struct ifreq *ifr,
-				  int cmd);
+static int p80211knetdev_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
+					void __user *data, int cmd);
 static int p80211knetdev_set_mac_address(struct net_device *dev, void *addr);
 static void p80211knetdev_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc);
@@ -461,56 +461,8 @@ static void p80211knetdev_set_multicast_list(struct net_device *dev)
 		wlandev->set_multicast_list(wlandev, dev);
 }
 
-#ifdef SIOCETHTOOL
-
-static int p80211netdev_ethtool(struct wlandevice *wlandev,
-				void __user *useraddr)
-{
-	u32 ethcmd;
-	struct ethtool_drvinfo info;
-	struct ethtool_value edata;
-
-	memset(&info, 0, sizeof(info));
-	memset(&edata, 0, sizeof(edata));
-
-	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
-		return -EFAULT;
-
-	switch (ethcmd) {
-	case ETHTOOL_GDRVINFO:
-		info.cmd = ethcmd;
-		snprintf(info.driver, sizeof(info.driver), "p80211_%s",
-			 wlandev->nsdname);
-		snprintf(info.version, sizeof(info.version), "%s",
-			 WLAN_RELEASE);
-
-		if (copy_to_user(useraddr, &info, sizeof(info)))
-			return -EFAULT;
-		return 0;
-#ifdef ETHTOOL_GLINK
-	case ETHTOOL_GLINK:
-		edata.cmd = ethcmd;
-
-		if (wlandev->linkstatus &&
-		    (wlandev->macmode != WLAN_MACMODE_NONE)) {
-			edata.data = 1;
-		} else {
-			edata.data = 0;
-		}
-
-		if (copy_to_user(useraddr, &edata, sizeof(edata)))
-			return -EFAULT;
-		return 0;
-#endif
-	}
-
-	return -EOPNOTSUPP;
-}
-
-#endif
-
 /*----------------------------------------------------------------
- * p80211knetdev_do_ioctl
+ * p80211knetdev_siocdevprivate
  *
  * Handle an ioctl call on one of our devices.  Everything Linux
  * ioctl specific is done here.  Then we pass the contents of the
@@ -537,8 +489,9 @@ static int p80211netdev_ethtool(struct wlandevice *wlandev,
  *	locks.
  *----------------------------------------------------------------
  */
-static int p80211knetdev_do_ioctl(struct net_device *dev,
-				  struct ifreq *ifr, int cmd)
+static int p80211knetdev_siocdevprivate(struct net_device *dev,
+					struct ifreq *ifr,
+					void __user *data, int cmd)
 {
 	int result = 0;
 	struct p80211ioctl_req *req = (struct p80211ioctl_req *)ifr;
@@ -547,13 +500,8 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 
 	netdev_dbg(dev, "rx'd ioctl, cmd=%d, len=%d\n", cmd, req->len);
 
-#ifdef SIOCETHTOOL
-	if (cmd == SIOCETHTOOL) {
-		result =
-		    p80211netdev_ethtool(wlandev, (void __user *)ifr->ifr_data);
-		goto bail;
-	}
-#endif
+	if (in_compat_syscall())
+		return -EOPNOTSUPP;
 
 	/* Test the magic, assume ifr is good if it's there */
 	if (req->magic != P80211_IOCTL_MAGIC) {
@@ -572,14 +520,13 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 	/* Allocate a buf of size req->len */
 	msgbuf = kmalloc(req->len, GFP_KERNEL);
 	if (msgbuf) {
-		if (copy_from_user(msgbuf, (void __user *)req->data, req->len))
+		if (copy_from_user(msgbuf, data, req->len))
 			result = -EFAULT;
 		else
 			result = p80211req_dorequest(wlandev, msgbuf);
 
 		if (result == 0) {
-			if (copy_to_user
-			    ((void __user *)req->data, msgbuf, req->len)) {
+			if (copy_to_user(data, msgbuf, req->len)) {
 				result = -EFAULT;
 			}
 		}
@@ -684,7 +631,7 @@ static const struct net_device_ops p80211_netdev_ops = {
 	.ndo_stop = p80211knetdev_stop,
 	.ndo_start_xmit = p80211knetdev_hard_start_xmit,
 	.ndo_set_rx_mode = p80211knetdev_set_multicast_list,
-	.ndo_do_ioctl = p80211knetdev_do_ioctl,
+	.ndo_siocdevprivate = p80211knetdev_siocdevprivate,
 	.ndo_set_mac_address = p80211knetdev_set_mac_address,
 	.ndo_tx_timeout = p80211knetdev_tx_timeout,
 	.ndo_validate_addr = eth_validate_addr,
-- 
2.27.0

