Return-Path: <BATV+d9f98309abae8ab29895+6175+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NOaRlO8PH56EoeQ6wPKZ+NHx4xWBn4wtfdyd3UU7j5Q=; b=r3wFqS6HvDtdd0R6F6qyrxhLxQ
 0UmwqQvsG/ORHCNVtcyBkrRyN8Jl7NMUK+kN9rgMr7dJqvgRbNpsmGad7MyMT0Cslsg7ne9Zs1UlE
 /RwPyLdiHDpNgBjCzw/HmZWsORXbrednhTKLDHU0qAnYKNBOOFKeNoZ82aOb0D1SeYW1aLzwzDOBP
 heWVXUEQRk3EcbcAs4HVrc9bFRGjDJl3iUtWA6BGC9ZrXLSjvOE0L6VJHRbQKC45uIe6QuMjN7Gk/
 O53gfIacoSmqnhrDUA7vy0qZZc0gL1aupHUgKPNVJamV2BJZVG7ttr+EMAYA95puN7nmqMY+irCXk
 KTg4Ltzw==;
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jul 2020 14:47:18 +0200
Message-Id: <20200720124737.118617-6-hch@lst.de>
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 05/24] net: switch sock_setbindtodevice to sockptr_t
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
 net/core/sock.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 91224709869389..bd20fc5cce0850 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -608,8 +608,7 @@ int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk)
 }
 EXPORT_SYMBOL(sock_bindtoindex);
 
-static int sock_setbindtodevice(struct sock *sk, char __user *optval,
-				int optlen)
+static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int optlen)
 {
 	int ret = -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -631,7 +630,7 @@ static int sock_setbindtodevice(struct sock *sk, char __user *optval,
 	memset(devname, 0, sizeof(devname));
 
 	ret = -EFAULT;
-	if (copy_from_user(devname, optval, optlen))
+	if (copy_from_sockptr(devname, optval, optlen))
 		goto out;
 
 	index = 0;
@@ -839,7 +838,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 	 */
 
 	if (optname == SO_BINDTODEVICE)
-		return sock_setbindtodevice(sk, optval, optlen);
+		return sock_setbindtodevice(sk, USER_SOCKPTR(optval), optlen);
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
-- 
2.27.0

