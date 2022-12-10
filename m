Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BC6440483
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C490E4047C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mwLfxSWuHXHhKMuieNDUM3tBBmhZ01RMiC5XcCnZss=;
 b=tU0RshxEGC2gRj3vxZS2hsR8UeVpsM6cyZD5Q9bxWZZQ0Pk/WqRPn+hRYHQQAXqH3PHDP1MkJJA83TR+FnJuG78qpBWeV1+jz0Tp/pQbhRtF6RkNassKZ4vhPbJ6IU8q9tK66kdDF9Q32hfKpRzaMqq9qs2ZHBRUqIAUvhnigrN1XhL6UUAPdLx9nrNHb2DrtPoLZw1j5/G4Gn0ZB+HiWhu8cJ4pgyArJy8tPLunJoMvyOam+HLUQpJcBiojMZXM/ZjpiNcFgmifu42pKbFbC3eDXmiuxIN0Evze1ftNmVaPtdjHLp/6IqJUWtl7vwxpnbYny+6YxnlTRFppxpnoRw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat, 10 Dec 2022 16:56:32 +0200
Message-Id: <20221210145633.1328511-14-idosch@nvidia.com>
In-Reply-To: <20221210145633.1328511-1-idosch@nvidia.com>
References: <20221210145633.1328511-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 13/14] selftests: forwarding: Rename
	bridge_mdb test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The test is only concerned with host MDB entries and not with MDB
entries as a whole. Rename the test to reflect that.

Subsequent patches will add a more general test that will contain the
test cases for host MDB entries and remove the current test.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 tools/testing/selftests/net/forwarding/Makefile                 | 2 +-
 .../net/forwarding/{bridge_mdb.sh => bridge_mdb_host.sh}        | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/net/forwarding/{bridge_mdb.sh => bridge_mdb_host.sh} (100%)

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index a9c5c1be5088..f2df81ca3179 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -2,7 +2,7 @@
 
 TEST_PROGS = bridge_igmp.sh \
 	bridge_locked_port.sh \
-	bridge_mdb.sh \
+	bridge_mdb_host.sh \
 	bridge_mdb_port_down.sh \
 	bridge_mld.sh \
 	bridge_port_isolation.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_host.sh
similarity index 100%
rename from tools/testing/selftests/net/forwarding/bridge_mdb.sh
rename to tools/testing/selftests/net/forwarding/bridge_mdb_host.sh
-- 
2.37.3

