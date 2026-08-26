Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188E37E310
	for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730504; cv=none; b=OJ7m8Zk0i7UEVXKTf4I/z+1wYfp7CcK30hiLnA1PGteMp9RkVjlGo6nYsmkA0HD2mIKNBcKDgLTMuIkGifdSIKq86U5xihUVdxBl7GPH3rJ+7K2Kuc69GYShqzgE3TpU0JFayIJM27NuJdCHP3P9i8d2/rqScKJemGPZzoN3T5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730504; c=relaxed/simple;
	bh=WJ0uLwRr9UFmTPVr4jLczI4kM0DG/KFUsDWq0YyLYMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+yQhGwdCk+vr5OdrG6+XLi2i5psXaGBIlXwjTQhx2gnL97qJkGDwquip7Y1X0XI/yH5SwIlGwXjhZZHaABUNDRaGu3iDKopPryeb1IOFCsiev0m6Fvs0IM8Pq2Iwz3KPM9dj3uloDHKgUucvqNnCFOX6SnNITTYVHd/MMQQrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nxRY8IGn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nxRY8IGn"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e2dab83eso93886166b.1
        for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787730499; x=1788335299; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUoJaBU6v8Sez5v2j24ZHioeYX9zgLhvXZSZMCcMA/U=;
        b=nxRY8IGnzhQxnQhLaXcg0e70UBC5C4iQIBjTUG2WmWwfxsuZBrsiaQZvRUXc6Sow7N
         ytReUJH2UhVgKG2LmXCHDvyJC+fnWSZV2y04xsi8aAtBBqf8NJ9KGDhHVtHwnpDb2hPq
         uAVIYTEv2/gpEFJhtTYnnKMIphxTXvFUH4y6FgiRoNe9W+lsC6LLIpjKSmX5MY/Vs4PU
         nAc1wSs5kjVXB8/PWBOR7gR9lv2npuZzlj1LCZLVhjcEGDThPAUxfuT842ePuBpj/fL7
         fzUMAESGG+ZJgyvAXr5RykcBPnjTcQxXHQczReBnDIJfhD+6Ybh4NMiLsUxiU4imW/sQ
         JB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730499; x=1788335299;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUoJaBU6v8Sez5v2j24ZHioeYX9zgLhvXZSZMCcMA/U=;
        b=YuMGlSKj2Hr1+ngHhtE7XoQa4mwH9QLlz84HfVeYD0pPq8kpLdbgMAyQd0aOAamdlA
         fgkw67k0MN0aDtc9JITFnxht32gEGkc8l/D5aPoFupMPM2R0PwFy26jbjV6O3SfueIvV
         xZakw9eLTxSW3NyGIF/Wc5joTu+FlwFqNkk1PNkav3286jnnVJNVnzlP7gBONN/SLkBu
         c5ORzHMNOs6ky8asYsKIDzBLa2/Ykbri7RXKyfX1TEor7bTbi4tif1HfCfcEQtnuyGZB
         p+Fe/aUjL8H487rRcOBiA9gGtrZecAV3mTLd+3eLwyrB6ZUCc2aJIkfP09bN+IcGIpGq
         2QFg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1SCj2QKIDW1QU4pu+R6mkx6VUTUQOCk3icDhgzDT2EIE6rb+I8TWtz7hEaCsoz/7FvkwVipo=@lists.linux.dev
X-Gm-Message-State: AFuF++motYdFE72P0obeyfh8ee+MHfS/WjqNztSigZTvlSz4r8keI0WX
	ma3sBhIN5ZcwKC4PYmUieTogxpEJpHuxRlpbva63eBdU2vyruJPMJy9GuVGIHGM1MzY=
X-Gm-Gg: AR+sD118sogW4zcEKJywvie9gIr8wXDGbUL16eXTkjgLmMqV3GtMJiN7es93diWWRAh
	EVJ0geg/4O6vge9QZD2JRmfzkEonBNaAtCy6XeZ37YpahazfhOUN0r+0MnPGL0zx0RWJGUyLZJc
	9VK4rSSNvARHoLTjpmh5mOdj07bqegH8CzfuEQ2haal2rSZugVh0f15ffHHkH8TxMPKFPCDtPt3
	JWvgHmUWmFSlj8rzxkGTBLuzCUuViye9zbfwg6JanhMthzWtL8YZV2VC8MNkPTqxdx/XaSmioF/
	hEgRzobNjY981niPoeai7viyegFywEODlxQojrCEPK3aLQcVZIYUDoBzgZJyfwf2dNZMK8B4gt3
	tLYZTkOJ0yo7PR4UqIXVbBipCPU41f1wZQVquqo5ZGbXMXUq/oXiwJAKC7YRWsSevoyu1ckdj4W
	s/yxmMbHkA3dAHYriqmMfVDPhv7Xw7K+g8o8yxBWZZeQKozYTvOTHDTj96haMAnBbPjfFrfvLR4
	1+sd0bO1dtWADD8HkM=
X-Received: by 2002:a17:907:6091:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c250c408972mr651961666b.24.1787730498862;
        Wed, 26 Aug 2026 00:48:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62dfsm338649666b.4.2026.08.26.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 00:48:18 -0700 (PDT)
Message-ID: <86b735ff-6996-4ab4-96b2-6853fcc788a7@blackwall.org>
Date: Wed, 26 Aug 2026 10:48:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mcast: don't truncate the port group
 walk on teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>
References: <20260826014200.362304-1-littleddfu@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260826014200.362304-1-littleddfu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 04:41, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
> port->mglist with hlist_for_each_entry_safe(). However,
> br_multicast_find_del_pg() can also delete other entries from the same
> list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().
> 
> If such an entry is the iterator's saved next node, hlist_del_init()
> clears its ->next and terminates the walk early. The reproducer triggers
> this in both teardown walks, leaving port groups in the bridge mdb with
> a dangling ->key.port after del_nbp() frees the port:
> 
>    BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
>     __mdb_fill_info+0x1191/0x1320
>     br_mdb_dump+0x594/0xe40
>     rtnl_mdb_dump+0x1cf/0x5d0
> 
> Use hlist_del_init_rcu() to unlink the group while preserving ->next.
> br_multicast_del_pg() and the teardown walks run under
> br->multicast_lock. The GC worker must acquire the same lock before
> detaching the group for destruction, so the node remains alive while
> the walk uses the preserved pointer.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v2: delete with hlist_del_init_rcu() to preserve ->next for an in-progress
>      teardown walk, per Nikolay's suggestion, instead of restarting the walks.
>      Tested on 7.2-rc7 with KASAN: the original use-after-free is no longer
>      reported.
> 
> v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/
> 
>   net/bridge/br_multicast.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..8022c7f12169 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>   	struct hlist_node *tmp;
>   
>   	rcu_assign_pointer(*pp, pg->next);
> -	hlist_del_init(&pg->mglist);
> +	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> +	 * a port->mglist teardown walk may have latched this node as its next,
> +	 * and deleting other groups of the same port must not truncate it.
> +	 */
> +	hlist_del_init_rcu(&pg->mglist);
>   	br_multicast_eht_clean_sets(pg);
>   	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
>   		br_multicast_del_group_src(ent, false);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

