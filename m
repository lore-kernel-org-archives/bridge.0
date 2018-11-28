Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MYsGvFT2niyUFeHQRrv0J+g9I7S5mm/nmvhpiZNi0tI=;
	b=LUIbZkrWvWoVu6X0dp7g0A10cIc9rMgPtLQ8bNrgWWqBT+me8bamR+5ZR46ZfR/aOJknvKpYv3kMsQ6y40yu6EB/yZgADNzo7Fb+JyFtCm25rW/+S4m8XXx6L6YF2gi1qpozG0aQfRES7bN6GW93MD3HhqJSUEkIA2enUbSm6A8=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:07:06 +0000
Message-ID: <20181128200558.31343-8-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 7/8] selftests: mlxsw: Add a test for
 VxLAN configuration with a VLAN-aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Extend the existing VLAN-unaware tests with their VLAN-aware
counterparts. This includes sanitization of invalid configuration and
offload indication on the local route performing decapsulation and the
FDB entries perform encapsulation.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../selftests/drivers/net/mlxsw/vxlan.sh      | 204 +++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh b/tools/tes=
ting/selftests/drivers/net/mlxsw/vxlan.sh
index d00d4665c807..90b4998a3b70 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
@@ -6,7 +6,8 @@
=20
 lib_dir=3D$(dirname $0)/../../../net/forwarding
=20
-ALL_TESTS=3D"sanitization_test offload_indication_test"
+ALL_TESTS=3D"sanitization_test offload_indication_test \
+	sanitization_vlan_aware_test offload_indication_vlan_aware_test"
 NUM_NETIFS=3D2
 source $lib_dir/lib.sh
=20
@@ -654,6 +655,207 @@ offload_indication_test()
 	offload_indication_setup_destroy
 }
=20
+sanitization_vlan_aware_test()
+{
+	RET=3D0
+
+	ip link add dev br0 type bridge mcast_snooping 0 vlan_filtering 1
+
+	ip link add name vxlan10 up master br0 type vxlan id 10 nolearning \
+		noudpcsum ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	ip link add name vxlan20 up master br0 type vxlan id 20 nolearning \
+		noudpcsum ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	# Test that when each VNI is mapped to a different VLAN we can enslave
+	# a port to the bridge
+	bridge vlan add vid 10 dev vxlan10 pvid untagged
+	bridge vlan add vid 20 dev vxlan20 pvid untagged
+
+	ip link set dev $swp1 master br0
+	check_err $?
+
+	log_test "vlan-aware - enslavement to vlan-aware bridge"
+
+	# Try to map both VNIs to the same VLAN and make sure configuration
+	# fails
+	RET=3D0
+
+	bridge vlan add vid 10 dev vxlan20 pvid untagged &> /dev/null
+	check_fail $?
+
+	log_test "vlan-aware - two vnis mapped to the same vlan"
+
+	# Test that enslavement of a port to a bridge fails when two VNIs
+	# are mapped to the same VLAN
+	RET=3D0
+
+	ip link set dev $swp1 nomaster
+
+	bridge vlan del vid 20 dev vxlan20 pvid untagged
+	bridge vlan add vid 10 dev vxlan20 pvid untagged
+
+	ip link set dev $swp1 master br0 &> /dev/null
+	check_fail $?
+
+	log_test "vlan-aware - failed enslavement to vlan-aware bridge"
+
+	ip link del dev vxlan20
+	ip link del dev vxlan10
+	ip link del dev br0
+}
+
+offload_indication_vlan_aware_setup_create()
+{
+	# Create a simple setup with two VxLAN devices and a single VLAN-aware
+	# bridge
+	ip link add name br0 up type bridge mcast_snooping 0 vlan_filtering 1 \
+		vlan_default_pvid 0
+
+	ip link set dev $swp1 master br0
+
+	bridge vlan add vid 10 dev $swp1
+	bridge vlan add vid 20 dev $swp1
+
+	ip address add 198.51.100.1/32 dev lo
+
+	ip link add name vxlan10 up master br0 type vxlan id 10 nolearning \
+		noudpcsum ttl 20 tos inherit local 198.51.100.1 dstport 4789
+	ip link add name vxlan20 up master br0 type vxlan id 20 nolearning \
+		noudpcsum ttl 20 tos inherit local 198.51.100.1 dstport 4789
+
+	bridge vlan add vid 10 dev vxlan10 pvid untagged
+	bridge vlan add vid 20 dev vxlan20 pvid untagged
+}
+
+offload_indication_vlan_aware_setup_destroy()
+{
+	bridge vlan del vid 20 dev vxlan20
+	bridge vlan del vid 10 dev vxlan10
+
+	ip link del dev vxlan20
+	ip link del dev vxlan10
+
+	ip address del 198.51.100.1/32 dev lo
+
+	bridge vlan del vid 20 dev $swp1
+	bridge vlan del vid 10 dev $swp1
+
+	ip link set dev $swp1 nomaster
+
+	ip link del dev br0
+}
+
+offload_indication_vlan_aware_fdb_test()
+{
+	RET=3D0
+
+	log_info "vxlan entry offload indication - vlan-aware"
+
+	bridge fdb add de:ad:be:ef:13:37 dev vxlan10 self master static \
+		dst 198.51.100.2 vlan 10
+
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep self \
+		| grep -q offload
+	check_err $?
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep -v self \
+		| grep -q offload
+	check_err $?
+
+	log_test "vxlan entry offload indication - initial state"
+
+	# Remove FDB entry from the bridge driver and check that corresponding
+	# entry in the VxLAN driver is not marked as offloaded
+	RET=3D0
+
+	bridge fdb del de:ad:be:ef:13:37 dev vxlan10 master vlan 10
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep self \
+		| grep -q offload
+	check_fail $?
+
+	log_test "vxlan entry offload indication - after removal from bridge"
+
+	# Add the FDB entry back to the bridge driver and make sure it is
+	# marked as offloaded in both drivers
+	RET=3D0
+
+	bridge fdb add de:ad:be:ef:13:37 dev vxlan10 master static vlan 10
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep self \
+		| grep -q offload
+	check_err $?
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep -v self \
+		| grep -q offload
+	check_err $?
+
+	log_test "vxlan entry offload indication - after re-add to bridge"
+
+	# Remove FDB entry from the VxLAN driver and check that corresponding
+	# entry in the bridge driver is not marked as offloaded
+	RET=3D0
+
+	bridge fdb del de:ad:be:ef:13:37 dev vxlan10 self
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep -v self \
+		| grep -q offload
+	check_fail $?
+
+	log_test "vxlan entry offload indication - after removal from vxlan"
+
+	# Add the FDB entry back to the VxLAN driver and make sure it is
+	# marked as offloaded in both drivers
+	RET=3D0
+
+	bridge fdb add de:ad:be:ef:13:37 dev vxlan10 self dst 198.51.100.2
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep self \
+		| grep -q offload
+	check_err $?
+	bridge fdb show brport vxlan10 | grep de:ad:be:ef:13:37 | grep -v self \
+		| grep -q offload
+	check_err $?
+
+	log_test "vxlan entry offload indication - after re-add to vxlan"
+
+	bridge fdb del de:ad:be:ef:13:37 dev vxlan10 self master vlan 10
+}
+
+offload_indication_vlan_aware_decap_route_test()
+{
+	RET=3D0
+
+	ip route show table local | grep 198.51.100.1 | grep -q offload
+	check_err $?
+
+	# Toggle PVID flag on one VxLAN device and make sure route is still
+	# marked as offloaded
+	bridge vlan add vid 10 dev vxlan10 untagged
+
+	ip route show table local | grep 198.51.100.1 | grep -q offload
+	check_err $?
+
+	# Toggle PVID flag on second VxLAN device and make sure route is no
+	# longer marked as offloaded
+	bridge vlan add vid 20 dev vxlan20 untagged
+
+	ip route show table local | grep 198.51.100.1 | grep -q offload
+	check_fail $?
+
+	# Toggle PVID flag back and make sure route is marked as offloaded
+	bridge vlan add vid 10 dev vxlan10 pvid untagged
+	bridge vlan add vid 20 dev vxlan20 pvid untagged
+
+	ip route show table local | grep 198.51.100.1 | grep -q offload
+	check_err $?
+
+	log_test "vxlan decap route - vni map/unmap"
+}
+
+offload_indication_vlan_aware_test()
+{
+	offload_indication_vlan_aware_setup_create
+	offload_indication_vlan_aware_fdb_test
+	offload_indication_vlan_aware_decap_route_test
+	offload_indication_vlan_aware_setup_destroy
+}
+
 trap cleanup EXIT
=20
 setup_prepare
--=20
2.19.1

