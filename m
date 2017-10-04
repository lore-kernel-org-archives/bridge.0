Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NYsvfIp3XSN06mNEqQZ1yqe3TE1Ij98snMFME4+KOVo=;
	b=uefZkXnmwKjkCe1Um3wfPV2lr5mPGYrNQp8dGW/ZboPaPkMWx9lcObOk1J2ilFoieq
	w2rcKbxprStU3WxXTRx0Y59SiGn1hS6mSeuX+50Fgj7/rweZPdivh+SznW+xkmFXcHZV
	4aaZKY7iUEMVRsBgyqH61T0/J3W2Ck/SWcUqDl9GP+PT1lJMlqErYTH5rONAVyn44mHY
	RMzumdv8TWmJc0QtvgpWm5ARAmWgYVXwZ7LYGabkHNsnLTxy8irU1Ca8JTYbTUd70Y81
	3vxGAnjw763u6iQXCXjjmwToS3k9ql1AAGHBTbkwfPG6pmNFUoAYsRgVXLcDIOZQ0+3Z
	jBCg==
From: David Ahern <dsahern@gmail.com>
Date: Tue,  3 Oct 2017 21:58:52 -0700
Message-Id: <1507093134-20406-6-git-send-email-dsahern@gmail.com>
In-Reply-To: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH net-next 5/7] net: bonding: Add extack messages for
	some enslave failures
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: j.vosburgh@gmail.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, David Ahern <dsahern@gmail.com>, davem@davemloft.net

A number of bond_enslave errors are logged using the netdev_err API.
Return those messages to userspace via the extack facility.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 drivers/net/bonding/bond_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bc92307c2082..6688dc9154e0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1348,12 +1348,15 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	/* already in-use? */
 	if (netdev_is_rx_handler_busy(slave_dev)) {
+		NL_SET_ERR_MSG(extack,
+			       "Device is in use and cannot be enslaved");
 		netdev_err(bond_dev,
 			   "Error: Device is in use and cannot be enslaved\n");
 		return -EBUSY;
 	}
 
 	if (bond_dev == slave_dev) {
+		NL_SET_ERR_MSG(extack, "Cannot enslave bond to itself.");
 		netdev_err(bond_dev, "cannot enslave bond to itself.\n");
 		return -EPERM;
 	}
@@ -1364,6 +1367,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		netdev_dbg(bond_dev, "%s is NETIF_F_VLAN_CHALLENGED\n",
 			   slave_dev->name);
 		if (vlan_uses_dev(bond_dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "Can not enslave VLAN challenged device to VLAN enabled bond");
 			netdev_err(bond_dev, "Error: cannot enslave VLAN challenged slave %s on VLAN enabled bond %s\n",
 				   slave_dev->name, bond_dev->name);
 			return -EPERM;
@@ -1383,6 +1388,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	 * enslaving it; the old ifenslave will not.
 	 */
 	if (slave_dev->flags & IFF_UP) {
+		NL_SET_ERR_MSG(extack, "Device can not be enslaved while up");
 		netdev_err(bond_dev, "%s is up - this may be due to an out of date ifenslave\n",
 			   slave_dev->name);
 		return -EPERM;
@@ -1423,6 +1429,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 						 bond_dev);
 		}
 	} else if (bond_dev->type != slave_dev->type) {
+		NL_SET_ERR_MSG(extack,
+			       "Device type is different from other slaves");
 		netdev_err(bond_dev, "%s ether type (%d) is different from other slaves (%d), can not enslave it\n",
 			   slave_dev->name, slave_dev->type, bond_dev->type);
 		return -EINVAL;
@@ -1430,6 +1438,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	if (slave_dev->type == ARPHRD_INFINIBAND &&
 	    BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
+		NL_SET_ERR_MSG(extack,
+			       "Only active-backup mode is supported for infiniband slaves");
 		netdev_warn(bond_dev, "Type (%d) supports only active-backup mode\n",
 			    slave_dev->type);
 		res = -EOPNOTSUPP;
@@ -1445,6 +1455,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 				bond->params.fail_over_mac = BOND_FOM_ACTIVE;
 				netdev_warn(bond_dev, "Setting fail_over_mac to active for active-backup mode\n");
 			} else {
+				NL_SET_ERR_MSG(extack,
+					       "Slave device does not support setting the MAC address, but fail_over_mac is not set to active");
 				netdev_err(bond_dev, "The slave device specified does not support setting the MAC address, but fail_over_mac is not set to active\n");
 				res = -EOPNOTSUPP;
 				goto err_undo_flags;
-- 
2.1.4

