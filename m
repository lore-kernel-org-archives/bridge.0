Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1592903317; x=1624439317;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Hf1oiWAZW47J1FDqvjaGVKeQoXmDU3F9JmfEwLpOK8A=;
 b=mNMCpDFQ/ZlUK35Xj75Q6McXc5Aua3ghekcAFyjU4ujMco7N9BfjX21m
 m57kg8sOQB+wuj69QVrRQt6TmSDA+PXNF7U763w06rlP32ZG7P/ZVTzRz
 zHrD5YhZztOpvb3NhbEJeXJu2BJ3DPmsNCwHHA2GaEx7pZWpHgEEqEIwh
 JvQqSvCCaYdsqpJ1lZUz9jGIx/+gv1qw7MeahAU7d4w1/WkQucZJFh0VI
 AzJwoxrGIxdJsq/x8SoSeeh0Ptc1Gpo9F2V3hHS3TeujlbGzVsse6jwAN
 c3LAndnisSKSM5t6PLkypZITWFuFby5xG16Srr4RciCwLysdK5EiaNGZN w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Jun 2020 11:05:39 +0200
Message-ID: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2 0/2] bridge: mrp: Update MRP_PORT_ROLE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series does the following:
- fixes the enum br_mrp_port_role_type. It removes the port role none(0x2)
  because this is in conflict with the standard. The standard defines the
  interconnect port role as value 0x2.
- adds checks regarding current defined port roles: primary(0x0) and
  secondary(0x1).

v2:
 - add the validation code when setting the port role.

Horatiu Vultur (2):
  bridge: uapi: mrp: Fix MRP_PORT_ROLE
  bridge: mrp: Validate when setting the port role

 include/uapi/linux/mrp_bridge.h |  1 -
 net/bridge/br_mrp.c             | 10 ++++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.26.2

