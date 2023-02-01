Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7470240B8C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91F7140B85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcDKbM/vxLaY/qHxu8fO8whiyjxP3cz/iCe2KzrkEEo=;
 b=IunugHtzdjqJ3Ywo5le2sttVRbC3bQWaiLe0hPS2EXZfIfVHoueIyT9eVOKvdc4fZefaml4cAPsfVCEgGQVU2vJj/0pF94J1EEcszvTQFGpjbG1rMgchnG5fW9ZhaWffjq9zHYnHutU5ZWfByNrJdyrNFZvU9ITR3egnTepgMWvUKUJMiURlv+pMhkZhTXG0PI/zSQJ6VfdScgptv6Okubmz2E6h1DJAviS1rhnV6Vr8Kd5qdSr2ZncDO7rQHnrtLEudWELMKgpIIrHmfJPbnSW7orOEa9j6cYksrO5dMYQ7FH/HfiDsdueXZxKQA76f/SOWct9lrC5cI9876bZIjA==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:46 +0100
Message-ID: <eaea04feeee8b203b03de93146e642818ced1e12.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 13/16] selftests: forwarding:
	lib: Parameterize IGMPv3/MLDv2 generation
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

In order to generate IGMPv3 and MLDv2 packets on the fly, the
functions that generate these packets need to be able to generate
packets for different groups and different sources. Generating MLDv2
packets further needs the source address of the packet for purposes of
checksum calculation. Add the necessary parameters, and generate the
payload accordingly by dispatching to helpers added in the previous
patches.

Adjust the sole client, bridge_mdb.sh, as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../selftests/net/forwarding/bridge_mdb.sh    |  9 ++---
 tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 4e16677f02ba..b48867d8cadf 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1029,7 +1029,7 @@ ctrl_igmpv3_is_in_test()
 
 	# IS_IN ( 192.0.2.2 )
 	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
-		-t ip proto=2,p=$(igmpv3_is_in_get) -q
+		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -q 192.0.2.2
 	check_fail $? "Permanent entry affected by IGMP packet"
@@ -1042,7 +1042,7 @@ ctrl_igmpv3_is_in_test()
 
 	# IS_IN ( 192.0.2.2 )
 	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
-		-t ip proto=2,p=$(igmpv3_is_in_get) -q
+		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -v "src" | \
 		grep -q 192.0.2.2
@@ -1067,8 +1067,9 @@ ctrl_mldv2_is_in_test()
 		filter_mode include source_list 2001:db8:1::1
 
 	# IS_IN ( 2001:db8:1::2 )
+	local p=$(mldv2_is_in_get fe80::1 ff0e::1 2001:db8:1::2)
 	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
-		-t ip hop=1,next=0,p=$(mldv2_is_in_get) -q
+		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
 		grep -q 2001:db8:1::2
@@ -1082,7 +1083,7 @@ ctrl_mldv2_is_in_test()
 
 	# IS_IN ( 2001:db8:1::2 )
 	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
-		-t ip hop=1,next=0,p=$(mldv2_is_in_get) -q
+		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | grep -v "src" | \
 		grep -q 2001:db8:1::2
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index b10c903d9abd..190e49e60508 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1788,26 +1788,35 @@ payload_template_nbytes()
 
 igmpv3_is_in_get()
 {
+	local GRP=$1; shift
+	local IP=$1; shift
+
 	local igmpv3
 
+	# IS_IN ( $IP )
 	igmpv3=$(:
 		)"22:"$(			: Type - Membership Report
 		)"00:"$(			: Reserved
-		)"2a:f8:"$(			: Checksum
+		)"CHECKSUM:"$(			: Checksum
 		)"00:00:"$(			: Reserved
 		)"00:01:"$(			: Number of Group Records
 		)"01:"$(			: Record Type - IS_IN
 		)"00:"$(			: Aux Data Len
 		)"00:01:"$(			: Number of Sources
-		)"ef:01:01:01:"$(		: Multicast Address - 239.1.1.1
-		)"c0:00:02:02"$(		: Source Address - 192.0.2.2
+		)"$(ipv4_to_bytes $GRP):"$(	: Multicast Address
+		)"$(ipv4_to_bytes $IP)"$(	: Source Address
 		)
+	local checksum=$(payload_template_calc_checksum "$igmpv3")
 
-	echo $igmpv3
+	payload_template_expand_checksum "$igmpv3" $checksum
 }
 
 mldv2_is_in_get()
 {
+	local SIP=$1; shift
+	local GRP=$1; shift
+	local IP=$1; shift
+
 	local hbh
 	local icmpv6
 
@@ -1820,17 +1829,24 @@ mldv2_is_in_get()
 	icmpv6=$(:
 		)"8f:"$(			: Type - MLDv2 Report
 		)"00:"$(			: Code
-		)"45:39:"$(			: Checksum
+		)"CHECKSUM:"$(			: Checksum
 		)"00:00:"$(			: Reserved
 		)"00:01:"$(			: Number of Group Records
 		)"01:"$(			: Record Type - IS_IN
 		)"00:"$(			: Aux Data Len
 		)"00:01:"$(			: Number of Sources
-		)"ff:0e:00:00:00:00:00:00:"$(	: Multicast address - ff0e::1
-		)"00:00:00:00:00:00:00:01:"$(	:
-		)"20:01:0d:b8:00:01:00:00:"$(	: Source Address - 2001:db8:1::2
-		)"00:00:00:00:00:00:00:02:"$(	:
+		)"$(ipv6_to_bytes $GRP):"$(	: Multicast address
+		)"$(ipv6_to_bytes $IP):"$(	: Source Address
 		)
 
-	echo ${hbh}${icmpv6}
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
 }
-- 
2.39.0

