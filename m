Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W8178pAv6uDZvuBR8Wd4aVbByEM9iWD9JrBfg6O4nCE=;
 b=ZLJj6Z3orbJ+wULGft+hxYNzeLu0dElfr6eP44nItmYtg2ZpXuVRpD4ikfpOk5Hrr+
 vJOPhyXUuR7P0hvBiyIBcWQz0c36R8pjYFZ5unQM6APXma7LMwiJoI1nS+Ixnh8hlm2j
 p9DSk4Tqno9xp4/X2G5I9ocH6Oi2+sgYlgMLfUB6UO5ldL5Qm5Q0YS63U3ASShTdi2hA
 cudHgyLzAs/Z0YbECGOV5XO767qC4L1TMrjSUIKxDO7ooJCdGwy1J8tC9NkZMjU86TSG
 okweKJ+iu2hdtmuq3rN71PX8W27PdtXDswETnO5Gm+0XKnp33MrowprW1bUgDJ/2KV0x
 67pQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 27 Oct 2020 20:59:22 +0200
Message-Id: <20201027185934.227040-5-razor@blackwall.org>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 04/16] selftests: net: bridge: igmp: add
	IGMPv3 entries' state helpers
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

Add helpers which will be used in subsequent tests, they are:
 - check_sg_entries: check for proper source list and S,G entry
   existence
 - check_sg_fwding: check for proper traffic forwarding/blocking
 - check_sg_state: check for proper blocked/forwarding entry state

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 .../selftests/net/forwarding/bridge_igmp.sh   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 5562aef14c0a..19c1f46d1151 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -143,6 +143,73 @@ v2reportleave_test()
 	log_test "IGMPv2 leave $TEST_GROUP"
 }
 
+check_sg_entries()
+{
+	local report=$1; shift
+	local slist=("$@")
+	local sarg=""
+
+	for src in "${slist[@]}"; do
+		sarg="${sarg} and .source_list[].address == \"$src\""
+	done
+	bridge -j -d -s mdb show dev br0 \
+		| jq -e ".[].mdb[] | \
+			 select(.grp == \"$TEST_GROUP\" and .source_list != null $sarg)" &>/dev/null
+	check_err $? "Wrong *,G entry source list after $report report"
+
+	for sgent in "${slist[@]}"; do
+		bridge -j -d -s mdb show dev br0 \
+			| jq -e ".[].mdb[] | \
+				 select(.grp == \"$TEST_GROUP\" and .src == \"$sgent\")" &>/dev/null
+		check_err $? "Missing S,G entry ($sgent, $TEST_GROUP)"
+	done
+}
+
+check_sg_fwding()
+{
+	local should_fwd=$1; shift
+	local sources=("$@")
+
+	for src in "${sources[@]}"; do
+		local retval=0
+
+		mcast_packet_test $TEST_GROUP_MAC $src $TEST_GROUP $h2 $h1
+		retval=$?
+		if [ $should_fwd -eq 1 ]; then
+			check_fail $retval "Didn't forward traffic from S,G ($src, $TEST_GROUP)"
+		else
+			check_err $retval "Forwarded traffic for blocked S,G ($src, $TEST_GROUP)"
+		fi
+	done
+}
+
+check_sg_state()
+{
+	local is_blocked=$1; shift
+	local sources=("$@")
+	local should_fail=1
+
+	if [ $is_blocked -eq 1 ]; then
+		should_fail=0
+	fi
+
+	for src in "${sources[@]}"; do
+		bridge -j -d -s mdb show dev br0 \
+			| jq -e ".[].mdb[] | \
+				 select(.grp == \"$TEST_GROUP\" and .source_list != null) |
+				 .source_list[] |
+				 select(.address == \"$src\") |
+				 select(.timer == \"0.00\")" &>/dev/null
+		check_err_fail $should_fail $? "Entry $src has zero timer"
+
+		bridge -j -d -s mdb show dev br0 \
+			| jq -e ".[].mdb[] | \
+				 select(.grp == \"$TEST_GROUP\" and .src == \"$src\" and \
+				 .flags[] == \"blocked\")" &>/dev/null
+		check_err_fail $should_fail $? "Entry $src has blocked flag"
+	done
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.25.4

