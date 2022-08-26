Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A10B419F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F9E6419F4
From: Hans Schultz <netdev@kapio-technology.com>
Date: Fri, 26 Aug 2022 13:45:38 +0200
Message-Id: <20220826114538.705433-7-netdev@kapio-technology.com>
In-Reply-To: <20220826114538.705433-1-netdev@kapio-technology.com>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add test of
	MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Hans Schultz <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>

Verify that the MAC-Auth mechanism works by adding a FDB entry with the
locked flag set, denying access until the FDB entry is replaced with a
FDB entry without the locked flag set.

Also add a test that verifies that sticky FDB entries cannot roam.

Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
---
 .../net/forwarding/bridge_locked_port.sh      | 107 +++++++++++++++++-
 .../net/forwarding/bridge_sticky_fdb.sh       |  21 +++-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index 5b02b6b60ce7..b763b3b9fdf0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -1,7 +1,15 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
+ALL_TESTS="
+	locked_port_ipv4
+	locked_port_ipv6
+	locked_port_vlan
+	locked_port_mab
+	locked_port_station_move
+	locked_port_mab_station_move
+"
+
 NUM_NETIFS=4
 CHECK_TC="no"
 source lib.sh
@@ -166,6 +174,103 @@ locked_port_ipv6()
 	log_test "Locked port ipv6"
 }
 
+locked_port_mab()
+{
+	RET=0
+	check_locked_port_support || return 0
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work before locking port"
+
+	bridge link set dev $swp1 locked on
+	bridge link set dev $swp1 learning on
+	if ! bridge link set dev $swp1 mab on 2>/dev/null; then
+		echo "SKIP: iproute2 too old; MacAuth feature not supported."
+		return $ksft_skip
+	fi
+
+	ping_do $h1 192.0.2.2
+	check_fail $? "MAB: Ping worked on locked port without FDB entry"
+
+	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
+	check_err $? "MAB: No locked fdb entry after ping on locked port"
+
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
+
+	bridge fdb del `mac_get $h1` dev $swp1 master
+	bridge link set dev $swp1 learning off
+	bridge link set dev $swp1 locked off
+
+	log_test "Locked port MAB"
+}
+
+# No roaming allowed to a simple locked port
+locked_port_station_move()
+{
+	local mac=a0:b0:c0:c0:b0:a0
+
+	RET=0
+	check_locked_port_support || return 0
+
+	bridge link set dev $swp1 locked on
+	bridge link set dev $swp1 learning on
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0"
+	check_fail $? "Locked port station move: FDB entry on first injection"
+
+	$MZ $h2 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"
+	check_err $? "Locked port station move: Entry not found on unlocked port"
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0"
+	check_fail $? "Locked port station move: entry roamed to locked port"
+
+	log_test "Locked port station move"
+}
+
+# Roaming to and from a MAB enabled port should work if sticky flag is not set
+locked_port_mab_station_move()
+{
+	local mac=10:20:30:30:20:10
+
+	RET=0
+	check_locked_port_support || return 0
+
+	bridge link set dev $swp1 locked on
+	bridge link set dev $swp1 learning on
+	if ! bridge link set dev $swp1 mab on 2>/dev/null; then
+		echo "SKIP: iproute2 too old; MacAuth feature not supported."
+		return $ksft_skip
+	fi
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	if bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0" | grep -q sticky; then
+		echo "SKIP: Roaming not possible with sticky flag, run sticky flag roaming test"
+		return $ksft_skip
+	fi
+
+	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
+	check_err $? "MAB station move: no locked entry on first injection"
+
+	$MZ $h2 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
+	check_fail $? "MAB station move: locked entry did not move"
+
+	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"
+	check_err $? "MAB station move: roamed entry not found"
+
+	$MZ $h1 -q -t udp -a $mac -b rand
+	bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
+	check_err $? "MAB station move: entry did not roam back to locked port"
+
+	log_test "Locked port MAB station move"
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
index 1f8ef0eff862..bca77bc3fe09 100755
--- a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="sticky"
+ALL_TESTS="sticky sticky_no_roaming"
 NUM_NETIFS=4
 TEST_MAC=de:ad:be:ef:13:37
 source lib.sh
@@ -59,6 +59,25 @@ sticky()
 	log_test "Sticky fdb entry"
 }
 
+# No roaming allowed with the sticky flag set
+sticky_no_roaming()
+{
+	local mac=a8:b4:c2:c2:b4:a8
+
+	RET=0
+
+	bridge link set dev $swp2 learning on
+	bridge fdb add $mac dev $swp1 master static sticky
+	bridge fdb show dev $swp1 | grep "$mac master br0" | grep -q sticky
+	check_err $? "Sticky no roaming: No sticky FDB entry found after adding"
+
+	$MZ $h2 -q -t udp -c 10 -d 100msec -a $mac -b rand
+	bridge fdb show dev $swp2 | grep "$mac master br0" | grep -q sticky
+	check_fail $? "Sticky no roaming: Sticky entry roamed"
+
+	log_test "Sticky no roaming"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.30.2

