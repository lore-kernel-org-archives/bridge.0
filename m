Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gJvu8f2jgbnJqs1NY6YsP4oxwkKYOvAd3eazDvKS0GI=;
 b=g+69WtLfjhgsl+7v0a3curceaiZQaK+hNEG0UuCK88gnmq2yKLMI9heFnt7ZKzGER2
 Krxonchdb+j3nEXNS0BRqY2EaTllTf7rOwW+4up+hQ8B+OGtVmmoRnvw7HVjgY2Nkjgv
 magldk+KL2ncKXmYUK7YkFEYKcdfWrYzRjvAtYiqoDSjgKO/I3fMhfWecpefFk9yt6IL
 ixzvd6YWlVHWH4oEVmQ0iWY6oxqc3i45CSp72DJ/Q+gUmAl6VCJECo6z1WdpOMWtMzTF
 lPIazRPIzkQtePTpdEnEE9kdGG7axZtUHDsCaShXU9Q+5EWXLwsKnf3jEeXc2uRxwj+X
 xDHA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  3 Nov 2020 19:24:12 +0200
Message-Id: <20201103172412.1044840-17-razor@blackwall.org>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 16/16] selftests: net: bridge: add test
	for mldv2 *, g auto-add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When we have *,G ports in exclude mode and a new S,G,port is added
the kernel has to automatically create an S,G entry for each exclude
port to get proper forwarding.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mld.sh    | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index b34cf4c6ceba..ffdcfa87ca2b 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="mldv2include_test mldv2inc_allow_test mldv2inc_is_include_test mldv2inc_is_exclude_test \
 	   mldv2inc_to_exclude_test mldv2exc_allow_test mldv2exc_is_include_test \
 	   mldv2exc_is_exclude_test mldv2exc_to_exclude_test mldv2inc_block_test \
-	   mldv2exc_block_test mldv2exc_timeout_test"
+	   mldv2exc_block_test mldv2exc_timeout_test mldv2star_ex_auto_add_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="ff02::cc"
@@ -519,6 +519,35 @@ mldv2exc_timeout_test()
 	mldv2cleanup $swp1
 }
 
+mldv2star_ex_auto_add_test()
+{
+	RET=0
+
+	mldv2exclude_prepare $h1
+
+	$MZ $h2 -c 1 $MZPKT_IS_INC -q
+	sleep 1
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and .src == \"2001:db8:1::3\" and \
+				.port == \"$swp1\")" &>/dev/null
+	check_err $? "S,G entry for *,G port doesn't exist"
+
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and .src == \"2001:db8:1::3\" and \
+				.port == \"$swp1\" and \
+				.flags[] == \"added_by_star_ex\")" &>/dev/null
+	check_err $? "Auto-added S,G entry doesn't have added_by_star_ex flag"
+
+	brmcast_check_sg_fwding 1 2001:db8:1::3
+
+	log_test "MLDv2 S,G port entry automatic add to a *,G port"
+
+	mldv2cleanup $swp1
+	mldv2cleanup $swp2
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

