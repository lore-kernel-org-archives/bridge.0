Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=50MJkKhlS1J2AvfKZSt0Jb7+m5hEUpZE6Hebck0fg/A=;
 b=JXCw9oiD2WnF+/dOWbCKR30QwHOFYeeIGFnoSQa3rk8zCXJGF9WjRf21JEaJS7JlFW
 oJYl9mRBvdtaftLg5HYDs6a1KOlfipXmEgYHv64nyqOgOdKBy5dw93enKmSLyOTC8vDJ
 W/UW3b6tEh2yZBB1eEDy309N1pFBTEJEpmWVM2F45VroybbBgx/7sQzUz5QgrIDKfitW
 cMnHAf+Q4TDrbb1nkoIJQXMsvEtII4Ikv0y/qk+3qrMBfUp2W8kEQjfFaQdohb1DjTE1
 sqAvuH9qb9id5HA7h3y0VaR/F/YMRqh2KrrJV6qs859EreZyHh+T2yEXN41++YTzd4wl
 zeKQ==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:37 +0200
Message-Id: <20220411133837.318876-14-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 13/13] selftests: forwarding: verify
	flood of known mc on mcast_router port
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

This test verifies that both known (in mdb) and unknown IP multicast is
forwarded to a mcast_router port.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 137bc79fd677..3fd7d68bca09 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -10,13 +10,16 @@
 # Verify selective multicast forwarding (strict mdb), when bridge port
 # mcast_flood is disabled, of known MAC, IPv4, IPv6 traffic.
 #
+# Verify flooding towards mcast_router ports of known IP multicast.
+#
 # Note: this test completely disables IPv6 auto-configuration to avoid
 #       any type of dynamic behavior outside of MLD and IGMP protocols.
 #       Static IPv6 addresses are used to ensure consistent behavior,
 #       even in the startup phase when multicast snooping is enabled.
 #
 
-ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test mdb_mac_fwd_test mdb_ip4_fwd_test mdb_ip6_fwd_test"
+ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test mdb_rport_fwd_test \
+	   mdb_mac_fwd_test mdb_ip4_fwd_test mdb_ip6_fwd_test"
 NUM_NETIFS=6
 
 SRC_PORT="1234"
@@ -246,6 +249,55 @@ mdb_compat_fwd_test()
 	do_compat_fwd "br0"
 }
 
+#
+# Verify fwd of IP multicast to router ports.  A detected multicast
+# router should always receive both known and unknown multicast.
+#
+mdb_rport_fwd_test()
+{
+	pass_grp=$PASS_GRP_IP4
+	fail_grp=$FAIL_GRP_IP4
+	pass_pkt=$PASS_PKT_IP4
+	fail_pkt=$FAIL_PKT_IP4
+	decoy="br0"
+	port=$h1
+	type="IPv4"
+
+	# Disable flooding of unknown multicast, strict MDB forwarding
+	bridge link set dev "$swp1" mcast_flood off
+	bridge link set dev "$swp2" mcast_flood off
+	bridge link set dev "br0"   mcast_flood off self
+
+	# Let h2 act as a multicast router
+	ip link set dev "$swp1" type bridge_slave mcast_router 2
+
+	# Static filter only to this decoy port
+	bridge mdb add dev br0 port $decoy grp "$pass_grp"
+	check_err $? "Failed adding multicast group $pass_grp to bridge port $decoy"
+
+	tcpdump_start "$port"
+
+	# Real data we're expecting
+	$MZ -q "$h2" "$pass_pkt"
+	# This should not pass
+	$MZ -q "$h2" "$fail_pkt"
+
+	sleep 1
+	tcpdump_stop "$port"
+
+	tcpdump_show "$port" |grep -q "$src$spt > $pass_grp$dpt"
+	check_err $? "Failed forwarding $type multicast $pass_grp from $h2 to port $port"
+
+	tcpdump_show "$port" |grep -q "$src$spt > $fail_grp$dpt"
+	check_err $? "Failed forwarding $type multicast $fail_grp from $h2 to port $port"
+
+	bridge mdb del dev br0 port br0 grp "$pass_grp"
+	ip link set dev "$swp1" type bridge_slave mcast_router 1
+
+	log_test "MDB forward all $type multicast to multicast router on $port"
+	tcpdump_cleanup "$port"
+}
+
 do_mdb_fwd()
 {
 	type=$1
-- 
2.25.1

