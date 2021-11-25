Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BzpnEA37RXcLJueyhR+TEPx2gUPlYvWfPjF8B5Ruo4o=;
 b=FPTx/34hoPRAdbxsgFLIdI155A0LPiIo/mRhgeXxXtt1IjbIgq1imUUaLmpUl5sMtZ
 rFJDaaz1WS6JWUV9zyqWh2Ck6DJz9KRqhHJ7iQpGWKLvTQWMJOkKTzqx9L9CtEN8DZAe
 V9l0yHfxD7emaU1CZ0vGxvFQkdKVhmgbwd9OlV/K+z8eLJ2VS16xiT0Zw2H0YXZMuz7E
 O6MHedZceHXkhrtbqeMGy1jNp/NC/RepM0lqbB9qy2501h82q/vMcBAWoosq/VtHg61i
 JW0u6rwl4qaDs93b5i0TNH5dMVolCYenzAGLyfCWncBVdzHyuUd9Ak/2vBXCHOk6uD1G
 +l2Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:50 +0200
Message-Id: <20211125140858.3639139-3-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 02/10] selftests: net: bridge: add vlan
	mcast querier test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add a test to try the new global vlan mcast_querier control and also
verify that tagged general query packets are properly generated when
querier is enabled for a single vlan.

TEST: Vlan mcast_querier global option default value                [ OK ]
TEST: Vlan 10 multicast querier enable                              [ OK ]
TEST: Vlan 10 tagged IGMPv2 general query sent                      [ OK ]
TEST: Vlan 10 tagged MLD general query sent                         [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 105 +++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 796e8f094e08..aa23764a328b 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="vlmc_control_test"
+ALL_TESTS="vlmc_control_test vlmc_querier_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -43,6 +43,9 @@ switch_create()
 	ip link set dev $swp1 up
 	ip link set dev $swp2 up
 
+	tc qdisc add dev $swp1 clsact
+	tc qdisc add dev $swp2 clsact
+
 	bridge vlan add vid 10-11 dev $swp1 master
 	bridge vlan add vid 10-11 dev $swp2 master
 
@@ -138,6 +141,106 @@ vlmc_control_test()
 	log_test "Vlan 10 multicast snooping control"
 }
 
+# setup for general query counting
+vlmc_query_cnt_xstats()
+{
+	local type=$1
+	local version=$2
+	local dev=$3
+
+	ip -j link xstats type bridge_slave dev $dev | \
+	jq -e ".[].multicast.${type}_queries.tx_v${version}"
+}
+
+vlmc_query_cnt_setup()
+{
+	local type=$1
+	local dev=$2
+
+	if [[ $type == "igmp" ]]; then
+		tc filter add dev $dev egress pref 10 prot 802.1Q \
+			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
+			action pass
+	else
+		tc filter add dev $dev egress pref 10 prot 802.1Q \
+			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
+			action pass
+	fi
+
+	ip link set dev br0 type bridge mcast_stats_enabled 1
+}
+
+vlmc_query_cnt_cleanup()
+{
+	local dev=$1
+
+	ip link set dev br0 type bridge mcast_stats_enabled 0
+	tc filter del dev $dev egress pref 10
+}
+
+vlmc_check_query()
+{
+	local type=$1
+	local version=$2
+	local dev=$3
+	local expect=$4
+	local time=$5
+	local ret=0
+
+	vlmc_query_cnt_setup $type $dev
+
+	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
+	ret=$?
+	if [[ $ret -eq 0 ]]; then
+		sleep $time
+
+		local tcstats=$(tc_rule_stats_get $dev 10 egress)
+		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
+
+		if [[ $tcstats != $expect || \
+		      $(($post_tx_xstats-$pre_tx_xstats)) != $expect || \
+		      $tcstats != $(($post_tx_xstats-$pre_tx_xstats)) ]]; then
+			ret=1
+		fi
+	fi
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 0
+	vlmc_query_cnt_cleanup $dev
+
+	return $ret
+}
+
+vlmc_querier_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and .mcast_querier == 0) " &>/dev/null
+	check_err $? "Wrong default mcast_querier global vlan option value"
+	log_test "Vlan mcast_querier global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
+	check_err $? "Could not enable querier in vlan 10"
+	log_test "Vlan 10 multicast querier enable"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 0
+
+	RET=0
+	vlmc_check_query igmp 2 $swp1 1 1
+	check_err $? "No vlan tagged IGMPv2 general query packets sent"
+	log_test "Vlan 10 tagged IGMPv2 general query sent"
+
+	RET=0
+	vlmc_check_query mld 1 $swp1 1 1
+	check_err $? "No vlan tagged MLD general query packets sent"
+	log_test "Vlan 10 tagged MLD general query sent"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

