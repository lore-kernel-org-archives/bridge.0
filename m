Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 13 Aug 2015 05:54:07 +0200
Message-Id: <1439438047-19441-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: fix wrong skb_get() usage / crash in IGMP/MLD
 parsing code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: Brenden Blanco <bblanco@plumgrid.com>, Herbert Xu <herbert@gondor.apana.org.au>, Alexei Starovoitov <alexei.starovoitov@gmail.com>

The recent refactoring of the IGMP and MLD parsing code into
ipv6_mc_check_mld() / ip_mc_check_igmp() introduced a potential crash /
BUG() invocation for bridges:

I wrongly assumed that skb_get() could be used as a simple reference
counter for an skb which is not the case. skb_get() bears additional
semantics, a user count. This leads to a BUG() invocation in
pskb_expand_head() / kernel panic if pskb_may_pull() is called on an skb
with a user count greater than one - unfortunately the refactoring did
just that.

Fixing this by removing the skb_get() call and changing the API: The
caller of ipv6_mc_check_mld() / ip_mc_check_igmp() now needs to
additionally check whether the returned skb_trimmed is a clone.

Fixes: 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
Reported-by: Brenden Blanco <bblanco@plumgrid.com>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c |    4 ++--
 net/core/skbuff.c         |   37 ++++++++++++++++++-------------------
 net/ipv4/igmp.c           |   33 ++++++++++++++++++---------------
 net/ipv6/mcast_snoop.c    |   33 ++++++++++++++++++---------------
 4 files changed, 56 insertions(+), 51 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0b39dcc..1285eaf 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1591,7 +1591,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 		break;
 	}
 
-	if (skb_trimmed)
+	if (skb_trimmed && skb_trimmed != skb)
 		kfree_skb(skb_trimmed);
 
 	return err;
@@ -1636,7 +1636,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 		break;
 	}
 
-	if (skb_trimmed)
+	if (skb_trimmed && skb_trimmed != skb)
 		kfree_skb(skb_trimmed);
 
 	return err;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b6a19ca..bf9a5d9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4022,8 +4022,8 @@ EXPORT_SYMBOL(skb_checksum_setup);
  * Otherwise returns the provided skb. Returns NULL in error cases
  * (e.g. transport_len exceeds skb length or out-of-memory).
  *
- * Caller needs to set the skb transport header and release the returned skb.
- * Provided skb is consumed.
+ * Caller needs to set the skb transport header and free any returned skb if it
+ * differs from the provided skb.
  */
 static struct sk_buff *skb_checksum_maybe_trim(struct sk_buff *skb,
 					       unsigned int transport_len)
@@ -4032,16 +4032,12 @@ static struct sk_buff *skb_checksum_maybe_trim(struct sk_buff *skb,
 	unsigned int len = skb_transport_offset(skb) + transport_len;
 	int ret;
 
-	if (skb->len < len) {
-		kfree_skb(skb);
+	if (skb->len < len)
 		return NULL;
-	} else if (skb->len == len) {
+	else if (skb->len == len)
 		return skb;
-	}
 
 	skb_chk = skb_clone(skb, GFP_ATOMIC);
-	kfree_skb(skb);
-
 	if (!skb_chk)
 		return NULL;
 
@@ -4066,8 +4062,8 @@ static struct sk_buff *skb_checksum_maybe_trim(struct sk_buff *skb,
  * If the skb has data beyond the given transport length, then a
  * trimmed & cloned skb is checked and returned.
  *
- * Caller needs to set the skb transport header and release the returned skb.
- * Provided skb is consumed.
+ * Caller needs to set the skb transport header and free any returned skb if it
+ * differs from the provided skb.
  */
 struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 				     unsigned int transport_len,
@@ -4079,23 +4075,26 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 	skb_chk = skb_checksum_maybe_trim(skb, transport_len);
 	if (!skb_chk)
-		return NULL;
+		goto err;
 
-	if (!pskb_may_pull(skb_chk, offset)) {
-		kfree_skb(skb_chk);
-		return NULL;
-	}
+	if (!pskb_may_pull(skb_chk, offset))
+		goto err;
 
 	__skb_pull(skb_chk, offset);
 	ret = skb_chkf(skb_chk);
 	__skb_push(skb_chk, offset);
 
-	if (ret) {
-		kfree_skb(skb_chk);
-		return NULL;
-	}
+	if (ret)
+		goto err;
 
 	return skb_chk;
+
+err:
+	if (skb_chk && skb_chk != skb)
+		kfree_skb(skb_chk);
+
+	return NULL;
+
 }
 EXPORT_SYMBOL(skb_checksum_trimmed);
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 651cdf6..9fdfd9d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1435,33 +1435,35 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 	struct sk_buff *skb_chk;
 	unsigned int transport_len;
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct igmphdr);
-	int ret;
+	int ret = -EINVAL;
 
 	transport_len = ntohs(ip_hdr(skb)->tot_len) - ip_hdrlen(skb);
 
-	skb_get(skb);
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ip_mc_validate_checksum);
 	if (!skb_chk)
-		return -EINVAL;
+		goto err;
 
-	if (!pskb_may_pull(skb_chk, len)) {
-		kfree_skb(skb_chk);
-		return -EINVAL;
-	}
+	if (!pskb_may_pull(skb_chk, len))
+		goto err;
 
 	ret = ip_mc_check_igmp_msg(skb_chk);
-	if (ret) {
-		kfree_skb(skb_chk);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	if (skb_trimmed)
 		*skb_trimmed = skb_chk;
-	else
+	/* free now unneeded clone */
+	else if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return 0;
+	ret = 0;
+
+err:
+	if (ret && skb_chk && skb_chk != skb)
+		kfree_skb(skb_chk);
+
+	return ret;
 }
 
 /**
@@ -1470,7 +1472,7 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
  * @skb_trimmed: to store an skb pointer trimmed to IPv4 packet tail (optional)
  *
  * Checks whether an IPv4 packet is a valid IGMP packet. If so sets
- * skb network and transport headers accordingly and returns zero.
+ * skb transport header accordingly and returns zero.
  *
  * -EINVAL: A broken packet was detected, i.e. it violates some internet
  *  standard
@@ -1485,7 +1487,8 @@ static int __ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
  * to leave the original skb and its full frame unchanged (which might be
  * desirable for layer 2 frame jugglers).
  *
- * The caller needs to release a reference count from any returned skb_trimmed.
+ * Caller needs to set the skb network header and free any returned skb if it
+ * differs from the provided skb.
  */
 int ip_mc_check_igmp(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 {
diff --git a/net/ipv6/mcast_snoop.c b/net/ipv6/mcast_snoop.c
index df8afe5..9405b04 100644
--- a/net/ipv6/mcast_snoop.c
+++ b/net/ipv6/mcast_snoop.c
@@ -143,34 +143,36 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
 	struct sk_buff *skb_chk = NULL;
 	unsigned int transport_len;
 	unsigned int len = skb_transport_offset(skb) + sizeof(struct mld_msg);
-	int ret;
+	int ret = -EINVAL;
 
 	transport_len = ntohs(ipv6_hdr(skb)->payload_len);
 	transport_len -= skb_transport_offset(skb) - sizeof(struct ipv6hdr);
 
-	skb_get(skb);
 	skb_chk = skb_checksum_trimmed(skb, transport_len,
 				       ipv6_mc_validate_checksum);
 	if (!skb_chk)
-		return -EINVAL;
+		goto err;
 
-	if (!pskb_may_pull(skb_chk, len)) {
-		kfree_skb(skb_chk);
-		return -EINVAL;
-	}
+	if (!pskb_may_pull(skb_chk, len))
+		goto err;
 
 	ret = ipv6_mc_check_mld_msg(skb_chk);
-	if (ret) {
-		kfree_skb(skb_chk);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	if (skb_trimmed)
 		*skb_trimmed = skb_chk;
-	else
+	/* free now unneeded clone */
+	else if (skb_chk != skb)
 		kfree_skb(skb_chk);
 
-	return 0;
+	ret = 0;
+
+err:
+	if (ret && skb_chk && skb_chk != skb)
+		kfree_skb(skb_chk);
+
+	return ret;
 }
 
 /**
@@ -179,7 +181,7 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
  * @skb_trimmed: to store an skb pointer trimmed to IPv6 packet tail (optional)
  *
  * Checks whether an IPv6 packet is a valid MLD packet. If so sets
- * skb network and transport headers accordingly and returns zero.
+ * skb transport header accordingly and returns zero.
  *
  * -EINVAL: A broken packet was detected, i.e. it violates some internet
  *  standard
@@ -194,7 +196,8 @@ static int __ipv6_mc_check_mld(struct sk_buff *skb,
  * to leave the original skb and its full frame unchanged (which might be
  * desirable for layer 2 frame jugglers).
  *
- * The caller needs to release a reference count from any returned skb_trimmed.
+ * Caller needs to set the skb network header and free any returned skb if it
+ * differs from the provided skb.
  */
 int ipv6_mc_check_mld(struct sk_buff *skb, struct sk_buff **skb_trimmed)
 {
-- 
1.7.10.4

