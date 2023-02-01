Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87E6081F2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD7E281F26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QfwDjRcqFxkcs4B67gJfwkJ/lZDxYu654RNOFOi9rw=;
 b=BurUQIx/z78d/zozfSe6Oc0ZOTkt5bUkbolGS5SgtMAEYy2eVi6VdZXU5IIyRKFdUcJwlVOPcyaa6diNaV0QoVpMjPAx81CnEZhCFn9GzgctK0CSDCZR2lD605ml1b9GLSD1JFvtc0PVZExNrtm6uCT2sOG7B6a9gGXV8fCMvdwGiLkzjgeZHBHqBF+AxPX2lRqxTMU5pdfJxLU/HiwTB7iCbPuCF5Jvz0jVW0PErK2lTtHYzKxDJd5r9l9Cmqk3T7oZVkd/iComeDiESR/yIvoEqH08aQaymF0A9vFHbv2bdlU4/arV7fLukZNro6QiZG/Z1NtT3UhxI87c3d/P4w==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:43 +0100
Message-ID: <aad4cf4f3f59aa652a2aae0033df95af91dba055.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 10/16] selftests: forwarding:
	bridge_mdb: Fix a typo
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

Add the letter missing from the word "INCLUDE".

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 51f2b0d77067..4e16677f02ba 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1054,7 +1054,7 @@ ctrl_igmpv3_is_in_test()
 
 	bridge mdb del dev br0 port $swp1 grp 239.1.1.1 vid 10
 
-	log_test "IGMPv3 MODE_IS_INCLUE tests"
+	log_test "IGMPv3 MODE_IS_INCLUDE tests"
 }
 
 ctrl_mldv2_is_in_test()
-- 
2.39.0

