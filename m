Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=FgEZaD+qaBUQURDZcatdSAcmpukEK3yyWD1n5B1AlNE=;
 b=Dqj8l9wZWDZHC1yP3YJCdmoXSjz9VdQZ0nXh27JmdifHCAIdkhRbRZVQrIejbZ3WjQ
 Facd+POgcmZoA1cdq73VcsPdCaQaAaTKVp5LHtYw4L1/E/nOU22l7xsISjb2Rwn5mTYS
 B/K02m5GurI9+HcZsANOpX/kFRKW5mQsMTRHcVgCKPiJVvMYxxxks6npgJp87DTTWKCo
 0zfjBUBu4SaIPElyMYzh2zUvhVknUjvzJ6sSEPM6AE3Lwg4DdaLTqZDWzfgdvPOLmSW1
 K7UQILzLUgJSIWLuPfcMrf+Kum4zLz5TvwBScXCaxb0/192mPsaw8vZoKo3dhGaOiHST
 a3lA==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Tue, 24 May 2022 17:21:44 +0200
Message-Id: <20220524152144.40527-5-schultz.hans+netdev@gmail.com>
In-Reply-To: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH V3 net-next 4/4] selftests: forwarding: add test of
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

Verify that the MAC-Auth mechanism works by adding a FDB entry with the
locked flag set. denying access until the FDB entry is replaced with a
FDB entry without the locked flag set.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 .../net/forwarding/bridge_locked_port.sh      | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index 5b02b6b60ce7..50b9048d044a 100755
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
@@ -94,13 +94,13 @@ locked_port_ipv4()
 	ping_do $h1 192.0.2.2
 	check_fail $? "Ping worked after locking port, but before adding FDB entry"
 
-	bridge fdb add `mac_get $h1` dev $swp1 master static
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
 
 	ping_do $h1 192.0.2.2
 	check_err $? "Ping did not work after locking port and adding FDB entry"
 
 	bridge link set dev $swp1 locked off
-	bridge fdb del `mac_get $h1` dev $swp1 master static
+	bridge fdb del `mac_get $h1` dev $swp1 master
 
 	ping_do $h1 192.0.2.2
 	check_err $? "Ping did not work after unlocking port and removing FDB entry."
@@ -124,13 +124,13 @@ locked_port_vlan()
 	ping_do $h1.100 198.51.100.2
 	check_fail $? "Ping through vlan worked after locking port, but before adding FDB entry"
 
-	bridge fdb add `mac_get $h1` dev $swp1 vlan 100 master static
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
 
 	ping_do $h1.100 198.51.100.2
 	check_err $? "Ping through vlan did not work after locking port and adding FDB entry"
 
 	bridge link set dev $swp1 locked off
-	bridge fdb del `mac_get $h1` dev $swp1 vlan 100 master static
+	bridge fdb del `mac_get $h1` dev $swp1 vlan 100 master
 
 	ping_do $h1.100 198.51.100.2
 	check_err $? "Ping through vlan did not work after unlocking port and removing FDB entry"
@@ -153,7 +153,8 @@ locked_port_ipv6()
 	ping6_do $h1 2001:db8:1::2
 	check_fail $? "Ping6 worked after locking port, but before adding FDB entry"
 
-	bridge fdb add `mac_get $h1` dev $swp1 master static
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
+
 	ping6_do $h1 2001:db8:1::2
 	check_err $? "Ping6 did not work after locking port and adding FDB entry"
 
@@ -166,6 +167,35 @@ locked_port_ipv6()
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
+	bridge fdb del `mac_get $h1` dev $swp1 master
+
+	ping_do $h1 192.0.2.2
+	check_fail $? "MAB: Ping worked on locked port without FDB entry"
+
+	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
+	check_err $? "MAB: No locked fdb entry after ping on locked port"
+
+	bridge fdb replace `mac_get $h1` dev $swp1 master static
+
+	ping_do $h1 192.0.2.2
+	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
+
+	bridge fdb del `mac_get $h1` dev $swp1 master
+	bridge link set dev $swp1 locked off
+
+	log_test "Locked port MAB"
+}
 trap cleanup EXIT
 
 setup_prepare
-- 
2.30.2

