Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a8a/oVFoV9MTiz2akf3h4usj7NJQcCNmdh3b+TKbrQA=;
 b=P4jRtSivE3zFaJhLu81Q2XNew3IIJiT+Px3Whj9g1g8Gc7u3qcaobFj+YtwCNzgSSs
 bo8/7GN+l7b3fv3p3sWA2JZy8UXUxtly4N3B3zPvjQR1pdN/IVrQ1FeDuifm+bibZmge
 j/SvIb2kbVUtNsodCKc879jyO1WDZPwI/+7Jo4MkjSpcwzVFBujXq+tZl655OLydnq88
 OR/k0qUg3B/RDIvTRZyEA4zUbLE3exjfJh1yGXSXi753GzDTqdyAMNZzQGHpR5VIWkvh
 6F2C1sBxCrTzh022tfqYSSsKeSxdVQBHKJT8HwqC2s/KSMIhucdtCW3A8YwyoCntzkPy
 9YjQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:21 +0200
Message-Id: <20201027185934.227040-4-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 03/16] selftests: net: bridge: igmp: check
	for specific udp ip protocol
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

We have to specifically check for udp protocol in addition to the mac
address because in IGMPv3 tests group-specific queries will use the same
mac address.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 1c19459dbc58..5562aef14c0a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -93,7 +93,7 @@ mcast_packet_test()
 	# was received by it or not.
 	tc qdisc add dev $host2_if ingress
 	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
-		flower dst_mac $mac action drop
+		flower ip_proto udp dst_mac $mac action drop
 
 	$MZ $host1_if -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
 	sleep 1
-- 
2.25.4

