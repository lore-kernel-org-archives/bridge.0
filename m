Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1599211154; x=1630747154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XG2WKbLHFnej+8AJLKZjXJ9YI92uDGizpyWGrWmiWBY=;
 b=MEBpGx/3Od6rqW5dsIT1ni76eHXw/EqlxBLY9Jfcu8hWDBu8pwrvxkiw
 wM9lLEkyCrS/q25gnrZVH6mQ06Sbo3cQ1TKPaqqDJ/VN93Pko8HH876xW
 mehND6qgstmnnvxOzI0YOwmGwwfvx4ZqQWPTyfyjogebH52QOPyQ5DvHU
 uji9wSYaJsZYQR2dChN7xPRY0VPbtx3FKLMArccC3smbbbHnykL9qC+1g
 dGJP6hC4mYFT7Q5Uac9nUDItHC2DC2M2VSsHyt/gYR7ox8wJ7Ag+gdB4P
 sCR+V3WbGNs8CaKote9VTcDSei9KziFrAdsi+5ck0u3UoL2j458j/Lzz1 w==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Fri, 4 Sep 2020 09:15:23 +0000
Message-ID: <20200904091527.669109-4-henrik.bjoernlund@microchip.com>
In-Reply-To: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH RFC 3/7] bridge: uapi: cfm: Added EtherType used by
	the CFM protocol.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This EtherType is used by all CFM protocal frames transmitted
according to 802.1Q section 12.14.

Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
---
 include/uapi/linux/if_ether.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index d6de2b167448..a0b637911d3c 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -99,6 +99,7 @@
 #define ETH_P_1588	0x88F7		/* IEEE 1588 Timesync */
 #define ETH_P_NCSI	0x88F8		/* NCSI protocol		*/
 #define ETH_P_PRP	0x88FB		/* IEC 62439-3 PRP/HSRv0	*/
+#define ETH_P_CFM	0x8902		/* Connectivity Fault Management */
 #define ETH_P_FCOE	0x8906		/* Fibre Channel over Ethernet  */
 #define ETH_P_IBOE	0x8915		/* Infiniband over Ethernet	*/
 #define ETH_P_TDLS	0x890D          /* TDLS */
-- 
2.28.0

