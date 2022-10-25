Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F64B60BB4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 194BC60BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3OAKlwUUhZ9nGBLi8a1/6yPNGuRKiiP0EOD6ENhYj0=;
 b=BVExyaObPRpcLpRIhNny5+MkLi81N81Ol6yVo4joijtTJRKJe5rKxVETUTcvdCR0H4hvT+qXF5PjoqRTP7QY/hmnHZD1KJK+D/K/GF7Mr3bguJGhH2Pc68psTxD8cE1FpPdSpGHvAEqDCos6jI7f/QApB9IKAKQJR+Z5URJc39bpP1F+G6Zv1RyX5YsyRDGy0qqYE1OWX3m+q6UmYafZFbVRIq2akL18OEPHpP4vvlfkMdlakQ24Ng4KCP9qfkEjdK6ZTKynj1ySvYyO7w0YgFtoKplvtu9s4xVvkQe/8iR/dE6WngUnbhxXq/8lG61NIZJ6JR/bGV7F80D8nEW9nQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:23 +0300
Message-Id: <20221025100024.1287157-16-idosch@nvidia.com>
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 15/16] selftests: mlxsw: Add a test
	for locked port trap
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Test that packets received via a locked bridge port whose {SMAC, VID}
does not appear in the bridge's FDB or appears with a different port,
trigger the "locked_port" packet trap.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/mlxsw/devlink_trap_l2_drops.sh        | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l2_drops.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l2_drops.sh
index a4c2812e9807..8d4b2c6265b3 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l2_drops.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l2_drops.sh
@@ -14,6 +14,7 @@ ALL_TESTS="
 	ingress_stp_filter_test
 	port_list_is_empty_test
 	port_loopback_filter_test
+	locked_port_test
 "
 NUM_NETIFS=4
 source $lib_dir/tc_common.sh
@@ -420,6 +421,110 @@ port_loopback_filter_test()
 	port_loopback_filter_uc_test
 }
 
+locked_port_miss_test()
+{
+	local trap_name="locked_port"
+	local smac=00:11:22:33:44:55
+
+	bridge link set dev $swp1 learning off
+	bridge link set dev $swp1 locked on
+
+	RET=0
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased before setting action to \"trap\""
+
+	devlink_trap_action_set $trap_name "trap"
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_err $? "Trap stats did not increase when should"
+
+	devlink_trap_action_set $trap_name "drop"
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after setting action to \"drop\""
+
+	devlink_trap_action_set $trap_name "trap"
+
+	bridge fdb replace $smac dev $swp1 master static vlan 1
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after adding an FDB entry"
+
+	bridge fdb del $smac dev $swp1 master static vlan 1
+	bridge link set dev $swp1 locked off
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after unlocking port"
+
+	log_test "Locked port - FDB miss"
+
+	devlink_trap_action_set $trap_name "drop"
+	bridge link set dev $swp1 learning on
+}
+
+locked_port_mismatch_test()
+{
+	local trap_name="locked_port"
+	local smac=00:11:22:33:44:55
+
+	bridge link set dev $swp1 learning off
+	bridge link set dev $swp1 locked on
+
+	RET=0
+
+	bridge fdb replace $smac dev $swp2 master static vlan 1
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased before setting action to \"trap\""
+
+	devlink_trap_action_set $trap_name "trap"
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_err $? "Trap stats did not increase when should"
+
+	devlink_trap_action_set $trap_name "drop"
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after setting action to \"drop\""
+
+	devlink_trap_action_set $trap_name "trap"
+	bridge link set dev $swp1 locked off
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after unlocking port"
+
+	bridge link set dev $swp1 locked on
+	bridge fdb replace $smac dev $swp1 master static vlan 1
+
+	devlink_trap_stats_check $trap_name $MZ $h1 -c 1 \
+		-a $smac -b $(mac_get $h2) -A 192.0.2.1 -B 192.0.2.2 -p 100 -q
+	check_fail $? "Trap stats increased after replacing an FDB entry"
+
+	bridge fdb del $smac dev $swp1 master static vlan 1
+	devlink_trap_action_set $trap_name "drop"
+
+	log_test "Locked port - FDB mismatch"
+
+	bridge link set dev $swp1 locked off
+	bridge link set dev $swp1 learning on
+}
+
+locked_port_test()
+{
+	locked_port_miss_test
+	locked_port_mismatch_test
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.37.3

