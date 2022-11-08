Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88D9360C33
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAA8960D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI+GU5wtJ259odUNlmPhjajoh1bx0gxT17jrad7ZEvo=;
 b=ooT+IH6PDXGGUxWOrs1eUWRO02WgiswIFekqnhCqGKljZwoO7wu+7i0RPcPAK1VVmtYV8obtCH39ks7Vxyn12AwpjgqgmQvKIg9pp+rD+S3YnmzIeyMH1dvWuU+URR+JNnvs4iU26ufq6bHgZw7/6uQMWin5dqNxz4p8OtxQ3r94xwwPP2/BO/dv/kBq15TSifc1UW2uX/3UwKWxf3X5d5hyhzvCLwriOGWgmVdGKuVKWqHHFpAu/5OZEaK3sgYf55Aw41ZJjegitPYtkVKEyLKL/X2/ZMVB4reTT+G2wfnRVid3TWg+fPl4knvq1oBzNhZQm1RH99cK3XtjZza73Q==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:09 +0100
Message-ID: <2db3f3f1eff65e42c92a8e3a5626d64f46e68edc.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 03/15] bridge: switchdev: Reflect MAB
	bridge port flag to device drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

From: Ido Schimmel <idosch@nvidia.com>

Reflect the 'BR_PORT_MAB' flag to device drivers so that:

* Drivers that support MAB could act upon the flag being toggled.
* Drivers that do not support MAB will prevent MAB from being enabled.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v1:
    * New patch.

 net/bridge/br_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8a0abe35137d..7eb6fd5bb917 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -71,7 +71,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 }
 
 /* Flags that can be offloaded to hardware */
-#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
+#define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_PORT_MAB | \
 				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
 				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
 
-- 
2.35.3

