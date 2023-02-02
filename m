Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0874941CF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC85D41CF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifoIliBKd48Gdlg8BlM2Lvhk5jUlMyh5LYVNvRpDVWA=;
 b=jcZ8hNDHLkB+i1KyFCTRpAkfG3g488FVmPnEGqIecxlXyMtplRcz6N08Qz3xERxxKPYrqjKsuWK6C/rLvLMVEC9djQJ8do8cBhfAMZ20UfvzuoBi2goU0rH6/xF6jYWQESDoyYxbQ93nmIbGaIx+yr5F2Nhpnty/dQafzlv5KFF8/9LFLo6reeirIvhdpXN/jIbGuBKqZhZih1xEJPS1TzcElNfTAAJVEuXQEDsdyym0qsgyGLXNmKx9K6CQ+cdLlkC91m0Q3YUnBQdwdC6mHPxP8UEFIlODh8vLBxgiY+5xz3atEK637AnXjC/qSVMAjstDyRDa8O9NvD/PwjMyeA==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 18:59:27 +0100
Message-ID: <b55106c4525a101f85431ad6accc03e83b0727f9.1675359453.git.petrm@nvidia.com>
In-Reply-To: <cover.1675359453.git.petrm@nvidia.com>
References: <cover.1675359453.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 09/16] selftests: forwarding: Move
	IGMP- and MLD-related functions to lib
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

These functions will be helpful for other testsuites as well. Extract them
to a common place.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 49 -------------------
 tools/testing/selftests/net/forwarding/lib.sh | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 2fa5973c0c28..51f2b0d77067 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1018,26 +1018,6 @@ fwd_test()
 	ip -6 address del fe80::1/64 dev br0
 }
 
-igmpv3_is_in_get()
-{
-	local igmpv3
-
-	igmpv3=$(:
-		)"22:"$(			: Type - Membership Report
-		)"00:"$(			: Reserved
-		)"2a:f8:"$(			: Checksum
-		)"00:00:"$(			: Reserved
-		)"00:01:"$(			: Number of Group Records
-		)"01:"$(			: Record Type - IS_IN
-		)"00:"$(			: Aux Data Len
-		)"00:01:"$(			: Number of Sources
-		)"ef:01:01:01:"$(		: Multicast Address - 239.1.1.1
-		)"c0:00:02:02"$(		: Source Address - 192.0.2.2
-		)
-
-	echo $igmpv3
-}
-
 ctrl_igmpv3_is_in_test()
 {
 	RET=0
@@ -1077,35 +1057,6 @@ ctrl_igmpv3_is_in_test()
 	log_test "IGMPv3 MODE_IS_INCLUE tests"
 }
 
-mldv2_is_in_get()
-{
-	local hbh
-	local icmpv6
-
-	hbh=$(:
-		)"3a:"$(			: Next Header - ICMPv6
-		)"00:"$(			: Hdr Ext Len
-		)"00:00:00:00:00:00:"$(		: Options and Padding
-		)
-
-	icmpv6=$(:
-		)"8f:"$(			: Type - MLDv2 Report
-		)"00:"$(			: Code
-		)"45:39:"$(			: Checksum
-		)"00:00:"$(			: Reserved
-		)"00:01:"$(			: Number of Group Records
-		)"01:"$(			: Record Type - IS_IN
-		)"00:"$(			: Aux Data Len
-		)"00:01:"$(			: Number of Sources
-		)"ff:0e:00:00:00:00:00:00:"$(	: Multicast address - ff0e::1
-		)"00:00:00:00:00:00:00:01:"$(	:
-		)"20:01:0d:b8:00:01:00:00:"$(	: Source Address - 2001:db8:1::2
-		)"00:00:00:00:00:00:00:02:"$(	:
-		)
-
-	echo ${hbh}${icmpv6}
-}
-
 ctrl_mldv2_is_in_test()
 {
 	RET=0
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ded967d204d3..0cfa0b699803 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1692,3 +1692,52 @@ hw_stats_monitor_test()
 
 	log_test "${type}_stats notifications"
 }
+
+igmpv3_is_in_get()
+{
+	local igmpv3
+
+	igmpv3=$(:
+		)"22:"$(			: Type - Membership Report
+		)"00:"$(			: Reserved
+		)"2a:f8:"$(			: Checksum
+		)"00:00:"$(			: Reserved
+		)"00:01:"$(			: Number of Group Records
+		)"01:"$(			: Record Type - IS_IN
+		)"00:"$(			: Aux Data Len
+		)"00:01:"$(			: Number of Sources
+		)"ef:01:01:01:"$(		: Multicast Address - 239.1.1.1
+		)"c0:00:02:02"$(		: Source Address - 192.0.2.2
+		)
+
+	echo $igmpv3
+}
+
+mldv2_is_in_get()
+{
+	local hbh
+	local icmpv6
+
+	hbh=$(:
+		)"3a:"$(			: Next Header - ICMPv6
+		)"00:"$(			: Hdr Ext Len
+		)"00:00:00:00:00:00:"$(		: Options and Padding
+		)
+
+	icmpv6=$(:
+		)"8f:"$(			: Type - MLDv2 Report
+		)"00:"$(			: Code
+		)"45:39:"$(			: Checksum
+		)"00:00:"$(			: Reserved
+		)"00:01:"$(			: Number of Group Records
+		)"01:"$(			: Record Type - IS_IN
+		)"00:"$(			: Aux Data Len
+		)"00:01:"$(			: Number of Sources
+		)"ff:0e:00:00:00:00:00:00:"$(	: Multicast address - ff0e::1
+		)"00:00:00:00:00:00:00:01:"$(	:
+		)"20:01:0d:b8:00:01:00:00:"$(	: Source Address - 2001:db8:1::2
+		)"00:00:00:00:00:00:00:02:"$(	:
+		)
+
+	echo ${hbh}${icmpv6}
+}
-- 
2.39.0

