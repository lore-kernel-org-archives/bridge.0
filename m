Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=m14KfFMNBJMj3DAuyjsFtzaOxg7nS8IZJkNu+xhWBoQ=;
 b=CF/kSL/5S4j/4pPmpoLhhNdCrfZHMeBh9sE/2PJE0HqUOCEgafv5S1xncVTcNldYka
 bujyLGn0wSb5IBpMJm+DjbZcofg5/n1pMDuRJcjcyGtYVModUHJBdPWkNUMBzWxB+6Y6
 7XTL1f9ut0IvB8D8LnbeO3VpuapMphxnK6rwcZ8l5muQmDpnS0A6jMN9b1twOzMAjnnV
 CEM6/CdcQV2cA1N2paU8GuKa33A+GOVIFImxq5tUYQEVYgkVcsPZnmaiRKU5QsPIo5mY
 mxmshyVaRmPnCK/qBqOPDhh7da9zMkNNLfLGBgyeVVVlKpHWokexKZ+VU2d8v27C0lO8
 Ob7Q==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:31 +0200
Message-Id: <20220411133837.318876-8-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 07/13] selftests: forwarding: new test,
	verify bridge flood flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Test per-port flood control flags of unknown BUM traffic by injecting
bc/uc/mc on one bridge port and verifying it being forwarded to both
the bridge itself and another regular bridge port.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../testing/selftests/net/forwarding/Makefile |   3 +-
 .../selftests/net/forwarding/bridge_flood.sh  | 170 ++++++++++++++++++
 2 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_flood.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index ae80c2aef577..873fa61d1ee1 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_PROGS = bridge_igmp.sh \
+TEST_PROGS = bridge_flood.sh \
+	bridge_igmp.sh \
 	bridge_locked_port.sh \
 	bridge_mdb.sh \
 	bridge_port_isolation.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_flood.sh b/tools/testing/selftests/net/forwarding/bridge_flood.sh
new file mode 100755
index 000000000000..1966c960d705
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_flood.sh
@@ -0,0 +1,170 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify per-port flood control flags of unknown BUM traffic.
+#
+#                     br0
+#                    /   \
+#                  h1     h2
+#
+# We inject bc/uc/mc on h1, toggle the three flood flags for
+# both br0 and h2, then verify that traffic is flooded as per
+# the flags, and nowhere else.
+#
+#set -x
+
+ALL_TESTS="br_flood_unknown_bc_test br_flood_unknown_uc_test br_flood_unknown_mc_test"
+NUM_NETIFS=4
+
+SRC_MAC="00:de:ad:be:ef:00"
+GRP_IP4="225.1.2.3"
+GRP_MAC="01:00:01:c0:ff:ee"
+GRP_IP6="ff02::42"
+
+BC_PKT="ff:ff:ff:ff:ff:ff $SRC_MAC 00:04 48:45:4c:4f"
+UC_PKT="02:00:01:c0:ff:ee $SRC_MAC 00:04 48:45:4c:4f"
+MC_PKT="01:00:5e:01:02:03 $SRC_MAC 08:00 45:00 00:20 c2:10 00:00 ff 11 12:b2 01:02:03:04 e1:01:02:03 04:d2 10:e1 00:0c 6e:84 48:45:4c:4f"
+
+# Disable promisc to ensure we only receive flooded frames
+export TCPDUMP_EXTRA_FLAGS="-pl"
+
+source lib.sh
+
+h1=${NETIFS[p1]}
+h2=${NETIFS[p3]}
+swp1=${NETIFS[p2]}
+swp2=${NETIFS[p4]}
+
+#
+# Port mappings and flood flag pattern to set/detect
+#
+declare -A ports=([br0]=br0 [$swp1]=$h1 [$swp2]=$h2)
+declare -A flag1=([$swp1]=off [$swp2]=off [br0]=off)
+declare -A flag2=([$swp1]=off [$swp2]=on  [br0]=off)
+declare -A flag3=([$swp1]=off [$swp2]=on  [br0]=on )
+declare -A flag4=([$swp1]=off [$swp2]=off [br0]=on )
+
+switch_create()
+{
+	ip link add dev br0 type bridge
+
+	for port in ${!ports[@]}; do
+		[ "$port" != "br0" ] && ip link set dev $port master br0
+		ip link set dev $port up
+	done
+}
+
+switch_destroy()
+{
+	for port in ${!ports[@]}; do
+		ip link set dev $port down
+	done
+	ip link del dev br0
+}
+
+setup_prepare()
+{
+	vrf_prepare
+
+	let i=1
+	for iface in ${ports[@]}; do
+		[ "$iface" = "br0" ] && continue
+		simple_if_init $iface 192.0.2.$i/24 2001:db8:1::$i/64
+		let i=$((i + 1))
+	done
+
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+	switch_destroy
+
+	let i=1
+	for iface in ${ports[@]}; do
+		[ "$iface" = "br0" ] && continue
+		simple_if_fini $iface 192.0.2.$i/24 2001:db8:1::$i/64
+		let i=$((i + 1))
+	done
+
+	vrf_cleanup
+}
+
+do_flood_unknown()
+{
+	local type=$1
+	local pass=$2
+	local flag=$3
+	local pkt=$4
+	local -n flags=$5
+
+	RET=0
+	for port in ${!ports[@]}; do
+		if [ "$port" = "br0" ]; then
+			self="self"
+		else
+			self=""
+		fi
+		bridge link set dev $port $flag ${flags[$port]} $self
+		check_err $? "Failed setting $port $flag ${flags[$port]}"
+	done
+
+	for iface in ${ports[@]}; do
+		tcpdump_start $iface
+	done
+
+	$MZ -q $h1 "$pkt"
+	sleep 1
+
+	for iface in ${ports[@]}; do
+		tcpdump_stop $iface
+	done
+
+	for port in ${!ports[@]}; do
+		iface=${ports[$port]}
+
+#		echo "Dumping PCAP from $iface, expecting ${flags[$port]}:"
+#		tcpdump_show $iface
+		tcpdump_show $iface |grep -q "$SRC_MAC"
+		rc=$?
+
+		check_err_fail "${flags[$port]} = on"  $? "failed flooding from $h1 to port $port"
+		check_err_fail "${flags[$port]} = off" $? "flooding from $h1 to port $port"
+	done
+
+	log_test "flood unknown $type pass $pass/4"
+}
+
+br_flood_unknown_bc_test()
+{
+	do_flood_unknown BC 1 bcast_flood "$BC_PKT" flag1
+	do_flood_unknown BC 2 bcast_flood "$BC_PKT" flag2
+	do_flood_unknown BC 3 bcast_flood "$BC_PKT" flag3
+	do_flood_unknown BC 4 bcast_flood "$BC_PKT" flag4
+}
+
+br_flood_unknown_uc_test()
+{
+	do_flood_unknown UC 1 flood "$UC_PKT" flag1
+	do_flood_unknown UC 2 flood "$UC_PKT" flag2
+	do_flood_unknown UC 3 flood "$UC_PKT" flag3
+	do_flood_unknown UC 4 flood "$UC_PKT" flag4
+}
+
+br_flood_unknown_mc_test()
+{
+	do_flood_unknown MC 1 mcast_flood "$MC_PKT" flag1
+	do_flood_unknown MC 2 mcast_flood "$MC_PKT" flag2
+	do_flood_unknown MC 3 mcast_flood "$MC_PKT" flag3
+	do_flood_unknown MC 4 mcast_flood "$MC_PKT" flag4
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.25.1

