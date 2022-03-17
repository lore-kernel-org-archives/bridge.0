Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=Rzca7XlJ3nGkRZRrrr3Av3J4sdu0DWRxi2d5ZWbv6Pg=;
 b=qMJYU9bvcIwzFO/6T3IGHQlUDY2nf8R0HceNbhjVGNu30qxD2oLqM33Q7BtWqV5gjX
 rnPbltg8xm5RjaYcPIkPW8ZpJOFCa4bvN1PrySyJYrgYyANBHmgXzN+4IDabjbOi0Haj
 3JLY8qYTUQYuj8nwjl2ZzH1yGO70LoA4FbDxuMmnu15N6/qSsKLepCeFgPoX1/8sOnpy
 k/GTyj2UO7qABKzgz40LSXS7pqIM4Cdn9r9c8l9JOdpflybjkaI15regv2D9YHBWMEeb
 qRnUH8zS12ZOATaCaesIlZUSY83wifNQEawIvw0JyoYv8l/NwVuNlFxsWNoJB0zAm/NW
 tdSw==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Thu, 17 Mar 2022 10:39:02 +0100
Message-Id: <20220317093902.1305816-5-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 4/4] selftests: forwarding: add test of
	MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Verify that the MAC-Auth mechanism works by adding a FDB entry with the
locked flag set. denying access until the FDB entry is replaced with a
FDB entry without the locked flag set.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 .../net/forwarding/bridge_locked_port.sh      | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index 6e98efa6d371..2f9519e814b6 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
+ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan locked_port_mab"
 NUM_NETIFS=4
 CHECK_TC="no"
 source lib.sh
@@ -170,6 +170,33 @@ locked_port_ipv6()
 	log_test "Locked port ipv6"
 }
 
+locked_port_mab()
+{
+	RET=0
+	check_locked_port_support || return 0
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work before locking port"
+
+	bridge link set dev $swp1 locked on
+	bridge link set dev $swp1 learning on
+
+	ping_do $h1 192.0.2.2
+	check_fail $? "MAB: Ping worked on port just locked"
+
+	if ! bridge fdb show | grep `mac_get $h1` | grep -q "locked"; then
+		RET=1
+		retmsg="MAB: No locked fdb entry after ping on locked port"
+	fi
+
+	bridge fdb del `mac_get $h1` dev $swp1 master
+	bridge fdb add `mac_get $h1` dev $swp1 master static
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
+
+	log_test "Locked port MAB"
+}
 trap cleanup EXIT
 
 setup_prepare
-- 
2.30.2

