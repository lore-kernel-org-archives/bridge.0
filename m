Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69158819BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9838A81A34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaDp6w1B8EvD+GP4cf4FpBO7+rXUo3RK+Z9b+7VLSPA=;
 b=YGgYqVrEAopRVHT2SClJyXuYpos1ptTrOHf62CMKDR2oIWe4mDnPAhiuyRrJkAfxg6EbNHiyC6JyZGDBfR2EtvqH3OcZzYpJeH314w6b1c8qNMsClfiLKfYPT4Lol6Im7jsFoy4Nhv84nNQQHqZ2+2ti8CXuQ+lyU4NXMxjvJMCcs9Z5vsM43Iwht6jNb7iaP60Zo08ZMk9iNiHME33bmeS297oeFjJHQ6gYd9mLfx/uzIUiF1BafO44cZu2m0JowGOQTVCez0Irmsfu+B31cmtPoAOfRvPDaA0kgYU9glfC8N2+CJGAG/n36SHfJVlDU6PO4a+ZzOBVJ5ikMt3frg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 13 Mar 2023 16:53:43 +0200
Message-Id: <20230313145349.3557231-6-idosch@nvidia.com>
In-Reply-To: <20230313145349.3557231-1-idosch@nvidia.com>
References: <20230313145349.3557231-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 05/11] vxlan: Move address helpers to
	private headers
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

Move the helpers out of the core C file to the private header so that
they could be used by the upcoming MDB code.

While at it, constify the second argument of vxlan_nla_get_addr().

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    | 47 -------------------------------
 drivers/net/vxlan/vxlan_private.h | 45 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b1b179effe2a..a3106abc2b52 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -71,53 +71,6 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 	       ip_tunnel_collect_metadata();
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
-		ip->sa.sa_family = AF_INET6;
-		return 0;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	if (ip->sa.sa_family == AF_INET6)
-		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
-	else
-		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-
-#else /* !CONFIG_IPV6 */
-
-static int vxlan_nla_get_addr(union vxlan_addr *ip, struct nlattr *nla)
-{
-	if (nla_len(nla) >= sizeof(struct in6_addr)) {
-		return -EAFNOSUPPORT;
-	} else if (nla_len(nla) >= sizeof(__be32)) {
-		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
-		ip->sa.sa_family = AF_INET;
-		return 0;
-	} else {
-		return -EAFNOSUPPORT;
-	}
-}
-
-static int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
-			      const union vxlan_addr *ip)
-{
-	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
-}
-#endif
-
 /* Find VXLAN socket based on network namespace, address family, UDP port,
  * enabled unshareable flags and socket device binding (see l3mdev with
  * non-default VRF).
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 599c3b4fdd5e..038528f9684a 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -85,6 +85,31 @@ bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
 		return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
 }
 
+static inline int vxlan_nla_get_addr(union vxlan_addr *ip,
+				     const struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		ip->sin6.sin6_addr = nla_get_in6_addr(nla);
+		ip->sa.sa_family = AF_INET6;
+		return 0;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static inline int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+				     const union vxlan_addr *ip)
+{
+	if (ip->sa.sa_family == AF_INET6)
+		return nla_put_in6_addr(skb, attr, &ip->sin6.sin6_addr);
+	else
+		return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+
 #else /* !CONFIG_IPV6 */
 
 static inline
@@ -93,6 +118,26 @@ bool vxlan_addr_equal(const union vxlan_addr *a, const union vxlan_addr *b)
 	return a->sin.sin_addr.s_addr == b->sin.sin_addr.s_addr;
 }
 
+static inline int vxlan_nla_get_addr(union vxlan_addr *ip,
+				     const struct nlattr *nla)
+{
+	if (nla_len(nla) >= sizeof(struct in6_addr)) {
+		return -EAFNOSUPPORT;
+	} else if (nla_len(nla) >= sizeof(__be32)) {
+		ip->sin.sin_addr.s_addr = nla_get_in_addr(nla);
+		ip->sa.sa_family = AF_INET;
+		return 0;
+	} else {
+		return -EAFNOSUPPORT;
+	}
+}
+
+static inline int vxlan_nla_put_addr(struct sk_buff *skb, int attr,
+				     const union vxlan_addr *ip)
+{
+	return nla_put_in_addr(skb, attr, ip->sin.sin_addr.s_addr);
+}
+
 #endif
 
 static inline struct vxlan_vni_node *
-- 
2.37.3

