Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593524740; x=1625060740;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DT8RPyRP9mmuQ6a31TkFhh6MXoc72CoyHoSonfX6oCE=;
 b=xrZ0sg8i0PhCsg11vxAhZLUQE9CdRAp8Yt/9/fM+tvQ4ob32GhzdefqY
 amfZK9Xi22mS4OpcyVoBl9dcvfcbuP8qlosrItIg/8mXdUZZZqb1iSF3U
 4zGUoLv3eGixV4p3bvdYdGiuLRnmW6PGsMIxzPWrkbYkvNc89IGGibYSS
 EY1gDtZoOLT1bHBaVoBGD4Swg3ZzDXmpYW6hKAA+k/F0nJNjnlyYi8zY0
 Cqh8T+CHRtl+xgcGw/foLKHRQolGfJPOJzW0HmfkyW7NkrisIoPTA6f1d
 Iss23yQMNuJsTVaZYIngOL4EfuDnfh5lam8GQXarztX+MqEo5gMOAhPmQ Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 30 Jun 2020 15:44:21 +0200
Message-ID: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/3] bridge: mrp: Add support for getting
	the status
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

Horatiu Vultur (3):
  bridge: uapi: mrp: Extend MRP attributes to get the status
  bridge: mrp: Add br_mrp_fill_info
  bridge: Extend br_fill_ifinfo to return MPR status

 include/uapi/linux/if_bridge.h | 17 ++++++++++
 include/uapi/linux/rtnetlink.h |  1 +
 net/bridge/br_mrp_netlink.c    | 57 ++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 29 ++++++++++++++++-
 net/bridge/br_private.h        |  7 +++++
 5 files changed, 110 insertions(+), 1 deletion(-)

-- 
2.27.0

