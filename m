Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA13DDDCB
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060462; cv=none; b=Z8trnDC2U7Td+n+b7dDNKLek3T6IgiAHNHNBKtkGnosO/TWkgqYIdfd5QJ9o+vdB7DpyO/I/QTNWctoZQS8kTihOjch19tkjqsRwx8dyIzGiH8QsW/sEY/XuvwaBM/wwY2K2bhFfplw6JdPv1Cwrkv2cPjmkyyRJSx1HA+Qoklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060462; c=relaxed/simple;
	bh=vqf1PiQgIrSLvLOIqCuthN86/GGCYXPRBreHnHltp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REbcPzipV86HYS1Okxeup1fQKXMZlcXKhXwYE0PZiY0JcVFG0XEpCzyQswGX/IOZrfqC2aQWx+zOfYK3B8XGS1Nz+D5+nvDXJQpWC88Rn6HEFBdJ+kluiR0JSsBqCXu/HXswYBIfS7eUtcFM/F1RZhU3wGrHjxKJhCqSh/BnzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etl+x2Ls; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etl+x2Ls"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso9893610c88.1
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060460; x=1775665260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=etl+x2Lskc5R/l3FV2bUNogLN6HbUKApO0egCnLScKG2YCs3Nt312S8a1QlhsXp7Zw
         UPeZKJNBIaYtiX8/hFJmV4ocreqPf1TNBBqn5S74RcF0LU2jc2k9vh325ufczbUzKh3u
         Z3bLahXe6fQgzfljM1rYLh8qO7hnIcgx4h/AXmyc0RKItiPd8DkjxKLLEOBEsrx/2i8d
         jzEWg8U/M+oSpNnu0p6eimp+k4Zu+0g/ieOhlezBq8QS+DX5aBLxWnfWzo6/CczmRFwP
         09rpRlcbT7py9l+Wc4d0C2gH1ct6NP5aewUT7xxZb9WieL6WRHElYRuBgkmtQ2Bw1bOZ
         BMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060460; x=1775665260;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=oC+EoQeQZrLY3pPkS/GO0gSYwWohpw2y2h+bY8Lk/iXLZjXYGVqL4DNju6Mw5gZHN+
         evdeooCWLfJGnA9GRf57IlZNN1Cx2VUkFXlifI3gktc+ROK5KV+lIKNa0fvmc1dyaNo+
         4Cdr2G6xaH1C1pIvJ4fJx54/g0UCVnSuGoEVI01cUHg6sDIuDIvfDGaXXxdERT8GRl9C
         RBqLlHs0fX2EDpb2qbB/YCPKswezy3wV+p7Ji47SM3bmOEUUsrSqaDDTABO63vKC5KDh
         PiweoxE2abgQcc2hgpobfOi5VjsP2emIdi99wrhyxsTgXrYo93X6g049sL8K0Hc+0Z5n
         G2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWi5maibXC8CzxSdHlb9x75X57MR4W04vveucykjQoa8qI5B40fU9zkI9viQZ/4m3DZdRRznkk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzudh6SMKhtnWPmIZ6/Mnr2mbi873F01fwxh99FcPk8boCcu28
	vqxE2lbahIJXueeLdcwamN8EIZsBT1YQOfczQy4yX3kIMTeD6tyPo/I=
X-Gm-Gg: ATEYQzw0U0KgloLWZqV93Vjke+XBPS7dLSF7ScCMKXcQrHqyZ5D5qkE+dFpKC3/7hMI
	IOAjw3x2bw8pMh5mMVgDyyEXGHe2TW3obL66A7/xoDsoLPqLqCyoy0CUZxf6/Q0paIuv6SmbTFR
	Slls8tfzzBjzvCoqQ+dfSNZZgbNMfzcHO5u5/jQuKZjty/AcsWA5LHb++FoHN2L0NJZkftQw8K1
	G1yRy06wqhoDoQdvCyQZdj6jq/mnih+fQ2pGPvRj74Kklwwf4UTSBms60bZ82XbmHGj8a2/GW6s
	3V1ISFTH1eVa9j3XTa6kQtipTvl91hZpC3mAZaXLS/c/nygTBGLgp5NfEV+86Lj8+JAHhTzZkOW
	w3cBw9qA7+SaR8pZS4jOmspnlakeyrgmy/hsV393pulrlF5QaL7+VssLjBav8U6u5Wbw00Ib0Mv
	uwZXZrpZfdZOWwTD3Bky91pyi47Eijr8IXp9A7klXd7oCof1YKWKIK+I+q+27aYGQKUpmFebyqj
	AAa0aPZG8yTfijmvw==
X-Received: by 2002:a05:7301:4090:b0:2c1:b26:8424 with SMTP id 5a478bee46e88-2c933d8e814mr2313816eec.33.1775060459420;
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm144003eec.7.2026.04.01.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:20:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <ac1F6hIHcoZo-soO@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
References: <20260401074509.1897527-1-dwmw2@infradead.org>
 <20260401074509.1897527-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>

On 04/01, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>  	struct sock *sk = sock->sk;
>  	int err = -EINVAL;
>  
> +	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
> +		     current->comm, task_pid_nr(current));
> +
>  	lock_sock(sk);
>  
>  	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> -- 
> 2.51.0
> 

Does this also need to look at the proto? inet6_stream_ops seem to be
using inet_listen as well.

const struct proto_ops inet6_stream_ops = {
        .family            = PF_INET6,
        .owner             = THIS_MODULE,
        .release           = inet6_release,
        .bind              = inet6_bind,
        .connect           = inet_stream_connect,       /* ok           */
        .socketpair        = sock_no_socketpair,        /* a do nothing */
        .accept            = inet_accept,               /* ok           */
        .getname           = inet6_getname,
        .poll              = tcp_poll,                  /* ok           */
        .ioctl             = inet6_ioctl,               /* must change  */
        .gettstamp         = sock_gettstamp,
        .listen            = inet_listen,               /* ok           */
