Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77FF941D10
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D98641D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaO7FyK2OwQD4JbLKs6GXiMXyTVLodrTsmyEdNFE22g=;
 b=GW1sOJTLe5zhFRfeqMiOpDjw3xyOuCHdxtWRbIIVRc82onluyYeK823V0tzQ3B9yq0A0DSK0Dq0VYIvmGv0WPzNmada9tCUynDeFCFyd/dgcBQHngAc0z60BLTy8s2spfdueurUNesSweYV7h4Me7W7uKJwh89PpVLP5NnfXG2484nyMfsedlSN4J1oWop7sfNTA2fETihWl26OC0Lqg1tzK8BsscjayWdyoSsqx+35BiF5g83ftP9UXIpyXLgCJ45KmlrsuzgLWxckYJvrfy3VsdaHht+TOh6GNZZNEsb1tcEYYwxRcCw9Ot2L1NuR6jCIXQ2kaqdJ6hwWopCy9gQ==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 18:59:33 +0100
Message-ID: <76cdd85502b18f3e1a2654ae0c91911db95cc795.1675359453.git.petrm@nvidia.com>
In-Reply-To: <cover.1675359453.git.petrm@nvidia.com>
References: <cover.1675359453.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 15/16] selftests: forwarding: lib: Add
	helpers to build IGMP/MLD leave packets
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

The testsuite that checks for mcast_max_groups functionality will need to
wipe the added groups as well. Add helpers to build an IGMP or MLD packets
announcing that host is leaving a given group.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 12ef34ebcbbf..969e570f609e 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1815,6 +1815,21 @@ igmpv3_is_in_get()
 	payload_template_expand_checksum "$igmpv3" $checksum
 }
 
+igmpv2_leave_get()
+{
+	local GRP=$1; shift
+
+	local payload=$(:
+		)"17:"$(			: Type - Leave Group
+		)"00:"$(			: Max Resp Time - not meaningful
+		)"CHECKSUM:"$(			: Checksum
+		)"$(ipv4_to_bytes $GRP)"$(	: Group Address
+		)
+	local checksum=$(payload_template_calc_checksum "$payload")
+
+	payload_template_expand_checksum "$payload" $checksum
+}
+
 mldv2_is_in_get()
 {
 	local SIP=$1; shift
@@ -1858,3 +1873,38 @@ mldv2_is_in_get()
 
 	payload_template_expand_checksum "$hbh$icmpv6" $checksum
 }
+
+mldv1_done_get()
+{
+	local SIP=$1; shift
+	local GRP=$1; shift
+
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
+		)"84:"$(			: Type - MLDv1 Done
+		)"00:"$(			: Code
+		)"CHECKSUM:"$(			: Checksum
+		)"00:00:"$(			: Max Resp Delay - not meaningful
+		)"00:00:"$(			: Reserved
+		)"$(ipv6_to_bytes $GRP):"$(	: Multicast address
+		)
+
+	local len=$(u16_to_bytes $(payload_template_nbytes $icmpv6))
+	local sudohdr=$(:
+		)"$(ipv6_to_bytes $SIP):"$(	: SIP
+		)"$(ipv6_to_bytes $GRP):"$(	: DIP is multicast address
+	        )"${len}:"$(			: Upper-layer length
+	        )"00:3a:"$(			: Zero and next-header
+	        )
+	local checksum=$(payload_template_calc_checksum ${sudohdr}${icmpv6})
+
+	payload_template_expand_checksum "$hbh$icmpv6" $checksum
+}
-- 
2.39.0

