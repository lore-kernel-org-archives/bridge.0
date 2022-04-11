Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=e7IjdhPKEVh1ILxXP0o9ofaJvPijy5TyOaJH5gWrzSo=;
 b=CG69gl74fRXhya4eLFC2KbyTlkiTOQUfJ0CqTKGenEhzBRLHESehB2tnCquvSwHp9V
 8SMqS50EaoIbfSPADm86/PKfHoBBmVzE39VIBPdpxhkJkPilkH3vztEfv3WkKvglG1Os
 PuqTSsqBr2RuqS/OZiqe3QORivaD67vSahID8wyRBvrivLtQyvh2pnHU8lvqiKi42tPP
 +A7yJMKoDapprK+zyFWrnq4HlejGJ+SqUcy1CbfwUqjY2GjGeP6jaqbQtqz54pBM65s6
 d1V6NoauDuqLA/hv7/CkSd40hEmp5yCDGBhxITP3i+zGdGFdAa9sslFpeEpk7k4WH1YP
 HVlw==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 10:40:54 +0200
Message-Id: <20220411084054.298807-3-troglobit@gmail.com>
In-Reply-To: <20220411084054.298807-1-troglobit@gmail.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <20220411084054.298807-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 2/2] selftests: forwarding: new test,
	verify host mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Joachim Wiberg <troglobit@gmail.com>, "David S . Miller" <davem@davemloft.net>

Boiler plate for testing static mdb entries.  This first test verifies
adding and removing host mdb entries for all supported types: IPv4,
IPv6, and MAC multicast.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/bridge_mdb.sh    | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 8fa97ae9af9e..ae80c2aef577 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -2,6 +2,7 @@
 
 TEST_PROGS = bridge_igmp.sh \
 	bridge_locked_port.sh \
+	bridge_mdb.sh \
 	bridge_port_isolation.sh \
 	bridge_sticky_fdb.sh \
 	bridge_vlan_aware.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
new file mode 100755
index 000000000000..b1ba6876dd86
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -0,0 +1,103 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that adding host mdb entries work as intended for all types of
+# multicast filters: ipv4, ipv6, and mac
+
+ALL_TESTS="mdb_add_del_test"
+NUM_NETIFS=2
+
+TEST_GROUP_IP4="225.1.2.3"
+TEST_GROUP_IP6="ff02::42"
+TEST_GROUP_MAC="01:00:01:c0:ff:ee"
+
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/24 2001:db8:1::1/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
+}
+
+switch_create()
+{
+	# Enable multicast filtering
+	ip link add dev br0 type bridge mcast_snooping 1
+
+	ip link set dev $swp1 master br0
+
+	ip link set dev br0 up
+	ip link set dev $swp1 up
+}
+
+switch_destroy()
+{
+	ip link set dev $swp1 down
+	ip link del dev br0
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	vrf_prepare
+
+	h1_create
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+do_mdb_add_del()
+{
+	local group=$1
+	local flag=$2
+
+	RET=0
+	bridge mdb add dev br0 port br0 grp $group $flag 2>/dev/null
+	check_err $? "Failed adding $group to br0, port br0"
+
+	if [ -z "$flag" ]; then
+	    flag="temp"
+	fi
+
+	bridge mdb show dev br0 | grep $group | grep -q $flag 2>/dev/null
+	check_err $? "$group not added with $flag flag"
+
+	bridge mdb del dev br0 port br0 grp $group 2>/dev/null
+	check_err $? "Failed deleting $group from br0, port br0"
+
+	bridge mdb show dev br0 | grep -q $group >/dev/null
+	check_err_fail 1 $? "$group still in mdb after delete"
+
+	log_test "MDB add/del group $group to bridge port br0"
+}
+
+mdb_add_del_test()
+{
+	do_mdb_add_del $TEST_GROUP_MAC permanent
+	do_mdb_add_del $TEST_GROUP_IP4
+	do_mdb_add_del $TEST_GROUP_IP6
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.25.1

