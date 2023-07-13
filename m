Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F206B40A85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D78740640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO+uLIS1dBPXdBfEZBh1qciQOB31Z7EWfy/iI61kG3U=;
 b=TSd/fVqwfGkGK+V9wHKxLAfT/8qS9YNeGxGT5w6/hxbXbyYocwKENplJInpwCssyvZGTt03NccVsb4sgAR5M1oeKJDdFaaTEzLLrpV0nnNvYaL/T9polHXXLlSEnn8Elo7pwZxzwu7ZRLQxjBxWx5T/yiqcyCJZtrIGd1cA8CB993L1RiG5QuVL3WUkE23kLYVvvMwFIlKS29YsELIlqP5Kha+a6laco0rN8DVwUBKCfF/AijI9KHNRLO5ijUZFnYCQfCtUr55ZpxBj4glxe0g4YOevsyf6FRXVAu0sTVHp/UVIJbs+y4u27bKdsyVufSafiCpxjLuf/GyKKyOW1+w==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Jul 2023 10:09:22 +0300
Message-ID: <20230713070925.3955850-2-idosch@nvidia.com>
In-Reply-To: <20230713070925.3955850-1-idosch@nvidia.com>
References: <20230713070925.3955850-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [RFC PATCH net-next 1/4] ip_tunnels: Add nexthop ID field
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

