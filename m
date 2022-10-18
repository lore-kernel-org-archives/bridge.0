Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC2C082F9E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 317A382F57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OLA8im292j50G4H7CGX2bZcE99PG35GfR8G4o7ySLk=;
 b=gc9nxTPs9YYYBjHrAt2ecEXyCfvy60jQTovRXzb7f1GLu9vRf1MOqSNLGNfLGSxDb2SNPVnTcY7p6lXo2uEvCw9Ih0gwSjKBnadk5eLiB5NT4vb8yKF62UnDGovEqGBd2dT1BfMxd4BGgauToWIIxSt1PnJYvIV3wRvWsZX0AJgxSppA5Ro/H1bo+KQ15J0Qt7Tot2Ybzu8Kn045r/Km01lgr77Go1hCSu133L/6JIALK9ODmc2vIyNMFs46sUxN3/V1W5NYtgsotdh9bqNrplUs8INenx/nI4SAQB6gHv3ok4Chk619SDVi1DMRO2lueHy1wVVO1H6J96s2zNeUaA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 09:39:59 +0300
Message-Id: <20221018064001.518841-3-idosch@nvidia.com>
In-Reply-To: <20221018064001.518841-1-idosch@nvidia.com>
References: <20221018064001.518841-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 2/4] selftests: bridge_igmp: Remove
	unnecessary address deletion
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

The test group address is added and removed in v2reportleave_test().
There is no need to delete it again during cleanup as it results in the
following error message:

 # bash -x ./bridge_igmp.sh
 [...]
 + cleanup
 + pre_cleanup
 [...]
 + ip address del dev swp4 239.10.10.10/32
 RTNETLINK answers: Cannot assign requested address
 + h2_destroy

Solve by removing the unnecessary address deletion.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 1162836f8f32..2aa66d2a1702 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -96,9 +96,6 @@ cleanup()
 
 	switch_destroy
 
-	# Always cleanup the mcast group
-	ip address del dev $h2 $TEST_GROUP/32 2>&1 1>/dev/null
-
 	h2_destroy
 	h1_destroy
 
-- 
2.37.3

