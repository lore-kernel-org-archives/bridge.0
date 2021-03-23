Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1616488536; x=1648024536;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n0QbJ/Z7gyQ6Y1lX/uRkOsxsUGuPQPG7ECU7h9LJUZw=;
 b=05T+FMb+usenhA7BcYtaB/xBE2Acsw2hMB6nvRl38fDmQAEKYUEqk4+5
 XLLAjMalafEMVehAdovrLNEDKQaReURR1Yg+QunD/9t5ldRnhdIjXs6hf
 gHV/aOT3btRM2Z9H9oxY1Pc7rw1QJJCtKbH+fSRC+r3gvs88F1QaA6ZWv
 dUCbkHv7xTpOqOUM1EU+Zxbb4Aa4nm7BwSSIPd809UBvnkHosiubky+aN
 xOoj5NY3PjScGHAd2D4k7kUcIEIIL3uzrLbctvye+1aeOdvQY9SWDxcvv
 6Va6inxkUyYA68++e74f4AKhNtTkfUTSeDAoQkbHZa3vERzXqaBeamW46 g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Mar 2021 09:33:45 +0100
Message-ID: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/2] bridge: mrp: Disable roles before
	deleting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Horatiu Vultur <horatiu.vultur@microchip.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com

The first patch in this series make sures that the driver is notified
that the role is disabled before the MRP instance is deleted. The
second patch uses this so it can simplify the driver.

Horatiu Vultur (2):
  bridge: mrp: Disable roles before deleting the MRP instance
  net: ocelot: Simplify MRP deletion

 drivers/net/ethernet/mscc/ocelot_mrp.c | 16 ----------------
 net/bridge/br_mrp.c                    |  7 +++++++
 2 files changed, 7 insertions(+), 16 deletions(-)

-- 
2.30.1

