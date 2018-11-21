Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=c0Hc64rTIiXTJTirnn7zNBxeGWoPA9OzowFyyhkElUY=;
	b=TCGedLqo4f7Eblj5+49dkiwctgO3Tge6VKUjIpBE+QO4p0rluHpbuWcDveqXBOIUh8BbCgI8VePWz36u3xBzkMhgvYWWQ+lP+rtjcY9xIw9GJS5P3/pvgUQ2hxnf8zL85zufeHQ/FELyPjn+pqTb8vkmixFLG9dds+iEK9qY+b0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:51 +0000
Message-ID: <20181121080141.16676-16-idosch@mellanox.com>
References: <20181121080141.16676-1-idosch@mellanox.com>
In-Reply-To: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 15/16] selftests: mlxsw: Consider VxLAN
 learning enabled as valid
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

The test currently expects that a configuration which includes a VxLAN
device with learning enabled to fail.

Previous patches enabled VxLAN learning in mlxsw, so change the test
accordingly.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 tools/testing/selftests/drivers/net/mlxsw/vxlan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh b/tools/tes=
ting/selftests/drivers/net/mlxsw/vxlan.sh
index 52e78adfe081..ffa79b738f2a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/vxlan.sh
@@ -167,7 +167,7 @@ sanitization_single_dev_learning_enabled_test()
 	ip link add name vxlan0 up type vxlan id 10 learning noudpcsum \
 		ttl 20 tos inherit local 198.51.100.1 dstport 4789
=20
-	sanitization_single_dev_test_fail
+	sanitization_single_dev_test_pass
=20
 	ip link del dev vxlan0
 	ip link del dev br0
--=20
2.19.1

