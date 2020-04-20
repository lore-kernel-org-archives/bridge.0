Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587395536; x=1618931536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=/a06eLKwrmchk7Eu2hL2TIyOwHuzsjEV6uhDIv8BGsk=;
 b=yo+eGNJ0lPBpHgq2pff2JbEIRb33+sd5+UUf9/tENWf+RwQwK/2Zv+9L
 3a2NA/zZq1KHrnBgP43N/YX0Npmeck2sbgRlVLQ6nHKEnWJsSW2KKOF/m
 0G9KBVWfTiqBqNbcIzwtk+DuIHfxYjz36dFyzyRHHMPTHwAot3MV4qjtG
 J57+9A1JCL6xKys6SU0QZtzQFXQqY/tvmWWuQ/+ytsELqW7YwtbKk1UBb
 w+j7/aAFIGYPPUW1+egPrljugdKsCDXS6an2pdyz5d8jEvQ0FfZpRqxZ8
 tgM69MEaJK+JpAHS3wArgryrLLu8uHTzI30O3zn2RnLg8txG6bibGko87 Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 20 Apr 2020 17:09:45 +0200
Message-ID: <20200420150947.30974-12-horatiu.vultur@microchip.com>
In-Reply-To: <20200420150947.30974-1-horatiu.vultur@microchip.com>
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 11/13] bridge: mrp: Update Makefile
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add all new mrp files to be compiled.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 49da7ae6f077..9bf3e1be3328 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -25,3 +25,5 @@ bridge-$(CONFIG_BRIDGE_VLAN_FILTERING) += br_vlan.o br_vlan_tunnel.o br_vlan_opt
 bridge-$(CONFIG_NET_SWITCHDEV) += br_switchdev.o
 
 obj-$(CONFIG_NETFILTER) += netfilter/
+
+bridge-$(CONFIG_BRIDGE_MRP)	+= br_mrp.o br_mrp_netlink.o br_mrp_switchdev.o
-- 
2.17.1

