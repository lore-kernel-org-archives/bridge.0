Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=3ST1LQFgjHw1X814y3v8X3zhxYcmyjbfmqY6gmtBi2s=;
 b=PciXyWy7sfQT1Cb4pldae1jHis/zw+whQml4tbIBKpJw8zyvsdhehWOjQWWj2Pa8HH
 ySbrQ1fIKgOW4ooICblPfOFyNHLhltPna9lS9T3Zl0Ohb0kc+CP61NrTLeQSYW43sOzq
 VntJ72Nqw/MzMs3QU+JAsvXVPHT0Tn9GZCKsUpFIaQbO1vUG6MtfYo0DM9TYWP28FrID
 0vY4TVbk37yHL8CDZYdl4JCAfx8GTnAFT1pXN6AactT6T3BfKSAUVhxaP7IYMureoeFH
 I5cFCASnevu5YvytGHAx1VlAfxCf7/A+1Qu6m7VJ1/pvhq3cThMMo6CEh2fR0X2HYyd1
 qqrQ==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:35 +0200
Message-Id: <20220411133837.318876-12-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 11/13] selftests: forwarding: verify
	strict mdb fwd of known multicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

When mcast_flood is disabled forwarding of multicast should strictly
follow the mdb, and mcast_router ports, dedicated test added later.

This patch updates bridge_mdb.sh with MAC, IPv4 and IPv6 strict MDB
forwarding tests.  The bulk of the work is done by do_mdb_fwd(); one MC
packet to a known group is verified to reach its destination port, and
one MC packet to an unknown group is verified to not be forwarded.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 88 ++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 6de98c59a620..4e3bb950263f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -7,13 +7,16 @@
 # Verify forwarding (default flooding behavior) to all ports of unknown
 # multicast: MAC, IPv4, IPv6.
 #
+# Verify selective multicast forwarding (strict mdb), when bridge port
+# mcast_flood is disabled, of known MAC, IPv4, IPv6 traffic.
+#
 # Note: this test completely disables IPv6 auto-configuration to avoid
 #       any type of dynamic behavior outside of MLD and IGMP protocols.
 #       Static IPv6 addresses are used to ensure consistent behavior,
 #       even in the startup phase when multicast snooping is enabled.
 #
 
-ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test"
+ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test mdb_mac_fwd_test mdb_ip4_fwd_test mdb_ip6_fwd_test"
 NUM_NETIFS=4
 
 SRC_PORT="1234"
@@ -224,6 +227,89 @@ mdb_compat_fwd_test()
 	do_compat_fwd "$h2"
 	do_compat_fwd "br0"
 }
+
+do_mdb_fwd()
+{
+	type=$1
+	port=$2
+	swp=$port
+	src=$3
+	pass_grp=$4
+	fail_grp=$5
+	pass_pkt=$6
+	fail_pkt=$7
+	RET=0
+
+	if [ "$type" = "MAC" ]; then
+		flag="permanent"
+	else
+		flag=""
+		spt=".$SRC_PORT"
+		dpt=".$DST_PORT"
+	fi
+	if [ "$port" = "$h2" ]; then
+		swp=$swp2
+	fi
+
+	# Disable flooding of unknown multicast, strict MDB forwarding
+	bridge link set dev "$swp1" mcast_flood off
+	bridge link set dev "$swp2" mcast_flood off
+	bridge link set dev "br0"   mcast_flood off self
+
+	# Static filter only to this port
+	bridge mdb add dev br0 port "$swp" grp "$pass_grp" $flag
+	check_err $? "Failed adding $type multicast group $pass_grp to bridge port $swp"
+
+	tcpdump_start "$port"
+
+	# Real data we're expecting
+	$MZ -q "$h1" "$pass_pkt"
+	# This should not pass
+	$MZ -q "$h1" "$fail_pkt"
+
+	sleep 1
+	tcpdump_stop "$port"
+
+	tcpdump_show "$port" |grep -q "$src$spt > $pass_grp$dpt"
+	check_err $? "Failed forwarding $type multicast $pass_grp from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "$src$spt > $fail_grp$dpt"
+	check_err_fail 1 $? "Received $type multicast group $fail_grp from $h1 to port $port"
+
+	bridge mdb del dev br0 port "$swp" grp "$pass_grp"
+
+	log_test "MDB forward $type multicast to bridge port $port"
+	tcpdump_cleanup "$port"
+}
+
+#
+# Forwarding of known MAC multicast according to mdb, verify blocking
+# unknown MAC multicast (flood off)
+#
+mdb_mac_fwd_test()
+{
+	do_mdb_fwd MAC "br0" $SRC_ADDR_MAC $PASS_GRP_MAC $FAIL_GRP_MAC "$PASS_PKT_MAC" "$FAIL_PKT_MAC"
+	do_mdb_fwd MAC "$h2" $SRC_ADDR_MAC $PASS_GRP_MAC $FAIL_GRP_MAC "$PASS_PKT_MAC" "$FAIL_PKT_MAC"
+}
+
+#
+# Forwarding of known IPv4 UDP multicast according to mdb, verify
+# blocking unknown IPv4 UDP multicast (flood off)
+#
+mdb_ip4_fwd_test()
+{
+	do_mdb_fwd IPv4 br0 $SRC_ADDR_IP4 $PASS_GRP_IP4 $FAIL_GRP_IP4 "$PASS_PKT_IP4" "$FAIL_PKT_IP4"
+	do_mdb_fwd IPv4 $h2 $SRC_ADDR_IP4 $PASS_GRP_IP4 $FAIL_GRP_IP4 "$PASS_PKT_IP4" "$FAIL_PKT_IP4"
+}
+
+#
+# Forwarding of known IPv6 UDP multicast according to mdb, verify
+# blocking unknown IPv6 UDP multicast (flood off)
+#
+mdb_ip6_fwd_test()
+{
+	do_mdb_fwd IPv6 br0 $SRC_ADDR_IP6 $PASS_GRP_IP6 $FAIL_GRP_IP6 "$PASS_PKT_IP6" "$FAIL_PKT_IP6"
+	do_mdb_fwd IPv6 $h2 $SRC_ADDR_IP6 $PASS_GRP_IP6 $FAIL_GRP_IP6 "$PASS_PKT_IP6" "$FAIL_PKT_IP6"
 }
 
 trap cleanup EXIT
-- 
2.25.1

