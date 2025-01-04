Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C53433B3
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980375; cv=none; b=ZFFS5JYOUjrnhyICnuCyyIkeYhQOW41zqW96eDKDIwU+t4f8tyM5O2vqkhXEBvuf/e7Pjx/sPx6qUVO9yEGpxGbS8r24iXIIDDbCXM9oziGoWUL9CaXBmVcs6NTLazRkmMoZHQnfA4TEd8LjWcVzHDvdbAZ+uhmePms5uUtxXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980375; c=relaxed/simple;
	bh=rXjsdc+U0xRvMvZ3QLwKQ9eNTcQFSgkNHad92O7Eevw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFSfdGVCZmGu5yHHXlXkzXlvU0boyGcVUH40NobFmwJmSGQbG6kDq8o+C4/fopLlemfPiJL7g/XRSOtD5OCACmC5Vd0OO/HQdU9DRWN9e5y+97ZcwYarwyplO17Yk4490k7RE56W6NZg2+jd1ssGNo9mwLQev/Ki2EFOdI1orBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fISDaX/9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fISDaX/9"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ebb669df2eso5912928b6e.1
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735980368; x=1736585168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl+Ir+W4Tc150TI86Xl3owY10X0QmL5Q3ZTgg7AzqP8=;
        b=fISDaX/9bnw24UiNwCyyaBUodZZxq3VRLESbYXWboSJ09NvqIeLEy1tC4FRt2ijn3q
         Es9gqpPZja/CVfIwhQBhT10rq0r6uR9Mj2+GXU7xRQ331jzTdXrMNxgaGhEPQFBeAt3V
         RFCxs97qNSRuWXAFGBBxT6H509gMC8M6k4XUSc21B8WG65jmOXliR6sAFY5Z/axFJA6e
         0vP27yoel2wxddc1YKcm1eP2ddhxE/vJqTiIUvcPi5ZbrU2AN4M65YL/h6oJfZthREAq
         rBwPOLMcAFeMvlxLadWzdLvWt74ITg9pyH05EJy3MFWvYbY1h9P+AK6at9Zdd7Kmjd/3
         Ol0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735980368; x=1736585168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl+Ir+W4Tc150TI86Xl3owY10X0QmL5Q3ZTgg7AzqP8=;
        b=n3VDvN2nUh6wJuTrXIabAo7vD4kKxc2n4vHLlCptvLWmenG79QjLD0UEqMrbRCzVyq
         cDggrJGtGMtSYEr3QLSrNKpUNprKDhKya4zmsjGPhU2Z7lhHaCdycPCLAw8DDDrWGxJ0
         qQ9crk7gi7OSjjymZ6V0eIqmdjt3/bY+q7K4/s6RLzPYGTlOUXAWE5fOoda9EeZWMPz4
         +qEE4ASrgRcu8q8zYDWCPOn6wpHrWtnuKjPA3aORTozGTxFClBJcS6y/2jLZqd7GEBhw
         15aXFlRzNFMxSNR/eCPHJmLxQC7gcZTwgqwMllF9eY8RYi2YqkFhX6T5MupDKilf8Dxt
         oECA==
X-Forwarded-Encrypted: i=1; AJvYcCWgtt/fm2iy8B2yaFIkSAEO3G+ZnHjHstM61P0kfXDZeHpVNi3FgXY35mu0MLQZymhQqKjBVEQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDmsCTBW3i92f7DhAJBQQZdQztwmIGeKalL7k30lqaEU7De/o3
	0YlZDxiok8lGnmgHcKBmsWR+6n2O737ASF8syO8j6IXYLXCupaE=
X-Gm-Gg: ASbGncu1Xvbwr2P644ygwLcVEyhkvd0d+g55u6azErTqBhQzQPHKG+oLU9V3m7tVvjw
	Yjv+vBnYkjGf3rOMAx/Ur/2DabopxWuoZqxjp6VJER5i8k/5CE2ZN1GPUAlY2agH8S6QwqIge3s
	luPFBCFWLcFYyLxuY2o7Taxj4R28vMLIA54rKIBUf2LhwJvkOwKBuTnN3zimbVv6hWz+576tXlt
	PUlQv7qNzZNNbbvFZkTDaEpQxu9mAMV+jVrZ8zefJOghuFVArZqfojc
X-Google-Smtp-Source: AGHT+IHSg75soj0PM2nULXoIjrLDnLFqZJlojY/MCnWC55e+vBBNVcMlwjwjjlKj84zfL1TUry7fFQ==
X-Received: by 2002:a05:6808:138a:b0:3eb:615a:eccf with SMTP id 5614622812f47-3ed88f79fd7mr32551549b6e.10.1735980368187;
        Sat, 04 Jan 2025 00:46:08 -0800 (PST)
Received: from ted-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece244e2b7sm8829599b6e.9.2025.01.04.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 00:46:07 -0800 (PST)
Date: Sat, 4 Jan 2025 16:46:06 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: roopa@nvidia.com, bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to
 "const struct sk_buff"
Message-ID: <Z3j1Tp428cuIHUzs@ted-dallas>
References: <20250103070900.70014-1-znscnchen@gmail.com>
 <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>

On Fri, Jan 03, 2025 at 11:59:45AM +0200, Nikolay Aleksandrov wrote:
> On 1/3/25 09:09, Ted Chen wrote:
> > The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.
> > 
> > Signed-off-by: Ted Chen <znscnchen@gmail.com>
> > ---
> >  net/bridge/br_arp_nd_proxy.c | 2 +-
> >  net/bridge/br_private.h      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> > index c7869a286df4..115a23054a58 100644
> > --- a/net/bridge/br_arp_nd_proxy.c
> > +++ b/net/bridge/br_arp_nd_proxy.c
> > @@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
> >  #endif
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
> > +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
> >  {
> >  	struct nd_msg *m;
> >  
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index 9853cfbb9d14..3fe432babfdf 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
> >  			      u16 vid, struct net_bridge_port *p);
> >  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
> >  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
> > -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
> > +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
> >  bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
> >  #endif
> 
> Hi,
> This should be targeted at net-next (subject should be PATCH net-next).
> Also please try to keep commit message lines shorter, checkpatch flags
> this one as over 75 characters. You should wait 24 hours before posting
> v2 of the patch.
> 
> Other than that the patch is ok.
> 
Thank you for your kindly guidance!
v2 is at: https://lore.kernel.org/all/20250104083846.71612-1-znscnchen@gmail.com

Ted
