Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KUwIDVuHZxC8CM1QJ43pGK3dXQdVN5CV0sqGlBsC+08=;
 b=B3t+dQ/ZMMRClgJdoY14DL/k5UGsWQP38sZjmzFQd7RLR7qkuQk1EBXLiJTRJiNrw1
 92oddnXE7M1avb9oEjN7p0/QVObZam7DxopYI2EMEgwOqD/lF4/4XlUzN1uVP3VKwtAK
 A1nsyIgF8xK/rugo4ODblyeV5Ssif8cVlEX3P+QMmD7bB66QKv29bWbBF1cD7qDg3wxA
 hyVxOj3YE165ebEvHl/uVkq741DDXaVuyn2rJ7kadooQ676fORbYxOrJbiw5Y1BdsWaH
 0B8S4plE5OurnFsB+DlwItxmK9ERr6G1gcHsPL8o+RVQnEc3LmC9aCR78P627mD7ZnYz
 kH0Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:33 +0200
Message-Id: <20201027185934.227040-16-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 15/16] selftests: net: bridge: add test
	for igmpv3 exclude timeout
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Test that when a group in exclude mode expires it changes mode to
include and the blocked entries are deleted.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 45c5619666d8..db0a03e30868 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -3,7 +3,8 @@
 
 ALL_TESTS="v2reportleave_test v3include_test v3inc_allow_test v3inc_is_include_test \
 	   v3inc_is_exclude_test v3inc_to_exclude_test v3exc_allow_test v3exc_is_include_test \
-	   v3exc_is_exclude_test v3exc_to_exclude_test v3inc_block_test v3exc_block_test"
+	   v3exc_is_exclude_test v3exc_to_exclude_test v3inc_block_test v3exc_block_test \
+	   v3exc_timeout_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -574,6 +575,52 @@ v3exc_block_test()
 	v3cleanup $swp1 $TEST_GROUP
 }
 
+v3exc_timeout_test()
+{
+	RET=0
+	local X=("192.0.2.20" "192.0.2.30")
+
+	# GMI should be 3 seconds
+	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+
+	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
+	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
+	sleep 3
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and .filter_mode == \"include\")" &>/dev/null
+	check_err $? "Wrong *,G entry filter mode"
+
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and
+				.source_list[].address == \"192.0.2.1\")" &>/dev/null
+	check_fail $? "Wrong *,G entry source list, 192.0.2.1 entry still exists"
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and
+				.source_list[].address == \"192.0.2.2\")" &>/dev/null
+	check_fail $? "Wrong *,G entry source list, 192.0.2.2 entry still exists"
+
+	check_sg_entries "allow" "${X[@]}"
+
+	check_sg_state 0 "${X[@]}"
+
+	check_sg_fwding 1 "${X[@]}"
+	check_sg_fwding 0 192.0.2.100
+
+	log_test "IGMPv3 group $TEST_GROUP exclude timeout"
+
+	ip link set dev br0 type bridge mcast_query_interval 12500 \
+					mcast_query_response_interval 1000
+
+	v3cleanup $swp1 $TEST_GROUP
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

