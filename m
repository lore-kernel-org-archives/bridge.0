Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604701100;
 bh=dgbf9vMJhf45lAdZILBXIwZQ1xaRMCOPTURp9X2yDDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iyQOyLpk77BiXIfUbf/MZngHQV2t7HAqDoucsEDONs2ivJnNsBHZLhh8GVl2Ce9t+
 hYgqArAgeX54SUCfK9szto3dnRNCXcFI0X1WboLlOEJbM/wVz4MzbZcUhvqnPk2Rw7
 a8PrKC9y8FFaZyy2QZd/g7jol6rC+v4GQkH/T5Pg=
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri,  6 Nov 2020 23:17:24 +0100
Message-Id: <20201106221743.3271965-10-arnd@kernel.org>
In-Reply-To: <20201106221743.3271965-1-arnd@kernel.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 09/28] bonding: use siocdevprivate
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

The bonding driver supports two command codes for each operation: one
in the SIOCDEVPRIVATE range and another one with the same definition
but a unique command code.

Only the second set currently works in compat mode, as the ifr_data
expansion overwrites part of the ifr_slave field.

Move the private ones into ndo_siocdevprivate and change the
implementation to call the other function.  This makes both version
work correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/bonding/bond_main.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 84ecbc6fa0ff..5a2956fec025 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3781,7 +3781,6 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 		}
 
 		return 0;
-	case BOND_INFO_QUERY_OLD:
 	case SIOCBONDINFOQUERY:
 		u_binfo = (struct ifbond __user *)ifr->ifr_data;
 
@@ -3793,7 +3792,6 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 			return -EFAULT;
 
 		return 0;
-	case BOND_SLAVE_INFO_QUERY_OLD:
 	case SIOCBONDSLAVEINFOQUERY:
 		u_sinfo = (struct ifslave __user *)ifr->ifr_data;
 
@@ -3823,19 +3821,15 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 		return -ENODEV;
 
 	switch (cmd) {
-	case BOND_ENSLAVE_OLD:
 	case SIOCBONDENSLAVE:
 		res = bond_enslave(bond_dev, slave_dev, NULL);
 		break;
-	case BOND_RELEASE_OLD:
 	case SIOCBONDRELEASE:
 		res = bond_release(bond_dev, slave_dev);
 		break;
-	case BOND_SETHWADDR_OLD:
 	case SIOCBONDSETHWADDR:
 		res = bond_set_dev_addr(bond_dev, slave_dev);
 		break;
-	case BOND_CHANGE_ACTIVE_OLD:
 	case SIOCBONDCHANGEACTIVE:
 		bond_opt_initstr(&newval, slave_dev->name);
 		res = __bond_opt_set_notify(bond, BOND_OPT_ACTIVE_SLAVE,
@@ -3848,6 +3842,28 @@ static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd
 	return res;
 }
 
+static int bond_siocdevprivate(struct net_device *bond_dev, struct ifreq *ifr,
+			       void __user *data, int cmd)
+{
+	struct ifreq ifrdata = { .ifr_data = data };
+	switch (cmd) {
+	case BOND_INFO_QUERY_OLD:
+		return bond_do_ioctl(bond_dev, &ifrdata, SIOCBONDINFOQUERY);
+	case BOND_SLAVE_INFO_QUERY_OLD:
+		return bond_do_ioctl(bond_dev, &ifrdata, SIOCBONDSLAVEINFOQUERY);
+	case BOND_ENSLAVE_OLD:
+		return bond_do_ioctl(bond_dev, ifr, SIOCBONDENSLAVE);
+	case BOND_RELEASE_OLD:
+		return bond_do_ioctl(bond_dev, ifr, SIOCBONDRELEASE);
+	case BOND_SETHWADDR_OLD:
+		return bond_do_ioctl(bond_dev, ifr, SIOCBONDSETHWADDR);
+	case BOND_CHANGE_ACTIVE_OLD:
+		return bond_do_ioctl(bond_dev, ifr, SIOCBONDCHANGEACTIVE);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static void bond_change_rx_flags(struct net_device *bond_dev, int change)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
@@ -4642,6 +4658,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_select_queue	= bond_select_queue,
 	.ndo_get_stats64	= bond_get_stats,
 	.ndo_do_ioctl		= bond_do_ioctl,
+	.ndo_siocdevprivate	= bond_siocdevprivate,
 	.ndo_change_rx_flags	= bond_change_rx_flags,
 	.ndo_set_rx_mode	= bond_set_rx_mode,
 	.ndo_change_mtu		= bond_change_mtu,
-- 
2.27.0

