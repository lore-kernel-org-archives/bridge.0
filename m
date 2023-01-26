Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC8B481759
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 057B98149A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdvkyOWqkuTdF5Uiph75HRDRDgwnL0E63JwfbM2XHlc=;
 b=VyBH/EuEraq+uTgEFyKITAr4NWuDYAjGGziXaJmfTPpfNIlEI8pjYpDoydSYAUOSE/L/3XBDXRZDZp/jwQb8FoftPQl3TpIVdrN/t4Xcm4IKR/qPpP1LfHqhdx36XsMkxWvj8Dwbgxlqsi2/KfoTEoCSe7XwOpFNWw+LfwaZ56TrBLOYZ/FfB8kyNzWy3XQQNhgbMt1Bd3CiZogOPi8bygTP/nMtw1DFeYQrag6i6eTz82xhuiOi6+5vZxNN+fwmkNVvo2SK9o/bXZeFLCrW2TgqDPD6ludTLu7ChaHoJHtM4zOxbhAJR9s2h4/2zCjrTUxnci7otVYXUuwhLrnqgw==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:09 +0100
Message-ID: <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
In-Reply-To: <cover.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 01/16] net: bridge: Set strict_start_type
	at two policies
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

Make any attributes newly-added to br_port_policy or vlan_tunnel_policy
parsed strictly, to prevent userspace from passing garbage. Note that this
patchset only touches the former policy. The latter was adjusted for
completeness' sake. There do not appear to be other _deprecated calls
with non-NULL policies.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c        | 2 ++
 net/bridge/br_netlink_tunnel.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 4316cc82ae17..a6133d469885 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -858,6 +858,8 @@ static int br_afspec(struct net_bridge *br,
 }
 
 static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
+	[IFLA_BRPORT_UNSPEC]	= { .strict_start_type =
+					IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT + 1 },
 	[IFLA_BRPORT_STATE]	= { .type = NLA_U8 },
 	[IFLA_BRPORT_COST]	= { .type = NLA_U32 },
 	[IFLA_BRPORT_PRIORITY]	= { .type = NLA_U16 },
diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 8914290c75d4..17abf092f7ca 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -188,6 +188,9 @@ int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 }
 
 static const struct nla_policy vlan_tunnel_policy[IFLA_BRIDGE_VLAN_TUNNEL_MAX + 1] = {
+	[IFLA_BRIDGE_VLAN_TUNNEL_UNSPEC] = {
+		.strict_start_type = IFLA_BRIDGE_VLAN_TUNNEL_FLAGS + 1
+	},
 	[IFLA_BRIDGE_VLAN_TUNNEL_ID] = { .type = NLA_U32 },
 	[IFLA_BRIDGE_VLAN_TUNNEL_VID] = { .type = NLA_U16 },
 	[IFLA_BRIDGE_VLAN_TUNNEL_FLAGS] = { .type = NLA_U16 },
-- 
2.39.0

