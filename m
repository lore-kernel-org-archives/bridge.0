Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76703A7E12
	for <bridge@lists.linux.dev>; Wed, 21 Jan 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016227; cv=none; b=kI8+TxXPZJv/VD2Bu87PjlqGlMo+brq84oElM6YFWCEudP5mSUMmpWC0IqKf6GnBU82Qu2ZLdBwQSij6Hj44FqWZ3BlfYS4fdEM72KDfMxFqz/jwonslxPP7HZMrj7bEa30RONSGKQqrXHwMkFeJwsm7/vwUyE3m1133gMsgGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016227; c=relaxed/simple;
	bh=DI63OJLiL9+FOfW93ih89bL5fyQaHnraiigjO/95iCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkBd9vTl/AsSI7qUyVSlczdVXJL9ONYNBDzWmfZFhyNY8SDwwU5Vrl0d9LVsKSG2Z39ZMOl02p1OltWqeJO0KfXCSKufjz1RMBCjl68KkGtn23FfE6orzgJRj/CgHTShpMvB6ZgTDfdD9lko6A1CFwMwZpAUL2sw0k0iiLSJWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ueUyeBnK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uoI6yzBf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ueUyeBnK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uoI6yzBf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 704CD1D00297;
	Wed, 21 Jan 2026 12:23:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 12:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769016223; x=
	1769102623; bh=hWIjHUQ/3+eV2KIHriZDhTusV5/FSAT4CPLcsSVcmf4=; b=u
	eUyeBnK0MCj83lyVejZFGMycRuqiYVSH4UZs/PsevyxmmFphWX2pxAUgx/IJkrPP
	J/ecSUCsgzKTO9JYF4kr4qn9rs67S3hfI6qW6JRREaOQ1jnlGe7GNGRdcOY/I00+
	MGG/Ml50zdZendNSLm8YGZTR2FEZc8bJMxnBRuenpam+hT5FkZZweW398tEUkLL7
	KWmR3ScACJsTm5zwTWDU9bAFr/d5Y4lT/kH11/Fy2XZOPO2AOH8jB9jk7bPQgrQ4
	YBNvZ8O6p+yvc8SHwvPgNsodjVsWGOan7/wo8trwWI6MsmcIRI4nAWP8fGJuYUWa
	AKyy7ytArkyPxthTRl3IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769016223; x=1769102623; bh=hWIjHUQ/3+eV2KIHriZDhTusV5/FSAT4CPL
	csSVcmf4=; b=uoI6yzBfxFBZEB9CRRVZvjiiBkTMdoyr73tb7uABP6D5UvJLOIc
	IsPSSjzuI0X3v7DtBope4m5HGlhq090BWG32nnSyq39J820YDYDAOqJ+ovapeigF
	Aqf6tQF9B0RHAt8Iz0xRbPqS6BrsjB+hSaLoxBK3tsXYyv03oxNoMwMRce2R7azx
	2glI3wl0fHUEJamijkZ82xZZRzF/TyEbVjQCmbRW+sHrIcAaaC4UQXiz8z8aW66a
	FHb429nlYM/QqdHGS77WVX18UH+xHsKw9CpQ2+I2I/3zfhhN06WmOzshxOiU8UaP
	TXx2cdEqgwaKBcZle7ZEZXVeb8oT2nhYEhQ==
X-ME-Sender: <xms:ngtxaaoTSvEw0LWMpvZMkyZKs4AuCvVu2T8i0ZzVzjuHY3Atk2iw5w>
    <xme:ngtxaTX0kvlghHk6ggEpaxfwgwJQzJfw92C6VFk1k_44jvaqUBV2Es5Qe7YI-_asa
    TLW7F1H__hZh1NxwTuUw6kN5c7M4EuHDYrvv4b_VBmjPWORDAGWMw>
X-ME-Received: <xmr:ngtxaV1LlW6eS7mMj6w-1WSVqJd7F9e8I0_MOYbqPoE4qsLsgSuBEapz5Fj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhmhigrnhhgfhhlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurg
    hvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrrgiiohhr
    segslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepihguohhstghhsehnvhhiughirg
    drtghomh
X-ME-Proxy: <xmx:ngtxaU1AK_Q9oH_qSVWRwocOXIgBv7Wsf5wjpLoSisR75y4XFeTl7A>
    <xmx:ngtxaUmuyikstuAC5EXuJYZz4zhgA2dRQLGDB6X7-md4sEFI-4S6Fg>
    <xmx:ngtxaVNiSD_qW1LVw34-mcrWg91_zoLQ0b0d8ybLbQNxVaochkqQZA>
    <xmx:ngtxab4uYzTb55nkxQ7qgRIyN5cF3hY1Mwi8fOL8WOHAT_vEVlBK9g>
    <xmx:nwtxaapqgE7vvR36iTe8hG0fBvfSgYcq7e8bLESo36fs7Kzq5aeUhmBp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 12:23:41 -0500 (EST)
Date: Wed, 21 Jan 2026 18:23:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <aXELnMSc4UU6DkbZ@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260120092137.2161162-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120092137.2161162-2-mmyangfl@gmail.com>

2026-01-20, 17:21:29 +0800, David Yang wrote:
> The following (anti-)pattern was observed in the code tree:
> 
>         do {
>                 start = u64_stats_fetch_begin(&pstats->syncp);
>                 memcpy(&temp, &pstats->stats, sizeof(temp));
>         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> 
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing, especially for memcpy(), for which arches may
> provide their highly-optimized implements.
> 
> In theory the affected code should convert to u64_stats_t, or use
> READ_ONCE()/WRITE_ONCE() properly.
> 
> However since there are needs to copy chunks of statistics, instead of
> writing loops at random places, we provide a safe memcpy() variant for
> u64_stats.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/linux/u64_stats_sync.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> index 457879938fc1..849ff6e159c6 100644
> --- a/include/linux/u64_stats_sync.h
> +++ b/include/linux/u64_stats_sync.h
> @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
>  	return local64_read(&p->v);
>  }
>  
> +static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
> +{
> +	BUILD_BUG_ON(len % sizeof(u64_stats_t));
> +	for (size_t i = 0; i < len / sizeof(u64_stats_t); i++)
> +		((u64 *)dst)[i] = local64_read(&((local64_t *)src)[i]);

Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?

> +	return dst;
> +}

Since this new helper is always used within a
u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
nicer to push the retry loop into the helper as well?  Not a strong
opinion. It would be a bit "simpler" for the callers, but your current
proposal has the advantage of looking like memcpy(), and of also
looking (for the caller) like other retry loops fetching each counter
explicitly.

Either way, I think extending the "Usage" section of the big comment
at the top of the file with this new helper would be nice.

-- 
Sabrina
