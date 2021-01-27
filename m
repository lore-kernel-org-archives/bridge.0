Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611780843; x=1643316843;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JtMgqDe1zRCwojD2fE9vIKSHA/7JaMFfOoLeN1LILIs=;
 b=ivfutiW4v0enPf7mF7niQ2q9bzdKkTPoV/IGwlwbbLqcD66CXmnTlXnu
 QlMKBy87o2pDGncoMFL185cXwz2eJqGuPyrtCfPwdjA4OwA3fdJUFZdQW
 6iT8pMpckW+fPMp8hfDE0cMU+3GZ0IbUCPDSJgaP4bSiUKj1vihjMPgQj
 brpi5ywpJmCXFggvp+AFmxauPR59W3mvHwnM26bvBudZ43lYgb75gqXGE
 juIzPvawrMQLKIBNkd7Fs6+2cngekM4Ob0c+dha6IVSemJhu9F7AXmKqn
 dEhUvFdVTk2HOoOh57Ep0QPdiBX4FZCBOk1547dzlvpK/W7QzjMLij8A0 w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 27 Jan 2021 21:52:38 +0100
Message-ID: <20210127205241.2864728-2-horatiu.vultur@microchip.com>
In-Reply-To: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
References: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 1/4] switchdev: mrp: Extend
	ring_role_mrp and in_role_mrp
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

Add the member sw_backup to the structures switchdev_obj_ring_role_mrp
and switchdev_obj_in_role_mrp. In this way the SW can call the driver in
2 ways, once when sw_backup is set to false, meaning that the driver
should implement this completely in HW. And if that is not supported the
SW will call again but with sw_backup set to true, meaning that the
HW should help or allow the SW to run the protocol.

For example when role is MRM, if the HW can't detect when it stops
receiving MRP Test frames but it can trap these frames to CPU, then it
needs to return -EOPNOTSUPP when sw_backup is false and return 0 when
sw_backup is true.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 88fcac140966..3f236eaa4f3e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -132,6 +132,7 @@ struct switchdev_obj_ring_role_mrp {
 	struct switchdev_obj obj;
 	u8 ring_role;
 	u32 ring_id;
+	u8 sw_backup;
 };
 
 #define SWITCHDEV_OBJ_RING_ROLE_MRP(OBJ) \
@@ -166,6 +167,7 @@ struct switchdev_obj_in_role_mrp {
 	u32 ring_id;
 	u16 in_id;
 	u8 in_role;
+	u8 sw_backup;
 };
 
 #define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
-- 
2.27.0

