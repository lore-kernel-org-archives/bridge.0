Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38980822DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54FEA822E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unZIVLZjFEKbYFMIB3J78jjRpX+nGMx659EWcFNWJ/Q=;
 b=dOL5EYiVj6vJ5DzQ8ZA34E4m+RkLkqYfY99Q1keIg3SCGJxLeozACCMqrjrxnEeVGBybAgpBkVpqv/u+pmXkHDATNM5SopAm8QpxqQ2sSQ6f53CUnCZF6Trz7PsUL6ygOKP9ZPb/knL2T87BlGguE+6Yy9CBhvtBI2KvrWr0JghZkd/SfNEo7sm9Ip0vRZLltbJjDTt8PPE7MLx2WPo6OiOvmOzgBr5hQCPpoz08gHKLvKD/iHGBmnaao53468iHrkkYdPlZnlxTQbpbaB1P2I2rPZbdA45clbmJhY54WHGshIbDXbxn9jFajvPDenjG1E0NBFTHC8Mgsi+Yc3ME6w==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:18 +0100
Message-ID: <064ee17ac1c20603b3530a23e0ca533d57450cfc.1674752051.git.petrm@nvidia.com>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 10/16] selftests: forwarding: bridge_mdb:
	Fix a typo
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

