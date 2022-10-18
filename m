Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A58AE41891
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4886741896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBOcdlumT6sm5Rw4LA4smgT1aeEbq3l0gRJKs1XJP0M=;
 b=Uz+7nr8L82veL1U7Rxc1W1hvm5QMQQG8y9UuYwGatdoLWklc0xlUeflkuIigqwB1/CI+ojzZ/4MPrD5W1mXMaGaNNikGBREa5/Zwe8C9/Flv6aEJOxFDV/9kV8JAPkFbXxzYuRg3gi2jagIUjBhJWWPp0ksyMmJDDPeXRbZMNtsb4W/yF1A2Coq+xFnmQ4CHWo7L0wFOw1T9CzA4lsyfpRjHSbRCAD6/sfLkq/JlmAZWRsPm0icGb85zfh/Q4G0eV2sBCPGuGLsuKwejcj4ggUVyDZkaUVadOrXzWxz7Cg/nnVUShK1u+NlT8xKUeHRFFKAog2dIB2keyv1CCKgpUw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 09:39:58 +0300
Message-Id: <20221018064001.518841-2-idosch@nvidia.com>
In-Reply-To: <20221018064001.518841-1-idosch@nvidia.com>
References: <20221018064001.518841-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 1/4] selftests: bridge_vlan_mcast: Delete
	qdiscs during cleanup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The qdiscs are added during setup, but not deleted during cleanup,
resulting in the following error messages:

 # ./bridge_vlan_mcast.sh
 [...]
 # ./bridge_vlan_mcast.sh
 Error: Exclusivity flag on, cannot modify.
 Error: Exclusivity flag on, cannot modify.

Solve by deleting the qdiscs during cleanup.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 8748d1b1d95b..72dfbeaf56b9 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -59,6 +59,9 @@ switch_create()
 
 switch_destroy()
 {
+	tc qdisc del dev $swp2 clsact
+	tc qdisc del dev $swp1 clsact
+
 	ip link set dev $swp2 down
 	ip link set dev $swp1 down
 
-- 
2.37.3

