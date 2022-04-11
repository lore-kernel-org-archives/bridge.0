Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=q+s8pq7+mxXhYAN0HYAAMlwmmRXM/+hxH/iXox3zYsM=;
 b=gdo0pS8M3mZcu6zMtF4X72sjJJqTcx5UQwbKFqReNhLgiXxnh2ISjb2yBJVIMrlQIa
 DSQmq4HxJNFezf/5uWJTQpnjWBRLOoZryE1tpiydETCDQFoDwZTh1Dq4cchaP9qYnbvd
 /GM7Y2vcPZ2pQggoBLHKuImTqcscnNPRjHYTawbAe9ndgi5nnl2oMnZh2nto5LqbJPAN
 46Gq00yyVLTLl1EehcDBJfV0zyQ0I8gIx1Ci9zNw8WMay9Mp25jHUF6ClIzRZodbCQ+G
 NuW19d2pkOyNDN3niO9heQrfNeTX54+tGnrtxEp7bruLXtvEEzaoEVqCTrjabKnpN3eY
 2Kug==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:36 +0200
Message-Id: <20220411133837.318876-13-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 12/13] selftests: forwarding: verify
	strict filtering doesn't leak
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

Add a another veth pair to get a dedicated canary port.  This to help us
verify that multicast is received by only a subset of the ports in the
MDB filter.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 4e3bb950263f..137bc79fd677 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -17,7 +17,7 @@
 #
 
 ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test mdb_mac_fwd_test mdb_ip4_fwd_test mdb_ip6_fwd_test"
-NUM_NETIFS=4
+NUM_NETIFS=6
 
 SRC_PORT="1234"
 DST_PORT="4321"
@@ -70,6 +70,16 @@ h2_destroy()
 	simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
 }
 
+h3_create()
+{
+	simple_if_init $h3 192.0.2.3/24 2001:db8:1::3/64
+}
+
+h3_destroy()
+{
+	simple_if_fini $h3 192.0.2.3/24 2001:db8:1::3/64
+}
+
 switch_create()
 {
 	# Enable multicast filtering w/ querier, reduce query response
@@ -88,10 +98,12 @@ switch_create()
 
 	ip link set dev $swp1 master br0
 	ip link set dev $swp2 master br0
+	ip link set dev $swp3 master br0
 
 	ip link set dev br0 up
 	ip link set dev $swp1 up
 	ip link set dev $swp2 up
+	ip link set dev $swp3 up
 
 	# Initial delay, when bridge floods all mcast, is set to 200
 	# above (2 sec.)  We wait 3 sec to handle the case when a single
@@ -102,6 +114,7 @@ switch_create()
 
 switch_destroy()
 {
+	ip link set dev $swp3 down
 	ip link set dev $swp2 down
 	ip link set dev $swp1 down
 
@@ -116,6 +129,9 @@ setup_prepare()
 	swp2=${NETIFS[p3]}
 	h2=${NETIFS[p4]}
 
+	swp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
 	# Disable all IPv6 autoconfiguration during test, we want
 	# full control of when MLD queries start etc.
 	sysctl_set net.ipv6.conf.default.accept_ra 0
@@ -123,6 +139,7 @@ setup_prepare()
 
 	h1_create
 	h2_create
+	h3_create
 
 	switch_create
 }
@@ -133,6 +150,7 @@ cleanup()
 
 	switch_destroy
 
+	h3_destroy
 	h2_destroy
 	h1_destroy
 
@@ -249,11 +267,15 @@ do_mdb_fwd()
 	fi
 	if [ "$port" = "$h2" ]; then
 		swp=$swp2
+		nop="$h3"
+	else
+		nop="$h2"
 	fi
 
 	# Disable flooding of unknown multicast, strict MDB forwarding
 	bridge link set dev "$swp1" mcast_flood off
 	bridge link set dev "$swp2" mcast_flood off
+	bridge link set dev "$swp3" mcast_flood off
 	bridge link set dev "br0"   mcast_flood off self
 
 	# Static filter only to this port
@@ -261,6 +283,7 @@ do_mdb_fwd()
 	check_err $? "Failed adding $type multicast group $pass_grp to bridge port $swp"
 
 	tcpdump_start "$port"
+	tcpdump_start "$nop"
 
 	# Real data we're expecting
 	$MZ -q "$h1" "$pass_pkt"
@@ -268,6 +291,7 @@ do_mdb_fwd()
 	$MZ -q "$h1" "$fail_pkt"
 
 	sleep 1
+	tcpdump_stop "$nop"
 	tcpdump_stop "$port"
 
 	tcpdump_show "$port" |grep -q "$src$spt > $pass_grp$dpt"
@@ -276,6 +300,12 @@ do_mdb_fwd()
 	tcpdump_show "$port" |grep -q "$src$spt > $fail_grp$dpt"
 	check_err_fail 1 $? "Received $type multicast group $fail_grp from $h1 to port $port"
 
+	# Verify we don't get multicast to the canary port
+	tcpdump_show "$nop" |grep -q "$src$spt > $pass_grp$dpt"
+	check_err_fail 1 $? "Received $type multicast group $pass_grp from $h1 to port $nop"
+	tcpdump_show "$nop" |grep -q "$src$spt > $fail_grp$dpt"
+	check_err_fail 1 $? "Received $type multicast group $fail_grp from $h1 to port $nop"
+
 	bridge mdb del dev br0 port "$swp" grp "$pass_grp"
 
 	log_test "MDB forward $type multicast to bridge port $port"
-- 
2.25.1

