Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590855075; x=1622391075;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LsWUZ3Vo3pgKdES5u3EIGHNrOLkQ2RbU+615OKxy1SI=;
 b=vaTAzZmhNRFplA8xDKp4xzwCiCFUGvTH8L32zYWxHtjnh8KRD84V4Jm9
 MLyb4RcQhNuLC80KWDgZzt0lJ+N24NIzMjaIv74pllLyaNLo+y16negwU
 gKjCJc56DIFbapfhbRpeb9FDibGwrdUMI6h2+y0aKP3eq7NjaWc/qsnt9
 IsqNv504Neqhf3YLcfl07vIbLhZVc64HTMqJyUUbp5QVEefS0WrPyk803
 RR3MBxyPf5bVkriBvMSIjVc33xqG4zJfzuaYCMUeDg7BEt9HpSOarv2wo
 REGmewiL1JQ/fb3BdqLnRP+FbhqlcggCAobNAIhNFDkIc6tgLd4i/b/yM Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 30 May 2020 18:09:45 +0000
Message-ID: <20200530180948.1194569-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 0/3] bridge: mrp: Add support for MRA
	role
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends the MRP with the MRA role.
A node that has the MRA role can behave as a MRM or as a MRC. In case there are
multiple nodes in the topology that has the MRA role then only one node can
behave as MRM and all the others need to be have as MRC. The node that has the
higher priority(lower value) will behave as MRM.
A node that has the MRA role and behaves as MRC, it just needs to forward the
MRP_Test frames between the ring ports but also it needs to detect in case it
stops receiving MRP_Test frames. In that case it would try to behave as MRM.

v2:
 - add new patch that fixes sparse warnings
 - fix parsing of prio attribute

Horatiu Vultur (3):
  bridge: mrp: Update MRP frame type
  bridge: mrp: Set the priority of MRP instance
  bridge: mrp: Add support for role MRA

 include/net/switchdev.h         |   2 +
 include/uapi/linux/if_bridge.h  |   4 +
 include/uapi/linux/mrp_bridge.h |  60 ++++++++++++---
 net/bridge/br_mrp.c             | 128 +++++++++++++++++++++++++++-----
 net/bridge/br_mrp_netlink.c     |  11 +++
 net/bridge/br_mrp_switchdev.c   |   5 +-
 net/bridge/br_private_mrp.h     |   5 +-
 7 files changed, 182 insertions(+), 33 deletions(-)

-- 
2.26.2

