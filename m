Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611418792; x=1642954792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JtMgqDe1zRCwojD2fE9vIKSHA/7JaMFfOoLeN1LILIs=;
 b=H1cEXKOubbcwnsZFXOcim61zXP6M1rFSdAaCaMBxwuGLx74CzWC6kV63
 7pTlRiRCwUVwciA8Yzd4j3C05ooDLAF+qkXAgtv4rMKmZpbOz0cwa8Xyw
 JV4BM+iMNTmTpxTlbMre2PyIS7JnaA682zYp3QOakHrqZpLW2ymJZrFJS
 GP6C2NYhO3pKJiBLFbAARkJDgqv+sYjfCHl7k8AtTv+kIDsaFoJWvhj38
 lpEMGoQqUT9z7JtgcfkJll43ara9Ld5Ub0EqDpZLhqj34kCsxeeRH4Te7
 UxvRCEQWL10P523Wrdkw9FAbCxnqz+JSrDmSxMMlSmAL5b59RABJWCjh0 Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 23 Jan 2021 17:18:09 +0100
Message-ID: <20210123161812.1043345-2-horatiu.vultur@microchip.com>
In-Reply-To: <20210123161812.1043345-1-horatiu.vultur@microchip.com>
References: <20210123161812.1043345-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/4] switchdev: mrp: Extend ring_role_mrp
	and in_role_mrp
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

