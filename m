Return-Path: <eng.alaamohamedsoliman.am@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6gx1I2LEKWcJc0uFAMan792S2TeZ8Y9b5WwgAcqsFho=;
 b=eqsr3iRoOLraeHQfAN1F8lxbHhTSxdIjUQr8ExFzQAGCUmElefmB7guzyjC0kxl5je
 HT0OIrgMVP7TYB+jH1by1xcLHdxR/iPH0RxBMg5q8hDehljaEk52mNtAkz7VAAAfq6uQ
 U598+3czQfs9pI2uIeUeVm6xVsHA+ogUhmyhCFfyVDEr1zdRF7yHyA3ybZoPFqixxaT/
 X/6mA+22S80hqy84zvJQgTv/OkAWwpJyHz4aD/4jYED4VSKNHVEP2I/N4UZ4TPedAj0+
 bMQcG1Int7xYiYvMjssXccYPNgZwB9G02qDFer0iaKKzUSx93WZuxt9XIQVsQf2k38am
 8hHg==
From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Fri, 29 Apr 2022 14:49:05 +0200
Message-Id: <cover.1651236081.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v5 0/2] propagate extack to
	vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: eng.alaamohamedsoliman.am@gmail.com, shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, vladimir.oltean@nxp.com, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, intel-wired-lan@lists.osuosl.org

In order to propagate extack to vxlan_fdb_delete and vxlan_fdb_parse,
add extack to .ndo_fdb_del and edit all fdb del handelers.

Alaa Mohamed (2):
  rtnetlink: add extack support in fdb del handlers
  net: vxlan: Add extack support to vxlan_fdb_delete

 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  3 +-
 drivers/net/macvlan.c                         |  3 +-
 drivers/net/vxlan/vxlan_core.c                | 41 +++++++++++++------
 include/linux/netdevice.h                     |  2 +-
 net/bridge/br_fdb.c                           |  3 +-
 net/bridge/br_private.h                       |  3 +-
 net/core/rtnetlink.c                          |  4 +-
 9 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.36.0

