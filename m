Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=z5/W5d8ndtvXDnyj0JyTra9alKgaGGYDMc0cdYTNV+Y=;
 b=PrNADXRvCHQzEChEPZg2kZj2LmA3yA1kD5ofn6xym7Neu/ROj+Tf88BEBnHcTrX6zN
 QA+RXn7FIQd2kWEQ6ciFFhyLUIJaYhBKJ4HgU31OE6xHtbMkGZrgQioXycEHo5wN21Af
 fW7sXUhV8TThK665pAO8Yg8HmweuI9KaHu/7QTVsOFfZj0NwTfKK1o4UaCmFMLLgO59z
 VYxD1emxfusy5Hutf+hzI6e64uTHPyYv/MDGVwGZZkI98effVZyPQmceUjp8KlRn/UtF
 n6QTT0FCD65iAkEO1MRKAoN+w2NM7HBb4iy4sTXlUB1U26NLYF52XQkiYWYAY0hDSU9s
 l9Mg==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:33 +0200
Message-Id: <20220411133837.318876-10-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 09/13] selftests: forwarding: rename
	test groups for next bridge mdb tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

Rename test groups to PASS and FAIL, respectively, for upcoming changes
to test suite.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh     | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index b1ba6876dd86..c0b84b7d4364 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -7,9 +7,15 @@
 ALL_TESTS="mdb_add_del_test"
 NUM_NETIFS=2
 
-TEST_GROUP_IP4="225.1.2.3"
-TEST_GROUP_IP6="ff02::42"
-TEST_GROUP_MAC="01:00:01:c0:ff:ee"
+PASS_GRP_IP4="225.1.2.3"
+FAIL_GRP_IP4="225.1.2.4"
+
+PASS_GRP_MAC="01:00:01:c0:ff:ee"
+FAIL_GRP_MAC="01:00:01:c0:ff:ef"
+
+PASS_GRP_IP6="ff02::42"
+FAIL_GRP_IP6="ff02::43"
+
 
 source lib.sh
 
@@ -88,9 +94,9 @@ do_mdb_add_del()
 
 mdb_add_del_test()
 {
-	do_mdb_add_del $TEST_GROUP_MAC permanent
-	do_mdb_add_del $TEST_GROUP_IP4
-	do_mdb_add_del $TEST_GROUP_IP6
+	do_mdb_add_del $PASS_GRP_MAC permanent
+	do_mdb_add_del $PASS_GRP_IP4
+	do_mdb_add_del $PASS_GRP_IP6
 }
 
 trap cleanup EXIT
-- 
2.25.1

