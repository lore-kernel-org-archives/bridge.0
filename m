Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xBm95jl2xW7HhQ7hwk4jZB0S0Y7wQfebO/eBHZqjNWo=;
 b=MqzUiWrQhY5xpB2YoBUurz8HpgeL4rD0U/WPxFKSRrv83ZBc6jSVrCVdx8rk/Pq3CS
 I8jdO2PTuajjv7UegAo7D6AnccQFOkWAOSDQ+SiLDG4OTFynJhx9izQO2/nbr1dQQBxE
 3yoq7NqaeFfhln1CNJOI067Zqmcpd0Vy8xWAtJ0jGRx/BywDQHiGY1jnPA1cfSpUaV7m
 USgfyueHQ64pmPimxsOsz9h9IQYUzAOGDKAdXg+78ZOkiz++2HeXCnpf0C9Bb5z/Kleb
 lfYzoLM8Wk3DAGSHOTUjMsEumGKT7h5t7r4GuBb8e30w0K4wUi78bmE6r9QASRUP5L+L
 kvpg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:23:57 +0200
Message-Id: <20201103172412.1044840-2-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 01/16] selftests: net: bridge: factor out
	mcast_packet_test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Factor out mcast_packet_test into lib.sh so it can be later extended and
reused by MLDv2 tests.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 32 -------------------
 tools/testing/selftests/net/forwarding/lib.sh | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 0e71abdd7a03..50a48ce16ba1 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -105,38 +105,6 @@ cleanup()
 	vrf_cleanup
 }
 
-# return 0 if the packet wasn't seen on host2_if or 1 if it was
-mcast_packet_test()
-{
-	local mac=$1
-	local src_ip=$2
-	local ip=$3
-	local host1_if=$4
-	local host2_if=$5
-	local seen=0
-
-	# Add an ACL on `host2_if` which will tell us whether the packet
-	# was received by it or not.
-	tc qdisc add dev $host2_if ingress
-	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
-		flower ip_proto udp dst_mac $mac action drop
-
-	$MZ $host1_if -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
-	sleep 1
-
-	tc -j -s filter show dev $host2_if ingress \
-		| jq -e ".[] | select(.options.handle == 101) \
-		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
-	if [[ $? -eq 0 ]]; then
-		seen=1
-	fi
-
-	tc filter del dev $host2_if ingress protocol ip pref 1 handle 101 flower
-	tc qdisc del dev $host2_if ingress
-
-	return $seen
-}
-
 v2reportleave_test()
 {
 	RET=0
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 927f9ba49e08..bb3ccc6d2165 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1270,3 +1270,35 @@ tcpdump_show()
 {
 	tcpdump -e -n -r $capfile 2>&1
 }
+
+# return 0 if the packet wasn't seen on host2_if or 1 if it was
+mcast_packet_test()
+{
+	local mac=$1
+	local src_ip=$2
+	local ip=$3
+	local host1_if=$4
+	local host2_if=$5
+	local seen=0
+
+	# Add an ACL on `host2_if` which will tell us whether the packet
+	# was received by it or not.
+	tc qdisc add dev $host2_if ingress
+	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
+		flower ip_proto udp dst_mac $mac action drop
+
+	$MZ $host1_if -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
+	sleep 1
+
+	tc -j -s filter show dev $host2_if ingress \
+		| jq -e ".[] | select(.options.handle == 101) \
+		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
+	if [[ $? -eq 0 ]]; then
+		seen=1
+	fi
+
+	tc filter del dev $host2_if ingress protocol ip pref 1 handle 101 flower
+	tc qdisc del dev $host2_if ingress
+
+	return $seen
+}
-- 
2.25.4

