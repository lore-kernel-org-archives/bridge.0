Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AidZspGMGx6iPf3sywvvgbABtuj5XaTANuRL7olyHPs=;
	b=hZBO3jd2BUF1dS1m14xYyVxwBXb6xxjK2+t5eWX5PQCD7dUoPdtBMwV3IOWQ0UvIWg
	UTMTUd3fhy7m/kal3UiJNZIVUPKC2FcAqZ/QpB1hYNz+68FucXsiTq6SX+YDp2G5Ar61
	1wGKOh/JmliWPDq60yyWQTvRt9OAKZdS15z2p5E4gsmT3RegAqvvz1sHY5vc1WmowJj/
	JGLu35vJj5lfKdQ9ujj6W/5z0zODS+BV9Hhnh6zaFNc53yn+1Hzo4tPQLEkkXWFho3Dw
	MjwDW4HnVjpAk8RJAaDUeppVGekvqL62buOhPQzgaF5s5Bs2KQj/IJQub5loOt5TdnCt
	CrUQ==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
Date: Mon,  2 Sep 2019 20:10:00 +0200
Message-Id: <20190902181000.25638-2-zahari.doychev@linux.com>
In-Reply-To: <20190902181000.25638-1-zahari.doychev@linux.com>
References: <20190902181000.25638-1-zahari.doychev@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 2/2] selftests: forwrading: tc vlan bridge test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: makita.toshiaki@lab.ntt.co.jp, jiri@resnulli.us, nikolay@cumulusnetworks.com, simon.horman@netronome.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Zahari Doychev <zahari.doychev@linux.com>, jhs@mojatatu.com, dsahern@gmail.com, xiyou.wangcong@gmail.com, johannes@sipsolutions.net, alexei.starovoitov@gmail.com

Add bridge vlan aware forwarding test for vlans added by tc-act_vlan. The
forwarding is tested in two cases when the bridge protocol and outer vlan
tag protocol match and mismatch. The tests checks the correct usage of
skb->mac_len in the bridge code.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>

---
v2->v3:
 - selftest added
---
 .../forwarding/bridge_vlan_aware_tc_vlan.sh   | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_vlan_aware_tc_vlan.sh

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware_tc_vlan.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware_tc_vlan.sh
new file mode 100755
index 000000000000..215d6293fa54
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware_tc_vlan.sh
@@ -0,0 +1,187 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test uses the standard topology for testing bridge forwarding. See
+# README for more details.
+#
+# tc vlan actions are applied on one of the bridge ports and on other one
+# the corresponding vlan network devices are created.
+#
+
+ALL_TESTS="
+	test_tc_vlan_bridge_ipv4_forwarding
+	test_tc_vlan_bridge_ipv4_forwarding_proto
+	test_tc_vlan_bridge_ipv6_forwarding
+	test_tc_vlan_bridge_ipv6_forwarding_proto
+"
+
+NUM_NETIFS=4
+CHECK_TC="yes"
+source lib.sh
+
+h_create()
+{
+	local dev=$1; shift
+	local ip=$1; shift
+	local ip6=$1
+
+	simple_if_init $dev $ip $ip6
+}
+
+h_destroy()
+{
+	local dev=$1; shift
+	local ip=$1; shift
+	local ip6=$1
+
+	simple_if_fini $dev $ip $ip6
+}
+
+switch_create()
+{
+	ip link add dev br0 type bridge vlan_filtering 1 vlan_protocol 802.1q \
+		mcast_snooping 0
+
+	ip link set dev $swp1 master br0
+	ip link set dev $swp2 master br0
+
+	ip link set dev br0 up
+	ip link set dev $swp1 up
+	ip link set dev $swp2 up
+
+	bridge vlan add dev $swp1 vid $svid master
+	bridge vlan add dev br0 vid $svid self
+	bridge vlan add dev $swp2 vid $svid master
+}
+
+switch_destroy()
+{
+	ip link set dev $swp2 down
+	ip link set dev $swp1 down
+
+	ip link del dev br0
+}
+
+tc_vlan_create()
+{
+	tc qdisc add dev $swp1 clsact
+
+	tc filter add dev $swp1 ingress pref 1 protocol all flower skip_hw \
+		action vlan push id $cvid protocol 802.1q pipe \
+		action vlan push id $svid protocol 802.1q
+
+	tc filter add dev $swp1 egress pref 1 protocol 802.1q \
+		flower skip_hw vlan_id $svid \
+		vlan_ethtype 802.1q cvlan_id $cvid \
+		action vlan pop pipe action vlan pop
+}
+
+tc_vlan_destroy()
+{
+	tc filter del dev $swp1 ingress pref 1
+	tc filter del dev $swp1 egress pref 1
+	tc qdisc del dev $swp1 clsact
+}
+
+vlan_create()
+{
+	local dev=$1; shift
+	local vid=$1; shift
+	local tpid=$1;
+
+	ip link add link $dev name $dev.$vid type vlan id $vid proto $tpid
+	ip link set dev $dev up
+	ip link set dev $dev.$vid
+}
+
+vlan_destroy()
+{
+	local dev=$1
+
+	ip link del dev $dev
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	cvid=10
+	svid=100
+
+	vrf_prepare
+
+	switch_create
+
+	tc_vlan_create
+
+	h_create $h1 192.0.2.1/24 2001:db8:1::1/64
+
+	vlan_create $h2 $svid 802.1q
+	vlan_create $h2.$svid $cvid 802.1q
+
+	h_create $h2.$svid.$cvid 192.0.2.2/24 2001:db8:1::2/64
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	tc_vlan_destroy
+
+	switch_destroy
+
+	h_destroy $h1 192.0.2.1/24 2001:db8:1::1/64
+	h_destroy $h2.$svid.$cvid 192.0.2.2/24 2001:db8:1::2/64
+
+	vlan_destroy $h2.$svid.$cvid
+	vlan_destroy $h2.$svid
+
+	ip link del dev $h1
+	ip link del dev $h2
+
+	vrf_cleanup
+}
+
+test_tc_vlan_bridge_ipv4_forwarding()
+{
+	ip link set dev br0 type bridge vlan_protocol 802.1q
+	ping_do $h1 192.0.2.2
+	check_err $? "Packets were not forwarded"
+	log_test "IPv4 tc-vlan bridge forwarding"
+}
+
+test_tc_vlan_bridge_ipv4_forwarding_proto()
+{
+	ip link set dev br0 type bridge vlan_protocol 802.1ad
+	ping_do $h1 192.0.2.2
+	check_err $? "Packets were not forwarded"
+	log_test "IPv4 tc-vlan bridge forwarding protocol mismatch"
+}
+
+test_tc_vlan_bridge_ipv6_forwarding()
+{
+	ip link set dev br0 type bridge vlan_protocol 802.1q
+	ping6_do $h1 2001:db8:1::2
+	check_err $? "Packets were not forwarded"
+	log_test "IPv6 tc-vlan bridge forwarding"
+}
+
+test_tc_vlan_bridge_ipv6_forwarding_proto()
+{
+	ip link set dev br0 type bridge vlan_protocol 802.1ad
+	ping6_do $h1  2001:db8:1::2
+	check_err $? "Packet were not forwarded"
+	log_test "IPv6 tc-vlan bridge forwarding protocol mismatch"
+}
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.22.0

