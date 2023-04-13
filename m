Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5314A83EF3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A40BD83D04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skXPRlKWkSk3ULoRmhja+VCV6ct38IRkmTkeVzeQtt8=;
 b=R0yXcpkjnEReFt1dYor1NUAtw9ZLCs2ZgjoLqjAhpIPRCPoNje30yqY8MHLVdODnFJhjy6D+fhc+mQF70ZiH9sNFgi4LI2nK+X8ulfYEVU9soITkvLf7p8cqAq1C41ZdngPV6tOBILiC26VVPxBjXsBqcAoLfG8OJePcFxd/LaGB1ygVCyfamXXYBegy22/pjegjTrA+/acZYukX0KZMTtyf5nHyvRQtMogCxJ6q895NXEn56BTUir28OieZPxAKnTpFTQHDJCuaYC2tJK7HckjKemU8A22JjsR+MbLGnRDecWPJ2R02maYUuYgxw1Ol19eY4aAXMezisvXfd16+BA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:22 +0300
Message-Id: <20230413095830.2182382-2-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 1/9] bridge: Reorder neighbor
	suppression check when flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The bridge does not flood ARP / NS packets for which a reply was sent to
bridge ports that have neighbor suppression enabled.

Subsequent patches are going to add per-{Port, VLAN} neighbor
suppression, which is going to make it more expensive to check whether
neighbor suppression is enabled since a VLAN lookup will be required.

Therefore, instead of unnecessarily performing this lookup for every
packet, only perform it for ARP / NS packets for which a reply was sent.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8d..0fe133fa214c 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -224,8 +224,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		/* Do not flood to ports that enable proxy ARP */
 		if (p->flags & BR_PROXYARP)
 			continue;
-		if ((p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)) &&
-		    BR_INPUT_SKB_CB(skb)->proxyarp_replied)
+		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied &&
+		    (p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)))
 			continue;
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
-- 
2.37.3

