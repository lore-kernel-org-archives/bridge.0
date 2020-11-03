Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dNyIExP8c9yMd7IzGVWPAaLZGLs2zadG76onwKL9QZM=;
 b=TljOs6rbX9O++Nptjxew0JrB01mnJ8mehSMrWfPFF2baZNj6e5EAoxlu0LWJsTy3ao
 5F4T0rqsZYeUrcZT3hPGJrRMD3f8EqbpRSJgqQWx+7cWtPQWl7YKHJdX5WUYqiPCg/MM
 V2Y8W2x+nUb9rKhW/ghg0qCFxiV641INL6Mk0pwlagMUZjezYlPgb3LhMzlb/N43RA3t
 J5J9HKTwsyjiMvEugiOKd/pu2JFrhRvMcJKtV+2Ohx79eadzpbwstZ8Cs3lJ9EixG9p7
 7rIyBXIRGoKppp9a3R6vXzl6PtFSEytxeAw0T2iB5pOLIhylaZ+YcK7EWteoDikRLg0V
 YPOw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:23:58 +0200
Message-Id: <20201103172412.1044840-3-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 02/16] selftests: net: lib: add support
	for IPv6 mcast packet test
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

In order to test an IPv6 multicast packet we need to pass different tc
and mausezahn protocols only, so add a simple check for the destination
address which decides if we should generate an IPv4 or IPv6 mcast
packet.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index bb3ccc6d2165..0a427b8a039d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1280,14 +1280,22 @@ mcast_packet_test()
 	local host1_if=$4
 	local host2_if=$5
 	local seen=0
+	local tc_proto="ip"
+	local mz_v6arg=""
+
+	# basic check to see if we were passed an IPv4 address, if not assume IPv6
+	if [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
+		tc_proto="ipv6"
+		mz_v6arg="-6"
+	fi
 
 	# Add an ACL on `host2_if` which will tell us whether the packet
 	# was received by it or not.
 	tc qdisc add dev $host2_if ingress
-	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
+	tc filter add dev $host2_if ingress protocol $tc_proto pref 1 handle 101 \
 		flower ip_proto udp dst_mac $mac action drop
 
-	$MZ $host1_if -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
+	$MZ $host1_if $mz_v6arg -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
 	sleep 1
 
 	tc -j -s filter show dev $host2_if ingress \
@@ -1297,7 +1305,7 @@ mcast_packet_test()
 		seen=1
 	fi
 
-	tc filter del dev $host2_if ingress protocol ip pref 1 handle 101 flower
+	tc filter del dev $host2_if ingress protocol $tc_proto pref 1 handle 101 flower
 	tc qdisc del dev $host2_if ingress
 
 	return $seen
-- 
2.25.4

