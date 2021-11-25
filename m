Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2qBrpPJsVudI6ySyaIY5TvYiAoJvmZq0zlu3qsVbGJw=;
 b=zkTCHhDPo6CeblP4zt7GKTJrhkAYeyHazgOcLJLN1Oy5SxnoWqzP10cvSZmh6t1EdB
 UD3x1kc6WaksgP3/QN+U3lZoZZ86ae3yhTwj4bRZDW4osGRd4F0pXTr21jkAi4ORy9LR
 vU234HOsyTi1nLApmLURc2RP2XBWXuD2wFsGLdCU/bQEzFA8U7AqaR1zqfEdAluM78d0
 pD3EHIRcNQZ6Q+gs8EKsIHxVu8014eFit2XUvfImxo5sbA2vz1giXpuOTnl6oUClTWil
 koFMY8GB5J1w1ITzMHNr90MvnSnFe4Osfetqqi7a1UuSWRopTqbMKSpEnFfXfblsDgdw
 /Fpw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:52 +0200
Message-Id: <20211125140858.3639139-5-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 04/10] selftests: net: bridge: add vlan
	mcast_last_member_count/interval tests
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

Add tests which verify the default values of mcast_last_member_count
mcast_last_member_count and also try to change them.

TEST: Vlan mcast_last_member_count global option default value      [ OK ]
TEST: Vlan mcast_last_member_interval global option default value   [ OK ]
TEST: Vlan 10 mcast_last_member_count option changed to 3           [ OK ]
TEST: Vlan 10 mcast_last_member_interval option changed to 200      [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 1b91778fac2f..85146c998316 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test"
+ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test vlmc_last_member_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -284,6 +284,40 @@ vlmc_igmp_mld_version_test()
 	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
 }
 
+vlmc_last_member_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_last_member_count == 2) " &>/dev/null
+	check_err $? "Wrong default mcast_last_member_count global vlan option value"
+	log_test "Vlan mcast_last_member_count global option default value"
+
+	RET=0
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and \
+					    .mcast_last_member_interval == 100) " &>/dev/null
+	check_err $? "Wrong default mcast_last_member_interval global vlan option value"
+	log_test "Vlan mcast_last_member_interval global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_count 3
+	check_err $? "Could not set mcast_last_member_count in vlan 10"
+	log_test "Vlan 10 mcast_last_member_count option changed to 3"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_count 2
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_interval 200
+	check_err $? "Could not set mcast_last_member_interval in vlan 10"
+	log_test "Vlan 10 mcast_last_member_interval option changed to 200"
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_last_member_interval 100
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

