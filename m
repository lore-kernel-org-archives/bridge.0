Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=/E3yYoXC157551h6xowHq2pNR018OFBhJ9Arvav070Y=; b=o6zhOep28KSjcnYm3J9aHcpkgm
 O2Fcz0+9OvZMn6mbYHPBFH/fhpi9DoauQT0ncpn5viSfaoFF6bLsJITCRXjgfdyqFLmf4LW5Djzbq
 mVD4a9wW/2LPyab9lB73mzm+FvayvQ+EgI8+vOBPzlrpsBjPVCB3G88FaBPOFgmA9Mu2nVuQYxlZH
 5LqOFVBqwVr859Q4epbLvsmne1egzV1tTu7+l4QNJED3wUW/yW3Y/QVQJEeAZPJymdlnG4fe6WTAC
 BSzIX9qF0b7Pb8owGsYurQp2qXY/WMlbn+gcpCALS7U1mCseHNtxJKPafipfiMwCKx140COitXOWS
 xalq63Mw==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:12 +0200
Message-Id: <20200717062331.691152-4-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 03/22] net: streamline __sys_getsockopt
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
 net/socket.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 49a6daf0293b83..b79376b17b45b7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2163,28 +2163,25 @@ static int __sys_getsockopt(int fd, int level, int optname,
 	int max_optlen;
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock != NULL) {
-		err = security_socket_getsockopt(sock, level, optname);
-		if (err)
-			goto out_put;
+	if (!sock)
+		return err;
 
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	err = security_socket_getsockopt(sock, level, optname);
+	if (err)
+		goto out_put;
 
-		if (level == SOL_SOCKET)
-			err =
-			    sock_getsockopt(sock, level, optname, optval,
+	max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+
+	if (level == SOL_SOCKET)
+		err = sock_getsockopt(sock, level, optname, optval, optlen);
+	else
+		err = sock->ops->getsockopt(sock, level, optname, optval,
 					    optlen);
-		else
-			err =
-			    sock->ops->getsockopt(sock, level, optname, optval,
-						  optlen);
 
-		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
-						     optval, optlen,
-						     max_optlen, err);
+	err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname, optval,
+					     optlen, max_optlen, err);
 out_put:
-		fput_light(sock->file, fput_needed);
-	}
+	fput_light(sock->file, fput_needed);
 	return err;
 }
 
-- 
2.27.0

