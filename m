Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LpHznR+IRzgzH6in5jT7JKWaQCGzhh8Iu4vmSBYkhkE=;
 b=tcBSgeO6Y6En6bJnm5gjagFeSQzIw2tQJ55bKAjwjyblN3cms+MzI0JryX7VsHZ0ER
 DV9UwwGbFCmrrzXu8Vt9sEUiM7Ut8M5lbWHAXWs+QQF6RsiiD4gjJjrQDt3AohxNlVq0
 1PfbySXy8TZ2UnhLlXNnEruuk8Gea+RKHpgift8LJ2sBLowOCqm9lbe3R6WmeDAGlsJk
 4l0ByErFqMZliMwgtq53bgGPOmQf/1RkG+i0m09Hwsmy4uuRQYkAtzwzsedzq9qEr46T
 b1AKginq/caTTSUS7Hq0WOdY7oDypFT269EmLeniwce5xnbgtxMmFS9on43WqLh47GG3
 m2gQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:24:10 +0200
Message-Id: <20201103172412.1044840-15-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 14/16] selftests: net: bridge: add test
	for mldv2 exc -> block report
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

The test checks for the following case:
   Router State  Report Received  New Router State     Actions
   EXCLUDE (X,Y)   BLOCK (A)      EXCLUDE (X+(A-Y),Y)  (A-X-Y) =
                                                            Filter Timer
                                                       Send Q(MA,A-Y)

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mld.sh    | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index a3c405b2fd6f..c498e51b8d2b 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -3,7 +3,8 @@
 
 ALL_TESTS="mldv2include_test mldv2inc_allow_test mldv2inc_is_include_test mldv2inc_is_exclude_test \
 	   mldv2inc_to_exclude_test mldv2exc_allow_test mldv2exc_is_include_test \
-	   mldv2exc_is_exclude_test mldv2exc_to_exclude_test mldv2inc_block_test"
+	   mldv2exc_is_exclude_test mldv2exc_to_exclude_test mldv2inc_block_test \
+	   mldv2exc_block_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="ff02::cc"
@@ -444,6 +445,34 @@ mldv2inc_block_test()
 	mldv2cleanup $swp1
 }
 
+mldv2exc_block_test()
+{
+	RET=0
+	local X=("2001:db8:1::1" "2001:db8:1::2" "2001:db8:1::30")
+	local Y=("2001:db8:1::20" "2001:db8:1::21")
+
+	mldv2exclude_prepare $h1
+
+	ip link set dev br0 type bridge mcast_last_member_interval 500
+	check_err $? "Could not change mcast_last_member_interval to 5s"
+
+	$MZ $h1 -c 1 $MZPKT_BLOCK -q
+	sleep 1
+	brmcast_check_sg_entries "block" "${X[@]}" "${Y[@]}"
+
+	brmcast_check_sg_state 0 "${X[@]}"
+	brmcast_check_sg_state 1 "${Y[@]}"
+
+	brmcast_check_sg_fwding 1 "${X[@]}" 2001:db8:1::100
+	brmcast_check_sg_fwding 0 "${Y[@]}"
+
+	log_test "MLDv2 report $TEST_GROUP exclude -> block"
+
+	ip link set dev br0 type bridge mcast_last_member_interval 100
+
+	mldv2cleanup $swp1
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

