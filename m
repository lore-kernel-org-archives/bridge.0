Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=RLzCcWSvjmmm2uELpX8rsFiP77zXFodpEVkn0mGblas=;
	b=bkAxgo1itWKDKWNWCVG4xwet0GPWTNuBkkkQqLSyZMNQqUL6YlS+RlQkHPafDlz6CI
	pLL1pwGoE949at1TvLAhXmTITJEo5aLM2OJ6p/j3+xh5v1G86JpsMpKinAtM6rL+msGo
	E5XfkULP1UB7Uo0iUdf3zEvJcrFr5i6Ui+I2RsDPFTdRW5a1VOmMSorqES2u81u3Eti4
	k8Y7jhCFX/mqF6hrKaol69ofcQk7LaCxp3xCmSjNYdGhTI8alo7Xie3eb9mIIT9vO3+S
	PnX8MQZO5/TWiUc20h5ykwOCUmQHPItAgUNPB1ZyRokWV7mI+nZA/fqoIVkfpUHlmPzc
	VHwA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 16 Jan 2015 09:56:01 -0800
Message-Id: <1421430962-18119-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
References: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 1/2] net: ipv4: handle DSA enabled
	master network devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, kaber@trash.net, davem@davemloft.net, buytenh@wantstofly.org

The logic to configure a network interface for kernel IP
auto-configuration is very simplistic, and does not handle the case
where a device is stacked onto another such as with DSA. This causes the
kernel not to open and configure the master network device in a DSA
switch tree, and therefore slave network devices using this master
network devices as conduit device cannot be open.

This restriction comes from a check in net/dsa/slave.c, which is
basically checking the master netdev flags for IFF_UP and returns
-ENETDOWN if it is not the case.

Automatically bringing-up DSA master network devices allows DSA slave
network devices to be used as valid interfaces for e.g: NFS root booting
by allowing kernel IP autoconfiguration to succeed on these interfaces.

On the reverse path, make sure we do not attempt to close a DSA-enabled
device as this would implicitely prevent the slave DSA network device
from operating.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- fixed typo in first comment hunk
- remove spurious newline change
- removed second comment, the code is obvious enough

 net/ipv4/ipconfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 7fa18bc7e47f..b26376ef87f6 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -209,9 +209,9 @@ static int __init ic_open_devs(void)
 	last = &ic_first_dev;
 	rtnl_lock();
 
-	/* bring loopback device up first */
+	/* bring loopback and DSA master network devices up first */
 	for_each_netdev(&init_net, dev) {
-		if (!(dev->flags & IFF_LOOPBACK))
+		if (!(dev->flags & IFF_LOOPBACK) && !netdev_uses_dsa(dev))
 			continue;
 		if (dev_change_flags(dev, dev->flags | IFF_UP) < 0)
 			pr_err("IP-Config: Failed to open %s\n", dev->name);
@@ -306,7 +306,7 @@ static void __init ic_close_devs(void)
 	while ((d = next)) {
 		next = d->next;
 		dev = d->dev;
-		if (dev != ic_dev) {
+		if (dev != ic_dev && !netdev_uses_dsa(dev)) {
 			DBG(("IP-Config: Downing %s\n", dev->name));
 			dev_change_flags(dev, d->flags);
 		}
-- 
2.1.0

