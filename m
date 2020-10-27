Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLPWNUeiDX6YqJv0P1s9lGNPu+RgfZ8zS9WrTNhZtwU=;
 b=Pbbgzu7Uim9URoVPsODKBzIRpIWNZUV/sc1OsVCs/ctmhcIQJuqP1Da07kJ2ti9/rK
 zwadkwjLlxDK6vSMPMNy7hOKGF9z/TVWXc++pM9nsU6I2AuCe/CIsrnng25YCjNkjb4f
 nyOsGMfA8wywQAx2ipPq2e+Cm42KAUKXLliz5jwbRyp1GGAZtlPV0gPBOKSl6pt+XRkh
 jhlsFvNWPtpOonDa/1z7uV3cBIFFMK7HjMxd29Pc6KJwjY0diRy6Y9jWj3DpTW9TVLii
 jpwVVOEsvNW0ITz2hhefUMxxEdpP8Qt870u1sEdMawZhO0x30jL4RKpm3No+NrtAJE0S
 WLTA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:20 +0200
Message-Id: <20201027185934.227040-3-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 02/16] selftests: net: bridge: igmp: add
	support for packet source address
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

Add support for one more argument which specifies the source address to
use. It will be later used for IGMPv3 S,G entry testing.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../testing/selftests/net/forwarding/bridge_igmp.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 481198300b72..1c19459dbc58 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -83,9 +83,10 @@ cleanup()
 mcast_packet_test()
 {
 	local mac=$1
-	local ip=$2
-	local host1_if=$3
-	local host2_if=$4
+	local src_ip=$2
+	local ip=$3
+	local host1_if=$4
+	local host2_if=$5
 	local seen=0
 
 	# Add an ACL on `host2_if` which will tell us whether the packet
@@ -94,7 +95,7 @@ mcast_packet_test()
 	tc filter add dev $host2_if ingress protocol ip pref 1 handle 101 \
 		flower dst_mac $mac action drop
 
-	$MZ $host1_if -c 1 -p 64 -b $mac -B $ip -t udp "dp=4096,sp=2048" -q
+	$MZ $host1_if -c 1 -p 64 -b $mac -A $src_ip -B $ip -t udp "dp=4096,sp=2048" -q
 	sleep 1
 
 	tc -j -s filter show dev $host2_if ingress \
@@ -120,7 +121,7 @@ v2reportleave_test()
 	bridge mdb show dev br0 | grep $TEST_GROUP 1>/dev/null
 	check_err $? "IGMPv2 report didn't create mdb entry for $TEST_GROUP"
 
-	mcast_packet_test $TEST_GROUP_MAC $TEST_GROUP $h1 $h2
+	mcast_packet_test $TEST_GROUP_MAC 192.0.2.1 $TEST_GROUP $h1 $h2
 	check_fail $? "Traffic to $TEST_GROUP wasn't forwarded"
 
 	log_test "IGMPv2 report $TEST_GROUP"
@@ -136,7 +137,7 @@ v2reportleave_test()
 	bridge mdb show dev br0 | grep $TEST_GROUP 1>/dev/null
 	check_fail $? "Leave didn't delete mdb entry for $TEST_GROUP"
 
-	mcast_packet_test $TEST_GROUP_MAC $TEST_GROUP $h1 $h2
+	mcast_packet_test $TEST_GROUP_MAC 192.0.2.1 $TEST_GROUP $h1 $h2
 	check_err $? "Traffic to $TEST_GROUP was forwarded without mdb entry"
 
 	log_test "IGMPv2 leave $TEST_GROUP"
-- 
2.25.4

