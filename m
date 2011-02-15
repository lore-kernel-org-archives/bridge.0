From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:21 +0100
Message-Id: <1297811961-19249-6-git-send-email-linus.luessing@web.de>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] [PATCH 5/5] bridge: Allow mcast snooping for transient
	link local addresses too
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>

Currently the multicast bridge snooping support is not active for
link local multicast. I assume this has been done to leave
important multicast data untouched, like IPv6 Neighborhood Discovery.

In larger, bridged, local networks it could however be desirable to
optimize for instance local multicast audio/video streaming too.

With the transient flag in IPv6 multicast addresses we have an easy
way to optimize such multimedia traffic without tempering with the
high priority multicast data from well-known addresses.

This patch alters the multicast bridge snooping for IPv6, to take
effect for transient multicast addresses instead of non-link-local
addresses.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 net/bridge/br_multicast.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e8fdaab..b5eb28a 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -37,10 +37,9 @@
 	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-static inline int ipv6_is_local_multicast(const struct in6_addr *addr)
+static inline int ipv6_is_transient_multicast(const struct in6_addr *addr)
 {
-	if (ipv6_addr_is_multicast(addr) &&
-	    IPV6_ADDR_MC_SCOPE(addr) <= IPV6_ADDR_SCOPE_LINKLOCAL)
+	if (ipv6_addr_is_multicast(addr) && IPV6_ADDR_MC_FLAG_TRANSIENT(addr))
 		return 1;
 	return 0;
 }
@@ -781,7 +780,7 @@ static int br_ip6_multicast_add_group(struct net_bridge *br,
 {
 	struct br_ip br_group;
 
-	if (ipv6_is_local_multicast(group))
+	if (!ipv6_is_transient_multicast(group))
 		return 0;
 
 	ipv6_addr_copy(&br_group.u.ip6, group);
@@ -1342,7 +1341,7 @@ static void br_ip6_multicast_leave_group(struct net_bridge *br,
 {
 	struct br_ip br_group;
 
-	if (ipv6_is_local_multicast(group))
+	if (!ipv6_is_transient_multicast(group))
 		return;
 
 	ipv6_addr_copy(&br_group.u.ip6, group);
-- 
1.7.2.3

