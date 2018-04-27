Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=JIdSg5FshTKL4hCkJ7VZvkukx+53138vxgtmYMHpEt8=;
	b=qMsGi9zRVS6O/MfBR7khbyuDNmxitVgl3GCV2b0oSBv9ws8RS98Hsd3CXPv/EWq5opWghtHombEIZPOVJQh1IhFZDEoVWCmlMPkuD9tfrLlIFfb+uJW5Wxqdk3ex2NyA5eQ9lvf93N5CU5CB67FkdqQhKMQbzrGLTT7bqtRKh74=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 27 Apr 2018 18:11:08 +0300
Message-Id: <20180427151111.22099-4-idosch@mellanox.com>
In-Reply-To: <20180427151111.22099-1-idosch@mellanox.com>
References: <20180427151111.22099-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 3/6] mlxsw: spectrum_switchdev: Publish
	two functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Publish the existing function mlxsw_sp_bridge_port_find(), and add
another service accessor mlxsw_sp_bridge_port_stp_state(). Publish both
in a new file spectrum_switchdev.h.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  9 ++++-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.h   | 43 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c11c9a635866..db4aea0f8996 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -50,6 +50,7 @@
 #include <net/switchdev.h>
 
 #include "spectrum_router.h"
+#include "spectrum_switchdev.h"
 #include "spectrum.h"
 #include "core.h"
 #include "reg.h"
@@ -239,7 +240,7 @@ __mlxsw_sp_bridge_port_find(const struct mlxsw_sp_bridge_device *bridge_device,
 	return NULL;
 }
 
-static struct mlxsw_sp_bridge_port *
+struct mlxsw_sp_bridge_port *
 mlxsw_sp_bridge_port_find(struct mlxsw_sp_bridge *bridge,
 			  struct net_device *brport_dev)
 {
@@ -2297,6 +2298,12 @@ static struct notifier_block mlxsw_sp_switchdev_notifier = {
 	.notifier_call = mlxsw_sp_switchdev_event,
 };
 
+u8
+mlxsw_sp_bridge_port_stp_state(struct mlxsw_sp_bridge_port *bridge_port)
+{
+	return bridge_port->stp_state;
+}
+
 static int mlxsw_sp_fdb_init(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_bridge *bridge = mlxsw_sp->bridge;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h
new file mode 100644
index 000000000000..bc44d5effc28
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h
+ * Copyright (c) 2018 Mellanox Technologies. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the names of the copyright holders nor the names of its
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/netdevice.h>
+
+struct mlxsw_sp_bridge;
+struct mlxsw_sp_bridge_port;
+
+struct mlxsw_sp_bridge_port *
+mlxsw_sp_bridge_port_find(struct mlxsw_sp_bridge *bridge,
+			  struct net_device *brport_dev);
+
+u8 mlxsw_sp_bridge_port_stp_state(struct mlxsw_sp_bridge_port *bridge_port);
-- 
2.14.3

