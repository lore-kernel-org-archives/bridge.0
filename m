Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HWwH1mzK26OWStIyr7YQx947cp92x7ujWn8BN7kPbwM=;
 b=OpuUHStqMculoVADiWHShDs8jkbf6mK4yTc4KiX2t5Tru35iyhx3OjPGf4omufYeJq
 48Vha9bTSNQ45A6ZbF97QFusOaeyQ5pzXRWZ0Xnbulxx8HIoCbsX9e6GC98u7nLDLkyy
 NtvzKZEc9WEvGEPNL3D3/TOah2z7SRiLsW91bmPgqDzy9zgi3oJS7GOqPZZH1da+rwo1
 SJtGDzjkc/ZB9nABYEHVPuzazu7Xz+qwytjWc3VetNZjerP0G/QiiUDKHWNEomjhWJzZ
 etO5OfBG4tyTCvLJy5cm6N/nNGlzoKyqshPzi52Nxo4nEr9ma8U0UGgAnm493MKwl3gC
 Bb7Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:34 +0200
Message-Id: <20201027185934.227040-17-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 16/16] selftests: net: bridge: add test
	for igmpv3 *, g auto-add
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

When we have *,G ports in exclude mode and a new S,G,port is added
the kernel has to automatically create an S,G entry for each exclude
port to get proper forwarding.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index db0a03e30868..0e71abdd7a03 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="v2reportleave_test v3include_test v3inc_allow_test v3inc_is_include_test \
 	   v3inc_is_exclude_test v3inc_to_exclude_test v3exc_allow_test v3exc_is_include_test \
 	   v3exc_is_exclude_test v3exc_to_exclude_test v3inc_block_test v3exc_block_test \
-	   v3exc_timeout_test"
+	   v3exc_timeout_test v3star_ex_auto_add_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -621,6 +621,35 @@ v3exc_timeout_test()
 	v3cleanup $swp1 $TEST_GROUP
 }
 
+v3star_ex_auto_add_test()
+{
+	RET=0
+
+	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
+
+	$MZ $h2 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_IS_INC" -q
+	sleep 1
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and .src == \"192.0.2.3\" and \
+				.port == \"$swp1\")" &>/dev/null
+	check_err $? "S,G entry for *,G port doesn't exist"
+
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and .src == \"192.0.2.3\" and \
+				.port == \"$swp1\" and \
+				.flags[] == \"added_by_star_ex\")" &>/dev/null
+	check_err $? "Auto-added S,G entry doesn't have added_by_star_ex flag"
+
+	check_sg_fwding 1 192.0.2.3
+
+	log_test "IGMPv3 S,G port entry automatic add to a *,G port"
+
+	v3cleanup $swp1 $TEST_GROUP
+	v3cleanup $swp2 $TEST_GROUP
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

