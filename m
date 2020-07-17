Return-Path: <BATV+fac86bbf8fd344557627+6172+infradead.org+hch@casper.srs.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Gk0icm7W1l6PNEXjPOF00ZeKuwMt8n5bPcc1urfvli0=; b=kdONCNhzaytXfggMeiqE4liA5Y
 FXH+SFlM1+3qR6XQC2W1Oaf4xZKwcHTS280Wb7OjSJkro6ZKuR/1KAJwAq+qVtU0I9X6Q5O3435fo
 wYk5zHTb2J1M7DQwFjefr5Obsa64MfX857EgZzFtKqJtQdmNkd0gYhoJUUgEP2VdhXekZ2pyDGdve
 9qda6eWKiRYoNjZCm81FOtLtE+KX4Ef4Qlj62tsEQap1zg8E7qJcPXwGv/7kGhdcwVVNY/3Aj98Y7
 laS1Ayw6MYPKpXY2HJCzp5OopcEewXMcxqL8ZWmyG+Y5Ky3TmP1U++jo12psasWq/z5SF90tdWKSj
 3++RRymw==;
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:28 +0200
Message-Id: <20200717062331.691152-20-hch@lst.de>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 19/22] net/ipv6: factor out MCAST_MSFILTER
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
 net/ipv6/ipv6_sockglue.c | 159 ++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 76 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index ef5656f876ac05..6aa49495d7bc0b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -171,6 +171,87 @@ static int do_ipv6_mcast_group_source(struct sock *sk, int optname,
 	return ip6_mc_source(add, omode, sk, greqs);
 }
 
+static int ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
+		int optlen)
+{
+	struct group_filter *gsf;
+	int ret;
+
+	if (optlen < GROUP_FILTER_SIZE(0))
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max)
+		return -ENOBUFS;
+
+	gsf = memdup_user(optval, optlen);
+	if (IS_ERR(gsf))
+		return PTR_ERR(gsf);
+
+	/* numsrc >= (4G-140)/128 overflow in 32 bits */
+	ret = -ENOBUFS;
+	if (gsf->gf_numsrc >= 0x1ffffffU ||
+	    gsf->gf_numsrc > sysctl_mld_max_msf)
+		goto out_free_gsf;
+
+	ret = -EINVAL;
+	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
+		goto out_free_gsf;
+
+	ret = ip6_mc_msfilter(sk, gsf, gsf->gf_slist);
+out_free_gsf:
+	kfree(gsf);
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
+		int optlen)
+{
+	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	struct compat_group_filter *gf32;
+	void *p;
+	int ret;
+	int n;
+
+	if (optlen < size0)
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max - 4)
+		return -ENOBUFS;
+
+	p = kmalloc(optlen + 4, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
+	ret = -EFAULT;
+	if (copy_from_user(gf32, optval, optlen))
+		goto out_free_p;
+
+	/* numsrc >= (4G-140)/128 overflow in 32 bits */
+	ret = -ENOBUFS;
+	n = gf32->gf_numsrc;
+	if (n >= 0x1ffffffU || n > sysctl_mld_max_msf)
+		goto out_free_p;
+
+	ret = -EINVAL;
+	if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen)
+		goto out_free_p;
+
+	rtnl_lock();
+	lock_sock(sk);
+	ret = ip6_mc_msfilter(sk, &(struct group_filter){
+			.gf_interface = gf32->gf_interface,
+			.gf_group = gf32->gf_group,
+			.gf_fmode = gf32->gf_fmode,
+			.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist);
+	release_sock(sk);
+	rtnl_unlock();
+
+out_free_p:
+	kfree(p);
+	return ret;
+}
+#endif
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -762,37 +843,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 	case MCAST_MSFILTER:
-	{
-		struct group_filter *gsf;
-
-		if (optlen < GROUP_FILTER_SIZE(0))
-			goto e_inval;
-		if (optlen > sysctl_optmem_max) {
-			retv = -ENOBUFS;
-			break;
-		}
-		gsf = memdup_user(optval, optlen);
-		if (IS_ERR(gsf)) {
-			retv = PTR_ERR(gsf);
-			break;
-		}
-		/* numsrc >= (4G-140)/128 overflow in 32 bits */
-		if (gsf->gf_numsrc >= 0x1ffffffU ||
-		    gsf->gf_numsrc > sysctl_mld_max_msf) {
-			kfree(gsf);
-			retv = -ENOBUFS;
-			break;
-		}
-		if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen) {
-			kfree(gsf);
-			retv = -EINVAL;
-			break;
-		}
-		retv = ip6_mc_msfilter(sk, gsf, gsf->gf_slist);
-		kfree(gsf);
-
+		retv = ipv6_set_mcast_msfilter(sk, optval, optlen);
 		break;
-	}
 	case IPV6_ROUTER_ALERT:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -977,52 +1029,7 @@ int compat_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return err;
 	}
 	case MCAST_MSFILTER:
-	{
-		const int size0 = offsetof(struct compat_group_filter, gf_slist);
-		struct compat_group_filter *gf32;
-		void *p;
-		int n;
-
-		if (optlen < size0)
-			return -EINVAL;
-		if (optlen > sysctl_optmem_max - 4)
-			return -ENOBUFS;
-
-		p = kmalloc(optlen + 4, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-
-		gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
-		if (copy_from_user(gf32, optval, optlen)) {
-			err = -EFAULT;
-			goto mc_msf_out;
-		}
-
-		n = gf32->gf_numsrc;
-		/* numsrc >= (4G-140)/128 overflow in 32 bits */
-		if (n >= 0x1ffffffU ||
-		    n > sysctl_mld_max_msf) {
-			err = -ENOBUFS;
-			goto mc_msf_out;
-		}
-		if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen) {
-			err = -EINVAL;
-			goto mc_msf_out;
-		}
-
-		rtnl_lock();
-		lock_sock(sk);
-		err = ip6_mc_msfilter(sk, &(struct group_filter){
-				.gf_interface = gf32->gf_interface,
-				.gf_group = gf32->gf_group,
-				.gf_fmode = gf32->gf_fmode,
-				.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist);
-		release_sock(sk);
-		rtnl_unlock();
-mc_msf_out:
-		kfree(p);
-		return err;
-	}
+		return compat_ipv6_set_mcast_msfilter(sk, optval, optlen);
 	}
 
 	err = do_ipv6_setsockopt(sk, level, optname, optval, optlen);
-- 
2.27.0

