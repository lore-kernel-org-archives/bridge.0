Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D11CB336
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622606; cv=none; b=l1pWnD1O0j6E66Yi3ps99bmn8s4rLfXFXkEyJwhST+dyzPLQrJef1xMsumefqdIeiHuLMhtcRV65xmVSBn1oBoGx1XSjIgMlB5/F3NV2Vc0CwCDfXDOf8SZnI/+mPa/HLi5RpayCca0Sf70nd66ppolFXrLphYBngIkLGdBzufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622606; c=relaxed/simple;
	bh=H/3SLq0dvyRb0LeVyF9BgA30UQ44hQlrC2EyAJ37Cwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L7CYNn5WX9tN57TWklVnTpi/ST0uWbYecV8GnCdr+ZQp88mb5Z3f9hkok9WJjsLAN1nD5BGEVe6gUwISPymrdMbjBOLX8a/DIUx48LFjc70la5GZGYlLQS/unm2TF47uUjgMyV5lZo97uKE1iNe2pVAk+FeO/dHOk9Pj2w6PG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+E7WfYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+E7WfYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
	b=g+E7WfYA8DD9o86aJST2lpOYNTPB3QzGRlkCBAnNqcs6dLZPsEV0suyWnQkGZGggp7Zdto
	AYyx9uusViTDa8Q219G/ZhLSjfKJuAr+sT72b7VuoH2wvEJmN6MR1SGn0aH7RQa88sZBNd
	xQOvUSC56sPLo/XBiGjX5Ov5ZYhXJfI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-Sfi8_3iLNzq5oeSgE7YDFw-1; Fri, 06 Sep 2024 07:36:40 -0400
X-MC-Unique: Sfi8_3iLNzq5oeSgE7YDFw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42ba94a0555so15440375e9.0
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 04:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622599; x=1726227399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
        b=m9HZysJ7pWQeVtmzmxNCQNmCOE3kyz/ZhchlPHwRNxnuJzXtXFUHPEMpIcqZH4k37H
         7j6enTl9BQr4xoahDKDMMWzN1NT6mdy9SxR89GAm82UeGq2qSy/STAvAnUxiumP8Mrvo
         DpN6Ee93vEXvXKpkblmF/k8gZAHB3R82/lauF/+X9HCoGYTh0DnY3UBUbKiKW95ylrig
         IgtR2tMSlFnbNNIYYVW24g6nn3Adctqw/BCRQc6vpVk1JyseCrnQOEeJsa8uE5E4y5Hs
         TkmAknGUeE3qti5SYF3o2vqyXUUSWma64z1/h5MEi5k7NUwP1CtHDJ60QP/vSxI951xF
         FC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPbKQCUUBN4xH7D4xKcTn80yCqcLcKDQSeRLAlLkwYaliiErYD/enoDr9nkj1tOnsnNxYJpjk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq7y4BJr4RDrfbBlwerTYcUk7m9Y0e10herhfuigO6XyT/XwEV
	0n+Q7yd5XgPDsn1A4zytyGSPDlBmzQzRp85IfuPAjNHs2+bKTxiqIQki2C8n+50ls2RHLpuQHBz
	/ovBiWBu5K1QqAw8JVPdxK1MH7JQ2J4djl3y/WiHtxNzI0xLw29RCcg==
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448836f8f.32.1725622599284;
        Fri, 06 Sep 2024 04:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvxtr7JBMGDYXn43/Db5EyNacFUtJy69cDUqld7dUH+RRHTkLZupBqCPcA0/x2kPypfjxAg==
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448800f8f.32.1725622598548;
        Fri, 06 Sep 2024 04:36:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm17942975e9.13.2024.09.06.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:36:37 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:36:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtrpQzQYR1yylvi0@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-6-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ip_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 18964394d6bd..b632c128ecb7 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  
>  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
>  				    iph->saddr, tunnel->parms.o_key,
> -				    RT_TOS(iph->tos), dev_net(dev),
> +				    iph->tos & INET_DSCP_MASK, dev_net(dev),

The net/inet_dscp.h header file is only included in patch 6, while it's
needed here in patch 5.

>  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
>  		rt = ip_route_output_key(tunnel->net, &fl4);
>  
> -- 
> 2.46.0
> 

