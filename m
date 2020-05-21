Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590096091; x=1621632091;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3YYTfA2G0R/lyoHmUaWO5sWwSP3/w89inO0e4lZ0ubk=;
 b=0JVUGlvF4xiwPL9v/BXrVCK0AsKKw7qmIbtbxfLtU22PBWxNBxCPsLzy
 ykEi0hoiI10xzNUKQKtIGt8NBR5JUoRPvy9loY3zoc/QPFM4gdA6Uq7n7
 xkgvlSTvsWt5NTKmVZ36Tq2KbR6GZPcGwh8OTkrgzTInX7JE3TtRP6M3a
 YZn7ka30h0uEBbC2oBS+9hPhIURRgwUXtYceSqfNccnwokYAUIXhPZFF/
 Vu2fAzyh4MajQLRjmgl3gQN08zuljjJAa7OljKzQbsUrMJOENNdRKjT7C
 AEXU+Wfok6+3vyT7+Uz92R3Lnl51ufZbdsfmH4jPNxAJKUMldcI5nlQWG Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 21 May 2020 23:19:04 +0000
Message-ID: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH v2 0/3] bridge: mrp: Add br_mrp_unique_ifindex
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series adds small fixes to MRP implementation.
The following are fixed in this patch series:
- now is not allow to add the same port to multiple MRP rings
- remove unused variable
- restore the port state according to the bridge state when the MRP instance
  is deleted

v2:
 - use rtnl_dereference instead of rcu_dereference in the first patch

Horatiu Vultur (3):
  bridge: mrp: Add br_mrp_unique_ifindex function
  switchdev: mrp: Remove the variable mrp_ring_state
  bridge: mrp: Restore port state when deleting MRP instance

 include/net/switchdev.h |  1 -
 net/bridge/br_mrp.c     | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.26.2

