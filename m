Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qug/l2PaHPdn5nmmo5MAN4jJnMHDysyaTDj3MD0cWk8=;
 b=yAQv4R8rgsLyHmAPm5o97IiojoAcx5+7ufwQVOSCinvt1RK0kxjCmtYzdoTwaAxiou
 H6764HMhlANaqp75yBugcbRLxBenWlYjL1RNs/AsO3qN6EG2Gnqi4Jh4ZRD+RhtCFIe3
 m7WKVivxJCNzzQkJkhyQqAnbbjUHQgmf9KyG+lIcXEjB6Qh+6uUZMHNiUX82WdN1oQRB
 Bl37O8AaW0AjdVaylhO0oyAylaFTbNwLNhz6BGZVQA92XSxulTg/eQTyCoXxSC/uLQZ2
 aFtorS94NL2uFpOTsjL6rSA15nxmKDWko6YzsdR3uE10HG+zWjn4a3gg3Dnky701E9Fh
 cuMA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:19 +0200
Message-Id: <20201027185934.227040-2-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 01/16] selftests: net: bridge: rename
	current igmp tests to igmpv2
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

To prepare the bridge_igmp.sh for IGMPv3 we need to rename the
current test to IGMPv2.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 88d2472ba151..481198300b72 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="reportleave_test"
+ALL_TESTS="v2reportleave_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -110,7 +110,7 @@ mcast_packet_test()
 	return $seen
 }
 
-reportleave_test()
+v2reportleave_test()
 {
 	RET=0
 	ip address add dev $h2 $TEST_GROUP/32 autojoin
@@ -118,12 +118,12 @@ reportleave_test()
 
 	sleep 5
 	bridge mdb show dev br0 | grep $TEST_GROUP 1>/dev/null
-	check_err $? "Report didn't create mdb entry for $TEST_GROUP"
+	check_err $? "IGMPv2 report didn't create mdb entry for $TEST_GROUP"
 
 	mcast_packet_test $TEST_GROUP_MAC $TEST_GROUP $h1 $h2
 	check_fail $? "Traffic to $TEST_GROUP wasn't forwarded"
 
-	log_test "IGMP report $TEST_GROUP"
+	log_test "IGMPv2 report $TEST_GROUP"
 
 	RET=0
 	bridge mdb show dev br0 | grep $TEST_GROUP 1>/dev/null
@@ -139,7 +139,7 @@ reportleave_test()
 	mcast_packet_test $TEST_GROUP_MAC $TEST_GROUP $h1 $h2
 	check_err $? "Traffic to $TEST_GROUP was forwarded without mdb entry"
 
-	log_test "IGMP leave $TEST_GROUP"
+	log_test "IGMPv2 leave $TEST_GROUP"
 }
 
 trap cleanup EXIT
-- 
2.25.4

