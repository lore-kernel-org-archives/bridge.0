Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593156852; x=1624692852;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h3hNjRKGmfssGibJLg47pILaq4IrAogvkfO1FL2evKQ=;
 b=jcObcqJPQVWgWm6xSRiWQoi/Loi8FvQ9w0PGUhFQmw7QLY9rTqIzt1Lb
 eX2jN/YGaXSEAnhpYCak1+7qiF/qzyjUkzQQjiH0ortzC1/akFWgK46Gh
 tCSgOnngN+x3go6z3bBKlTmOMAJO3E9KnyyId1p3+LwItA1owFd365S/a
 sfZwQWte+WsobBHRwkGO46tCrnaOhRLeGUo7W1p5hpnyaHG+UxFZFpZrB
 RfpLHgRy0tZDg7vaX45ayPbmMhCn8qpVayzVZ1pjxpQiKK50wkniTdN65
 y2nk8xZRxgAhgJKnAdczbItYUONaKfsaBTfJXyth4g9N4JmyvWCNzA+dq A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 26 Jun 2020 09:33:47 +0200
Message-ID: <20200626073349.3495526-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 0/2] bridge: mrp: Extend MRP netlink
	interface with IFLA_BRIDGE_MRP_CLEAR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends MRP netlink interface with IFLA_BRIDGE_MRP_CLEAR.
To allow the userspace to clear all MRP instances when is started. The
second patch in the series fix different sparse warnings.

v3:
  - add the second patch to fix sparse warnings

v2:
  - use list_for_each_entry_safe instead of list_for_each_entry_rcu
    when deleting mrp instances

Horatiu Vultur (2):
  bridge: mrp: Extend MRP netlink interface with IFLA_BRIDGE_MRP_CLEAR
  bridge: mrp: Fix endian conversion and some other warnings

 include/uapi/linux/if_bridge.h |  8 ++++++++
 net/bridge/br_mrp.c            | 17 ++++++++++++++++-
 net/bridge/br_mrp_netlink.c    | 26 ++++++++++++++++++++++++++
 net/bridge/br_private.h        |  2 +-
 net/bridge/br_private_mrp.h    |  3 ++-
 5 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.26.2

