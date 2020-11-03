Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1i5q0YkqyzRPr4Kh/KGjP2SBAhGipIHGU89Hep2TGE0=;
 b=1e+O5yiBFEYPKp1Jd9+xgaLFeAjF+kkDWYgx4mFAh7dqU582fGfwPeIiFnvu79X4Mj
 9tJKUhZonsunlHvi0qIwvJrqXvSyFXsiuxj2uvPt2HKGKYEb0Yxi74jThztzQt8vIH6q
 HjJCrvW500Ue1me2PhW5EmePy53bAUVbMMZgsBPmSLJ9GOUaGgmTXbYdImnf4LlcaL0g
 q8e7RP+ryroHh2Yu6PK4REjdmjFkdHFiupaYoS0wMdp7B7l5hx+9FFbKA3QSiWuRbGJI
 7QZklcypiozBHFxIfbA6FkMfuaL7kV0MSw3H8mBsoW+OzH3bjPCttao0asgudyEZvJLH
 1Fkw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:24:05 +0200
Message-Id: <20201103172412.1044840-10-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 09/16] selftests: net: bridge: add test
	for mldv2 exc -> allow report
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
   EXCLUDE (X,Y)   ALLOW (A)      EXCLUDE (X+A,Y-A)    (A)=MALI

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mld.sh    | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index 571b01ef672c..97882c13f278 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="mldv2include_test mldv2inc_allow_test mldv2inc_is_include_test mldv2inc_is_exclude_test \
-	   mldv2inc_to_exclude_test"
+	   mldv2inc_to_exclude_test mldv2exc_allow_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="ff02::cc"
@@ -26,6 +26,11 @@ MZPKT_ALLOW="33:33:00:00:00:01:fe:54:00:04:5e:ba:86:dd:60:0a:2d:ae:00:54:00:01:f
 02:00:00:00:00:8f:00:8a:ac:00:00:00:01:05:00:00:03:ff:02:00:00:00:00:00:00:00:00:00:00:00:00:\
 00:cc:20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:10:20:01:0d:b8:00:01:00:00:00:00:00:00:00:\
 00:00:11:20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:12"
+# MLDv2 allow report: grp ff02::cc allow 2001:db8:1::20,2001:db8:1::30
+MZPKT_ALLOW2="33:33:00:00:00:01:fe:54:00:04:5e:ba:86:dd:60:0a:2d:ae:00:44:00:01:fe:80:00:00:00:\
+00:00:00:fc:54:00:ff:fe:04:5e:ba:ff:02:00:00:00:00:00:00:00:00:00:00:00:00:00:01:3a:00:05:02:00:\
+00:00:00:8f:00:b8:5a:00:00:00:01:05:00:00:02:ff:02:00:00:00:00:00:00:00:00:00:00:00:00:00:cc:20:\
+01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:20:20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:30"
 # MLDv2 is_ex report: grp ff02::cc is_exclude 2001:db8:1::1,2001:db8:1::2,2001:db8:1::20,2001:db8:1::21
 MZPKT_IS_EXC="33:33:00:00:00:01:fe:54:00:04:5e:ba:86:dd:60:0a:2d:ae:00:64:00:01:fe:80:00:00:00:\
 00:00:00:fc:54:00:ff:fe:04:5e:ba:ff:02:00:00:00:00:00:00:00:00:00:00:00:00:00:01:3a:00:05:02:00:\
@@ -296,6 +301,29 @@ mldv2inc_to_exclude_test()
 	mldv2cleanup $swp1
 }
 
+mldv2exc_allow_test()
+{
+	RET=0
+	local X=("2001:db8:1::1" "2001:db8:1::2" "2001:db8:1::20" "2001:db8:1::30")
+	local Y=("2001:db8:1::21")
+
+	mldv2exclude_prepare $h1
+
+	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
+	sleep 1
+	brmcast_check_sg_entries "allow" "${X[@]}" "${Y[@]}"
+
+	brmcast_check_sg_state 0 "${X[@]}"
+	brmcast_check_sg_state 1 "${Y[@]}"
+
+	brmcast_check_sg_fwding 1 "${X[@]}" 2001:db8:1::100
+	brmcast_check_sg_fwding 0 "${Y[@]}"
+
+	log_test "MLDv2 report $TEST_GROUP exclude -> allow"
+
+	mldv2cleanup $swp1
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

