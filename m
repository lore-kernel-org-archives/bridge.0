Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13E8F408E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50C07408D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Hrp23UtQD1B7K2NarNKAQiXcs8o/7u/87dkXWarc4=;
 b=DFwVXOCfX+qICrhu+b2L2zPXnfpfgMF+0kuuCPiPoJkWXCOeYJXrgIIgM2zgzGpijDnwosCgcChfax6sSCXp5t9X7ikuJ2xBBuxt6vQUTjcYttZEJ1L+QsfFUkYKbGaWC4nYVuTkZjy3QrNSbR2QUIOV8KwGt9eJ2orcEGZdKPVM1G/lpMsQATltargPOhx4LbGGcu9AoD3MR734hwPsAjAsadfC+3+U209XvwslGAbJxX1M7y26hvQiCvLv95daJIdCKlqhjpQWMWdX/j3KhZPDkVhG5Bfl2L+w7gscBMBwqjj9ruKxwBd6uwWRjL51Zb7VQFiPoVqF0UQjTcr8HA==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:21 +0100
Message-ID: <9fb8b83ce2029c51c81c942f24ece789ae8fe1c1.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 15/15] selftests: mlxsw: Add a test for
	invalid locked bridge port configurations
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

Test that locked bridge port configurations that are not supported by
mlxsw are rejected.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
index 04f03ae9d8fb..5e89657857c7 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
@@ -34,6 +34,7 @@ ALL_TESTS="
 	nexthop_obj_bucket_offload_test
 	nexthop_obj_blackhole_offload_test
 	nexthop_obj_route_offload_test
+	bridge_locked_port_test
 	devlink_reload_test
 "
 NUM_NETIFS=2
@@ -917,6 +918,36 @@ nexthop_obj_route_offload_test()
 	simple_if_fini $swp1 192.0.2.1/24 2001:db8:1::1/64
 }
 
+bridge_locked_port_test()
+{
+	RET=0
+
+	ip link add name br1 up type bridge vlan_filtering 0
+
+	ip link add link $swp1 name $swp1.10 type vlan id 10
+	ip link set dev $swp1.10 master br1
+
+	bridge link set dev $swp1.10 locked on
+	check_fail $? "managed to set locked flag on a VLAN upper"
+
+	ip link set dev $swp1.10 nomaster
+	ip link set dev $swp1 master br1
+
+	bridge link set dev $swp1 locked on
+	check_fail $? "managed to set locked flag on a bridge port that has a VLAN upper"
+
+	ip link del dev $swp1.10
+	bridge link set dev $swp1 locked on
+
+	ip link add link $swp1 name $swp1.10 type vlan id 10
+	check_fail $? "managed to configure a VLAN upper on a locked port"
+
+	log_test "bridge locked port"
+
+	ip link del dev $swp1.10 &> /dev/null
+	ip link del dev br1
+}
+
 devlink_reload_test()
 {
 	# Test that after executing all the above configuration tests, a
-- 
2.35.3

