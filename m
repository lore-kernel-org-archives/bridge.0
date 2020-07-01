Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593588172; x=1625124172;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ASReo1CJm8170qaaG0UUzUeLV1c7HctXtdLcR5LMm/I=;
 b=lhRMXL/49QwyrzTl+tCF2VkPIh4cv9f2gtZLugO9+ZNCBbTbjGFkeSqZ
 0mhDpV3/t7qdPwtYrr+rWdvOdqcBXFm0QrIs23Ky5Iy6pQWfMJVDce0UK
 SQNj4Zbf72POdMX833JWXdaST0LMPH7vfuhnDBy7ung0id0szuqMUTuID
 7cJ9Q1r1kwQtQfkHWkm99Fehe5g0hWqy1XWes9xEo0zxbO1KcutUDs9wL
 8g0F8sDNFFLiorK8vTXfWjMkXaeI1gJlmg4dQjJeXnLW4siWYDug3A1Tm
 QTZdNCmxy6y4UoW529tbwQAfmRvFM6S1ge/FFpSbvXJw28Ai84Zk3E7Ye A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 1 Jul 2020 09:22:36 +0200
Message-ID: <20200701072239.520807-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 0/3] bridge: mrp: Add support for
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

v2:
  - fix sparse warnings

Horatiu Vultur (3):
  bridge: uapi: mrp: Extend MRP attributes to get the status
  bridge: mrp: Add br_mrp_fill_info
  bridge: Extend br_fill_ifinfo to return MPR status

 include/uapi/linux/if_bridge.h | 17 +++++++++
 include/uapi/linux/rtnetlink.h |  1 +
 net/bridge/br_mrp_netlink.c    | 64 ++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 29 ++++++++++++++-
 net/bridge/br_private.h        |  7 ++++
 5 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.27.0

