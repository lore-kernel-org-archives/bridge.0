Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zYFf5rleB9ec1h6L5Rsg6C85Sz0GkYn54vaAI/sfBKM=;
 b=TZ4dGHtEEfqktYYq6EH4whBPY2645fhRxPiV/i9ULpr6ozh9oLTyJ4GXOSpkcT0IyA
 pEWrfUX5fWk6L5QENIVhdpd3+TXwh/SAzZSDFKX06XcNNYospIL4eEPKBBzcyYnoqfhQ
 1Z9D+zD3BoVGjiWsZIu//sCxU+jxOBVfdzWX5EFgBldvOGJYobXOZ9FnYRoqZQH0spq4
 ZhAqxcqLXfezrGJJL5/yaRcNyEK7OADcIjdOABNNAntNRm9xjA3OK2Aok2xumniYRfcf
 e3jjNq+nvx8IqA2VFa/04bovWO6A8SkSMEAzDuY+3RBL0q984PWfpEhyNkXqfv2R8cxR
 6EqA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:54 +0200
Message-Id: <20211125140858.3639139-7-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 06/10] selftests: net: bridge: add vlan
	mcast_membership_interval test
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

Add a test which changes the new per-vlan mcast_membership_interval and
verifies that a newly learned mdb entry would expire in that interval.

TEST: Vlan mcast_membership_interval global option default value    [ OK ]
TEST: Vlan 10 mcast_membership_interval option changed to 200       [ OK ]
TEST: Vlan 10 mcast_membership_interval mdb entry expire            [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 0070d8292569..87dcd49b0a8d 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
-	   vlmc_last_member_test vlmc_startup_query_test"
+	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -358,6 +358,32 @@ vlmc_startup_query_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
 }
 
+vlmc_membership_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_membership_interval == 26000) " &>/dev/null
+	check_err $? "Wrong default mcast_membership_interval global vlan option value"
+	log_test "Vlan mcast_membership_interval global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_membership_interval 200
+	check_err $? "Could not set mcast_membership_interval in vlan 10"
+	log_test "Vlan 10 mcast_membership_interval option changed to 200"
+
+	RET=0
+	vlmc_v2join_test 1
+	log_test "Vlan 10 mcast_membership_interval mdb entry expire"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_membership_interval 26000
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

