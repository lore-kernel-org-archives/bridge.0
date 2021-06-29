Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fKBJ+HCJQ1IihBjBCwPYHx5qSIWh4l6D9kHNjLPM2ok=;
 b=LUK7Je5mFDyxa3Ck/5fKxRcW1h76Y6D+iaxJLub1wjj+YhxP3HAS38wYKoUQvr9lrE
 RXetrSp0J6/onP+1RXJ94Rv7SKI/YQ+fQmvrmIoX3iUlXTP5F8+MJaJ+0bxX0thtmBoS
 v4OJqKxmQ+alqAMgUD+lcKUSzhzyUcqgkBOJ66Q92VDePY5CiPMtoW/xcn7nLSvSdNIu
 L7VSenM2of7PJ0i0bqvr0SnrS7pzWscde6LoC4giT+1wYl+yGwaiiFLKIiCSjyvtv04g
 b8rM5di8Muf1I3bnYbDcTLEXNWw4oPG1u4d5dgEVvOforOzv7BBYxkeZvdJd6jwLnwBP
 mvAQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:58 +0300
Message-Id: <20210629140658.2510288-16-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 15/15] net: dsa: replay the local
	bridge FDB entries pointing to the bridge dev too
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

When we join a bridge that already has some local addresses pointing to
itself, we do not get those notifications. Similarly, when we leave that
bridge, we do not get notifications for the deletion of those entries.
The only switchdev notifications we get are those of entries added while
the DSA port is enslaved to the bridge.

This makes use cases such as the following work properly (with the
number of additions and removals properly balanced):

ip link add br0 type bridge
ip link add br1 type bridge
ip link set br0 address 00:01:02:03:04:05
ip link set br1 address 00:01:02:03:04:05
ip link set swp0 up
ip link set swp1 up
ip link set swp0 master br0
ip link set swp1 master br1
ip link set br0 up
ip link set br1 up
ip link del br1 # 00:01:02:03:04:05 still installed on the CPU port
ip link del br0 # 00:01:02:03:04:05 finally removed from the CPU port

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none

 net/dsa/port.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 778b0dc2bb39..28b45b7e66df 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -199,11 +199,17 @@ static int dsa_port_switchdev_sync(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	/* Forwarding and termination FDB entries on the port */
 	err = br_fdb_replay(br, brport_dev, dp, true,
 			    &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	/* Termination FDB entries on the bridge itself */
+	err = br_fdb_replay(br, br, dp, true, &dsa_slave_switchdev_notifier);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	err = br_vlan_replay(br, brport_dev, dp, true,
 			     &dsa_slave_switchdev_blocking_notifier, extack);
 	if (err && err != -EOPNOTSUPP)
@@ -225,11 +231,17 @@ static int dsa_port_switchdev_unsync_objs(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	/* Forwarding and termination FDB entries on the port */
 	err = br_fdb_replay(br, brport_dev, dp, false,
 			    &dsa_slave_switchdev_notifier);
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
+	/* Termination FDB entries on the bridge itself */
+	err = br_fdb_replay(br, br, dp, false, &dsa_slave_switchdev_notifier);
+	if (err && err != -EOPNOTSUPP)
+		return err;
+
 	err = br_vlan_replay(br, brport_dev, dp, false,
 			     &dsa_slave_switchdev_blocking_notifier, extack);
 	if (err && err != -EOPNOTSUPP)
-- 
2.25.1

