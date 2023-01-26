Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFCF64171D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F7F941706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEmIO7uxrQsYrcorJVreuzMKZo4Grzx8cK37H/rcF50=;
 b=tR5qBPXRJFJYBglwnePnczI1sE0BFcCuWQgspXvKU3qMOe0Ef0A8spzf9OC8g/SAgjA0ySsxNdiGq67oaRwqFRxm7EBdGUN2gjR/D5E4V4Ah9sW+L1Qo1TqMS5ovyTtzOp0lQxzOZMUkqyeWVl8/1rz2Ohk490ewYMTX/c4ks2jadHWk1MAW/WjS7hBsRbyYtodCXgAI1EiQR+8OcqWiY0VDu9Cm9MjcKGtxEafOu1Gu3K//53/J0THDNQ1hjc0TIjgQXoF3PV55JHE+JYerphuUljYtBinEC+CXo+kCrkz5gUUSi/j3HhV9CNAhL3yVTAjFNjyIw4i0k0W0/tZyIw==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:19 +0100
Message-ID: <cc8762f78b2468f9b48288235470bd606fddbd96.1674752051.git.petrm@nvidia.com>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 11/16] selftests: forwarding: lib: Add
	helpers for IP address handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

In order to generate IGMPv3 and MLDv2 packets on the fly, we will need
helpers to expand IPv4 and IPv6 addresses given as parameters in
mausezahn payload notation. Add helpers that do it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index db2534f7e49b..8f7e2cc8b779 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1693,6 +1693,43 @@ hw_stats_monitor_test()
 	log_test "${type}_stats notifications"
 }
 
+ipv4_to_bytes()
+{
+	local IP=$1; shift
+
+	printf '%02x:' ${IP//./ } |
+	    sed 's/:$//'
+}
+
+# Convert a given IPv6 address, `IP' such that the :: token, if present, is
+# expanded, and each 16-bit group is padded with zeroes to be 4 hexadecimal
+# digits. An optional `BYTESEP' parameter can be given to further separate
+# individual bytes of each 16-bit group.
+expand_ipv6()
+{
+	local IP=$1; shift
+	local bytesep=$1; shift
+
+	local cvt_ip=${IP/::/_}
+	local colons=${cvt_ip//[^:]/}
+	local allcol=:::::::
+	# IP where :: -> the appropriate number of colons:
+	local allcol_ip=${cvt_ip/_/${allcol:${#colons}}}
+
+	echo $allcol_ip | tr : '\n' |
+	    sed s/^/0000/ |
+	    sed 's/.*\(..\)\(..\)/\1'"$bytesep"'\2/' |
+	    tr '\n' : |
+	    sed 's/:$//'
+}
+
+ipv6_to_bytes()
+{
+	local IP=$1; shift
+
+	expand_ipv6 "$IP" :
+}
+
 igmpv3_is_in_get()
 {
 	local igmpv3
-- 
2.39.0

