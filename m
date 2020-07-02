Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593677595; x=1625213595;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yl2VuSGjDWMQiuL7KQmLjM60vMbdhACMmPH2M/uS8AI=;
 b=batYJHqlTSoj+8oEM6UrLZIAI6V+9yPHqbrD7x1SSDNos+NsvuvBigiC
 5pcxJtPBgEUhUSzyuO/LtdqELJrnh8lt1UEjtrcbfhC4kfP85cWUxmuwt
 63LfG98uEsMuK2dKh3X0K01G4742//3SRqSrZ8WnHGXz7Wzyh/A6WOHq2
 HAHWQ6670WXr8HOhCYPldWJIkfM8df1MFNK0jqCMJChXknDwD49wSFJKp
 zrJEV+MpX1evyewcU0IDO7FfmEqq6tssBQKZdYj5TtwqRMJmksQZTaf62
 Z8mkTx+ICyBL5OdRNumDTg1eHgupTdM3sBGRYQGvYiHkqKrtbLi20IW1j g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 2 Jul 2020 10:13:04 +0200
Message-ID: <20200702081307.933471-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 0/3] bridge: mrp: Add support for
	getting the status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends the MRP netlink interface to allow the userspace
daemon to get the status of the MRP instances in the kernel.

v3:
  - remove misleading comment
  - fix to use correctly the RCU

v2:
  - fix sparse warnings

Horatiu Vultur (3):
  bridge: uapi: mrp: Extend MRP attributes to get the status
  bridge: mrp: Add br_mrp_fill_info
  bridge: Extend br_fill_ifinfo to return MPR status

 include/uapi/linux/if_bridge.h | 17 +++++++++
 include/uapi/linux/rtnetlink.h |  1 +
 net/bridge/br_mrp_netlink.c    | 64 ++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 25 ++++++++++++-
 net/bridge/br_private.h        |  7 ++++
 5 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.27.0

