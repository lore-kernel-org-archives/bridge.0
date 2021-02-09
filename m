Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=33/uyGIN3FY3+rBdv4FUVUP8dhmUMuazcIsOv+i6Gos=;
 b=Jze5auyHPDoC6rfV73gY30Hp1USjjzyfk4eUjoUSm/ZtmJUo0//B9gg5YM1xmx4SGA
 m94yMWYIaoLHQTuURAvVTDpiYHPvDU77il0aNvTjxzRWzpLI3MLnPLZQ49Dn6FDU1YMO
 WCid8yzpagqm6Y7xzh0cHgqLG8Ql5cImK1tQemFDvTKZDl+e9Sk7XVRbfd0+5tuSAy/p
 evF3lWgG/HM/6d/Wdq8YDdLeGNrSErN5MGA0MjwtHrP+Hnljy04hYROZEUD7slwsoc0q
 4LVZ2xKfV1sdpKkuFDA16wmfRF40pE0B8XEdTIEommbKbT94DQTO6GYAR1r0cixMb4mO
 xJMA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue,  9 Feb 2021 17:19:33 +0200
Message-Id: <20210209151936.97382-9-olteanv@gmail.com>
In-Reply-To: <20210209151936.97382-1-olteanv@gmail.com>
References: <20210209151936.97382-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 08/11] net: bridge: put
	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS on the blocking call chain
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that br_switchdev_set_port_flag is never called from under br->lock,
it runs in sleepable context.

All switchdev drivers handle SWITCHDEV_PORT_ATTR_SET as both blocking
and atomic, so no changes are needed on that front.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Patch is new.

 net/bridge/br_switchdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index bc63b10b2e67..3b152f2cd9b5 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -79,9 +79,8 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.u.brport_flags.val = flags;
 	attr.u.brport_flags.mask = mask;
 
-	/* We run from atomic context here */
-	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
-				       &info.info, extack);
+	err = call_switchdev_blocking_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
+						&info.info, extack);
 	err = notifier_to_errno(err);
 	if (err == -EOPNOTSUPP)
 		return 0;
-- 
2.25.1

