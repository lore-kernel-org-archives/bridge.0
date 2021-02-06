Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612648185; x=1644184185;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yLgapeK5FwV5IDNMOCWuPlVIbCFeQL0vs9X/eGhKGDw=;
 b=yT/k3nnFIaQMXkjb+ImaJBY7xPG5U5jS4cK3VXZ5cqY8a2GXv3jY/ZAI
 AGkEX4gzPWSgJtob41WGST+Z5wV/8/DDyFH4NqbHEMz3Y7DiPl0nMNVBX
 rJzxklvR62tJqCudFhvFqE2EfoCj/P7kIEqrnXsHxLyAg7Yh08ftzivWO
 j1q0IbNQpX5rcs76jgNZKDgJHq4+GBALtB9mJn1CmKiSVfrJ9615A3ACy
 Lz8/uuLLVbEy1NgikV+XdvtB38JgXDhbcYs4Nh7dk0eawJ49sKZpJxnWz
 XUQsQW8NWpM/C01WECWdr8aCrIS3eAO81PzeYo/YY0v5vG8N34jBJbVeY Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 6 Feb 2021 22:47:32 +0100
Message-ID: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net 0/2] bridge: mrp: Fix
	br_mrp_port_switchdev_set_state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Based on the discussion here[1], there was a problem with the function
br_mrp_port_switchdev_set_state. The problem was that it was called
both with BR_STATE* and BR_MRP_PORT_STATE* types. This patch series
fixes this issue and removes SWITCHDEV_ATTR_ID_MRP_PORT_STAT because
is not used anymore.

[1] https://www.spinics.net/lists/netdev/msg714816.html

Horatiu Vultur (2):
  bridge: mrp: Fix the usage of br_mrp_port_switchdev_set_state
  switchdev: mrp: Remove SWITCHDEV_ATTR_ID_MRP_PORT_STAT

 include/net/switchdev.h       | 2 --
 net/bridge/br_mrp.c           | 9 ++++++---
 net/bridge/br_mrp_switchdev.c | 7 +++----
 net/bridge/br_private_mrp.h   | 3 +--
 4 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.27.0

