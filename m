Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1589973083; x=1621509083;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x3JarY+Ofxg1Q/ChDZn1X4VP9ONVcoEd86Sl35tMr3w=;
 b=b9wi4IiV/um4xSnVBpT4NOXnLkDXJtRLSx4J0C6d6NfCHvgKpf9pErx3
 JAyOOXx4etoD4OS8/c6ldhzaoku2q6DOU+9RtFiRFkYkA3tvW8L15jYKY
 dMHxSmElkTPzcafJP9H4O4QvrSDAfF7P0IMr8nkfPQHXXvDiCS6Lbc44m
 EBUkxxmFGB9hSNt8bMiBs1SCGLMcVYS5uAqFBcbNK5BeUUdm69NA0m4+6
 8IN1xq84K3x225+aHBAwldC0FkC7wixLJpxBdxWtMO1i3yX0OZtjP6LVv
 1uRntY4+TNmE2csmEwYfGp1QXpNQ5b1Gbo9Db6IiSnyK6IKcu7khSRCbT Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 20 May 2020 13:09:22 +0000
Message-ID: <20200520130923.3196432-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 2/3] switchdev: mrp: Remove the variable
	mrp_ring_state
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

Remove the variable mrp_ring_state from switchdev_attr because is not
used anywhere.
The ring state is set using SWITCHDEV_OBJ_ID_RING_STATE_MRP.

Fixes: c284b5459008 ("switchdev: mrp: Extend switchdev API to offload MRP")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ae7aeb0d1f9ca..db519957e134b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -62,7 +62,6 @@ struct switchdev_attr {
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 		u8 mrp_port_state;			/* MRP_PORT_STATE */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
-		u8 mrp_ring_state;			/* MRP_RING_STATE */
 #endif
 	} u;
 };
-- 
2.26.2

