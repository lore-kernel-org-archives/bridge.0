Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VPJ9jTUgTW2L3AYmAi4ayhOIdJWIN78h7irWLCMjGEc=;
	b=aYMu3J12N4MIkX5jFqhEa6vmv+559Z6xeNPEpW7HIVjHk3A40wqSOQ1oRWuHM2wYd/5RoZvRni+IosWvqPG5OsKjDbUInuDJXHCs14hrGlLGrlcBtadaTH98qDWvpWbNMUVQvt7bljgbfBZNIdTa8HqVHLuv78bpiLLTyQpZ7zw=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:03:04 +0000
Message-ID: <4d769046c43d1d945789d7da789080ae9ed02271.1544632918.git.petrm@mellanox.com>
References: <cover.1544632917.git.petrm@mellanox.com>
In-Reply-To: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 8/9] selftests: mlxsw: extack: Test
 VLAN add on a VXLAN device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "dsa@cumulusnetworks.com" <dsa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

Test mapping a VLAN at a VXLAN device that can't be offloaded.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
---
 .../testing/selftests/drivers/net/mlxsw/extack.sh  | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/extack.sh b/tools/te=
sting/selftests/drivers/net/mlxsw/extack.sh
index 101a5508bdfd..d9e02624c70b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/extack.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/extack.sh
@@ -7,6 +7,7 @@ lib_dir=3D$(dirname $0)/../../../net/forwarding
=20
 ALL_TESTS=3D"
 	netdev_pre_up_test
+	vxlan_vlan_add_test
 "
 NUM_NETIFS=3D2
 source $lib_dir/lib.sh
@@ -74,6 +75,36 @@ netdev_pre_up_test()
 	ip link del dev br1
 }
=20
+vxlan_vlan_add_test()
+{
+	RET=3D0
+
+	ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 0
+
+	# Unsupported configuration: mlxsw demands VXLAN with "noudpcsum".
+	ip link add name vx1 up type vxlan id 1000 \
+		local 192.0.2.17 remote 192.0.2.18 \
+		dstport 4789 tos inherit ttl 100
+
+	ip link set dev vx1 master br1
+	check_err $?
+
+	bridge vlan add dev vx1 vid 1
+	check_err $?
+
+	ip link set dev $swp1 master br1
+	check_err $?
+
+	bridge vlan add dev vx1 vid 1 pvid untagged 2>&1 >/dev/null \
+		| grep -q mlxsw_spectrum
+	check_err $?
+
+	log_test "extack - map VLAN at VXLAN device"
+
+	ip link del dev vx1
+	ip link del dev br1
+}
+
 trap cleanup EXIT
=20
 setup_prepare
--=20
2.4.11

