Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611418790; x=1642954790;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DN5eZjnAtCOTKv9CtTf6bYhkgWAbYsnIlHVD1aItLxU=;
 b=Ez95UUFbEtTqez/LwjygPamH1i80WEZuX1O0JOPMNwHH5ZRvuK4Bi6Au
 m54G0fCaaIfMfZ4ZMsgtVnE+yjGOLvDUxJU8iwXjKwizGdwMniOqcd7YC
 5pEcnpndbKuPNonYtBzB3aKZ7C9UGG/boB1W5cOa0zGqOIyH0XMCpIMIW
 ODeENWqVB6LABRGZv8yC/Hw81L0M9iu7CVqcy6sGW9ygdubmBWhmZuhUe
 e9GemXHraqQta8jvkdvHzR8BYrrS3RKBsOgOhWgyAnb7QQolVF0O1PZ4W
 gezL8TZgw+tnnePINWLdWxoteenqQJS90T7ozcl0z35b/EZ/BSJnJza/C Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 23 Jan 2021 17:18:08 +0100
Message-ID: <20210123161812.1043345-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/4] bridge: mrp: Extend br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends MRP switchdev to allow the SW to have a better
understanding if the HW can implment the MRP functionality or it needs to
help the HW to run it. There are 3 cases:
- when HW can't implement at all the functionality.
- when HW can implement a part of the functionality but needs the SW
  implement the rest. For example if it can't detect when it stops
  receiving MRP Test frames but it can copy the MRP frames to CPU to
  allow the SW to determin this.  Another example is generating the MRP
  Test frames. If HW can't do that then the SW is used as backup.
- when HW can implement completely the functionality.

So, initially the SW tries to offload the entire functionality in HW, if
that fails it tries offload parts of the functionality in HW and use the
SW as helper and if also this fails then MRP can't run on this HW.

Horatiu Vultur (4):
  switchdev: mrp: Extend ring_role_mrp and in_role_mrp
  bridge: mrp: Add 'enum br_mrp_hw_support'
  bridge: mrp: Extend br_mrp_switchdev to detect better the errors
  bridge: mrp: Update br_mrp to use new return values of
    br_mrp_switchdev

 include/net/switchdev.h       |   2 +
 net/bridge/br_mrp.c           |  43 +++++---
 net/bridge/br_mrp_switchdev.c | 189 +++++++++++++++++++++++++---------
 net/bridge/br_private_mrp.h   |  38 +++++--
 4 files changed, 195 insertions(+), 77 deletions(-)

-- 
2.27.0

