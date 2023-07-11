Return-Path: <prvs=549678ead=kuniyu@amazon.co.jp>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33EC941E4A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BC2841E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1689119669; x=1720655669;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S31tc4n4Ui6HS+LailK8v4AO1tjvB2dHTdcwzIgGBFk=;
 b=fsaCeF2b7BODBn9dkEYnt0kziFvuHCDiVjV0clIAnMGJmsoxSjCMBoH8
 CSwkfkWb2GXz3kL4abrqFs0BugDi6bBGUWWsWBQdMvBLFKaSGUgncdw9M
 R2MIxvdnJPoXLu7AGRJynRyg/X07EqAkndj3I9Bydy4csWnkC1vZ9c2CA M=;
From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 11 Jul 2023 16:54:15 -0700
Message-ID: <20230711235415.92166-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH v1 net] bridge: Return an error when enabling STP
	in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kuniyuki Iwashima <kuniyu@amazon.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin <hcoin@quietfountain.com>, Kuniyuki Iwashima <kuni1840@gmail.com>

When we create an L2 loop on a bridge in netns, we will see packets storm
even if STP is enabled.

  # unshare -n
  # ip link add br0 type bridge
  # ip link add veth0 type veth peer name veth1
  # ip link set veth0 master br0 up
  # ip link set veth1 master br0 up
  # ip link set br0 type bridge stp_state 1
  # ip link set br0 up
  # sleep 30
  # ip -s link show br0
  2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
      link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
      RX: bytes  packets  errors  dropped missed  mcast
      956553768  12861249 0       0       0       12861249  <-. Keep
      TX: bytes  packets  errors  dropped carrier collsns     |  increasing
      1027834    11951    0       0       0       0         <-'   rapidly

This is because llc_rcv() drops all packets in non-root netns and BPDU
is dropped.

Let's show an error when enabling STP in netns.

  # unshare -n
  # ip link add br0 type bridge
  # ip link set br0 type bridge stp_state 1
  Error: bridge: STP can't be enabled in non-root netns.

Note this commit will be reverted later when we namespacify the whole LLC
infra.

Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
Suggested-by: Harry Coin <hcoin@quietfountain.com>
Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/bridge/br_stp_if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d36d7f9..a807996ac56b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net)) {
+		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
+		return -EINVAL;
+	}
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
-- 
2.30.2

