Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A62B741A15
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3E44419AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wala80QlVvUe+kGD829okTyjeaN7hjQ1PvUoebul3c8=;
 b=oEJ6t2Ool+GxuzSyQNvFqj5MdwCF1JLl8f0MpFHJ1oZscQrYnvz48fVPlPx2rKqZlUXeFN+E0FthyjwUu1zIxVgjZK6N0xKuvxtux3b/hpmDWQgpWfSuBL+U6z7Ceabb4w/xmmdKXaQ8nOv00DM1Qj8bIPX/RTndwdsmfcwIf9cOmW9Z2Bxw9o+xbqJqQb28qTx/3S6lDwbiGPnKNIwShKkNfUEgbj1AHzNSXWNAnK4hp6Iu/NpSITkXVNNmugIwXnB2KgNeUKqHJdXhlhxQgjtKQ7nk18KO4s83MRE8/dUti0aPU1awPC/582oJjtfrn9YfvDzOM/j1/axi61qK7w==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:44 +0100
Message-ID: <b3ea6cacbd5368e0e9f9495902730c3c6ae44dc3.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 11/16] selftests: forwarding:
	lib: Add helpers for IP address handling
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 0cfa0b699803..409ff3799b55 100755
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

