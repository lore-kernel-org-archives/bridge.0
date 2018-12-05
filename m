Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ky86EgLmvhenxdQ7iHJz5xb2+X40q96KOP30CWdhIoA=;
	b=Q+0V4kL2PKHi7I7r5meEHKi9iTh6Uvy1X+hSpDtEmweMUptbXSNcYvejoy/GBCML5shHC1Rt5FfhZW9Ynk3Y+SI1btZ1EHbgvf8L2UK6pWyxkM14kt8NOdGKB8Adi2sJ07fx6+y3wNyotIH49j8Fw/0vU20t0u1Bz3r7XH5Kh3o=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 5 Dec 2018 15:50:54 +0000
Message-ID: <20181205154958.20262-13-idosch@mellanox.com>
References: <20181205154958.20262-1-idosch@mellanox.com>
In-Reply-To: <20181205154958.20262-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 12/12] selftests: forwarding: Add PVID
 test case for VXLAN with VLAN-aware bridges
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

When using VLAN-aware bridges with VXLAN, the VLAN that is mapped to the
VNI of the VXLAN device is that which is configured as "pvid untagged"
on the corresponding bridge port.

When these flags are toggled or when the VLAN is deleted entirely,
remote hosts should not be able to receive packets from the VTEP.

Add a test case for above mentioned scenarios.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../net/forwarding/vxlan_bridge_1q.sh         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh b/to=
ols/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
index bac2e568d22c..a5789721ba92 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
@@ -95,6 +95,7 @@ export VXPORT
 	test_flood
 	test_unicast
 	test_learning
+	test_pvid
     "}
=20
 NUM_NETIFS=3D6
@@ -610,6 +611,75 @@ test_unicast()
 	done
 }
=20
+test_pvid()
+{
+	local -a expects=3D(0 0 0 0 0)
+	local mac=3Dde:ad:be:ef:13:37
+	local dst=3D192.0.2.100
+	local vid=3D10
+
+	# Check that flooding works
+	RET=3D0
+
+	expects[0]=3D10; expects[1]=3D10; expects[3]=3D10
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	log_test "VXLAN: flood before pvid off"
+
+	# Toggle PVID off and test that flood to remote hosts does not work
+	RET=3D0
+
+	bridge vlan add vid 10 dev vx10
+
+	expects[0]=3D10; expects[1]=3D0; expects[3]=3D0
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	log_test "VXLAN: flood after pvid off"
+
+	# Toggle PVID on and test that flood to remote hosts does work
+	RET=3D0
+
+	bridge vlan add vid 10 dev vx10 pvid untagged
+
+	expects[0]=3D10; expects[1]=3D10; expects[3]=3D10
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	log_test "VXLAN: flood after pvid on"
+
+	# Add a new VLAN and test that it does not affect flooding
+	RET=3D0
+
+	bridge vlan add vid 30 dev vx10
+
+	expects[0]=3D10; expects[1]=3D10; expects[3]=3D10
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	bridge vlan del vid 30 dev vx10
+
+	log_test "VXLAN: flood after vlan add"
+
+	# Remove currently mapped VLAN and test that flood to remote hosts does
+	# not work
+	RET=3D0
+
+	bridge vlan del vid 10 dev vx10
+
+	expects[0]=3D10; expects[1]=3D0; expects[3]=3D0
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	log_test "VXLAN: flood after vlan delete"
+
+	# Re-add the VLAN and test that flood to remote hosts does work
+	RET=3D0
+
+	bridge vlan add vid 10 dev vx10 pvid untagged
+
+	expects[0]=3D10; expects[1]=3D10; expects[3]=3D10
+	vxlan_flood_test $mac $dst $vid "${expects[@]}"
+
+	log_test "VXLAN: flood after vlan re-add"
+}
+
 vxlan_ping_test()
 {
 	local ping_dev=3D$1; shift
--=20
2.19.1

