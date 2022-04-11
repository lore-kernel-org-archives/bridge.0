Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=7+9AQPsj4qe+ej9vd9ZSEydjVfvWzHGKKHrVDnEiVdU=;
 b=QCrNRd94foqMNxVskGlMwCCfRXRjQeQ+pp6t1LBGrm9LEuIGq4N4GXTvyNQx4uEUBh
 ++f6ASOqDQLBns5t1I9IMVfxzR6IlWEZIBxk2DBCYDNGcHdL8vyzwCZz4q4YfpIoyC4T
 VZQKvlUgbx+I8b9kNSG2LhpqWaUYBRyHkWKvbeh1lltsD0OniLu8Ay/4e/2S/wAIJH52
 CHAaf8fTEqBgk8G76MuGXEHS/WUiYcZ0SKLtEAqXdZmov79e5faGdOsziIPbICPZ5zfi
 9T71AKcCSUNE8Dcg7JSOKdCjUQV8IStq7GGOVkNQ2z4KX+WjiWa2kQF1PNysKiFnVtvR
 B/PQ==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:30 +0200
Message-Id: <20220411133837.318876-7-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 06/13] selftests: forwarding: multiple
	instances in tcpdump helper
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

Extend tcpdump_start() & C:o to handle multiple instances.  Useful when
observing bridge operation, e.g., unicast learning/flooding, and any
case of multicast distribution (to these ports but not that one ...).

This means the interface argument is now a mandatory argument to all
tcpdump_*() functions, hence the changes to the ocelot flower test.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../drivers/net/ocelot/tc_flower_chains.sh    | 24 +++++++++---------
 tools/testing/selftests/net/forwarding/lib.sh | 25 +++++++++++++------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ocelot/tc_flower_chains.sh b/tools/testing/selftests/drivers/net/ocelot/tc_flower_chains.sh
index eaf8a04a7ca5..7e684e27a682 100755
--- a/tools/testing/selftests/drivers/net/ocelot/tc_flower_chains.sh
+++ b/tools/testing/selftests/drivers/net/ocelot/tc_flower_chains.sh
@@ -215,15 +215,15 @@ test_vlan_pop()
 
 	sleep 1
 
-	tcpdump_stop
+	tcpdump_stop $eth2
 
-	if tcpdump_show | grep -q "$eth3_mac > $eth2_mac, ethertype IPv4"; then
+	if tcpdump_show $eth2 | grep -q "$eth3_mac > $eth2_mac, ethertype IPv4"; then
 		echo "OK"
 	else
 		echo "FAIL"
 	fi
 
-	tcpdump_cleanup
+	tcpdump_cleanup $eth2
 }
 
 test_vlan_push()
@@ -236,15 +236,15 @@ test_vlan_push()
 
 	sleep 1
 
-	tcpdump_stop
+	tcpdump_stop $eth3.100
 
-	if tcpdump_show | grep -q "$eth2_mac > $eth3_mac"; then
+	if tcpdump_show $eth3.100 | grep -q "$eth2_mac > $eth3_mac"; then
 		echo "OK"
 	else
 		echo "FAIL"
 	fi
 
-	tcpdump_cleanup
+	tcpdump_cleanup $eth3.100
 }
 
 test_vlan_ingress_modify()
@@ -267,15 +267,15 @@ test_vlan_ingress_modify()
 
 	sleep 1
 
-	tcpdump_stop
+	tcpdump_stop $eth2
 
-	if tcpdump_show | grep -q "$eth3_mac > $eth2_mac, .* vlan 300"; then
+	if tcpdump_show $eth2 | grep -q "$eth3_mac > $eth2_mac, .* vlan 300"; then
 		echo "OK"
 	else
 		echo "FAIL"
 	fi
 
-	tcpdump_cleanup
+	tcpdump_cleanup $eth2
 
 	tc filter del dev $eth0 ingress chain $(IS1 2) pref 3
 
@@ -305,15 +305,15 @@ test_vlan_egress_modify()
 
 	sleep 1
 
-	tcpdump_stop
+	tcpdump_stop $eth2
 
-	if tcpdump_show | grep -q "$eth3_mac > $eth2_mac, .* vlan 300"; then
+	if tcpdump_show $eth2 | grep -q "$eth3_mac > $eth2_mac, .* vlan 300"; then
 		echo "OK"
 	else
 		echo "FAIL"
 	fi
 
-	tcpdump_cleanup
+	tcpdump_cleanup $eth2
 
 	tc filter del dev $eth1 egress chain $(ES0) pref 3
 	tc qdisc del dev $eth1 clsact
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 00cdcab7accf..20a6d6b2f389 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1349,13 +1349,17 @@ stop_traffic()
 	{ kill %% && wait %%; } 2>/dev/null
 }
 
+declare -A cappid
+declare -A capfile
+declare -A capout
+
 tcpdump_start()
 {
 	local if_name=$1; shift
 	local ns=$1; shift
 
-	capfile=$(mktemp)
-	capout=$(mktemp)
+	capfile[$if_name]=$(mktemp)
+	capout[$if_name]=$(mktemp)
 
 	if [ -z $ns ]; then
 		ns_cmd=""
@@ -1376,26 +1380,33 @@ tcpdump_start()
 	fi
 
 	$ns_cmd tcpdump $extra_flags -e -n -Q in -i $if_name \
-		-s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-	cappid=$!
+		-s 65535 -B 32768 $capuser -w ${capfile[$if_name]} > "${capout[$if_name]}" 2>&1 &
+	cappid[$if_name]=$!
 
 	sleep 1
 }
 
 tcpdump_stop()
 {
-	$ns_cmd kill $cappid
+	local if_name=$1
+	local pid=${cappid[$if_name]}
+
+	$ns_cmd kill "$pid" && wait "$pid"
 	sleep 1
 }
 
 tcpdump_cleanup()
 {
-	rm $capfile $capout
+	local if_name=$1
+
+	rm ${capfile[$if_name]} ${capout[$if_name]}
 }
 
 tcpdump_show()
 {
-	tcpdump -e -n -r $capfile 2>&1
+	local if_name=$1
+
+	tcpdump -e -n -r ${capfile[$if_name]} 2>&1
 }
 
 # return 0 if the packet wasn't seen on host2_if or 1 if it was
-- 
2.25.1

