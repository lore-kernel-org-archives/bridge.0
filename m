Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=i72mpvj6nl7/nOM+1tWLZUUVGG1e8/l2+OoHhK0nhUw=;
	b=W+EZEEyW1bRV8BTFg5MTN1GlSMUuEsSrcLfk7IR6TkBx1n5lTJHUpLNyfvaSaEVNswwhjbE9du3kUUmj9ADKpr/caRLiHMUa8lmttjCZKeKZTyOhmyy9jT360LC3h6Y+QLblFct1Gy0l3alcgjbMV+VTGVLKeKIq2LE3kKlvpT4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:18 +0000
Message-ID: <20181207195433.22540-12-idosch@mellanox.com>
References: <20181207195433.22540-1-idosch@mellanox.com>
In-Reply-To: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 11/12] selftests: mlxsw: vxlan: Test
 FDB un/marking on VXLAN join/leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

From: Petr Machata <petrm@mellanox.com>

When a VXLAN device is attached to an offloaded bridge, or when a
front-panel port is attached to a bridge that already has a VXLAN
device, mlxsw should offload the existing offloadable FDB entries.
Similarly when VXLAN device is downed, the FDB entries are unoffloaded,
and the marks thus need to be cleared. Similarly when a front-panel port
device is attached to a bridge with a VXLAN device, or when VLAN flags
are tweaked on a VXLAN port attached to a VLAN-aware bridge.

Test that the replaying / clearing logic works by observing transitions
in presence of offload marks under different scenarios.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../selftests/drivers/net/mlxsw/vxlan.sh      | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh b/tools/tes=
ting/selftests/drivers/net/mlxsw/vxlan.sh
index 90b4998a3b70..ea11535f5a6e 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
@@ -647,12 +647,159 @@ offload_indication_decap_route_test()
 		noudpcsum ttl 20 tos inherit local 198.51.100.1 dstport 4789
 }
=20
+check_fdb_offloaded()
+{
+	local mac=3D00:11:22:33:44:55
+	local zmac=3D00:00:00:00:00:00
+
+	bridge fdb show dev vxlan0 | grep $mac | grep self | grep -q offload
+	check_err $?
+	bridge fdb show dev vxlan0 | grep $mac | grep master | grep -q offload
+	check_err $?
+
+	bridge fdb show dev vxlan0 | grep $zmac | grep self | grep -q offload
+	check_err $?
+}
+
+check_vxlan_fdb_not_offloaded()
+{
+	local mac=3D00:11:22:33:44:55
+	local zmac=3D00:00:00:00:00:00
+
+	bridge fdb show dev vxlan0 | grep $mac | grep -q self
+	check_err $?
+	bridge fdb show dev vxlan0 | grep $mac | grep self | grep -q offload
+	check_fail $?
+
+	bridge fdb show dev vxlan0 | grep $zmac | grep -q self
+	check_err $?
+	bridge fdb show dev vxlan0 | grep $zmac | grep self | grep -q offload
+	check_fail $?
+}
+
+check_bridge_fdb_not_offloaded()
+{
+	local mac=3D00:11:22:33:44:55
+	local zmac=3D00:00:00:00:00:00
+
+	bridge fdb show dev vxlan0 | grep $mac | grep -q master
+	check_err $?
+	bridge fdb show dev vxlan0 | grep $mac | grep master | grep -q offload
+	check_fail $?
+}
+
+__offload_indication_join_vxlan_first()
+{
+	local vid=3D$1; shift
+
+	local mac=3D00:11:22:33:44:55
+	local zmac=3D00:00:00:00:00:00
+
+	bridge fdb append $zmac dev vxlan0 self dst 198.51.100.2
+
+	ip link set dev vxlan0 master br0
+	bridge fdb add dev vxlan0 $mac self master static dst 198.51.100.2
+
+	RET=3D0
+	check_vxlan_fdb_not_offloaded
+	ip link set dev $swp1 master br0
+	sleep .1
+	check_fdb_offloaded
+	log_test "offload indication - attach vxlan first"
+
+	RET=3D0
+	ip link set dev vxlan0 down
+	check_vxlan_fdb_not_offloaded
+	check_bridge_fdb_not_offloaded
+	log_test "offload indication - set vxlan down"
+
+	RET=3D0
+	ip link set dev vxlan0 up
+	sleep .1
+	check_fdb_offloaded
+	log_test "offload indication - set vxlan up"
+
+	if [[ ! -z $vid ]]; then
+		RET=3D0
+		bridge vlan del dev vxlan0 vid $vid
+		check_vxlan_fdb_not_offloaded
+		check_bridge_fdb_not_offloaded
+		log_test "offload indication - delete VLAN"
+
+		RET=3D0
+		bridge vlan add dev vxlan0 vid $vid
+		check_vxlan_fdb_not_offloaded
+		check_bridge_fdb_not_offloaded
+		log_test "offload indication - add tagged VLAN"
+
+		RET=3D0
+		bridge vlan add dev vxlan0 vid $vid pvid untagged
+		sleep .1
+		check_fdb_offloaded
+		log_test "offload indication - add pvid/untagged VLAN"
+	fi
+
+	RET=3D0
+	ip link set dev $swp1 nomaster
+	check_vxlan_fdb_not_offloaded
+	log_test "offload indication - detach port"
+}
+
+offload_indication_join_vxlan_first()
+{
+	ip link add dev br0 up type bridge mcast_snooping 0
+	ip link add name vxlan0 up type vxlan id 10 nolearning noudpcsum \
+		ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	__offload_indication_join_vxlan_first
+
+	ip link del dev vxlan0
+	ip link del dev br0
+}
+
+__offload_indication_join_vxlan_last()
+{
+	local zmac=3D00:00:00:00:00:00
+
+	RET=3D0
+
+	bridge fdb append $zmac dev vxlan0 self dst 198.51.100.2
+
+	ip link set dev $swp1 master br0
+
+	bridge fdb show dev vxlan0 | grep $zmac | grep self | grep -q offload
+	check_fail $?
+
+	ip link set dev vxlan0 master br0
+
+	bridge fdb show dev vxlan0 | grep $zmac | grep self | grep -q offload
+	check_err $?
+
+	log_test "offload indication - attach vxlan last"
+}
+
+offload_indication_join_vxlan_last()
+{
+	ip link add dev br0 up type bridge mcast_snooping 0
+	ip link add name vxlan0 up type vxlan id 10 nolearning noudpcsum \
+		ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	__offload_indication_join_vxlan_last
+
+	ip link del dev vxlan0
+	ip link del dev br0
+}
+
 offload_indication_test()
 {
 	offload_indication_setup_create
 	offload_indication_fdb_test
 	offload_indication_decap_route_test
 	offload_indication_setup_destroy
+
+	log_info "offload indication - replay & cleanup"
+	offload_indication_join_vxlan_first
+	offload_indication_join_vxlan_last
 }
=20
 sanitization_vlan_aware_test()
@@ -848,12 +995,42 @@ offload_indication_vlan_aware_decap_route_test()
 	log_test "vxlan decap route - vni map/unmap"
 }
=20
+offload_indication_vlan_aware_join_vxlan_first()
+{
+	ip link add dev br0 up type bridge mcast_snooping 0 \
+		vlan_filtering 1 vlan_default_pvid 1
+	ip link add name vxlan0 up type vxlan id 10 nolearning noudpcsum \
+		ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	__offload_indication_join_vxlan_first 1
+
+	ip link del dev vxlan0
+	ip link del dev br0
+}
+
+offload_indication_vlan_aware_join_vxlan_last()
+{
+	ip link add dev br0 up type bridge mcast_snooping 0 \
+		vlan_filtering 1 vlan_default_pvid 1
+	ip link add name vxlan0 up type vxlan id 10 nolearning noudpcsum \
+		ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	__offload_indication_join_vxlan_last
+
+	ip link del dev vxlan0
+	ip link del dev br0
+}
+
 offload_indication_vlan_aware_test()
 {
 	offload_indication_vlan_aware_setup_create
 	offload_indication_vlan_aware_fdb_test
 	offload_indication_vlan_aware_decap_route_test
 	offload_indication_vlan_aware_setup_destroy
+
+	log_info "offload indication - replay & cleanup - vlan aware"
+	offload_indication_vlan_aware_join_vxlan_first
+	offload_indication_vlan_aware_join_vxlan_last
 }
=20
 trap cleanup EXIT
--=20
2.19.1

