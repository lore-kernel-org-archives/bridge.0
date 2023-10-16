Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EC59611D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E654611E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmxpLyIqP7Rsru/cXevrGDE3e/66SDRvoqRLeQk0CxI=;
 b=Y9m2CAiJe4LPMj1CZcFUfc4YEiNJKvtETOU5N0wUyli9GCutJLtOD/0mEMF9D3gv7tm2jnUqNjQNj8jDqvjBdiIEal1BZzbfCZSACSvInZkd4tCGWRl9hzI9z1AbUkZHi0qarnW8IGHl6jGnlccXsHuJRXNQ/FB+Zw4sfIXaP4kw8+YqMg4rXjVuAXbOOGui6EQZ5/rBrjxXRrIQPKt7IE/uLJPZNpwLoO4wcJV2xMf6o4MxfZQDWEvqPHnqlnpGCtG8vC8J9BR1i1j3JJPJPncbspiNOTMOZNE+nSquIjvwVqmumWsw04OvHuk2vO0OISG4VLlfJEpZiSmQCAh6eg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:59 +0300
Message-ID: <20231016131259.3302298-14-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 13/13] selftests: vxlan_mdb: Use MDB get
	instead of dump
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Test the new MDB get functionality by converting dump and grep to MDB
get.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++++++---------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 31e5f0f8859d..6e996f8063cd 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -337,62 +337,62 @@ basic_common()
 	# Basic add, replace and delete behavior.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry addition"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
 	log_test $? 0 "MDB entry presence after addition"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
 	log_test $? 0 "MDB entry presence after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
-	log_test $? 1 "MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
+	log_test $? 254 "MDB entry presence after deletion"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 	log_test $? 255 "Non-existent MDB entry deletion"
 
 	# Default protocol and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "MDB entry default protocol"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent proto 123 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"proto 123\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"proto 123\""
 	log_test $? 0 "MDB entry protocol replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default destination port and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "MDB entry default destination port"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip dst_port 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"dst_port 1234\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"dst_port 1234\""
 	log_test $? 0 "MDB entry destination port replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default destination VNI and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" vni \""
 	log_test $? 1 "MDB entry default destination VNI"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip vni 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"vni 1234\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"vni 1234\""
 	log_test $? 0 "MDB entry destination VNI replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default outgoing interface and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" via \""
 	log_test $? 1 "MDB entry default outgoing interface"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010 via veth0"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"via veth0\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"via veth0\""
 	log_test $? 0 "MDB entry outgoing interface replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
@@ -550,127 +550,127 @@ star_g_common()
 	# Basic add, replace and delete behavior.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry addition with source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry presence after addition"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry presence after addition"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry replacement with source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry presence after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry presence after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
-	log_test $? 1 "(*, G) MDB entry presence after deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
-	log_test $? 1 "(S, G) MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
+	log_test $? 254 "(*, G) MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
+	log_test $? 254 "(S, G) MDB entry presence after deletion"
 
 	# Default filter mode and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep exclude"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep exclude"
 	log_test $? 0 "(*, G) MDB entry default filter mode"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode include source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep include"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep include"
 	log_test $? 0 "(*, G) MDB entry after replacing filter mode to \"include\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry after replacing filter mode to \"include\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\" | grep blocked"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep blocked"
 	log_test $? 1 "\"blocked\" flag after replacing filter mode to \"include\""
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep exclude"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep exclude"
 	log_test $? 0 "(*, G) MDB entry after replacing filter mode to \"exclude\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grep grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry after replacing filter mode to \"exclude\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\" | grep blocked"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep blocked"
 	log_test $? 0 "\"blocked\" flag after replacing filter mode to \"exclude\""
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default source list and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep source_list"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep source_list"
 	log_test $? 1 "(*, G) MDB entry default source list"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1,$src2,$src3 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 1st source after replacing source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src2\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src2 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 2nd source after replacing source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src3\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src3 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 3rd source after replacing source list"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1,$src3 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 1st source after removing source"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src2\""
-	log_test $? 1 "(S, G) MDB entry of 2nd source after removing source"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src3\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src2 src_vni 10010"
+	log_test $? 254 "(S, G) MDB entry of 2nd source after removing source"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src3 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 3rd source after removing source"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default protocol and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "(*, G) MDB entry default protocol"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "(S, G) MDB entry default protocol"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 proto bgp dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \"proto bgp\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \"proto bgp\""
 	log_test $? 0 "(*, G) MDB entry protocol after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \"proto bgp\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \"proto bgp\""
 	log_test $? 0 "(S, G) MDB entry protocol after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default destination port and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "(*, G) MDB entry default destination port"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "(S, G) MDB entry default destination port"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip dst_port 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" dst_port 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" dst_port 1234 \""
 	log_test $? 0 "(*, G) MDB entry destination port after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" dst_port 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" dst_port 1234 \""
 	log_test $? 0 "(S, G) MDB entry destination port after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default destination VNI and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" vni \""
 	log_test $? 1 "(*, G) MDB entry default destination VNI"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" vni \""
 	log_test $? 1 "(S, G) MDB entry default destination VNI"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip vni 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" vni 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" vni 1234 \""
 	log_test $? 0 "(*, G) MDB entry destination VNI after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" vni 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" vni 1234 \""
 	log_test $? 0 "(S, G) MDB entry destination VNI after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default outgoing interface and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" via \""
 	log_test $? 1 "(*, G) MDB entry default outgoing interface"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" via \""
 	log_test $? 1 "(S, G) MDB entry default outgoing interface"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010 via veth0"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" via veth0 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" via veth0 \""
 	log_test $? 0 "(*, G) MDB entry outgoing interface after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" via veth0 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" via veth0 \""
 	log_test $? 0 "(S, G) MDB entry outgoing interface after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
@@ -772,7 +772,7 @@ sg_common()
 
 	# Default filter mode.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp src $src permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep include"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src src_vni 10010 | grep include"
 	log_test $? 0 "(S, G) MDB entry default filter mode"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp src $src permanent dst $vtep_ip src_vni 10010"
@@ -2296,9 +2296,9 @@ if [ ! -x "$(command -v jq)" ]; then
 	exit $ksft_skip
 fi
 
-bridge mdb help 2>&1 | grep -q "src_vni"
+bridge mdb help 2>&1 | grep -q "get"
 if [ $? -ne 0 ]; then
-   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB support"
+   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB get support"
    exit $ksft_skip
 fi
 
-- 
2.40.1

