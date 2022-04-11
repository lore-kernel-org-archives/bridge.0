Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=nqbOmZU5eRZ/5dvOqIFsFAOGgG76eQOYLqqyaQWHdcQ=;
 b=FJuOlY+7YXJgldvEmB8NUIn16A6H3oodoYf/O+sUuMCNv8ISHnTbPIYP88j7Ybkiys
 ErbxqMwRfCUa+/4QMlylMI5wbAblbrBH33Jn8UWnIbFU/+HvyxT2ol9Z+BwxnY32smcT
 AqUIloFZGpxmxIpfvGBM0Gz9LRPixscaFWoFSgDvlyxdknyxmbukPahj+E4z3Z04ZWSa
 Oh6bRSagDGioRHJLaR958qKYeXJ2j3cDGkIifUwlYfeKEsACZlC2DTP/nmm//53Yq6N0
 GDvhC+OTS9nGt89g4bXEE2E0n1g6F420nJSk683TLxt6Yxunt+DcH6htuwHkiMp4/0Xy
 lwwA==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:34 +0200
Message-Id: <20220411133837.318876-11-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 10/13] selftests: forwarding: verify
	flooding of unknown multicast
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

This patch adds forwarding test to bridge_mdb.sh, using groups and group
names that make little sense right now.

Ensure flooding of unknown multicast works as intended after the initial
grace period when we don't know if we are the querier or if someone else
on the LAN is.  Hence the reduced timers.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 135 +++++++++++++++++-
 1 file changed, 131 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index c0b84b7d4364..6de98c59a620 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -3,22 +3,50 @@
 #
 # Verify that adding host mdb entries work as intended for all types of
 # multicast filters: ipv4, ipv6, and mac
+#
+# Verify forwarding (default flooding behavior) to all ports of unknown
+# multicast: MAC, IPv4, IPv6.
+#
+# Note: this test completely disables IPv6 auto-configuration to avoid
+#       any type of dynamic behavior outside of MLD and IGMP protocols.
+#       Static IPv6 addresses are used to ensure consistent behavior,
+#       even in the startup phase when multicast snooping is enabled.
+#
 
-ALL_TESTS="mdb_add_del_test"
-NUM_NETIFS=2
+ALL_TESTS="mdb_add_del_test mdb_compat_fwd_test"
+NUM_NETIFS=4
 
+SRC_PORT="1234"
+DST_PORT="4321"
+
+SRC_ADDR_IP4="1.2.3.4"
 PASS_GRP_IP4="225.1.2.3"
 FAIL_GRP_IP4="225.1.2.4"
 
+SRC_ADDR_MAC="00:de:ad:be:ef:00"
 PASS_GRP_MAC="01:00:01:c0:ff:ee"
 FAIL_GRP_MAC="01:00:01:c0:ff:ef"
 
+PASS_PKT_MAC="$PASS_GRP_MAC $SRC_ADDR_MAC 00:04 48:45:4c:4f"
+FAIL_PKT_MAC="$FAIL_GRP_MAC $SRC_ADDR_MAC 00:04 46:41:49:4c"
+
+PASS_PKT_IP4="01:00:5e:01:02:03 $SRC_ADDR_MAC 08:00 45:00 00:20 c2:10 00:00 ff 11 12:b2 01:02:03:04 e1:01:02:03 04:d2 10:e1 00:0c 6e:84 48:45:4c:4f"
+FAIL_PKT_IP4="01:00:5e:01:02:04 $SRC_ADDR_MAC 08:00 45:00 00:20 dc:e4 00:00 ff 11 f7:dc 01:02:03:04 e1:01:02:04 04:d2 10:e1 00:0c 73:8a 46:41:49:4c"
+
+SRC_ADDR_IP6="ff2e::42"
 PASS_GRP_IP6="ff02::42"
 FAIL_GRP_IP6="ff02::43"
 
+PASS_PKT_IP6="33 33 00 00 00 42 36 1e b4 04 cd e8 86 dd 60 00 01 01 00 08 11 ff ff 2e 00 00 00 00 00 00 00 00 00 00 00 00 00 42 ff 02 00 00 00 00 00 00 00 00 00 00 00 00 00 42 04 d2 10 e1 00 08 eb 75"
+FAIL_PKT_IP6="33 33 00 00 00 43 36 1e b4 04 cd e8 86 dd 60 00 01 01 00 08 11 ff ff 2e 00 00 00 00 00 00 00 00 00 00 00 00 00 42 ff 02 00 00 00 00 00 00 00 00 00 00 00 00 00 43 04 d2 10 e1 00 08 eb 74"
+
+# Disable promisc to ensure we only receive $TEST_GROUP*
+export TCPDUMP_EXTRA_FLAGS="-pl"
 
 source lib.sh
 
+require_command tcpdump
+
 h1_create()
 {
 	simple_if_init $h1 192.0.2.1/24 2001:db8:1::1/64
@@ -29,20 +57,51 @@ h1_destroy()
 	simple_if_fini $h1 192.0.2.1/24 2001:db8:1::1/64
 }
 
+h2_create()
+{
+	simple_if_init $h2 192.0.2.2/24 2001:db8:1::2/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 192.0.2.2/24 2001:db8:1::2/64
+}
+
 switch_create()
 {
-	# Enable multicast filtering
-	ip link add dev br0 type bridge mcast_snooping 1
+	# Enable multicast filtering w/ querier, reduce query response
+	# and startup interval to speed up test a bit.
+	ip link add dev br0 type bridge mcast_snooping 1 \
+	   mcast_startup_query_interval 400 mcast_query_response_interval 200
+
+	# Set static IPv6 address before we enable the multicast querier
+	# function.  This, along with disabling IPv6 address auto config
+	# (previously), ensures correct forwarding according to the MDB
+	# even when per-port flooding is disabled, *after* the initial
+	# startup phase when the bridge floods all multicast (according
+	# to its per-port mcast_flood settings.
+	ip addr add 2001:db8:1::42/64 dev br0
+	ip link set br0 type bridge mcast_querier 1
 
 	ip link set dev $swp1 master br0
+	ip link set dev $swp2 master br0
 
 	ip link set dev br0 up
 	ip link set dev $swp1 up
+	ip link set dev $swp2 up
+
+	# Initial delay, when bridge floods all mcast, is set to 200
+	# above (2 sec.)  We wait 3 sec to handle the case when a single
+	# strict fwd test is run directly after the initial setup, e.g.,
+	# TESTS=mdb_ip6_fwd_test
+	sleep 3
 }
 
 switch_destroy()
 {
+	ip link set dev $swp2 down
 	ip link set dev $swp1 down
+
 	ip link del dev br0
 }
 
@@ -51,9 +110,17 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	swp1=${NETIFS[p2]}
 
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	# Disable all IPv6 autoconfiguration during test, we want
+	# full control of when MLD queries start etc.
+	sysctl_set net.ipv6.conf.default.accept_ra 0
 	vrf_prepare
 
 	h1_create
+	h2_create
+
 	switch_create
 }
 
@@ -62,9 +129,12 @@ cleanup()
 	pre_cleanup
 
 	switch_destroy
+
+	h2_destroy
 	h1_destroy
 
 	vrf_cleanup
+	sysctl_restore net.ipv6.conf.default.accept_ra
 }
 
 do_mdb_add_del()
@@ -99,6 +169,63 @@ mdb_add_del_test()
 	do_mdb_add_del $PASS_GRP_IP6
 }
 
+do_compat_fwd()
+{
+	port=$1
+	RET=0
+
+	# Ensure default settings, regardless of test start order
+	bridge link set dev "$swp1" mcast_flood on
+	bridge link set dev "$swp2" mcast_flood on
+	bridge link set dev "br0"   mcast_flood on self
+
+	tcpdump_start "$port"
+
+	$MZ -q $h1 "$PASS_PKT_MAC"
+	$MZ -q $h1 "$FAIL_PKT_MAC"
+
+	$MZ -q $h1 "$PASS_PKT_IP4"
+	$MZ -q $h1 "$FAIL_PKT_IP4"
+
+	$MZ -q $h1 "$PASS_PKT_IP6"
+	$MZ -q $h1 "$FAIL_PKT_IP6"
+
+	sleep 1
+	tcpdump_stop "$port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_MAC} > ${PASS_GRP_MAC}"
+	check_err $? "Failed forwarding multicast group $PASS_GRP_MAC from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_MAC} > ${FAIL_GRP_MAC}"
+	check_err $? "Failed forwarding multicast group ${FAIL_GRP_MAC} from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_IP4}.${SRC_PORT} > ${PASS_GRP_IP4}.${DST_PORT}"
+	check_err $? "Failed forwarding multicast group $PASS_GRP_IP4 from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_IP4}.${SRC_PORT} > ${FAIL_GRP_IP4}.${DST_PORT}"
+	check_err $? "Failed forwarding multicast group ${FAIL_GRP_IP4} from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_IP6}.${SRC_PORT} > ${PASS_GRP_IP6}.${DST_PORT}"
+	check_err $? "Failed forwarding multicast group $PASS_GRP_IP6 from $h1 to port $port"
+
+	tcpdump_show "$port" |grep -q "${SRC_ADDR_IP6}.${SRC_PORT} > ${FAIL_GRP_IP6}.${DST_PORT}"
+	check_err $? "Failed forwarding multicast group ${FAIL_GRP_IP6} from $h1 to port $port"
+
+	log_test "MDB forward unknown MAC/IPv4/IPv6 multicast to port $port"
+	tcpdump_cleanup "$port"
+}
+
+#
+# Verify default behavior, unknown multicast is flooded, to both
+# regular bridge ports and the bridge itself (also a port).
+#
+mdb_compat_fwd_test()
+{
+	do_compat_fwd "$h2"
+	do_compat_fwd "br0"
+}
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.1

