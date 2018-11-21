Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HE/UUg+L14rBNrXtnOAf/rXJYkOt36BrF8UuOZXN+WQ=;
	b=svAnbMvbga++jzuPYa/Kh1sBcVngiHHeaVTkPU/tPSnixlnH7SrTdgaj+syZnY/+YMJnHl+prO6SKutJq0M104NdGgxuMBdFW1uj1Ax+R1cLnrUx7J/0Jd9lFf4bO+pK38+7aQIwGv5ATPRmOQWH6y5o3tqLkG4uZ/ah6joGYIY=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:52 +0000
Message-ID: <20181121080141.16676-17-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 16/16] selftests: forwarding:
 vxlan_bridge_1d: Add learning test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Add a test which checks that the VxLAN driver can learn FDB entries and
that these entries are correctly deleted and aged-out.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 .../net/forwarding/vxlan_bridge_1d.sh         | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/to=
ols/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index 5cc6ac74eb74..56cef3b1c194 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -76,6 +76,7 @@ export VXPORT
 	ping_ipv4
 	test_flood
 	test_unicast
+	test_learning
     "}
=20
 NUM_NETIFS=3D6
@@ -663,6 +664,113 @@ test_ecn_decap()
 	test_ecn_decap_error
 }
=20
+test_learning()
+{
+	local mac=3Dde:ad:be:ef:13:37
+	local dst=3D192.0.2.100
+
+	# Enable learning on the VxLAN device and set ageing time to 10 seconds
+	ip link set dev br1 type bridge ageing_time 1000
+	ip link set dev vx1 type vxlan ageing 10
+	ip link set dev vx1 type vxlan learning
+	reapply_config
+
+	# Check that flooding works
+	RET=3D0
+
+	vxlan_flood_test $mac $dst 10 10 10
+
+	log_test "VXLAN: flood before learning"
+
+	# Send a packet with source mac set to $mac from host w2 and check that
+	# a corresponding entry is created in VxLAN device vx1
+	RET=3D0
+
+	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q
+	sleep 1
+
+	bridge fdb show brport vx1 | grep $mac | grep -q self
+	check_err $?
+	bridge fdb show brport vx1 | grep $mac | grep -q -v self
+	check_err $?
+
+	log_test "VXLAN: show learned FDB entry"
+
+	# Repeat first test and check that packets only reach host w2 in ns1
+	RET=3D0
+
+	vxlan_flood_test $mac $dst 0 10 0
+
+	log_test "VXLAN: learned FDB entry"
+
+	# Delete the learned FDB entry from the VxLAN and bridge devices and
+	# check that packets are flooded
+	RET=3D0
+
+	bridge fdb del dev vx1 $mac master self
+	sleep 1
+
+	vxlan_flood_test $mac $dst 10 10 10
+
+	log_test "VXLAN: deletion of learned FDB entry"
+
+	# Re-learn the first FDB entry and check that it is correctly aged-out
+	RET=3D0
+
+	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q
+	sleep 1
+
+	bridge fdb show brport vx1 | grep $mac | grep -q self
+	check_err $?
+	bridge fdb show brport vx1 | grep $mac | grep -q -v self
+	check_err $?
+
+	vxlan_flood_test $mac $dst 0 10 0
+
+	sleep 20
+
+	bridge fdb show brport vx1 | grep $mac | grep -q self
+	check_fail $?
+	bridge fdb show brport vx1 | grep $mac | grep -q -v self
+	check_fail $?
+
+	vxlan_flood_test $mac $dst 10 10 10
+
+	log_test "VXLAN: Ageing of learned FDB entry"
+
+	# Toggle learning on the bridge port and check that the bridge's FDB
+	# is populated only when it should
+	RET=3D0
+
+	ip link set dev vx1 type bridge_slave learning off
+
+	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q
+	sleep 1
+
+	bridge fdb show brport vx1 | grep $mac | grep -q -v self
+	check_fail $?
+
+	ip link set dev vx1 type bridge_slave learning on
+
+	in_ns ns1 $MZ w2 -c 1 -p 64 -a $mac -b ff:ff:ff:ff:ff:ff -B $dst \
+		-t icmp -q
+	sleep 1
+
+	bridge fdb show brport vx1 | grep $mac | grep -q -v self
+	check_err $?
+
+	log_test "VXLAN: learning toggling on bridge port"
+
+	# Restore previous settings
+	ip link set dev vx1 type vxlan nolearning
+	ip link set dev vx1 type vxlan ageing 300
+	ip link set dev br1 type bridge ageing_time 30000
+	reapply_config
+}
+
 test_all()
 {
 	echo "Running tests with UDP port $VXPORT"
--=20
2.19.1

