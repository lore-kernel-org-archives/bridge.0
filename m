Return-Path: <amcohen@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A4C582010
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51D698211B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPQrcvAu8rLpQapwQqxzBzEo7hcE9ye2l3LUdfKldvk=;
 b=Ig/2VZ+H0DcAJ8g+IOo60uoTh2ObP/1IQWRrmTcait5QEGl0CzeGgEVJifezrp1jOXl5lw25iSQ2cclZkSllb7I5p3CXM8FGgEJAMeXtEANH9bSPHQpPdphiJ/JwUG61tBmFK6iW/yC0DFvy/qGA1aCoS68cjjkWmG2hZJ8/g2r94Wt4ma7+aB1CtIlHjE5auCvlNYoS5AG0ydfMuf/AQRuxE7ZCW+mUAOE+/wFteCKsJ6og9mSyBmmqu1h0LRU9tI+qa9Ur4H1IqIh3EGXnGGtPDAXFWiqq+Heh6f50LM6/svBUwGcW9LumjuNvgmAAL3hRmRWQySC97hDGTwCoBw==
From: Amit Cohen <amcohen@nvidia.com>
Date: Mon, 9 Oct 2023 13:06:18 +0300
Message-ID: <20231009100618.2911374-12-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 11/11] selftests: fdb_flush: Add test
	cases for FDB flush with bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org, Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

Extend the test to check flushing with bridge device, test flush by device
and by VID.

Add test case for flushing with "self" and "master" and attributes that are
supported only in one driver, this is unrecommended configuration, check it
to verify that user gets an error.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 tools/testing/selftests/net/fdb_flush.sh | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/net/fdb_flush.sh b/tools/testing/selftests/net/fdb_flush.sh
index 3050b031f46d..90e7a29e0476 100755
--- a/tools/testing/selftests/net/fdb_flush.sh
+++ b/tools/testing/selftests/net/fdb_flush.sh
@@ -32,6 +32,9 @@ TESTS="
 	$FLUSH_BY_FLAG_TESTS
 	vxlan_test_flush_by_several_args
 	vxlan_test_flush_by_remote_attributes
+	bridge_test_flush_by_dev
+	bridge_test_flush_by_vlan
+	bridge_vxlan_test_flush
 "
 
 : ${VERBOSE:=0}
@@ -647,6 +650,93 @@ vxlan_test_flush_by_remote_attributes()
 	log_test $? 0 "Check how many entries were flushed"
 }
 
+bridge_test_flush_by_dev()
+{
+	local dst_ip=192.0.2.1
+	local br0_n_ent_t0=$($BRIDGE fdb show dev br0 | wc -l)
+	local br1_n_ent_t0=$($BRIDGE fdb show dev br1 | wc -l)
+
+	fdb_add_mac_pool_1 br0 dst $dst_ip
+	fdb_add_mac_pool_2 br1 dst $dst_ip
+
+	# Each 'fdb add' command adds one extra entry in the bridge with the
+	# default vlan.
+	local exp_br0_n_ent=$(($br0_n_ent_t0 + 2 * $mac_pool_1_len))
+	local exp_br1_n_ent=$(($br1_n_ent_t0 + 2 * $mac_pool_2_len))
+
+	fdb_check_n_entries_by_dev_filter br0 $exp_br0_n_ent
+	fdb_check_n_entries_by_dev_filter br1 $exp_br1_n_ent
+
+	run_cmd "$BRIDGE fdb flush dev br0"
+	log_test $? 0 "Flush FDB by dev br0"
+
+	# The default entry should not be flushed
+	fdb_check_n_entries_by_dev_filter br0 1
+	log_test $? 0 "Flush FDB by dev br0 - test br0 entries"
+
+	fdb_check_n_entries_by_dev_filter br1 $exp_br1_n_ent
+	log_test $? 0 "Flush FDB by dev br0 - test br1 entries"
+}
+
+bridge_test_flush_by_vlan()
+{
+	local vlan_1=10
+	local vlan_2=20
+	local vlan_1_ent_t0
+	local vlan_2_ent_t0
+
+	$BRIDGE vlan add vid $vlan_1 dev br0 self
+	$BRIDGE vlan add vid $vlan_2 dev br0 self
+
+	vlan_1_ent_t0=$($BRIDGE fdb show dev br0 | grep "vlan $vlan_1" | wc -l)
+	vlan_2_ent_t0=$($BRIDGE fdb show dev br0 | grep "vlan $vlan_2" | wc -l)
+
+	fdb_add_mac_pool_1 br0 vlan $vlan_1
+	fdb_add_mac_pool_2 br0 vlan $vlan_2
+
+	local exp_vlan_1_ent=$(($vlan_1_ent_t0 + $mac_pool_1_len))
+	local exp_vlan_2_ent=$(($vlan_2_ent_t0 + $mac_pool_2_len))
+
+	fdb_check_n_entries_by_dev_filter br0 $exp_vlan_1_ent vlan $vlan_1
+	fdb_check_n_entries_by_dev_filter br0 $exp_vlan_2_ent vlan $vlan_2
+
+	run_cmd "$BRIDGE fdb flush dev br0 vlan $vlan_1"
+	log_test $? 0 "Flush FDB by dev br0 and vlan $vlan_1"
+
+	fdb_check_n_entries_by_dev_filter br0 0 vlan $vlan_1
+	log_test $? 0 "Test entries with vlan $vlan_1"
+
+	fdb_check_n_entries_by_dev_filter br0 $exp_vlan_2_ent vlan $vlan_2
+	log_test $? 0 "Test entries with vlan $vlan_2"
+}
+
+bridge_vxlan_test_flush()
+{
+	local vlan_1=10
+	local dst_ip=192.0.2.1
+
+	$IP link set dev vx10 master br0
+	$BRIDGE vlan add vid $vlan_1 dev br0 self
+	$BRIDGE vlan add vid $vlan_1 dev vx10
+
+	fdb_add_mac_pool_1 vx10 vni 3000 dst $dst_ip self master
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vlan $vlan_1
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vni 3000
+
+	# Such command should fail in VXLAN driver as vlan is not supported,
+	# but the command should flush the entries in the bridge
+	run_cmd "$BRIDGE fdb flush dev vx10 vlan $vlan_1 master self"
+	log_test $? 255 \
+		"Flush FDB by dev vx10, vlan $vlan_1, master and self"
+
+	fdb_check_n_entries_by_dev_filter vx10 0 vlan $vlan_1
+	log_test $? 0 "Test entries with vlan $vlan_1"
+
+	fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip
+	log_test $? 0 "Test entries with dst $dst_ip"
+}
+
 setup()
 {
 	IP="ip -netns ns1"
@@ -656,10 +746,16 @@ setup()
 
 	$IP link add name vx10 type vxlan id 1000 dstport "$VXPORT"
 	$IP link add name vx20 type vxlan id 2000 dstport "$VXPORT"
+
+	$IP link add br0 type bridge vlan_filtering 1
+	$IP link add br1 type bridge vlan_filtering 1
 }
 
 cleanup()
 {
+	$IP link del dev br1
+	$IP link del dev br0
+
 	$IP link del dev vx20
 	$IP link del dev vx10
 
-- 
2.40.1

