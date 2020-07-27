Return-Path: <Jason@zx2c4.com>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
 :cc:subject:message-id:references:mime-version:content-type
 :in-reply-to; s=mail; bh=e4Ncj5PqOxuE3ONaroBLzrHpd+c=; b=Qoh5rxw
 E4ipK+7oF4FAXGvGyQT6VIu5cnzAaedp87/f4nZ24qqbi4r0S6rLuYQVbXudh+xO
 99wZVZdEftTfV3U58Qyas4D20X9oLmF3+ZOrRcoZGGPBMtw/UBnS5mDFlX53nwQ3
 4y+YK+0Lf0FJU2nN2lAvRlVBPPTMG6w4amUbqly/mlHgyL1B4Nf9kT64IIu53y9T
 u5hByM6CogNFuzrdCCHYLAOIub3eMmAcMs5HlyJpDmEpP3aYT0/5fhT9mzv6s3tJ
 e3sjwNkGyyDF3HX5B00L9mYUMASGIdL1UuQ+tbrvm+L6NQ0CP4GaybSPFSC1SlZS
 k03jp9ulXwzPOkw==
Date: Mon, 27 Jul 2020 17:03:10 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <20200727150310.GA1632472@zx2c4.com>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723060908.50081-13-hch@lst.de>
Subject: Re: [Bridge] [PATCH 12/26] netfilter: switch nf_setsockopt to
	sockptr_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hi Christoph,

On Thu, Jul 23, 2020 at 08:08:54AM +0200, Christoph Hellwig wrote:
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index da933f99b5d517..42befbf12846c0 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1422,7 +1422,8 @@ int ip_setsockopt(struct sock *sk, int level,
>  			optname != IP_IPSEC_POLICY &&
>  			optname != IP_XFRM_POLICY &&
>  			!ip_mroute_opt(optname))
> -		err = nf_setsockopt(sk, PF_INET, optname, optval, optlen);
> +		err = nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(optval),
> +				    optlen);
>  #endif
>  	return err;
>  }
> diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
> index 4697d09c98dc3e..f2a9680303d8c0 100644
> --- a/net/ipv4/netfilter/ip_tables.c
> +++ b/net/ipv4/netfilter/ip_tables.c
> @@ -1102,7 +1102,7 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
>  }
>  
>  static int
> -do_replace(struct net *net, const void __user *user, unsigned int len)
> +do_replace(struct net *net, sockptr_t arg, unsigned int len)
>  {
>  	int ret;
>  	struct ipt_replace tmp;
> @@ -1110,7 +1110,7 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
>  	void *loc_cpu_entry;
>  	struct ipt_entry *iter;
>  
> -	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> +	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
>  		return -EFAULT;
>  
>  	/* overflow check */
> @@ -1126,8 +1126,8 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
>  		return -ENOMEM;
>  
>  	loc_cpu_entry = newinfo->entries;
> -	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
> -			   tmp.size) != 0) {
> +	sockptr_advance(arg, sizeof(tmp));
> +	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) != 0) {
>  		ret = -EFAULT;
>  		goto free_newinfo;
>  	}

Something along this path seems to have broken with this patch. An
invocation of `iptables -A INPUT -m length --length 1360 -j DROP` now
fails, with

nf_setsockopt->do_replace->translate_table->check_entry_size_and_hooks:
  (unsigned char *)e + e->next_offset > limit  ==>  TRUE

resulting in the whole call chain returning -EINVAL. It bisects back to
this commit. This is on net-next.

Jason
