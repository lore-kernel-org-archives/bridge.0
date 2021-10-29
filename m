Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yk7ObfgbV6bHLpvFk8W0bMRko++x+nG1d7mbf7ehRf8=;
 b=3hSVPH2QcGxHO8zd1Asn6yhjgFGMryxEE14djkGf1sXpAeqs/IBDMfyGQek8YEDkrA
 gSoIMnICeI5klOOesMYf1c9jZtkR5J5Ksq0OOhNAREATdGBxaJKjFhcfMVjwzi9fK5Ez
 N3gDfPBRW4ib0AmS5evFJWC60hp4nT3GJVZLZFOGgwRj9XvSv9vNmvuif0Qpkto2qm10
 COFk70ekyklBXjOUeJKuWtLyOGkyzBV98MUpoOv0xe1BPb4dM2SaTEi3nOs+wyxoVcRA
 6cEkoA4rvpfJ57rBtlvuEfSADQik+NigfZ9IU24Ci23Yk5Ot1ndXBUPGWfPKbGoqGbP9
 ER8w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 29 Oct 2021 15:05:27 +0300
Message-Id: <20211029120527.2716884-1-razor@blackwall.org>
In-Reply-To: <c09158a8-f94c-5e33-db31-59430501e631@nvidia.com>
References: <c09158a8-f94c-5e33-db31-59430501e631@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net v2] selftests: net: bridge: update IGMP/MLD
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
v2: set membership_interval in the same command and reset it back to
default after the test

 .../testing/selftests/net/forwarding/bridge_igmp.sh  | 12 +++++++++---
 tools/testing/selftests/net/forwarding/bridge_mld.sh | 12 +++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 675eff45b037..1162836f8f32 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -482,10 +482,15 @@ v3exc_timeout_test()
 	local X=("192.0.2.20" "192.0.2.30")
 
 	# GMI should be 3 seconds
-	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+	ip link set dev br0 type bridge mcast_query_interval 100 \
+					mcast_query_response_interval 100 \
+					mcast_membership_interval 300
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
-	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	ip link set dev br0 type bridge mcast_query_interval 500 \
+					mcast_query_response_interval 500 \
+					mcast_membership_interval 1500
+
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
 	sleep 3
 	bridge -j -d -s mdb show dev br0 \
@@ -517,7 +522,8 @@ v3exc_timeout_test()
 	log_test "IGMPv3 group $TEST_GROUP exclude timeout"
 
 	ip link set dev br0 type bridge mcast_query_interval 12500 \
-					mcast_query_response_interval 1000
+					mcast_query_response_interval 1000 \
+					mcast_membership_interval 26000
 
 	v3cleanup $swp1 $TEST_GROUP
 }
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index ffdcfa87ca2b..e2b9ff773c6b 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -479,10 +479,15 @@ mldv2exc_timeout_test()
 	local X=("2001:db8:1::20" "2001:db8:1::30")
 
 	# GMI should be 3 seconds
-	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+	ip link set dev br0 type bridge mcast_query_interval 100 \
+					mcast_query_response_interval 100 \
+					mcast_membership_interval 300
 
 	mldv2exclude_prepare $h1
-	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	ip link set dev br0 type bridge mcast_query_interval 500 \
+					mcast_query_response_interval 500 \
+					mcast_membership_interval 1500
+
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
 	sleep 3
 	bridge -j -d -s mdb show dev br0 \
@@ -514,7 +519,8 @@ mldv2exc_timeout_test()
 	log_test "MLDv2 group $TEST_GROUP exclude timeout"
 
 	ip link set dev br0 type bridge mcast_query_interval 12500 \
-					mcast_query_response_interval 1000
+					mcast_query_response_interval 1000 \
+					mcast_membership_interval 26000
 
 	mldv2cleanup $swp1
 }
-- 
2.31.1

