Return-Path: <jnixdorf-oss@avm.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E77A360608
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01F4960F1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1695125795; bh=1Pn1Mj5B9BK9G6xRh+VXmW7e+DczI+9uJJqpPrAiqOA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=M+XuX7K00vctJxIPrf1FQDGQdyJWQVco7pMmtmaGPUVYmHGhE2ANt7WGaXd1GFpWI
 sTuq6gICoVsbC4Q1xW15L4TecDWhmBTrqo56zFQHNWLIGAusW5Lvx7Xe2dquMLQU1k
 QG2qtj2NusTAgxYBfh4hUrKWNWuK0t1WuoYiAR5s=
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
Date: Tue, 19 Sep 2023 10:12:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
In-Reply-To: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695111167; l=7286;
 i=jnixdorf-oss@avm.de; s=20230906; h=from:subject:message-id;
 bh=1Pn1Mj5B9BK9G6xRh+VXmW7e+DczI+9uJJqpPrAiqOA=;
 b=ZSgDZskCJzluT9nSnnXD2U5tXzeWhEqArbAtQ1bb9jVX8f9JbxWL9ssQ0ZSe5OroeeKh3G4Ck
 1MHUzy2/ZwZDCMw5QOzDHvmilgHtKhAmtFrHV4eBea87U1un1lvT6Dr
X-Developer-Key: i=jnixdorf-oss@avm.de; a=ed25519;
 pk=KMraV4q7ANHRrwjf9EVhvU346JsqGGNSbPKeNILOQfo=
Subject: [Bridge] [PATCH net-next v4 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Johannes Nixdorf <jnixdorf-oss@avm.de>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Add a suite covering the fdb_n_learned and fdb_max_learned bridge
features, touching all special cases in accounting at least once.

Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
---
 tools/testing/selftests/net/forwarding/Makefile    |   3 +-
 .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
 2 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 74e754e266c3..df593b7b3e6b 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = bridge_igmp.sh \
+TEST_PROGS = bridge_fdb_learning_limit.sh \
+	bridge_igmp.sh \
 	bridge_locked_port.sh \
 	bridge_mdb.sh \
 	bridge_mdb_host.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
new file mode 100755
index 000000000000..0760a34b7114
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
@@ -0,0 +1,283 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# ShellCheck incorrectly believes that most of the code here is unreachable
+# because it's invoked by variable name following ALL_TESTS.
+#
+# shellcheck disable=SC2317
+
+ALL_TESTS="check_accounting check_limit"
+NUM_NETIFS=6
+source lib.sh
+
+TEST_MAC_BASE=de:ad:be:ef:42:
+
+NUM_PKTS=16
+FDB_LIMIT=8
+
+FDB_TYPES=(
+	# name		is counted?	overrides learned?
+	'learned	1		0'
+	'static		0		1'
+	'user		0		1'
+	'extern_learn	0		1'
+	'local		0		1'
+)
+
+mac()
+{
+	printf "${TEST_MAC_BASE}%02x" "$1"
+}
+
+H1_DEFAULT_MAC=$(mac 42)
+
+switch_create()
+{
+	ip link add dev br0 type bridge
+
+	ip link set dev "$swp1" master br0
+	ip link set dev "$swp2" master br0
+	# swp3 is used to add local MACs, so do not add it to the bridge yet.
+
+	# swp2 is only used for replying when learning on swp1, its MAC should not be learned.
+	ip link set dev "$swp2" type bridge_slave learning off
+
+	ip link set dev br0 up
+
+	ip link set dev "$swp1" up
+	ip link set dev "$swp2" up
+	ip link set dev "$swp3" up
+}
+
+switch_destroy()
+{
+	ip link set dev "$swp3" down
+	ip link set dev "$swp2" down
+	ip link set dev "$swp1" down
+
+	ip link del dev br0
+}
+
+h_create()
+{
+	ip link set "$h1" addr "$H1_DEFAULT_MAC"
+
+	simple_if_init "$h1" 192.0.2.1/24
+	simple_if_init "$h2" 192.0.2.2/24
+}
+
+h_destroy()
+{
+	simple_if_fini "$h1" 192.0.2.1/24
+	simple_if_fini "$h2" 192.0.2.2/24
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	h2=${NETIFS[p3]}
+	swp2=${NETIFS[p4]}
+
+	swp3=${NETIFS[p6]}
+
+	vrf_prepare
+
+	h_create
+
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+
+	h_destroy
+
+	vrf_cleanup
+}
+
+fdb_get_n_learned()
+{
+	ip -d -j link show dev br0 type bridge | \
+		jq '.[]["linkinfo"]["info_data"]["fdb_n_learned"]'
+}
+
+fdb_get_n_mac()
+{
+	local mac=${1}
+
+	bridge -j fdb show br br0 | \
+		jq "map(select(.mac == \"${mac}\" and (has(\"vlan\") | not))) | length"
+}
+
+fdb_fill_learned()
+{
+	local i
+
+	for i in $(seq 1 "$NUM_PKTS"); do
+		fdb_add learned "$(mac "$i")"
+	done
+}
+
+fdb_reset()
+{
+	bridge fdb flush dev br0
+
+	# Keep the default MAC address of h1 in the table. We set it to a different one when
+	# testing dynamic learning.
+	bridge fdb add "$H1_DEFAULT_MAC" dev "$swp1" master static use
+}
+
+fdb_add()
+{
+	local type=$1 mac=$2
+
+	case "$type" in
+		learned)
+			ip link set "$h1" addr "$mac"
+			# Wait for a reply so we implicitly wait until after the forwarding
+			# code finished and the FDB entry was created.
+			PING_COUNT=1 ping_do "$h1" 192.0.2.2
+			check_err $? "Failed to ping another bridge port"
+			ip link set "$h1" addr "$H1_DEFAULT_MAC"
+			;;
+		local)
+			ip link set dev "$swp3" addr "$mac" && ip link set "$swp3" master br0
+			;;
+		static)
+			bridge fdb replace "$mac" dev "$swp1" master static
+			;;
+		user)
+			bridge fdb replace "$mac" dev "$swp1" master static use
+			;;
+		extern_learn)
+			bridge fdb replace "$mac" dev "$swp1" master extern_learn
+			;;
+	esac
+
+	check_err $? "Failed to add a FDB entry of type ${type}"
+}
+
+fdb_del()
+{
+	local type=$1 mac=$2
+
+	case "$type" in
+		local)
+			ip link set "$swp3" nomaster
+			;;
+		*)
+			bridge fdb del "$mac" dev "$swp1" master
+			;;
+	esac
+
+	check_err $? "Failed to remove a FDB entry of type ${type}"
+}
+
+check_accounting_one_type()
+{
+	local type=$1 is_counted=$2 overrides_learned=$3
+	shift 3
+	RET=0
+
+	fdb_reset
+	fdb_add "$type" "$(mac 0)"
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$is_counted" ]
+	check_fail $? "Inserted FDB type ${type}: Expected the count ${is_counted}, but got ${learned}"
+
+	fdb_del "$type" "$(mac 0)"
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne 0 ]
+	check_fail $? "Removed FDB type ${type}: Expected the count 0, but got ${learned}"
+
+	if [ "$overrides_learned" -eq 1 ]; then
+		fdb_reset
+		fdb_add learned "$(mac 0)"
+		fdb_add "$type" "$(mac 0)"
+		learned=$(fdb_get_n_learned)
+		[ "$learned" -ne "$is_counted" ]
+		check_fail $? "Set a learned entry to FDB type ${type}: Expected the count ${is_counted}, but got ${learned}"
+		fdb_del "$type" "$(mac 0)"
+	fi
+
+	log_test "FDB accounting interacting with FDB type ${type}"
+}
+
+check_accounting()
+{
+	local type_args learned
+	RET=0
+
+	fdb_reset
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne 0 ]
+	check_fail $? "Flushed the FDB table: Expected the count 0, but got ${learned}"
+
+	fdb_fill_learned
+	sleep 1
+
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$NUM_PKTS" ]
+	check_fail $? "Filled the FDB table: Expected the count ${NUM_PKTS}, but got ${learned}"
+
+	log_test "FDB accounting"
+
+	for type_args in "${FDB_TYPES[@]}"; do
+		# This is intentional use of word splitting.
+		# shellcheck disable=SC2086
+		check_accounting_one_type $type_args
+	done
+}
+
+check_limit_one_type()
+{
+	local type=$1 is_counted=$2
+	local n_mac expected=$((1 - is_counted))
+	RET=0
+
+	fdb_reset
+	fdb_fill_learned
+
+	fdb_add "$type" "$(mac 0)"
+	n_mac=$(fdb_get_n_mac "$(mac 0)")
+	[ "$n_mac" -ne "$expected" ]
+	check_fail $? "Inserted FDB type ${type} at limit: Expected the count ${expected}, but got ${n_mac}"
+
+	log_test "FDB limits interacting with FDB type ${type}"
+}
+
+check_limit()
+{
+	local learned
+	RET=0
+
+	ip link set br0 type bridge fdb_max_learned "$FDB_LIMIT"
+
+	fdb_reset
+	fdb_fill_learned
+
+	learned=$(fdb_get_n_learned)
+	[ "$learned" -ne "$FDB_LIMIT" ]
+	check_fail $? "Filled the limited FDB table: Expected the count ${FDB_LIMIT}, but got ${learned}"
+
+	log_test "FDB limits"
+
+	for type_args in "${FDB_TYPES[@]}"; do
+		# This is intentional use of word splitting.
+		# shellcheck disable=SC2086
+		check_limit_one_type $type_args
+	done
+}
+
+trap cleanup EXIT
+
+setup_prepare
+
+tests_run
+
+exit $EXIT_STATUS

-- 
2.42.0

