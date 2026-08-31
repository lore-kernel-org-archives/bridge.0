Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C3408017
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179833; cv=none; b=tYNhQwWHSF6367C77yAc4RTiA+qdeRTt3opFCXnAi6yCuSwkE5Q6+DbyMXq/qWrZjp3ERAJzH8onKSVqj7iwJrjeKpVVZtH/XcQsKmft4d1JjEvdf263EomAvwO2whtqQlR0rOeWwupjA1kl3Rpq2jMy0iinsgQDOrlpaKbsBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179833; c=relaxed/simple;
	bh=vU5Pm5j/kRRP83h0uEZ8fm34t1t9ZA6JsaLkvTmcYuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTuD6uQUOWrAt7Gj9+sIndHqa2rjOJW5n4AgHonn4uDrD+eH6pPWzj3pOLbaDnaqw0FMjzy1d6NSW0onglnzOwvC0Rp2mB4cvW3iJ8sx76kq/5ugIDbBL7zcLSxl4V3ThtHleC94AayC54Ci5sdZh63Uz0/Wld1hpRK44ujqyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=m42ER0Sp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="m42ER0Sp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so32467635e9.1
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179828; x=1788784628; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcg00jdxBoVgvjWMidECdjzP3FFCwSJCVtYTTaC2+bg=;
        b=m42ER0SpLBLXwaUXRmMy522SMMf85QoFYGJAMIxRZfYUjwu3SRzZkeLL4nBoVL4+2+
         Hn/C+3Z6Dc8maWXJ3EEHzqAGZOwJIfIXFCDijkkLe0x2GvuGZ2jHjbZmgL+48qG3fmeO
         HzWtRTJAD5zJEv0SX57kDC0YjsG0JRJ+DYjDwAMvVeb2nk90dOll3cBiBV6QxkXEa9Mu
         ycwelR0a72219yt6SPPr77jpHCIW8VTSTSRCrvqrZqQGQV5uVQc8ZnzRtN5ys0WTS36d
         Mc32DzczDBgd+0C3AOEdKYBMYX9W5y0zAYoeRGFOQ+/zbdl9aHz7ynU3Hzg/vdvidxBh
         Qy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179828; x=1788784628;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcg00jdxBoVgvjWMidECdjzP3FFCwSJCVtYTTaC2+bg=;
        b=JbyulmkwK0uEhP1tJzbondRH3GX/pJrC5qAJShMDLxT0GJsZsdCShNrWMeiRzIgd6b
         KsqFh9Pw+yBanzXDB0JAUaTk9Sv7IpPpy2DRd4QZBT99AiSyg2GOou6b2/MDTG/GtpfU
         3Pmymf5tmPch0SO8C0G+bMup7tZLF3UbwDcKbp2In+ZxMhPpFADhX8JHq9mP+U1aXf8n
         VUadVmTdWDrWlgaeCJ0RFL+d81Zf8M77T9YGFbFxjoPogJPC+s94jnlxpUYj7JljT4gL
         eEHl7HiaDY7YnEqDsSKm8c0Ao+Qga5/0Qov8W81KzhO1lzSHm6/AiKU7C88r+6+eCNSZ
         qoHw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4WDIq+WsX12I0BPetXt21civiVOFlKsIiNVPoIfTxdgVs8GbfFRGb+RiXu21/+p9tIzwL46k=@lists.linux.dev
X-Gm-Message-State: AFuF++lRNGYTjcmq15NVU9jV/l6XJ7mkEKZ9M8NB9SwUXihGpwXyaco+
	esQoBUXMqpUHarCsICSkuaS8dOhOw/4laNoK74zrUWNkKnwxLeMEMROjOe6VfwABTsU=
X-Gm-Gg: AR+sD13pGJjLadnO7cdwLqblutT96pKmqm3fK5s99LVJaOu/IhTmK1uNXqbUddLxjb6
	lTGduklCO9DG/i+6e0oK7UywG2r3joxgcoZisdcPCv+zNovy/ZO543CSTtHKXprRA+yxSgetXV1
	XYL2khbRI2MRgYejbYjtR8zIvMND6g+cIgu1dIEP3/v1e8lERDbBNOXzrPnj0NQY0FaM8jhKGT+
	7UlcXRMM2H6jZJ2eH1kOp8L7u4wah5lv1p5AGqN5I92MlHWEvgBpFlW5Sgp4kYoiB9m9oTItBZB
	sYZKPDOwxWaLU58QFgB4gaAW/uhBmuM/hHdEa+d8DxIesGOUcB9Qoo2EjHaATkbivEUOHguwPMj
	MhPGhrK0aHB9Lf49CQkx6a8QFIhm47DSIeaFl7frNOsNY5DU+MAqFqsMJPXe75w0d6kcmQoqVW5
	FuJZWXDglWQghdOHaZ667CycejFvVS/AWnq5R3kEvg38me3JrOChSXoBAfKcSWckKQVDpVAe1XZ
	dp1b2GapL/Y0PQ/7VQ=
X-Received: by 2002:a05:600c:34d2:b0:49c:cbad:1c44 with SMTP id 5b1f17b1804b1-49ccbad1cf1mr290301455e9.6.1788179827630;
        Mon, 31 Aug 2026 05:37:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12016571f8f.12.2026.08.31.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:37:06 -0700 (PDT)
Message-ID: <e9dfedbf-b49c-436e-b01b-cd9cc02618cc@blackwall.org>
Date: Mon, 31 Aug 2026 15:37:05 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: mcast: don't truncate the port group
 walk on teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>
References: <20260831111330.199543-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831111330.199543-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 14:13, Jun Yang wrote:
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
> Preserving ->next means a walk can now reach a group that an earlier
> iteration already deleted as a side effect. That group is off mp->ports,
> so br_multicast_find_del_pg() would fall through its port scan and hit
> the trailing WARN_ON(1). Skip such groups at the top of that helper: a
> port group is put on port->mglist when it is created and only unlinked
> when it is deleted, so hlist_unhashed() identifies exactly this case.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v3: skip already-unlinked groups at the top of br_multicast_find_del_pg()
>      instead of in each teardown walk, per Nikolay's suggestion, so the
>      preserved ->next no longer leads to the trailing WARN_ON(1).
> 
> v2: https://lore.kernel.org/netdev/20260826014200.362304-1-littleddfu@gmail.com/
>      Use hlist_del_init_rcu() to preserve ->next, as suggested by Nikolay,
>      instead of restarting the walks.
> 
> v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/
> 
>   net/bridge/br_multicast.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..ea0a50eb8b77 100644
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
> @@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
>   	struct net_bridge_mdb_entry *mp;
>   	struct net_bridge_port_group *p;
>   
> +	/* A teardown walk over port->mglist can reach a group that an earlier
> +	 * iteration already deleted as a side effect. It is off mp->ports by
> +	 * now, so skip it instead of falling through to the WARN_ON() below.
> +	 */
> +	if (hlist_unhashed(&pg->mglist))
> +		return;
> +
>   	mp = br_mdb_ip_get(br, &pg->key.addr);
>   	if (WARN_ON(!mp))
>   		return;


This should be fine, let's also see what sashiko thinks. :)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

