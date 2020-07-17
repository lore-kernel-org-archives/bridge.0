Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=f8sxF6lqgSOtJgTg8maQxOEGY1f8ZNeToFNAXuRekpY=; b=ZEqOtR7YleQvC92xGmKC91Kk8L
 WTEXAQTf/mF9q9Sr6E1umt3uL5isI+jl33iT6B+NTWGjBQCHmj5vR2cqc1gH3RLw87ZBI2KJCyK4j
 OsS524C9XTPJYGNJrzCJ0VEVOeyFwAvP/JchrRtBr8ED8bo6wbJFPIQWRaekV0RZYb5LDDC0UrqeR
 Kus4x/xm2hTJTg5FJATe/2UhIbHHDHlA3jUWlAv1s3QZx4Q0PEQpxDBuCxzrE9R/3L9T6dPjNnTit
 /CDWgXJrbMMzBa/1e6cziI38mK/P6j9Kyif5s6YoYnAzkO1g0wtsXDHyWgAfdl3/mbxZnLS51qNWF
 JN+mKrIg==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:11 +0200
Message-Id: <20200717062331.691152-3-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 02/22] net: streamline __sys_setsockopt
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

Return early when sockfd_lookup_light fails to reduce a level of
indentation for most of the function body.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/socket.c | 57 +++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 770503c4ca76c9..49a6daf0293b83 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2107,43 +2107,40 @@ static int __sys_setsockopt(int fd, int level, int optname,
 		return -EINVAL;
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock != NULL) {
-		err = security_socket_setsockopt(sock, level, optname);
-		if (err)
-			goto out_put;
+	if (!sock)
+		return err;
 
-		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level,
-						     &optname, optval, &optlen,
-						     &kernel_optval);
+	err = security_socket_setsockopt(sock, level, optname);
+	if (err)
+		goto out_put;
 
-		if (err < 0) {
-			goto out_put;
-		} else if (err > 0) {
-			err = 0;
-			goto out_put;
-		}
+	err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
+					     optval, &optlen, &kernel_optval);
+	if (err < 0)
+		goto out_put;
+	if (err > 0) {
+		err = 0;
+		goto out_put;
+	}
 
-		if (kernel_optval) {
-			set_fs(KERNEL_DS);
-			optval = (char __user __force *)kernel_optval;
-		}
+	if (kernel_optval) {
+		set_fs(KERNEL_DS);
+		optval = (char __user __force *)kernel_optval;
+	}
 
-		if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
-			err =
-			    sock_setsockopt(sock, level, optname, optval,
+	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
+		err = sock_setsockopt(sock, level, optname, optval, optlen);
+	else
+		err = sock->ops->setsockopt(sock, level, optname, optval,
 					    optlen);
-		else
-			err =
-			    sock->ops->setsockopt(sock, level, optname, optval,
-						  optlen);
 
-		if (kernel_optval) {
-			set_fs(oldfs);
-			kfree(kernel_optval);
-		}
-out_put:
-		fput_light(sock->file, fput_needed);
+	if (kernel_optval) {
+		set_fs(oldfs);
+		kfree(kernel_optval);
 	}
+
+out_put:
+	fput_light(sock->file, fput_needed);
 	return err;
 }
 
-- 
2.27.0

