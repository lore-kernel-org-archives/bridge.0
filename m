Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=5UhNspDdIml9tpfUfRWGkC9v9AOZv925n+e1F7He35A=; b=ngePkQgpsw8v14v2e2H1RuLUgP
 0xqQQ043zu+gtXRpXV0bf1ADe/edoqtXj7z3kKW9mKK+iCMOqbmpx3giNOQFrEznviF1qfzoZwbDo
 xr7UnllY+pDKH2CH55FbdxZENM4P5ohmSYAJ0fRT7rs+qqeSNBf08yCPD3u4f/qFc5Y9NGvnoQNep
 Q1DsD4GKGED6DkS1FkzSoMqYpNOH/w2g4VpT16FR3tH0BYHZ8AioctdDH4k7C39SaqLi85vEZptIG
 vVRFnCSAKWjMPjLVXYuX97UKI3rDl+CoNmVE1f7b4ZTU02I8+ZHtLq4ucRfi35nEz/aA046/AsP0+
 9sdcqAzw==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:25 +0200
Message-Id: <20200717062331.691152-17-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 16/22] net/ipv4: factor out mcast join/leave
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
 net/ipv4/ip_sockglue.c | 109 +++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b587dee006f882..73bb88fbe54661 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -806,6 +806,60 @@ static int compat_ip_set_mcast_msfilter(struct sock *sk, void __user *optval,
 }
 #endif
 
+static int ip_mcast_join_leave(struct sock *sk, int optname,
+		void __user *optval, int optlen)
+{
+	struct ip_mreqn mreq = { };
+	struct sockaddr_in *psin;
+	struct group_req greq;
+
+	if (optlen < sizeof(struct group_req))
+		return -EINVAL;
+	if (copy_from_user(&greq, optval, sizeof(greq)))
+		return -EFAULT;
+
+	psin = (struct sockaddr_in *)&greq.gr_group;
+	if (psin->sin_family != AF_INET)
+		return -EINVAL;
+	mreq.imr_multiaddr = psin->sin_addr;
+	mreq.imr_ifindex = greq.gr_interface;
+	if (optname == MCAST_JOIN_GROUP)
+		return ip_mc_join_group(sk, &mreq);
+	return ip_mc_leave_group(sk, &mreq);
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_ip_mcast_join_leave(struct sock *sk, int optname,
+		void __user *optval, int optlen)
+{
+	struct compat_group_req greq;
+	struct ip_mreqn mreq = { };
+	struct sockaddr_in *psin;
+	int err;
+
+	if (optlen < sizeof(struct compat_group_req))
+		return -EINVAL;
+	if (copy_from_user(&greq, optval, sizeof(greq)))
+		return -EFAULT;
+
+	psin = (struct sockaddr_in *)&greq.gr_group;
+	if (psin->sin_family != AF_INET)
+		return -EINVAL;
+	mreq.imr_multiaddr = psin->sin_addr;
+	mreq.imr_ifindex = greq.gr_interface;
+
+	rtnl_lock();
+	lock_sock(sk);
+	if (optname == MCAST_JOIN_GROUP)
+		err = ip_mc_join_group(sk, &mreq);
+	else
+		err = ip_mc_leave_group(sk, &mreq);
+	release_sock(sk);
+	rtnl_unlock();
+	return err;
+}
+#endif
+
 static int do_ip_setsockopt(struct sock *sk, int level,
 			    int optname, char __user *optval, unsigned int optlen)
 {
@@ -1211,29 +1265,8 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 	}
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
-	{
-		struct group_req greq;
-		struct sockaddr_in *psin;
-		struct ip_mreqn mreq;
-
-		if (optlen < sizeof(struct group_req))
-			goto e_inval;
-		err = -EFAULT;
-		if (copy_from_user(&greq, optval, sizeof(greq)))
-			break;
-		psin = (struct sockaddr_in *)&greq.gr_group;
-		if (psin->sin_family != AF_INET)
-			goto e_inval;
-		memset(&mreq, 0, sizeof(mreq));
-		mreq.imr_multiaddr = psin->sin_addr;
-		mreq.imr_ifindex = greq.gr_interface;
-
-		if (optname == MCAST_JOIN_GROUP)
-			err = ip_mc_join_group(sk, &mreq);
-		else
-			err = ip_mc_leave_group(sk, &mreq);
+		err = ip_mcast_join_leave(sk, optname, optval, optlen);
 		break;
-	}
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
@@ -1389,37 +1422,7 @@ int compat_ip_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
-	{
-		struct compat_group_req __user *gr32 = (void __user *)optval;
-		struct group_req greq;
-		struct sockaddr_in *psin = (struct sockaddr_in *)&greq.gr_group;
-		struct ip_mreqn mreq;
-
-		if (optlen < sizeof(struct compat_group_req))
-			return -EINVAL;
-
-		if (get_user(greq.gr_interface, &gr32->gr_interface) ||
-		    copy_from_user(&greq.gr_group, &gr32->gr_group,
-				sizeof(greq.gr_group)))
-			return -EFAULT;
-
-		if (psin->sin_family != AF_INET)
-			return -EINVAL;
-
-		memset(&mreq, 0, sizeof(mreq));
-		mreq.imr_multiaddr = psin->sin_addr;
-		mreq.imr_ifindex = greq.gr_interface;
-
-		rtnl_lock();
-		lock_sock(sk);
-		if (optname == MCAST_JOIN_GROUP)
-			err = ip_mc_join_group(sk, &mreq);
-		else
-			err = ip_mc_leave_group(sk, &mreq);
-		release_sock(sk);
-		rtnl_unlock();
-		return err;
-	}
+		return compat_ip_mcast_join_leave(sk, optname, optval, optlen);
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
-- 
2.27.0

