Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77F0470894
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1D8470888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgtxxFCzn3VC8mcorTKgWJMxgzUkHqpP5BMNrJF1fF0=;
 b=CRzz/OATWmaKUTO3y9P2UynuZf7XMzoZDuFMjgs1CALdirnGk9v4CC7LivmsMDbmEHSYnDTDYH9We5jWvTPmwDPRGbZlZnpXsu6JmmCecQG3rhczonCwmj93EWgyiboQPi2W3vJ8pN79TlDQ1Bze7v8xzfI94GpVvKbONIBfex5y3dWH2PYU7CnYK68fhLdB+9d9mbS9HzbUQjUdsnJEl3cTcDPMJcGROJKlDg42I7rWw1qBghcJCJ3TD2A+el9EPZJGXJ95RnNZaC5AC5y4NPbYDkse5XapOi7K2jVBbzjrPbilENB9pKPFrqt5AkLXBFv3eqJ8ir1/vcHSFJ72FQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:08 +0300
Message-ID: <20231025123020.788710-2-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 01/13] bridge: mcast: Dump MDB entries
	even when snooping is disabled
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

Currently, the bridge driver does not dump MDB entries when multicast
snooping is disabled although the entries are present in the kernel:

 # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ff9d:e61b temp
 # ip link set dev br0 type bridge mcast_snooping 0
 # bridge mdb show dev br0
 # ip link set dev br0 type bridge mcast_snooping 1
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ff9d:e61b temp

This behavior differs from other netlink dump interfaces that dump
entries regardless if they are used or not. For example, VLANs are
dumped even when VLAN filtering is disabled:

 # ip link set dev br0 type bridge vlan_filtering 0
 # bridge vlan show dev swp1
 port              vlan-id
 swp1              1 PVID Egress Untagged

Remove the check and always dump MDB entries:

 # bridge mdb add dev br0 port swp1 grp 239.1.1.1 permanent
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp
 # ip link set dev br0 type bridge mcast_snooping 0
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp
 # ip link set dev br0 type bridge mcast_snooping 1
 # bridge mdb show dev br0
 dev br0 port swp1 grp 239.1.1.1 permanent
 dev br0 port br0 grp ff02::6a temp
 dev br0 port br0 grp ff02::1:ffeb:1a4d temp

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7305f5f8215c..fb58bb1b60e8 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -323,9 +323,6 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net_bridge_mdb_entry *mp;
 	struct nlattr *nest, *nest2;
 
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		return 0;
-
 	nest = nla_nest_start_noflag(skb, MDBA_MDB);
 	if (nest == NULL)
 		return -EMSGSIZE;
-- 
2.40.1

