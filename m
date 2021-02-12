Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VU/Ikjjp9YKqSORV3tobt3dZbVwKnijcAhFtaSftkOM=;
 b=qonI8wT2dff7Mgsx31B+JOmlvExNq+3TpV5Yz8M7nlv4XGgSFrCxsRmEM7/a5q75+f
 fepRIKLIGyqAbSW+WEGSqaHHEiMzZsxOtmHEzn+fTkj4lj801GQWwfzgZIOQoI3DNLmm
 i96R1+mB5/C8rZTZ77FYFQuncEK10Gx6tOK15nqaEvQ4LfbXBrCy1GOEYuf9y7zLRV0C
 AkAvEsJF1Utgo5JzfjjkGuOfzn5yFTnsfptqd2hX+yvMmfKgh9Ls8MuvZ8NRhbDMpFTJ
 HG30AhPayp5i9X6pTcFds/L1V/8UP8RbSrVErEcgH5IVGWyUhNMT/VWJ2Uf4bkE0r3Wj
 RzqA==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 03:05:26 +0200
Message-Id: <20210212010531.2722925-5-olteanv@gmail.com>
In-Reply-To: <20210212010531.2722925-1-olteanv@gmail.com>
References: <20210212010531.2722925-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 4/9] net: dsa: configure better brport
	flags when ports leave the bridge
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

For a DSA switch port operating in standalone mode, address learning
doesn't make much sense since that is a bridge function. In fact,
address learning even breaks setups such as this one:

   +---------------------------------------------+
   |                                             |
   | +-------------------+                       |
   | |        br0        |    send      receive  |
   | +--------+-+--------+ +--------+ +--------+ |
   | |        | |        | |        | |        | |
   | |  swp0  | |  swp1  | |  swp2  | |  swp3  | |
   | |        | |        | |        | |        | |
   +-+--------+-+--------+-+--------+-+--------+-+
          |         ^           |          ^
          |         |           |          |
          |         +-----------+          |
          |                                |
          +--------------------------------+

because if the switch has a single FDB (can offload a single bridge)
then source address learning on swp3 can "steal" the source MAC address
of swp2 from br0's FDB, because learning frames coming from swp2 will be
done twice: first on the swp1 ingress port, second on the swp3 ingress
port. So the hardware FDB will become out of sync with the software
bridge, and when swp2 tries to send one more packet towards swp1, the
ASIC will attempt to short-circuit the forwarding path and send it
directly to swp3 (since that's the last port it learned that address on),
which it obviously can't, because swp3 operates in standalone mode.

So DSA drivers operating in standalone mode should still configure a
list of bridge port flags even when they are standalone. Currently DSA
attempts to call dsa_port_bridge_flags with 0, which disables egress
flooding of unknown unicast and multicast, something which doesn't make
much sense. For the switches that implement .port_egress_floods - b53
and mv88e6xxx, it probably doesn't matter too much either, since they
can possibly inject traffic from the CPU into a standalone port,
regardless of MAC DA, even if egress flooding is turned off for that
port, but certainly not all DSA switches can do that - sja1105, for
example, can't. So it makes sense to use a better common default there,
such as "flood everything".

It should also be noted that what DSA calls "dsa_port_bridge_flags()"
is a degenerate name for just calling .port_egress_floods(), since
nothing else is implemented - not learning, in particular. But disabling
address learning, something that this driver is also coding up for, will
be supported by individual drivers once .port_egress_floods is replaced
with a more generic .port_bridge_flags.

Previous attempts to code up this logic have been in the common bridge
layer, but as pointed out by Ido Schimmel, there are corner cases that
are missed when doing that:
https://patchwork.kernel.org/project/netdevbpf/patch/20210209151936.97382-5-olteanv@gmail.com/

So, at least for now, let's leave DSA in charge of setting port flags
before and after the bridge join and leave.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v4:
None.

Changes in v3:
Patch is new, logically it was moved from the bridge layer to the DSA
layer.

 net/dsa/port.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5e079a61528e..9f65ba11ad00 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -122,6 +122,27 @@ void dsa_port_disable(struct dsa_port *dp)
 	rtnl_unlock();
 }
 
+static void dsa_port_change_brport_flags(struct dsa_port *dp,
+					 bool bridge_offload)
+{
+	unsigned long mask, flags;
+	int flag, err;
+
+	mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
+	if (bridge_offload)
+		flags = mask;
+	else
+		flags = mask & ~BR_LEARNING;
+
+	for_each_set_bit(flag, &mask, 32) {
+		err = dsa_port_pre_bridge_flags(dp, BIT(flag));
+		if (err)
+			continue;
+
+		dsa_port_bridge_flags(dp, flags & BIT(flag));
+	}
+}
+
 int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br)
 {
 	struct dsa_notifier_bridge_info info = {
@@ -132,10 +153,10 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br)
 	};
 	int err;
 
-	/* Set the flooding mode before joining the port in the switch */
-	err = dsa_port_bridge_flags(dp, BR_FLOOD | BR_MCAST_FLOOD);
-	if (err)
-		return err;
+	/* Notify the port driver to set its configurable flags in a way that
+	 * matches the initial settings of a bridge port.
+	 */
+	dsa_port_change_brport_flags(dp, true);
 
 	/* Here the interface is already bridged. Reflect the current
 	 * configuration so that drivers can program their chips accordingly.
@@ -146,7 +167,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br)
 
 	/* The bridging is rolled back on error */
 	if (err) {
-		dsa_port_bridge_flags(dp, 0);
+		dsa_port_change_brport_flags(dp, false);
 		dp->bridge_dev = NULL;
 	}
 
@@ -172,8 +193,18 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	if (err)
 		pr_err("DSA: failed to notify DSA_NOTIFIER_BRIDGE_LEAVE\n");
 
-	/* Port is leaving the bridge, disable flooding */
-	dsa_port_bridge_flags(dp, 0);
+	/* Configure the port for standalone mode (no address learning,
+	 * flood everything).
+	 * The bridge only emits SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS events
+	 * when the user requests it through netlink or sysfs, but not
+	 * automatically at port join or leave, so we need to handle resetting
+	 * the brport flags ourselves. But we even prefer it that way, because
+	 * otherwise, some setups might never get the notification they need,
+	 * for example, when a port leaves a LAG that offloads the bridge,
+	 * it becomes standalone, but as far as the bridge is concerned, no
+	 * port ever left.
+	 */
+	dsa_port_change_brport_flags(dp, false);
 
 	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
 	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
-- 
2.25.1

