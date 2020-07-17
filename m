Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=wr5cOSCBypjWaa13QpyMI0Pyh05kUAwvudFuTMkZyns=; b=s3rvm7cVFffHZaEfGTg7ZfxVZj
 x98j/y1+kfHZpWI0o1XmAwtMIa3yqk+Mc35fICVgr5SELYyL2RJfoDIKDIQSXFAsXM2VTe8QKHi5F
 Ms4N6XlX6SrfF4CMde/BUp9r4z8dZzORk9rMPY4AUlCe5u/SKvMCnl4dBlfzkl2VAmFEIm+GFY8lZ
 QShVpd2XFETG8G+PSNHUayBUaUWpvUXP1w8ZOTIXN90+oLvpDE6atTMlyXW8e9cOsrgX/OhVi9zFr
 aJKInlOHEuN74IWoQ+LsKSCMq945wnFRGiPbMkMVSCsxQnG2UWG2tAf67VXI8o56QRe+iexrykVXk
 6aCu719g==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:17 +0200
Message-Id: <20200717062331.691152-9-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 08/22] netfilter/ip_tables: clean up compat {get,
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
 net/ipv4/netfilter/ip_tables.c | 86 +++++++++-------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 5bf9fa06aee0be..fbfad38f397949 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -944,8 +944,7 @@ static int compat_table_info(const struct xt_table_info *info,
 }
 #endif
 
-static int get_info(struct net *net, void __user *user,
-		    const int *len, int compat)
+static int get_info(struct net *net, void __user *user, const int *len)
 {
 	char name[XT_TABLE_MAXNAMELEN];
 	struct xt_table *t;
@@ -959,7 +958,7 @@ static int get_info(struct net *net, void __user *user,
 
 	name[XT_TABLE_MAXNAMELEN-1] = '\0';
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_lock(AF_INET);
 #endif
 	t = xt_request_find_table_lock(net, AF_INET, name);
@@ -969,7 +968,7 @@ static int get_info(struct net *net, void __user *user,
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
 
-		if (compat) {
+		if (in_compat_syscall()) {
 			ret = compat_table_info(private, &tmp);
 			xt_compat_flush_offsets(AF_INET);
 			private = &tmp;
@@ -995,7 +994,7 @@ static int get_info(struct net *net, void __user *user,
 	} else
 		ret = PTR_ERR(t);
 #ifdef CONFIG_COMPAT
-	if (compat)
+	if (in_compat_syscall())
 		xt_compat_unlock(AF_INET);
 #endif
 	return ret;
@@ -1153,7 +1152,7 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
 
 static int
 do_add_counters(struct net *net, const void __user *user,
-		unsigned int len, int compat)
+		unsigned int len)
 {
 	unsigned int i;
 	struct xt_counters_info tmp;
@@ -1164,7 +1163,8 @@ do_add_counters(struct net *net, const void __user *user,
 	struct ipt_entry *iter;
 	unsigned int addend;
 
-	paddc = xt_copy_counters_from_user(user, len, &tmp, compat);
+	paddc = xt_copy_counters_from_user(user, len, &tmp,
+					   in_compat_syscall());
 	if (IS_ERR(paddc))
 		return PTR_ERR(paddc);
 
@@ -1534,31 +1534,6 @@ compat_do_replace(struct net *net, void __user *user, unsigned int len)
 	return ret;
 }
 
-static int
-compat_do_ipt_set_ctl(struct sock *sk,	int cmd, void __user *user,
-		      unsigned int len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IPT_SO_SET_REPLACE:
-		ret = compat_do_replace(sock_net(sk), user, len);
-		break;
-
-	case IPT_SO_SET_ADD_COUNTERS:
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
 struct compat_ipt_get_entries {
 	char name[XT_TABLE_MAXNAMELEN];
 	compat_uint_t size;
@@ -1634,29 +1609,6 @@ compat_get_entries(struct net *net, struct compat_ipt_get_entries __user *uptr,
 	xt_compat_unlock(AF_INET);
 	return ret;
 }
-
-static int do_ipt_get_ctl(struct sock *, int, void __user *, int *);
-
-static int
-compat_do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
-{
-	int ret;
-
-	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-		return -EPERM;
-
-	switch (cmd) {
-	case IPT_SO_GET_INFO:
-		ret = get_info(sock_net(sk), user, len, 1);
-		break;
-	case IPT_SO_GET_ENTRIES:
-		ret = compat_get_entries(sock_net(sk), user, len);
-		break;
-	default:
-		ret = do_ipt_get_ctl(sk, cmd, user, len);
-	}
-	return ret;
-}
 #endif
 
 static int
@@ -1669,11 +1621,16 @@ do_ipt_set_ctl(struct sock *sk, int cmd, void __user *user, unsigned int len)
 
 	switch (cmd) {
 	case IPT_SO_SET_REPLACE:
-		ret = do_replace(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = compat_do_replace(sock_net(sk), user, len);
+		else
+#endif
+			ret = do_replace(sock_net(sk), user, len);
 		break;
 
 	case IPT_SO_SET_ADD_COUNTERS:
-		ret = do_add_counters(sock_net(sk), user, len, 0);
+		ret = do_add_counters(sock_net(sk), user, len);
 		break;
 
 	default:
@@ -1693,11 +1650,16 @@ do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 
 	switch (cmd) {
 	case IPT_SO_GET_INFO:
-		ret = get_info(sock_net(sk), user, len, 0);
+		ret = get_info(sock_net(sk), user, len);
 		break;
 
 	case IPT_SO_GET_ENTRIES:
-		ret = get_entries(sock_net(sk), user, len);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = compat_get_entries(sock_net(sk), user, len);
+		else
+#endif
+			ret = get_entries(sock_net(sk), user, len);
 		break;
 
 	case IPT_SO_GET_REVISION_MATCH:
@@ -1886,15 +1848,9 @@ static struct nf_sockopt_ops ipt_sockopts = {
 	.set_optmin	= IPT_BASE_CTL,
 	.set_optmax	= IPT_SO_SET_MAX+1,
 	.set		= do_ipt_set_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_set	= compat_do_ipt_set_ctl,
-#endif
 	.get_optmin	= IPT_BASE_CTL,
 	.get_optmax	= IPT_SO_GET_MAX+1,
 	.get		= do_ipt_get_ctl,
-#ifdef CONFIG_COMPAT
-	.compat_get	= compat_do_ipt_get_ctl,
-#endif
 	.owner		= THIS_MODULE,
 };
 
-- 
2.27.0

