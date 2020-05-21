Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590096097; x=1621632097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TdAMOjHLIL52IjrktH/4zpMrbAD/w3CJWe4Kq01sDTk=;
 b=lbJnvqknMKmtu/4sH7/8zDBHnjUS2UpKqmLScL6oofU4KlO2OGkGCFph
 IFzghoQ1qsyUrhXOR6zEY6btO4eDEHkxWCb0Bi3lEDeA7xUINj+G54/By
 2QHmJO8/OL153a5jhOWDbo3BMqb+9/2Kz3IB1UXyRX3CBjcxiNGuarHjI
 0pyGKnS0sh+6PAh05Cmsn9MGGYbXxIE9oxtWwXXzTkg1VNwI7GnrRU8T2
 AIiaOQv2otRVmF8OJJj7BwqR4URy2sb1pPdhI+QYRU5XU2lT0Yz+fbWUf
 FknHgYYKjkONh8nXVj0cPDL1xYeOpgM3lpwGVi1+ka19oPhlNPMKeI7h+ Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 21 May 2020 23:19:06 +0000
Message-ID: <20200521231907.3564679-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
References: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH v2 2/3] switchdev: mrp: Remove the variable
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
Acked-by: Ivan Vecera <ivecera@redhat.com>
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

