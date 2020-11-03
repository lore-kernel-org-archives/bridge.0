Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gOOQHtOX6w4d/nnhTN7xuIIArAAXX7jfcR/5MZf9CcQ=;
 b=MVxyWoYMT/dNrrNoy0pKOM7oUG4gcNl0f7D/EXoZgrUK7eMdDa3wkQNasvjtRxHlju
 O0zIVwVyE4N+SRFeN9Lie40vPtXDqLSrNkhgiMEJz7kpPXDznc3xKDsUsJpuXlBsKpow
 0ROekGogck6G+AaLClyE6EvuBQmj+A3TRKn5BnL2j+SHENh+/qK2L9Bw3pB4jXj4bhjR
 qjmHX55W+6CDuvdDrO6/xWYQ8bJWor57vWQudWp45oDDX+mwGGxQGD4Yht0vN6XdfFEx
 +32xRLunOOkxHblgEfFzDsPhn35PIp65Na+TJTvtB4khw2BhPH3OFaD1NM8tJelXgFV1
 rFxg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:24:11 +0200
Message-Id: <20201103172412.1044840-16-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 15/16] selftests: net: bridge: add test
	for mldv2 exclude timeout
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

Test that when a group in exclude mode expires it changes mode to
include and the blocked entries are deleted.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mld.sh    | 48 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index c498e51b8d2b..b34cf4c6ceba 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="mldv2include_test mldv2inc_allow_test mldv2inc_is_include_test mldv2inc_is_exclude_test \
 	   mldv2inc_to_exclude_test mldv2exc_allow_test mldv2exc_is_include_test \
 	   mldv2exc_is_exclude_test mldv2exc_to_exclude_test mldv2inc_block_test \
-	   mldv2exc_block_test"
+	   mldv2exc_block_test mldv2exc_timeout_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="ff02::cc"
@@ -473,6 +473,52 @@ mldv2exc_block_test()
 	mldv2cleanup $swp1
 }
 
+mldv2exc_timeout_test()
+{
+	RET=0
+	local X=("2001:db8:1::20" "2001:db8:1::30")
+
+	# GMI should be 3 seconds
+	ip link set dev br0 type bridge mcast_query_interval 100 mcast_query_response_interval 100
+
+	mldv2exclude_prepare $h1
+	ip link set dev br0 type bridge mcast_query_interval 500 mcast_query_response_interval 500
+	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
+	sleep 3
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and .filter_mode == \"include\")" &>/dev/null
+	check_err $? "Wrong *,G entry filter mode"
+
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and
+				.source_list[].address == \"2001:db8:1::1\")" &>/dev/null
+	check_fail $? "Wrong *,G entry source list, 2001:db8:1::1 entry still exists"
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and \
+				.source_list != null and
+				.source_list[].address == \"2001:db8:1::2\")" &>/dev/null
+	check_fail $? "Wrong *,G entry source list, 2001:db8:1::2 entry still exists"
+
+	brmcast_check_sg_entries "allow" "${X[@]}"
+
+	brmcast_check_sg_state 0 "${X[@]}"
+
+	brmcast_check_sg_fwding 1 "${X[@]}"
+	brmcast_check_sg_fwding 0 2001:db8:1::100
+
+	log_test "MLDv2 group $TEST_GROUP exclude timeout"
+
+	ip link set dev br0 type bridge mcast_query_interval 12500 \
+					mcast_query_response_interval 1000
+
+	mldv2cleanup $swp1
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

