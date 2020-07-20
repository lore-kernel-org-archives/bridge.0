Return-Path: <BATV+d9f98309abae8ab29895+6175+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=XFgdEhn2vLmThLShP1o7gYGDYV3zgNoNH4PA05fsJS8=; b=Wkzy9EJDG4l7lgluY2A4k1gkzk
 dHXnUTdC/Nhh1WIcSPASdHtlIMwcRj8ffKYWkm/ND2HeOF9pwAr6W0kFtq++kQkmsFbDKkGph29TG
 mLxMkHP/KhFXpyNQnHvKtgkdUiKmemflpUt39osjFaqvvF/EFGdVXCXHfwu5HIh/q2IOaC35QPVM6
 DUvpfkRYCdoLNG0Zz72Bb7JVAWpDKbATSgbOwnqvggK4gHxNhJVnpZGhEV0mRP+mMAL7ub9tuTAvU
 xQHw+/y8tgti6Qyzdrzl2hUUfwrzU7JnbzMGgsdbBO4RfqCvdlUEEmDH0RkjxN+ICaczwlL2GumfX
 JoHLgVXw==;
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jul 2020 14:47:35 +0200
Message-Id: <20200720124737.118617-23-hch@lst.de>
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 22/24] net/tcp: switch ->md5_parse to sockptr_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Eric Dumazet <edumazet@google.com>
Cc: linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, linux-decnet-user@lists.sourceforge.net, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, dccp@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, lvs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-hams@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, linux-afs@lists.infradead.org, mptcp@lists.01.org

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/tcp.h   | 2 +-
 net/ipv4/tcp.c      | 3 ++-
 net/ipv4/tcp_ipv4.c | 4 ++--
 net/ipv6/tcp_ipv6.c | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f7f7c0c110451..e3c8e1d820214c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2002,7 +2002,7 @@ struct tcp_sock_af_ops {
 					 const struct sk_buff *skb);
 	int		(*md5_parse)(struct sock *sk,
 				     int optname,
-				     char __user *optval,
+				     sockptr_t optval,
 				     int optlen);
 #endif
 };
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 58ede3d62b2e2c..49bf15c27deac7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3249,7 +3249,8 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
-		err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
+		err = tp->af_specific->md5_parse(sk, optname,
+						 USER_SOCKPTR(optval), optlen);
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cd81b6e04efbfa..a03e70b3af2e6c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1194,7 +1194,7 @@ static void tcp_clear_md5_list(struct sock *sk)
 }
 
 static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
-				 char __user *optval, int optlen)
+				 sockptr_t optval, int optlen)
 {
 	struct tcp_md5sig cmd;
 	struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.tcpm_addr;
@@ -1205,7 +1205,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	if (optlen < sizeof(cmd))
 		return -EINVAL;
 
-	if (copy_from_user(&cmd, optval, sizeof(cmd)))
+	if (copy_from_sockptr(&cmd, optval, sizeof(cmd)))
 		return -EFAULT;
 
 	if (sin->sin_family != AF_INET)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c34b7834fd84a8..305870a72352d6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -567,7 +567,7 @@ static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
 }
 
 static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
-				 char __user *optval, int optlen)
+				 sockptr_t optval, int optlen)
 {
 	struct tcp_md5sig cmd;
 	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)&cmd.tcpm_addr;
@@ -577,7 +577,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	if (optlen < sizeof(cmd))
 		return -EINVAL;
 
-	if (copy_from_user(&cmd, optval, sizeof(cmd)))
+	if (copy_from_sockptr(&cmd, optval, sizeof(cmd)))
 		return -EFAULT;
 
 	if (sin6->sin6_family != AF_INET6)
-- 
2.27.0

