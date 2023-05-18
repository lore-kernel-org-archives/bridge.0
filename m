Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 328DE81B8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14FA481BB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKdTRS0ZIQEdAbs+I0FkXntaP1eXB6RVCBy0Hb4d49U=;
 b=FIsm4HPiqbwLcjyJJmFbNIsRNZevetLXuQFg/cFxkLgR7PWgWVsiSeQ5UbthQG2YDGqVeTihiYTS/Ml9AX26B61HNMUWUyN390cjq3HEJkAJRX6xFkNdYQC+GmkvQXGykbBYXKU/bESimo62zj0f1MOcrxttWoavuezorfka2Kr2f+3IqvG/YAldiFkBmNfmi91qQC7G3kZptcobp1ssA+ChqNfgwOnbF5r//+yemE6UkNsaNKqF36ZRyzrTjONz+RXJJZPsq8FMF+5GIpcL/UBsuZ7RYDwg9AQXJvjbWEDhZAgaaEcTJ76VY9tWzOSZp1B/ZXnbUHL68U+K58lcVA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 18 May 2023 14:33:28 +0300
Message-ID: <20230518113328.1952135-6-idosch@nvidia.com>
In-Reply-To: <20230518113328.1952135-1-idosch@nvidia.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 5/5] selftests: forwarding: Add layer 2
	miss test cases
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Add test cases to verify that the bridge driver correctly marks layer 2
misses only when it should and that the flower classifier can match on
this metadata.

Example output:

 # ./tc_flower_l2_miss.sh
 TEST: L2 miss - Unicast                                             [ OK ]
 TEST: L2 miss - Multicast (IPv4)                                    [ OK ]
 TEST: L2 miss - Multicast (IPv6)                                    [ OK ]
 TEST: L2 miss - Link-local multicast (IPv4)                         [ OK ]
 TEST: L2 miss - Link-local multicast (IPv6)                         [ OK ]
 TEST: L2 miss - Broadcast                                           [ OK ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/tc_flower_l2_miss.sh       | 343 ++++++++++++++++++
 2 files changed, 344 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index a474c60fe348..9d0062b542e5 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -83,6 +83,7 @@ TEST_PROGS = bridge_igmp.sh \
 	tc_chains.sh \
 	tc_flower_router.sh \
 	tc_flower.sh \
+	tc_flower_l2_miss.sh \
 	tc_mpls_l2vpn.sh \
 	tc_police.sh \
 	tc_shblocks.sh \
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
new file mode 100755
index 000000000000..fbf0a960b2c8
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
@@ -0,0 +1,343 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------+                             +----------------------+
+# | H1 (vrf)              |                             | H2 (vrf)             |
+# |    + $h1              |                             |              $h2 +   |
+# |    | 192.0.2.1/28     |                             |     192.0.2.2/28 |   |
+# |    | 2001:db8:1::1/64 |                             | 2001:db8:1::2/64 |   |
+# +----|------------------+                             +------------------|---+
+#      |                                                                   |
+# +----|-------------------------------------------------------------------|---+
+# | SW |                                                                   |   |
+# |  +-|-------------------------------------------------------------------|-+ |
+# |  | + $swp1                       BR                              $swp2 + | |
+# |  +-----------------------------------------------------------------------+ |
+# +----------------------------------------------------------------------------+
+
+ALL_TESTS="
+	test_l2_miss_unicast
+	test_l2_miss_multicast
+	test_l2_miss_ll_multicast
+	test_l2_miss_broadcast
+"
+
+NUM_NETIFS=4
+source lib.sh
+source tc_common.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.2/28 2001:db8:1::2/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 192.0.2.2/28 2001:db8:1::2/64
+}
+
+switch_create()
+{
+	ip link add name br1 up type bridge
+	ip link set dev $swp1 master br1
+	ip link set dev $swp1 up
+	ip link set dev $swp2 master br1
+	ip link set dev $swp2 up
+
+	tc qdisc add dev $swp2 clsact
+}
+
+switch_destroy()
+{
+	tc qdisc del dev $swp2 clsact
+
+	ip link set dev $swp2 down
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp1 down
+	ip link set dev $swp1 nomaster
+	ip link del dev br1
+}
+
+test_l2_miss_unicast()
+{
+	local dmac=00:01:02:03:04:05
+	local dip=192.0.2.2
+	local sip=192.0.2.1
+
+	RET=0
+
+	# Unknown unicast.
+	tc filter add dev $swp2 egress protocol ipv4 handle 101 pref 1 \
+	   flower indev $swp1 l2_miss true dst_mac $dmac src_ip $sip \
+	   dst_ip $dip action pass
+	# Known unicast.
+	tc filter add dev $swp2 egress protocol ipv4 handle 102 pref 1 \
+	   flower indev $swp1 l2_miss false dst_mac $dmac src_ip $sip \
+	   dst_ip $dip action pass
+
+	# Before adding FDB entry.
+	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Unknown unicast filter was not hit before adding FDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 0
+	check_err $? "Known unicast filter was hit before adding FDB entry"
+
+	# Adding FDB entry.
+	bridge fdb replace $dmac dev $swp2 master static
+
+	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Unknown unicast filter was hit after adding FDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 1
+	check_err $? "Known unicast filter was not hit after adding FDB entry"
+
+	# Deleting FDB entry.
+	bridge fdb del $dmac dev $swp2 master static
+
+	$MZ $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 2
+	check_err $? "Unknown unicast filter was not hit after deleting FDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 1
+	check_err $? "Known unicast filter was hit after deleting FDB entry"
+
+	tc filter del dev $swp2 egress protocol ipv4 pref 1 handle 102 flower
+	tc filter del dev $swp2 egress protocol ipv4 pref 1 handle 101 flower
+
+	log_test "L2 miss - Unicast"
+}
+
+test_l2_miss_multicast_common()
+{
+	local proto=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local mode=$1; shift
+	local name=$1; shift
+
+	RET=0
+
+	# Unregistered multicast.
+	tc filter add dev $swp2 egress protocol $proto handle 101 pref 1 \
+	   flower indev $swp1 l2_miss true src_ip $sip dst_ip $dip \
+	   action pass
+	# Registered multicast.
+	tc filter add dev $swp2 egress protocol $proto handle 102 pref 1 \
+	   flower indev $swp1 l2_miss false src_ip $sip dst_ip $dip \
+	   action pass
+
+	# Before adding MDB entry.
+	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Unregistered multicast filter was not hit before adding MDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 0
+	check_err $? "Registered multicast filter was hit before adding MDB entry"
+
+	# Adding MDB entry.
+	bridge mdb replace dev br1 port $swp2 grp $dip permanent
+
+	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Unregistered multicast filter was hit after adding MDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 1
+	check_err $? "Registered multicast filter was not hit after adding MDB entry"
+
+	# Deleting MDB entry.
+	bridge mdb del dev br1 port $swp2 grp $dip
+
+	$MZ $mode $h1 -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 2
+	check_err $? "Unregistered multicast filter was not hit after deleting MDB entry"
+
+	tc_check_packets "dev $swp2 egress" 102 1
+	check_err $? "Registered multicast filter was hit after deleting MDB entry"
+
+	tc filter del dev $swp2 egress protocol $proto pref 1 handle 102 flower
+	tc filter del dev $swp2 egress protocol $proto pref 1 handle 101 flower
+
+	log_test "L2 miss - Multicast ($name)"
+}
+
+test_l2_miss_multicast_ipv4()
+{
+	local proto="ipv4"
+	local sip=192.0.2.1
+	local dip=239.1.1.1
+	local mode="-4"
+	local name="IPv4"
+
+	test_l2_miss_multicast_common $proto $sip $dip $mode $name
+}
+
+test_l2_miss_multicast_ipv6()
+{
+	local proto="ipv6"
+	local sip=2001:db8:1::1
+	local dip=ff0e::1
+	local mode="-6"
+	local name="IPv6"
+
+	test_l2_miss_multicast_common $proto $sip $dip $mode $name
+}
+
+test_l2_miss_multicast()
+{
+	# Configure $swp2 as a multicast router port so that it will forward
+	# both registered and unregistered multicast traffic.
+	bridge link set dev $swp2 mcast_router 2
+
+	# Forwarding according to MDB entries only takes place when the bridge
+	# detects that there is a valid querier in the network. Set the bridge
+	# as the querier and assign it a valid IPv6 link-local address to be
+	# used as the source address for MLD queries.
+	ip link set dev br1 type bridge mcast_querier 1
+	ip -6 address add fe80::1/64 nodad dev br1
+	# Wait the default Query Response Interval (10 seconds) for the bridge
+	# to determine that there are no other queriers in the network.
+	sleep 10
+
+	test_l2_miss_multicast_ipv4
+	test_l2_miss_multicast_ipv6
+
+	ip -6 address del fe80::1/64 dev br1
+	ip link set dev br1 type bridge mcast_querier 0
+	bridge link set dev $swp2 mcast_router 1
+}
+
+test_l2_miss_multicast_common2()
+{
+	local name=$1; shift
+	local dmac=$1; shift
+	local dip=224.0.0.1
+	local sip=192.0.2.1
+
+}
+
+test_l2_miss_ll_multicast_common()
+{
+	local proto=$1; shift
+	local dmac=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local mode=$1; shift
+	local name=$1; shift
+
+	RET=0
+
+	tc filter add dev $swp2 egress protocol $proto handle 101 pref 1 \
+	   flower indev $swp1 l2_miss true dst_mac $dmac src_ip $sip \
+	   dst_ip $dip action pass
+
+	$MZ $mode $h1 -a own -b $dmac -t ip -A $sip -B $dip -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Filter was not hit"
+
+	tc filter del dev $swp2 egress protocol $proto pref 1 handle 101 flower
+
+	log_test "L2 miss - Link-local multicast ($name)"
+}
+
+test_l2_miss_ll_multicast_ipv4()
+{
+	local proto=ipv4
+	local dmac=01:00:5e:00:00:01
+	local sip=192.0.2.1
+	local dip=224.0.0.1
+	local mode="-4"
+	local name="IPv4"
+
+	test_l2_miss_ll_multicast_common $proto $dmac $sip $dip $mode $name
+}
+
+test_l2_miss_ll_multicast_ipv6()
+{
+	local proto=ipv6
+	local dmac=33:33:00:00:00:01
+	local sip=2001:db8:1::1
+	local dip=ff02::1
+	local mode="-6"
+	local name="IPv6"
+
+	test_l2_miss_ll_multicast_common $proto $dmac $sip $dip $mode $name
+}
+
+test_l2_miss_ll_multicast()
+{
+	test_l2_miss_ll_multicast_ipv4
+	test_l2_miss_ll_multicast_ipv6
+}
+
+test_l2_miss_broadcast()
+{
+	local dmac=ff:ff:ff:ff:ff:ff
+	local smac=00:01:02:03:04:05
+
+	RET=0
+
+	tc filter add dev $swp2 egress protocol all handle 101 pref 1 \
+	   flower indev $swp1 l2_miss true dst_mac $dmac src_mac $smac \
+	   action pass
+
+	$MZ $h1 -a $smac -b $dmac -c 1 -p 100 -q
+
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Filter was not hit"
+
+	tc filter del dev $swp2 egress protocol all pref 1 handle 101 flower
+
+	log_test "L2 miss - Broadcast"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	vrf_prepare
+	h1_create
+	h2_create
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+	h2_destroy
+	h1_destroy
+	vrf_cleanup
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
2.40.1

