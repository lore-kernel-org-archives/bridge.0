Return-Path: <eng.alaamohamedsoliman.am@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OhzJ18rUdY++br4oj9YWYkBT8GEB1PEcZ+V/iXVMZrg=;
 b=Yp2ksl18LS/4Zs/ovpsVTlQwPq8RKkSp5QpY5tBP2+j05ULF7qPRftNv6iD6RV/IlN
 wBgjKe+jfS8pkoAlzDTWhfuCNXo8tuvgYq8GdjluJNdsL0Egy2XuECnoZ1b2EPAjXUe+
 jMVbqPb4/rU9tF+FQiWisfBHk5ZPwSSW1FGaE1as3zRZF/Bl8U0iJvqlG30E5ae4IJ3/
 fULg5bRvkciOv3RjeFApqNa7WkOnypR+SOycWijAO17Hx98IiaXeUtULZ3nSGJ+2vbiX
 wDgY8NgfbOWevz+rMK4KPWxSboDV2TSMJmbRhXZAbyf/q0RpPAAY7AoTalW7Zk59XBqQ
 a2EA==
From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Mon, 25 Apr 2022 16:25:05 +0200
Message-Id: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 0/2] propagate extack to
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
add extack to .ndo_fdb_del and edit all fdb del handelers

Alaa Mohamed (2):
  rtnetlink: add extack support in fdb del handlers
  net: vxlan: vxlan_core.c: Add extack support to vxlan_fdb_delete

 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  4 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  2 +-
 drivers/net/macvlan.c                         |  2 +-
 drivers/net/vxlan/vxlan_core.c                | 39 +++++++++++++------
 include/linux/netdevice.h                     |  2 +-
 net/bridge/br_fdb.c                           |  2 +-
 net/bridge/br_private.h                       |  3 +-
 net/core/rtnetlink.c                          |  4 +-
 9 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.36.0

