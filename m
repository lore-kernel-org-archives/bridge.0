Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jDgbRWbHqWtsaVeh+4rNPIsENfs+qLEuUZMgVdJDcfw=;
 b=saZZVnYLTtWITiQYzBL+L1wPU01pMugwFRwS0HyBsP1zl2v+21xj2jCBo4f/PbOJXa
 qJNMR9Q4MJiXFwP7jjQdciNVRlQ5YX9ZS1ynXMM7OawOtAja/QjbjEhnCDXnO4mMsXSY
 4evNrOuFgOc3cneku9JItIszBnxMDUcjsrva/RQb2maiCNZYrkwN+eZJIiU0vkPxgEDj
 meyLFRHSpaPGHzq3VfPDxGJghLKmK8yLzWZADTFt+p0wmFqQDpIKIS1Wq7bQbwAWbS6W
 zSiq3sL4EQUyqy/LkujM4pW4aOrp6tO+EqGCeh3F54KEajRU56pg5gaIaettRnoVi5it
 aeQA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:53 +0200
Message-Id: <20211125140858.3639139-6-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 05/10] selftests: net: bridge: add vlan
	mcast_startup_query_count/interval tests
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

Add tests which change the new per-vlan startup query count/interval
options and verify the proper number of queries are sent in the expected
interval.

TEST: Vlan mcast_startup_query_interval global option default value   [ OK ]
TEST: Vlan mcast_startup_query_count global option default value    [ OK ]
TEST: Vlan 10 mcast_startup_query_interval option changed to 100    [ OK ]
TEST: Vlan 10 mcast_startup_query_count option changed to 3         [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 85146c998316..0070d8292569 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test vlmc_last_member_test"
+ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
+	   vlmc_last_member_test vlmc_startup_query_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -318,6 +319,45 @@ vlmc_last_member_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_interval 100
 }
 
+vlmc_startup_query_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_startup_query_interval == 3125) " &>/dev/null
+	check_err $? "Wrong default mcast_startup_query_interval global vlan option value"
+	log_test "Vlan mcast_startup_query_interval global option default value"
+
+	RET=0
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_startup_query_count == 2) " &>/dev/null
+	check_err $? "Wrong default mcast_startup_query_count global vlan option value"
+	log_test "Vlan mcast_startup_query_count global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_interval 100
+	check_err $? "Could not set mcast_startup_query_interval in vlan 10"
+	vlmc_check_query igmp 2 $swp1 2 3
+	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
+	log_test "Vlan 10 mcast_startup_query_interval option changed to 100"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 3
+	check_err $? "Could not set mcast_startup_query_count in vlan 10"
+	vlmc_check_query igmp 2 $swp1 3 4
+	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
+	log_test "Vlan 10 mcast_startup_query_count option changed to 3"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_interval 3125
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

