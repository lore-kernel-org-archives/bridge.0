Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEE4D4010C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FE1C40012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHnrAb6jHBkVv4Flz3tgHmHWAuQ1pTAPUlLP8SHsiUk=;
 b=sBbpyKbDwNrTas8RvCGhR9j9wmpBXJUivz9zDWw9mc/AY4Sg+SdTS2/rYmxZaflB7Pl8CzayGkQXCMWudEIaDtS7u10/uS1vAm4qa/SMeehdUvDCBCL8iRH4gAz62+7m7TjgPmbxRbNu42zzannFccM617M3HY0Kcx0TvY2D8NqEpXdikdFwm2wJccKTo3LNahfcR+LlR5gZHPomgn812+JYqvNWd1DMi3+qqgCg3V7tSUA/s8vMK17w+uLS8aA8vkyt4TX8ca6tkBE2R26n/P5M52vX8x8IQPC53za5MFlkg34aitM5F3FlxsQPjqDblGanwQT0v4MCBGwShOEvXQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 17 Jul 2023 11:12:26 +0300
Message-ID: <20230717081229.81917-2-idosch@nvidia.com>
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
References: <20230717081229.81917-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 1/4] ip_tunnels: Add nexthop ID field
	to ip_tunnel_key
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, taspelund@nvidia.com, Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org, dsahern@gmail.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Extend the ip_tunnel_key structure with a field indicating the ID of the
nexthop object via which the skb should be routed.

The field is going to be populated in subsequent patches by the bridge
driver in order to indicate to the VXLAN driver which FDB nexthop object
to use in order to reach the target host.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/ip_tunnels.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ed4b6ad3fcac..e8750b4ef7e1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -52,6 +52,7 @@ struct ip_tunnel_key {
 	u8			tos;		/* TOS for IPv4, TC for IPv6 */
 	u8			ttl;		/* TTL for IPv4, HL for IPv6 */
 	__be32			label;		/* Flow Label for IPv6 */
+	u32			nhid;
 	__be16			tp_src;
 	__be16			tp_dst;
 	__u8			flow_flags;
-- 
2.40.1

