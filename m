Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=16gvd7BfAcfkRnjtzWfjSCGdsSy14Us38+FznvZBJ7k=;
 b=PxNd/HwEcNRSVMr99MKoK3FzawQD6GjQmrNvZWYlyPKEozceeJEV7Feiql1pcoI7Rb
 wg9Zt1LmDZR/Etlg/TPais3DvwGsK0kA52gXrvdz3x5V7arW4lg0meHUobfoFNutshdR
 akA0NLol+kdv0LD0cnBx+X86WYao9mr97lZvRBN8UarkgQ6jGGLg41oqfkxAYRGlgq83
 xjqgJv1WgXdxqNTWGb/Wtmt+UsDmvfAHhBBjbAdPm6MY9i+jwiHvcnvunQqgV0sxSyh0
 EoghLxnZiY4BA9dIxr00RSdF0YWbcama5fTUCt6cnwd3n4r0u9PUIiq2H5TDULTe20Ck
 s88Q==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:30 +0200
Message-Id: <20210106095136.224739-2-olteanv@gmail.com>
In-Reply-To: <20210106095136.224739-1-olteanv@gmail.com>
References: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 1/7] net: bridge: notify switchdev of
	disappearance of old FDB entry upon migration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Currently the bridge emits atomic switchdev notifications for
dynamically learnt FDB entries. Monitoring these notifications works
wonders for switchdev drivers that want to keep their hardware FDB in
sync with the bridge's FDB.

For example station A wants to talk to station B in the diagram below,
and we are concerned with the behavior of the bridge on the DUT device:

                   DUT
 +-------------------------------------+
 |                 br0                 |
 | +------+ +------+ +------+ +------+ |
 | |      | |      | |      | |      | |
 | | swp0 | | swp1 | | swp2 | | eth0 | |
 +-------------------------------------+
      |        |                  |
  Station A    |                  |
               |                  |
         +--+------+--+    +--+------+--+
         |  |      |  |    |  |      |  |
         |  | swp0 |  |    |  | swp0 |  |
 Another |  +------+  |    |  +------+  | Another
  switch |     br0    |    |     br0    | switch
         |  +------+  |    |  +------+  |
         |  |      |  |    |  |      |  |
         |  | swp1 |  |    |  | swp1 |  |
         +--+------+--+    +--+------+--+
                                  |
                              Station B

Interfaces swp0, swp1, swp2 are handled by a switchdev driver that has
the following property: frames injected from its control interface bypass
the internal address analyzer logic, and therefore, this hardware does
not learn from the source address of packets transmitted by the network
stack through it. So, since bridging between eth0 (where Station B is
attached) and swp0 (where Station A is attached) is done in software,
the switchdev hardware will never learn the source address of Station B.
So the traffic towards that destination will be treated as unknown, i.e.
flooded.

This is where the bridge notifications come in handy. When br0 on the
DUT sees frames with Station B's MAC address on eth0, the switchdev
driver gets these notifications and can install a rule to send frames
towards Station B's address that are incoming from swp0, swp1, swp2,
only towards the control interface. This is all switchdev driver private
business, which the notification makes possible.

All is fine until someone unplugs Station B's cable and moves it to the
other switch:

                   DUT
 +-------------------------------------+
 |                 br0                 |
 | +------+ +------+ +------+ +------+ |
 | |      | |      | |      | |      | |
 | | swp0 | | swp1 | | swp2 | | eth0 | |
 +-------------------------------------+
      |        |                  |
  Station A    |                  |
               |                  |
         +--+------+--+    +--+------+--+
         |  |      |  |    |  |      |  |
         |  | swp0 |  |    |  | swp0 |  |
 Another |  +------+  |    |  +------+  | Another
  switch |     br0    |    |     br0    | switch
         |  +------+  |    |  +------+  |
         |  |      |  |    |  |      |  |
         |  | swp1 |  |    |  | swp1 |  |
         +--+------+--+    +--+------+--+
               |
           Station B

Luckily for the use cases we care about, Station B is noisy enough that
the DUT hears it (on swp1 this time). swp1 receives the frames and
delivers them to the bridge, who enters the unlikely path in br_fdb_update
of updating an existing entry. It moves the entry in the software bridge
to swp1 and emits an addition notification towards that.

As far as the switchdev driver is concerned, all that it needs to ensure
is that traffic between Station A and Station B is not forever broken.
If it does nothing, then the stale rule to send frames for Station B
towards the control interface remains in place. But Station B is no
longer reachable via the control interface, but via a port that can
offload the bridge port learning attribute. It's just that the port is
prevented from learning this address, since the rule overrides FDB
updates. So the rule needs to go. The question is via what mechanism.

It sure would be possible for this switchdev driver to keep track of all
addresses which are sent to the control interface, and then also listen
for bridge notifier events on its own ports, searching for the ones that
have a MAC address which was previously sent to the control interface.
But this is cumbersome and inefficient. Instead, with one small change,
the bridge could notify of the address deletion from the old port, in a
symmetrical manner with how it did for the insertion. Then the switchdev
driver would not be required to monitor learn/forget events for its own
ports. It could just delete the rule towards the control interface upon
bridge entry migration. This would make hardware address learning be
possible again. Then it would take a few more packets until the hardware
and software FDB would be in sync again.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
Patch is new.

 net/bridge/br_fdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 32ac8343b0ba..b7490237f3fc 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -602,6 +602,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			/* fastpath: update of existing entry */
 			if (unlikely(source != fdb->dst &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
+				br_switchdev_fdb_notify(fdb, RTM_DELNEIGH);
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
-- 
2.25.1

