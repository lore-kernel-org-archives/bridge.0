Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305329B766
	for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785060848; cv=none; b=NsPEL298T473vJrZvkx5UIxKeL4ldOvGOAHEFZZ/On0DDTUm+bdew4v4jCf7NX4V3AUEVP+pE83wMuOKMC3hmo/QR99nCwrKnSU2VuNEowp29MUNda+c2lgHc0x2Dfj55z3gRRNIq/gywRS0hWhFgfoPjKZlVrpeu89jwJ1hvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785060848; c=relaxed/simple;
	bh=h1P5btjzqqAMj2JC/X8BiIMgvZUoT0u7grKnwIzMGNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEs7uLznaXDr5UDysSEx1bjT+46CQmaVf+blklFlGVOZsAGft6671RwRUqhghuSER9/PFCzx0AB/ZOp5jOB2TwlMggv+ubhmgv5azFNelgjPL44xoFTU9UltLFX5pY+dPrVELGmV9hML1IRxUgRy/I7N9L3WH8qwqk/nu1wdm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WQpfGvLh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WQpfGvLh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso13002495e9.2
        for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785060845; x=1785665645; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDxc0+6iV2GZQ0LIsObeEGPpkXqQEjGEB1+96GPkh0w=;
        b=WQpfGvLh9f4EoA6X6pNZTveUHPFpZXlxsCK/kqFfop2epv1CCniSfE2vyO1Xj6s6OJ
         c2LYw+aRaaj4S+HJlJZxOCOBbOCnuh3Dn9Kk+pgpWO0L8pIK/Xx0CWi5wxEjBW3YbVJY
         LbLIrCvP316SpHzOct5PJsQat0h2WQX1jPML/GWyctQ5z+ev0fz1NkEpDGxxFDpfseEQ
         pNd21N77FwmFPoR4FR1QCyl20+Wkug5Y6qJRhMqaeDVsxPdwvHORqy6JRL73hxekece3
         lNJYRlgJL6+b7rjycEMksFQ3bMQknG90j4FNFj0e2b7zkwcBHnxkhAMFNZU/KiM0uOSq
         5XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785060845; x=1785665645;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDxc0+6iV2GZQ0LIsObeEGPpkXqQEjGEB1+96GPkh0w=;
        b=itGoUuzQhtOFiixkvKhFIEkfTM6pNWXvBdVBoKKMNL4qJsKvdud0KVtZtxzCFnTarD
         dE5+F7awfDtP/jqDZyTJuQA59xEpE2CmjXjYmql8tm/7C6rb2hl9c+Uuszx4XsLH8S44
         Soh/kSYEP9M1wHGyxsMQ8z95sXsFFlk7Eb5NlYBGVLy3fvrDazitd5Wzc9JmLLjmPMUX
         YQk4vhIigpQpKZ4OfG3EQXIR3BK3CY/Rd1Tr1EMpyQ183P5R/txDJekncXK3kpnMpx/Z
         c+p4q4OCVpufVyPbTdC7FTEDefEXWBKthMuH7NPD/9O0fr3k2+qUrBucS4AsgrY6sB1c
         e7VA==
X-Gm-Message-State: AOJu0Yx/0D3Q275t7JxekJzkOOzqAabIekIiS33e3azhVtaOpbRUTXRt
	f7vAQO+DbhwQKmSSJoS/exaGSOhZYoDGStuwJrLNtOvAr/QigGNW348FLm2TVgS+Dkc=
X-Gm-Gg: AR+sD11ZWC3zH+91Afa+AtchIsd6jKV1EKS6CSF+AkHkaP2iUQnT8VtefhiikQxsf6K
	M9IHDe2fTA5Xkw4VFGGAIPfD2mez6RKvU4BkGysXPBSddBrBe5aHAQ0t7bK4+7pVAB/wG0bhAGb
	VKQQ5xKkMLfJ9GDhh3ke0ZhD0h4KObrm92NxBi0BfwcA4ws6rMXJpIkPGaBnzty1zbbt5gQ3Aqu
	0pRnIeR+l9hlwa1SNkdsnBJLqGW+ZmOiMzquZOzvPKOXYUzwur9M86YjFqRJZTKQimC9q6hQD5L
	FNP/60a5L3eoRi1eRmBYgWXZ1zgxja9BRUfChsJmIGkPnx9Vb/7yuq5S4Gdply8WF7Wspkkkl1y
	7VCT61xhPhuQLVk95Aq3d+Lbmfw16+tluFwDnKl8lmDpqO8NO6UrjeJNXHtG3WIF6DON0rG2NFz
	cKuv3sILYN
X-Received: by 2002:a05:600c:3e10:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-496b57160e7mr53193435e9.19.1785060845317;
        Sun, 26 Jul 2026 03:14:05 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm162079695e9.1.2026.07.26.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:14:04 -0700 (PDT)
Date: Sun, 26 Jul 2026 13:13:53 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, linus.luessing@c0d3.blue,
	vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net 1/1] net: bridge: stop fast-leave after deleting a
 port group
Message-ID: <amXd4UTdaREoxTpG@penguin>
References: <cover.1784707712.git.zhilinz@nebusec.ai>
 <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf0898872ef7c72d5f4c0304414a192c6dac591.1784707712.git.zhilinz@nebusec.ai>

On Fri, Jul 24, 2026 at 12:52:48AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> br_multicast_leave_group() iterates mp->ports with pp = &p->next in
> its fast-leave path. After br_multicast_del_pg() removes p,
> continuing the loop advances pp through the deleted entry.
> 
> If multicast-to-unicast was enabled, the bridge can hold multiple port
> groups for the same port and group with different source MAC
> addresses. Once multicast-to-unicast is disabled,
> br_port_group_equal() matches those entries by port only. A fast leave
> can then delete one entry and continue from its stale next pointer,
> leaving mp->ports pointing at a deleted port group.
> 
> Fast leave only needs to remove one matching port group. Break after
> br_multicast_del_pg() so the loop stops before dereferencing the
> removed entry.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/bridge/br_multicast.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 6b3ac473fd22..00aa9b2879d6 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -3687,6 +3687,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
>  
>  			p->flags |= MDB_PG_FLAGS_FAST_LEAVE;
>  			br_multicast_del_pg(mp, p, pp);
> +			break;
>  		}
>  		goto out;
>  	}
> -- 
> 2.43.0
> 

Yeah, all other places which use br_port_group_equal do exactly that
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

