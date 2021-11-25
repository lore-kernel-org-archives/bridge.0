Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FzgAx/GM5UY7f5TX8VZkJRzCg4EVgCVxeMVd/CytlKU=;
 b=kVCq5pWtzAWSHFYGKKnoa+wROir6oCgaHq8S/t7k0/VnVWnx2tlLcVzoF/81ImvC2W
 L4LnH3d61VE8JTaMpI6aUcmjeqheIEboLwgiIlj6flPJLV55AwsIGXGHRx7TB/qeGfrg
 f28bpDm68q9KcAfybVWFNcXnxltwpEs/TwkSUtxZX1RZFo4zXgI1GKbXDU1jYyWoHlNu
 yqTKL4DBFI1SoVFJYCnAyBxk6ZwK4K6hiwgWauHgmRT47huWzRTDVlwD3L+/qNF0ygpf
 5Jzjs8Now3cL+BgyMzgL++n0O/ptuouqzzYa4IKxVvV/4sTlhMRkarFdlxaesLq4e7gy
 pKzw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 25 Nov 2021 16:08:51 +0200
Message-Id: <20211125140858.3639139-4-razor@blackwall.org>
In-Reply-To: <20211125140858.3639139-1-razor@blackwall.org>
References: <20211125140858.3639139-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 03/10] selftests: net: bridge: add vlan
	mcast igmp/mld version tests
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

Add tests which change the new per-vlan IGMP/MLD versions and verify
that proper tagged general query packets are sent.

TEST: Vlan mcast_igmp_version global option default value           [ OK ]
TEST: Vlan mcast_mld_version global option default value            [ OK ]
TEST: Vlan 10 mcast_igmp_version option changed to 3                [ OK ]
TEST: Vlan 10 tagged IGMPv3 general query sent                      [ OK ]
TEST: Vlan 10 mcast_mld_version option changed to 2                 [ OK ]
TEST: Vlan 10 tagged MLDv2 general query sent                       [ OK ]

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index aa23764a328b..1b91778fac2f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="vlmc_control_test vlmc_querier_test"
+ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -241,6 +241,49 @@ vlmc_querier_test()
 	log_test "Vlan 10 tagged MLD general query sent"
 }
 
+vlmc_igmp_mld_version_test()
+{
+	RET=0
+	local goutput=`bridge -j vlan global show`
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10)" &>/dev/null
+	check_err $? "Could not find vlan 10's global options"
+
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and .mcast_igmp_version == 2) " &>/dev/null
+	check_err $? "Wrong default mcast_igmp_version global vlan option value"
+	log_test "Vlan mcast_igmp_version global option default value"
+
+	RET=0
+	echo -n $goutput |
+		jq -e ".[].vlans[] | select(.vlan == 10 and .mcast_mld_version == 1) " &>/dev/null
+	check_err $? "Wrong default mcast_mld_version global vlan option value"
+	log_test "Vlan mcast_mld_version global option default value"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
+	check_err $? "Could not set mcast_igmp_version in vlan 10"
+	log_test "Vlan 10 mcast_igmp_version option changed to 3"
+
+	RET=0
+	vlmc_check_query igmp 3 $swp1 1 1
+	check_err $? "No vlan tagged IGMPv3 general query packets sent"
+	log_test "Vlan 10 tagged IGMPv3 general query sent"
+
+	RET=0
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
+	check_err $? "Could not set mcast_mld_version in vlan 10"
+	log_test "Vlan 10 mcast_mld_version option changed to 2"
+
+	RET=0
+	vlmc_check_query mld 2 $swp1 1 1
+	check_err $? "No vlan tagged MLDv2 general query packets sent"
+	log_test "Vlan 10 tagged MLDv2 general query sent"
+
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
+	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.31.1

