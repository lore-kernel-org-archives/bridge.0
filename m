Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38C8141496
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0467540919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYNLi97idUCs/uBfghoaHt9pd6pv5pnH77gQt8cqEQ=;
 b=nU2jmSs4XTqhEuxtBjFXDb02Y8iDuaQ95ItnC5+AbHo3PqJYqaW8wnFD8qEJYT9Q4aE9KDym9IByC6Mwcrb6hCz2GkTRzY3Cjc8jSEgwI9Nq8//KDFThElg9mr0vbkEpE9kXoLrAEIniD4TwdqvV8oQoYh7V3jpNasLXr+7x15H8ZH8XzbQg5jLZJ4OJaFwBvo5t14ey5/nn5xh7hwRpH2QRltGzddoC+cYRjM4+wzo8kP0UlRFyFNl+MBFExDKOA6ltCcdP9rrL3RfICQTSBk2xLWohQ5hJNWZHXfA5Lad6qObJQ9bFJ3DhrH4bT6W2zLEOzclHHsOJtjFuzJHcIg==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:20 +0100
Message-ID: <61b030c0932726657eff1ac545d1904a2ee930ea.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 14/15] selftests: mlxsw: Add a test for
	locked port trap
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

Test that packets received via a locked bridge port whose {SMAC, VID}
does not appear in the bridge's FDB or appears with a different port,
trigger the "locked_port" packet trap.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
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
2.35.3

