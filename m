Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612902257; x=1644438257;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mScHVWGIFuV1tfRo50B5fq0AL0izsRJ5iX46aUKbLLE=;
 b=cRhBKZ4zpIxfX0JOkjuMAhgP+nJfgQ1B2nOj18iJOZiU2ohp5UArPE8Q
 EX3yjO9QdwN7isuuidqO8eok8d2dvXKTHCnZTqf9zt+fo7jJg2Q49gXa/
 SD0JXfFpENIMVIP4HH/RbGOzq5isoo2UEBpjO+lkoe+UVzn4E10CSZpMR
 i4suYXj7wrE3q0X2NQ7uaRt133Qq9iEamL7ZCgqDzyM0+NqCve8jHuBFX
 fFfLe2Mqwhdy9Mg2XnCi9gyUwIidgF7sYbzehxjQzmspz5UP9Ec6suy2n
 1Cay5cdaXN2pOKCADkz3AQs5hVDCGefBSxqrsUVClF6LINDkCodJoeG4N Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 9 Feb 2021 21:21:07 +0100
Message-ID: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 0/5] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends MRP switchdev to allow the SW to have a better
understanding if the HW can implement the MRP functionality or it needs
to help the HW to run it. There are 3 cases:
- when HW can't implement at all the functionality.
- when HW can implement a part of the functionality but needs the SW
  implement the rest. For example if it can't detect when it stops
  receiving MRP Test frames but it can copy the MRP frames to CPU to
  allow the SW to determine this.  Another example is generating the MRP
  Test frames. If HW can't do that then the SW is used as backup.
- when HW can implement completely the functionality.

So, initially the SW tries to offload the entire functionality in HW, if
that fails it tries offload parts of the functionality in HW and use the
SW as helper and if also this fails then MRP can't run on this HW.

Also implement the switchdev calls for Ocelot driver. This is an example
where the HW can't run completely the functionality but it can help the SW
to run it, by trapping all MRP frames to CPU.

v3:
 - implement the switchdev calls needed by Ocelot driver.
v2:
 - fix typos in comments and in commit messages
 - remove some of the comments
 - move repeated code in helper function
 - fix issue when deleting a node when sw_backup was true

Horatiu Vultur (5):
  switchdev: mrp: Extend ring_role_mrp and in_role_mrp
  bridge: mrp: Add 'enum br_mrp_hw_support'
  bridge: mrp: Extend br_mrp_switchdev to detect better the errors
  bridge: mrp: Update br_mrp to use new return values of
    br_mrp_switchdev
  net: mscc: ocelot: Add support for MRP

 drivers/net/ethernet/mscc/ocelot_net.c     | 154 +++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot_vsc7514.c |   6 +
 include/net/switchdev.h                    |   2 +
 include/soc/mscc/ocelot.h                  |   6 +
 net/bridge/br_mrp.c                        |  43 ++++--
 net/bridge/br_mrp_switchdev.c              | 171 +++++++++++++--------
 net/bridge/br_private_mrp.h                |  38 +++--
 7 files changed, 327 insertions(+), 93 deletions(-)

-- 
2.27.0

