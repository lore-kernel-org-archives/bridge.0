Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DYxPRHRLEYcQrka7MbONriR7V5sW93K2rC+A+CbWUo0=;
 b=16Km5yqD1Jq7DqqEExTSa8dTgydtuWXkbRI5Ua4QUtOuXqQSDk5JBX9Kk+rxevcQDN
 k+xgovQkOr0B9aF8hdIj9f6KCj9srlwk0EmuIYDCBqQ7dCA759Rlo831pOZek6OViGie
 nzORFaOJDeHw9EtShM7FVXaEw4tHSWGa0dSoNA0+7LCrL8phbzO2DisADNWu9nI6uVM/
 Ff1cnAuwnDtcX+pfb+tCm2V58UQBwDtzplViNpHLL4Pa6SOsmQGXOM8RQLSg+pW6ZsGC
 YqT88vZLmuI9D4gufEHFMqx8a1+paH+s35KH4LtVjNIGy+NKxulKQCsAqCwni3W8JPhd
 0jBQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:55 +0200
Message-Id: <20211125140858.3639139-8-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 07/10] selftests: net: bridge: add vlan
	mcast_querier_interval tests
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

Add tests which change the new per-vlan mcast_querier_interval and
verify that it is taken into account when an outside querier is present.

TEST: Vlan mcast_querier_interval global option default value       [ OK ]
TEST: Vlan 10 mcast_querier_interval option changed to 100          [ OK ]
TEST: Vlan 10 mcast_querier_interval expire after outside query     [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 87dcd49b0a8d..9a68d56fd74c 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -2,7 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
-	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test"
+	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
+	   vlmc_querier_intvl_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -384,6 +385,43 @@ vlmc_membership_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_membership_interval 26000
 }
 
+vlmc_querier_intvl_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_querier_interval == 25500) " &>/dev/null
+	check_err $? "Wrong default mcast_querier_interval global vlan option value"
+	log_test "Vlan mcast_querier_interval global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier_interval 100
+	check_err $? "Could not set mcast_querier_interval in vlan 10"
+	log_test "Vlan 10 mcast_querier_interval option changed to 100"
+
+	RET=0
+	ip link add dev br1 type bridge mcast_snooping 1 mcast_querier 1 vlan_filtering 1 \
+					mcast_vlan_snooping 1
+	bridge vlan add vid 10 dev br1 self pvid untagged
+	ip link set dev $h1 master br1
+	ip link set dev br1 up
+	bridge vlan add vid 10 dev $h1 master
+	bridge vlan global set vid 10 dev br1 mcast_snooping 1 mcast_querier 1
+	sleep 2
+	ip link del dev br1
+	ip addr replace 2001:db8:1::1/64 dev $h1
+	vlmc_check_query igmp 2 $swp1 1 1
+	check_err $? "Wrong number of IGMPv2 general queries after querier interval"
+	log_test "Vlan 10 mcast_querier_interval expire after outside query"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier_interval 25500
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

