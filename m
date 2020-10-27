Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eh7WAxMOPKXXzFs26VQMmI3KTTBmFoUGd5NShuFmYTI=;
 b=y044UhrUzUTQHrbOmghMxJAowA7TXmIo5m0dxTpVuGY6BerjGF90KmoVYELavc/tRo
 zR7ON80BmM2fNY3m+UvIMxRue0crw0AtRBP0tXW7b/pIAiYc4hrWmj4LoVifM4RD8n3w
 2pRRBVb8WwUvUsRf86eoZQAGdSPInowb+xCnFEX1BNxoAFSB/IDD1A6OuOuXVfIhAR3r
 goLXAVUKtP5LBjZtUaJmHcHM0e9T2FSu5a63xdNcNXos4oCb32r0WL9rB1gp/Ljdl8pF
 QYtY4EfHaPtMJ9khsNFAzfiecSeTMP1FQaD+3ck3b2vjQgkv8nrdPbHspMAFN0NhjUB/
 V1fg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:28 +0200
Message-Id: <20201027185934.227040-11-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 10/16] selftests: net: bridge: add test
	for igmpv3 exc -> is_include report
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
    state          report        result                  action
   EXCLUDE (X,Y)  IS_IN (A)     EXCLUDE (X+A,Y-A)       (A)=GMI

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index d786e75abe2c..b2b0f7d7e860 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="v2reportleave_test v3include_test v3inc_allow_test v3inc_is_include_test \
-	   v3inc_is_exclude_test v3inc_to_exclude_test v3exc_allow_test"
+	   v3inc_is_exclude_test v3inc_to_exclude_test v3exc_allow_test v3exc_is_include_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -15,6 +15,8 @@ ALL_MAC="01:00:5e:00:00:01"
 MZPKT_IS_INC="22:00:9d:de:00:00:00:01:01:00:00:03:ef:0a:0a:0a:c0:00:02:01:c0:00:02:02:c0:00:02:03"
 # IGMPv3 is_in report: grp 239.10.10.10 is_include 192.0.2.10,192.0.2.11,192.0.2.12
 MZPKT_IS_INC2="22:00:9d:c3:00:00:00:01:01:00:00:03:ef:0a:0a:0a:c0:00:02:0a:c0:00:02:0b:c0:00:02:0c"
+# IGMPv3 is_in report: grp 239.10.10.10 is_include 192.0.2.20,192.0.2.30
+MZPKT_IS_INC3="22:00:5f:b4:00:00:00:01:01:00:00:02:ef:0a:0a:0a:c0:00:02:14:c0:00:02:1e"
 # IGMPv3 allow report: grp 239.10.10.10 allow 192.0.2.10,192.0.2.11,192.0.2.12
 MZPKT_ALLOW="22:00:99:c3:00:00:00:01:05:00:00:03:ef:0a:0a:0a:c0:00:02:0a:c0:00:02:0b:c0:00:02:0c"
 # IGMPv3 allow report: grp 239.10.10.10 allow 192.0.2.20,192.0.2.30
@@ -436,6 +438,29 @@ v3exc_allow_test()
 	v3cleanup $swp1 $TEST_GROUP
 }
 
+v3exc_is_include_test()
+{
+	RET=0
+	local X=("192.0.2.1" "192.0.2.2" "192.0.2.20" "192.0.2.30")
+	local Y=("192.0.2.21")
+
+	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
+
+	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC3" -q
+	sleep 1
+	check_sg_entries "is_include" "${X[@]}" "${Y[@]}"
+
+	check_sg_state 0 "${X[@]}"
+	check_sg_state 1 "${Y[@]}"
+
+	check_sg_fwding 1 "${X[@]}" 192.0.2.100
+	check_sg_fwding 0 "${Y[@]}"
+
+	log_test "IGMPv3 report $TEST_GROUP exclude -> is_include"
+
+	v3cleanup $swp1 $TEST_GROUP
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

