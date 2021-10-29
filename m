Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b3qSGM0p6y4ZgfnoAyiZzzlY57n4MzHUR7ioYeiIdMs=;
 b=HR/oSlud9C/7XG9RmGUmGigozqBYikJPozqCKVTuoaq6kIWCJw2MFOpbB3ssr/CRNk
 WAGbgtsjODRJXLZPoQpy901q8DIa+vjwrw7CQTzFZOWybWWfWoCep1/BLCwFHnf+aXi2
 LWMGfcjinxI/mS7ORW78vIgo+Opma2ED2kqI+8fDe43NnELBAvzxuoK8gvcv6Y8efMSy
 FML03VWSWDG0YEoGLLfBbSsmCcDgGlXSbHKqScpet+/ucvFXA12KeZoEN773cPor44Jj
 /untbboy1Ora7/FEphwWqs8Gs00/xq1x2UtzQonFsyZtY8TDl6FdVtgwPeh+ZCAR08Pd
 M7Aw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 29 Oct 2021 13:53:43 +0300
Message-Id: <20211029105343.2705436-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] selftests: net: bridge: update IGMP/MLD
	membership interval value
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When I fixed IGMPv3/MLDv2 to use the bridge's multicast_membership_interval
value which is chosen by user-space instead of calculating it based on
multicast_query_interval and multicast_query_response_interval I forgot
to update the selftests relying on that behaviour. Now we have to
manually set the expected GMI value to perform the tests correctly and get
proper results (similar to IGMPv2 behaviour).

Fixes: fac3cb82a54a ("net: bridge: mcast: use multicast_membership_interval for IGMPv3")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 3 +++
 tools/testing/selftests/net/forwarding/bridge_mld.sh  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 675eff45b037..da031892ffd2 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -483,9 +483,12 @@ v3exc_timeout_test()
 
 	# GMI should be 3 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+	ip link set dev br0 type bridge mcast_membership_interval 300
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	ip link set dev br0 type bridge mcast_membership_interval 1500
+
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
 	sleep 3
 	bridge -j -d -s mdb show dev br0 \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index ffdcfa87ca2b..96fdaa84606f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -480,9 +480,12 @@ mldv2exc_timeout_test()
 
 	# GMI should be 3 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+	ip link set dev br0 type bridge mcast_membership_interval 300
 
 	mldv2exclude_prepare $h1
 	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	ip link set dev br0 type bridge mcast_membership_interval 1500
+
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
 	sleep 3
 	bridge -j -d -s mdb show dev br0 \
-- 
2.31.1

