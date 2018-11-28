Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7iYJHgFzjLHQg1ak2ZV8kDxi1WxgxFgFleOEfuO1JbU=;
	b=p3LI8xiEkWvw+YXFdedT1V+pgGp4H2Vr62YPUs8h97t7yNcAPVtZ+Q+MA/W4xNIoNezhNS/1UejtFRSrUd8lF20A70v/OD0aWvgJkKKHHzUfpkATKtb9CHSOqiQiXeBWfj2l6g+vAZT1G1o/bmWJYkrdmy51nL3an0Wdomnieyg=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:07:05 +0000
Message-ID: <20181128200558.31343-7-idosch@mellanox.com>
References: <20181128200558.31343-1-idosch@mellanox.com>
In-Reply-To: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 6/8] selftests: mlxsw: Consider VLAN-aware
 bridges as valid
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

Previous patches add the ability to work with VLAN-aware bridges and
VxLAN devices, so make sure such configuration no longer fails.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 tools/testing/selftests/drivers/net/mlxsw/vxlan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh b/tools/tes=
ting/selftests/drivers/net/mlxsw/vxlan.sh
index ffa79b738f2a..d00d4665c807 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
@@ -81,7 +81,7 @@ sanitization_single_dev_vlan_aware_test()
 	ip link add name vxlan0 up type vxlan id 10 nolearning noudpcsum \
 		ttl 20 tos inherit local 198.51.100.1 dstport 4789
=20
-	sanitization_single_dev_test_fail
+	sanitization_single_dev_test_pass
=20
 	ip link del dev vxlan0
 	ip link del dev br0
--=20
2.19.1

