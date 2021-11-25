Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nmr06pA0TokKoR6jlJic1Isl4JZia+uZ96LV+9m0Xfk=;
 b=qCilOhgU1ExKEZEIAxoiLKHqAkukOP07ZzUuPqR52J7FfCdWqISFFzn//+tHX35VLi
 RTThkXPJTbMU2L4plslbTzWY8aRPsH0tF24AoD+R5TuceouHuzSXojqeuLnfdL9/x297
 iLH3EirHXGckKJC9VJfEUHeyWfSFH7keERCCZ5F2xROX24SOF9/bqptMxXahfbAwAgn5
 2QvuQ3DzhYD1V3SxKgsjSm/ytjfj1Lw+E1EMb0vc7oPeSMNHYUi8CglzsT07EVhyfFw7
 6dNDrYZjmwUV2QHs/Vr2txD/Mx65Bywp5Qu26JlUKHkLwKKw/4ghpJ4rDMU0aO+EEVmL
 iOxw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:58 +0200
Message-Id: <20211125140858.3639139-11-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 10/10] selftests: net: bridge: add test
	for vlan_filtering dependency
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

Add a test for dependency of mcast_vlan_snooping on vlan_filtering. If
vlan_filtering gets disabled, then mcast_vlan_snooping must be
automatically disabled as well.

TEST: Disable multicast vlan snooping when vlan filtering is disabled   [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_vlan_mcast.sh    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 898a70f4d226..5224a5a8595b 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
 	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
 	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test \
-	   vlmc_router_port_test"
+	   vlmc_router_port_test vlmc_filtering_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -523,6 +523,16 @@ vlmc_router_port_test()
 	bridge vlan set vid 10 dev $swp1 mcast_router 1
 }
 
+vlmc_filtering_test()
+{
+	RET=0
+	ip link set dev br0 type bridge vlan_filtering 0
+	ip -j -d link show dev bridge | \
+	jq -e "select(.[0].linkinfo.info_data.mcast_vlan_snooping == 1)" &>/dev/null
+	check_fail $? "Vlan filtering is disabled but multicast vlan snooping is still enabled"
+	log_test "Disable multicast vlan snooping when vlan filtering is disabled"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

