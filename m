Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MKmLffX+pWU4FoGNzKjM0jOIw2aMhpVyY+HZhQGjnqg=;
 b=vd141DjmUJYTiCdsz/2wy8xA6ToZUseMArv0IPAnwB33JcVmD1P7Egx4igtP6nHk7I
 L63haVNgajhvJcUOyK79pW4cXv5dDb2diGLW/ginf6KSt/Trk2ZsK0fnfAJ9NeoDaiTE
 ULVHgWXIxT9MSFApIgDJ5TnzBEgbKTxkaejeH9VYisrleBVxr+o8/Qy1rjaf/84mys6M
 ypxIMEZwowA6JgNik8J77MaXrviVEf/ZurQhQ9+tshwSGkwaYvbnf3uLvmx03CSAIWAo
 gMsyj/XBfkSRLA/qTUBqGxgpFmHLEs9r/Udp/Wao1WiLNkaS9jaAF9FZPeQx3xJFxCuD
 TbyQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:56 +0200
Message-Id: <20211125140858.3639139-9-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 08/10] selftests: net: bridge: add vlan
	mcast query and query response interval tests
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

Add tests which change the new per-vlan mcast_query_interval and verify
the new value is in effect, also add a test to change
mcast_query_response_interval's value.

TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 200   [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 9a68d56fd74c..fbc7f5045b26 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -3,7 +3,7 @@
 
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
 	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
-	   vlmc_querier_intvl_test"
+	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -422,6 +422,55 @@ vlmc_querier_intvl_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier_interval 25500
 }
 
+vlmc_query_intvl_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_query_interval == 12500) " &>/dev/null
+	check_err $? "Wrong default mcast_query_interval global vlan option value"
+	log_test "Vlan mcast_query_interval global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 200
+	check_err $? "Could not set mcast_query_interval in vlan 10"
+	# 1 is sent immediately, then 2 more in the next 5 seconds
+	vlmc_check_query igmp 2 $swp1 3 5
+	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
+	log_test "Vlan 10 mcast_query_interval option changed to 200"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
+}
+
+vlmc_query_response_intvl_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_query_response_interval == 1000) " &>/dev/null
+	check_err $? "Wrong default mcast_query_response_interval global vlan option value"
+	log_test "Vlan mcast_query_response_interval global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
+	check_err $? "Could not set mcast_query_response_interval in vlan 10"
+	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

