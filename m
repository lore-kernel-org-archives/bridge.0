Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+VCp+M6LeW8FDpyr7wpNvWuI4BNWqFi7JKzfYrQ+dWQ=; b=IEnHLxbUNi0NH0s9vaRENCbsa+
 lBdonIkz1Nun86rXP17mfcn8S1Gp4G7dumaPNbR/siTumrDztawUGl3e6Lbedg3rirHAl4Gr4kg8O
 d/dcYnbAeJnp+If+j1Z+Ywmlsi2Ci6FbgaXTge5bbuxTrTHFEdPLmhynLvPNSREVBQk/MQ3G1C55u
 KB3I+6T1FzXXobd920GAKfbnaYa3k4EJKiUNjv3KrZX+wpVlK0THIUyLK3ZkRlx4LcWM1i+yavQaE
 ELVoAcO0zAJ4c4oZ7ntQOzwzodRfKpqdrhowInfpopZzTX+loc3w5bzbHEp+q+4mmXUZ/nRu9VA56
 RuIFd8+A==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:18 +0200
Message-Id: <20200717062331.691152-10-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 09/22] netfilter/ip6_tables: clean up compat {get,
	set}sockopt handling
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

Merge the native and compat {get,set}sockopt handlers using
in_compat_syscall().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/netfilter/ip6_tables.c | 87 ++++++++-------------------------
 1 file changed, 21 insertions(+), 66 deletions(-)

diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index e96a431549bcc9..96c48e91e6c7f7 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -960,8 +960,7 @@ static int compat_table_info(const struct xt_table_info *info,
 }
 #endif
 
-static int get_info(struct net *net, void __user *user,
-		    const int *len, int compat)
+static int get_info(struct net *net, void __user *user, const int *len)
 {
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
@@ -975,7 +974,7 @@ static int get_info(struct net *net, void __user *user,
 
 	name[XT_TABLE_MAXNAMELEN-1] = '\0';
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_lock(AF_INET6);
 #endif
 	t = xt_request_find_table_lock(net, AF_INET6, name);
@@ -985,7 +984,7 @@ static int get_info(struct net *net, void __user *user,
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
 
-		if (compat) {
+		if (in_compat_syscall()) {
 			ret = compat_table_info(private, &tmp);
 			xt_compat_flush_offsets(AF_INET6);
 			private = &tmp;
@@ -1011,7 +1010,7 @@ static int get_info(struct net *net, void __user *user,
 	} else
 		ret = PTR_ERR(t);
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_unlock(AF_INET6);
 #endif
 	return ret;
@@ -1169,8 +1168,7 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
 }
 
 static int
-do_add_counters(struct net *net, const void __user *user, unsigned int len,
-		int compat)
+do_add_counters(struct net *net, const void __user *user, unsigned int len)
 {
 	unsigned int i;
 	struct xt_counters_info tmp;
@@ -1181,7 +1179,8 @@ do_add_counters(struct net *net, const void __user *user, unsigned int len,
 	struct ip6t_entry *iter;
 	unsigned int addend;
 
-	paddc = xt_copy_counters_from_user(user, len, &tmp, compat);
+	paddc = xt_copy_counters_from_user(user, len, &tmp,
+					   in_compat_syscall());
 	if (IS_ERR(paddc))
 		return PTR_ERR(paddc);
 	t = xt_find_table_lock(net, AF_INET6, tmp.name);
@@ -1543,31 +1542,6 @@ compat_do_replace(struct net *net, void __user *user, unsigned int len)
 	return ret;
 }
 
-static int
-compat_do_ip6t_set_ctl(struct sock *sk, int cmd, void __user *user,
-		       unsigned int len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IP6T_SO_SET_REPLACE:
-		ret = compat_do_replace(sock_net(sk), user, len);
-		break;
-
-	case IP6T_SO_SET_ADD_COUNTERS:
-		ret = do_add_counters(sock_net(sk), user, len, 1);
-		break;
-
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
 struct compat_ip6t_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
@@ -1643,29 +1617,6 @@ compat_get_entries(struct net *net, struct compat_ip6t_get_entries __user *uptr,
 	xt_compat_unlock(AF_INET6);
 	return ret;
 }
-
-static int do_ip6t_get_ctl(struct sock *, int, void __user *, int *);
-
-static int
-compat_do_ip6t_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IP6T_SO_GET_INFO:
-		ret = get_info(sock_net(sk), user, len, 1);
-		break;
-	case IP6T_SO_GET_ENTRIES:
-		ret = compat_get_entries(sock_net(sk), user, len);
-		break;
-	default:
-		ret = do_ip6t_get_ctl(sk, cmd, user, len);
-	}
-	return ret;
-}
 #endif
 
 static int
@@ -1678,11 +1629,16 @@ do_ip6t_set_ctl(struct sock *sk, int cmd, void __user *user, unsigned int len)
 
 	switch (cmd) {
 	case IP6T_SO_SET_REPLACE:
-		ret = do_replace(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = compat_do_replace(sock_net(sk), user, len);
+		else
+#endif
+			ret = do_replace(sock_net(sk), user, len);
 		break;
 
 	case IP6T_SO_SET_ADD_COUNTERS:
-		ret = do_add_counters(sock_net(sk), user, len, 0);
+		ret = do_add_counters(sock_net(sk), user, len);
 		break;
 
 	default:
@@ -1702,11 +1658,16 @@ do_ip6t_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 
 	switch (cmd) {
 	case IP6T_SO_GET_INFO:
-		ret = get_info(sock_net(sk), user, len, 0);
+		ret = get_info(sock_net(sk), user, len);
 		break;
 
 	case IP6T_SO_GET_ENTRIES:
-		ret = get_entries(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = compat_get_entries(sock_net(sk), user, len);
+		else
+#endif
+			ret = get_entries(sock_net(sk), user, len);
 		break;
 
 	case IP6T_SO_GET_REVISION_MATCH:
@@ -1897,15 +1858,9 @@ static struct nf_sockopt_ops ip6t_sockopts = {
 	.set_optmin	= IP6T_BASE_CTL,
 	.set_optmax	= IP6T_SO_SET_MAX+1,
 	.set		= do_ip6t_set_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_set	= compat_do_ip6t_set_ctl,
-#endif
 	.get_optmin	= IP6T_BASE_CTL,
 	.get_optmax	= IP6T_SO_GET_MAX+1,
 	.get		= do_ip6t_get_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_get	= compat_do_ip6t_get_ctl,
-#endif
 	.owner		= THIS_MODULE,
 };
 
-- 
2.27.0

