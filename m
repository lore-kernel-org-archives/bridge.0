Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9ZecB7FYVOCdT8M0yq4Vnm4XxQvstglvD++Sjp0mO9k=; b=nF1demlo+MqDH7bOQoZ3yEEJGM
 mmGwDFKzdv4Q7lwgj3FQqO3JqEFYl+LBMa7TcvxYneP1omyk0IB9fsqurTQw8xa/QQLKiPxuO8rOy
 ZuM1qwf5/DPFY0TQkVsg0IO3T/4rsP0U/l7kHohmHCy6+1XCJO0wsVaBJo8P85GaYsqsXJ+O8DVek
 J03r4uWE25idyw13uhWSCmJMtIi79rpe7yJVZ3gGdjIJVV0dK8276gefNlukGjXRIgIhHBqKmZ5BU
 EzK0LeU+/P3HRiOsdwwxWCisjW91vPIlX5QVymdg5WZ6g0pOzpXgG71EHfgb9TlGWjzQghkdw6aXf
 zKGGhw/w==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:29 +0200
Message-Id: <20200717062331.691152-21-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 20/22] net/ipv6: factor out mcast join/leave
	setsockopt helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, Alexei Starovoitov <ast@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org, mptcp@lists.01.org, Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, bpf@vger.kernel.org, linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>

Factor out one helper each for setting the native and compat
version of the MCAST_MSFILTER option.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/ipv6_sockglue.c | 103 ++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 6aa49495d7bc0b..1ea0cd12beaee9 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -252,6 +252,56 @@ static int compat_ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
 }
 #endif
 
+static int ipv6_mcast_join_leave(struct sock *sk, int optname,
+		void __user *optval, int optlen)
+{
+	struct sockaddr_in6 *psin6;
+	struct group_req greq;
+
+	if (optlen < sizeof(greq))
+		return -EINVAL;
+	if (copy_from_user(&greq, optval, sizeof(greq)))
+		return -EFAULT;
+
+	if (greq.gr_group.ss_family != AF_INET6)
+		return -EADDRNOTAVAIL;
+	psin6 = (struct sockaddr_in6 *)&greq.gr_group;
+	if (optname == MCAST_JOIN_GROUP)
+		return ipv6_sock_mc_join(sk, greq.gr_interface,
+					 &psin6->sin6_addr);
+	return ipv6_sock_mc_drop(sk, greq.gr_interface, &psin6->sin6_addr);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_ipv6_mcast_join_leave(struct sock *sk, int optname,
+		void __user *optval, int optlen)
+{
+	struct compat_group_req gr32;
+	struct sockaddr_in6 *psin6;
+	int err;
+
+	if (optlen < sizeof(gr32))
+		return -EINVAL;
+	if (copy_from_user(&gr32, optval, sizeof(gr32)))
+		return -EFAULT;
+
+	if (gr32.gr_group.ss_family != AF_INET6)
+		return -EADDRNOTAVAIL;
+	rtnl_lock();
+	lock_sock(sk);
+	psin6 = (struct sockaddr_in6 *)&gr32.gr_group;
+	if (optname == MCAST_JOIN_GROUP)
+		err = ipv6_sock_mc_join(sk, gr32.gr_interface,
+					&psin6->sin6_addr);
+	else
+		err = ipv6_sock_mc_drop(sk, gr32.gr_interface,
+					&psin6->sin6_addr);
+	release_sock(sk);
+	rtnl_unlock();
+	return err;
+}
+#endif
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -803,29 +853,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
-	{
-		struct group_req greq;
-		struct sockaddr_in6 *psin6;
-
-		if (optlen < sizeof(struct group_req))
-			goto e_inval;
-
-		retv = -EFAULT;
-		if (copy_from_user(&greq, optval, sizeof(struct group_req)))
-			break;
-		if (greq.gr_group.ss_family != AF_INET6) {
-			retv = -EADDRNOTAVAIL;
-			break;
-		}
-		psin6 = (struct sockaddr_in6 *)&greq.gr_group;
-		if (optname == MCAST_JOIN_GROUP)
-			retv = ipv6_sock_mc_join(sk, greq.gr_interface,
-						 &psin6->sin6_addr);
-		else
-			retv = ipv6_sock_mc_drop(sk, greq.gr_interface,
-						 &psin6->sin6_addr);
+		retv = ipv6_mcast_join_leave(sk, optname, optval, optlen);
 		break;
-	}
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
@@ -975,34 +1004,8 @@ int compat_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
-	{
-		struct compat_group_req __user *gr32 = (void __user *)optval;
-		struct group_req greq;
-		struct sockaddr_in6 *psin6 = (struct sockaddr_in6 *)&greq.gr_group;
-
-		if (optlen < sizeof(struct compat_group_req))
-			return -EINVAL;
-
-		if (get_user(greq.gr_interface, &gr32->gr_interface) ||
-		    copy_from_user(&greq.gr_group, &gr32->gr_group,
-				sizeof(greq.gr_group)))
-			return -EFAULT;
-
-		if (greq.gr_group.ss_family != AF_INET6)
-			return -EADDRNOTAVAIL;
-
-		rtnl_lock();
-		lock_sock(sk);
-		if (optname == MCAST_JOIN_GROUP)
-			err = ipv6_sock_mc_join(sk, greq.gr_interface,
-						 &psin6->sin6_addr);
-		else
-			err = ipv6_sock_mc_drop(sk, greq.gr_interface,
-						 &psin6->sin6_addr);
-		release_sock(sk);
-		rtnl_unlock();
-		return err;
-	}
+		return compat_ipv6_mcast_join_leave(sk, optname, optval,
+						    optlen);
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
-- 
2.27.0

