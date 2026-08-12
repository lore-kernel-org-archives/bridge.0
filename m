Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CE43303B
	for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537035; cv=none; b=sm+4mzEfbuWpExsFQ82DMZ8GaxiXLOtwC0fzGIiWH8F/GJ2TCJTmXC4QKVYfdFqoNh89A4F8Gq3eap2OiF6Y89Y3Oedhgf75vkVGlxO3wSaJ51XP486J3TDahHkmag6cMepKXZGo+He3ZKM8RAt+OnWPADJhZSDukvniI1S0dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537035; c=relaxed/simple;
	bh=6wiDWXMEJCbp5MAnB3iLeOvQ8Ifz6/TEB24QRvVTxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kq5ERwsXT8Z2+I9syuzlIsDmBVkU8fO5shKxraaQKlAj0H/caKinU81cBF5vp9BxUdguzVfrN+cNcnyzYf7FDN0Q8Ie2rRlk0JsCWU2hEn1LOnsmhp3jIsThJ5S2zK7Sy5AQJD87BxpgHVKeHtkevbRFv5tTeS/FPXzdln9uP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NhBVi3pt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NhBVi3pt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49553515a8bso12814465e9.1
        for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786537030; x=1787141830; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBwafU5xy4gBpXZZ8RpOZbZKdoNHkxpt7OyTBRfCxbA=;
        b=NhBVi3ptVIjNK5f9LF1qrGfvuxnxMBJJPAF6rWXDpTwto9Hlvyv/eBdGFSCl12nBG+
         L2GIFyJxVF8koT1GaSgL6nJP4RTM3+tWMN6tPKTHrNoyOmHCJKmht+8dGHBj+EWksUGg
         DmPIzLrcL+YtGXbkEhjYL4ccE4c1Tcg1zPcuMGMPHTAirPOD0VuzpNk8HJOyqgETUQsf
         jdIAyfYOjqKBuP9vKW6DhO4gx2llyTx35a5CLFI0oS+lwINxUp1+jQD3NegSo4bcyWPf
         22F5mCu1wS7tUobdqBVh5ctlOtu/fjWP4wpmrynHi3Wj2ABMc3+OVpNjvVOZq+p+vj9/
         QmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537030; x=1787141830;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBwafU5xy4gBpXZZ8RpOZbZKdoNHkxpt7OyTBRfCxbA=;
        b=Te+3hJa1BbwJza6qBZtsYI/E0M/T0ovss+oKdYKydqDzH7oM1rDKQv67Vu8siDx30f
         C0wjbvdf5Q+7Uxb/1w/ffS9wKCLS0gfdu/+DwAbuz0+DSBXLmbp5BJl/2Zchml2ccAC8
         QGUP03oswEZ4MJVpwFysxlD0Ctw0D1jy06rGq6MRcUznUdQjK53850aj7oPDFhVLS5Zs
         iLIc6vDI9+niWE73+jLeVEo1t18Sa+Bb0f8SIbClDuSyZvFG42i4expmNo4pgXOSASYJ
         Wl7LEAXOhEQExpeg57TtMgrSZO1ApL8JfP4KoLozApJXSGTFlgs2cayiaW5TNrODmeUE
         sjig==
X-Forwarded-Encrypted: i=1; AHgh+RookMGIuOWLMyNGGGI9PnqHWE6r8gualfh6JLDf6veQYbd2kXNiPCbjF5cOry2Qtqugl3zF4MM=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi7/VC6EwhEAq1BdX73ge/xVp2qZs9QPJ2BaqHYAANcyn3NeP6
	3cdxcPTiQPy6LKyc00/2dQ5y12Vaq0pT6a7bIuGOjhI22BgLPt4s35HhkV2RVQgDjX4=
X-Gm-Gg: AR+sD10UjLHzGtduTE8tt3HwHhNuNLwT52AX7W+CGHD0vWZ6XH+DxLB+DSVOOe1932Q
	RMfSjyFG/6jp9Fs1jyeNNZnUfAHOaB257XACoBrEllJDDuVIug/kChkCWPZk1M7qwvkREB9HI1R
	h1clifoiHpCExCjt1tq7AXbCtpr5cergBWzgUBpcaOPBbcA0VNLZrPUFU63glRLvESSHYj18P4m
	fyoNU6OHGxW1eVBokE7iiTvnMcLyPE4PpFNy2GtWNXU+tWPq1vK6wA9zjPA4RtVTXOwvtf2sCVs
	1RQX3xC3mH4DU1TPIu9QuUMb/IDUFcgraMuPVz/yIi9RIEqExUhvkYIIvP8VU0cWM3WuRNy5aFN
	YFoKPnXqrQimbQik+zmuwESbOaWabAiqTTVa4duJrPAta9dgChduls+Tz0RnzIIcLtvSpz5D3zH
	JBN4PfsyEqfVdw5Nq18Ka19YUjpBZtIgcu43O8LTOKQ43aq6T38yfZMwvZ70ocxk4ZVUDiSoYr5
	34Ty3ipC+gC5wyN7C0=
X-Received: by 2002:a7b:ce0e:0:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-4997c149ba3mr41006275e9.14.1786537029670;
        Wed, 12 Aug 2026 05:17:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c94f4c0sm40120515e9.8.2026.08.12.05.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:17:09 -0700 (PDT)
Message-ID: <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
Date: Wed, 12 Aug 2026 15:17:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
 TencentOS Corvus AI <corvus@tencent.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260812113435.1854275-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 14:34, Jun Yang wrote:
> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
> port->mglist with hlist_for_each_entry_safe(), which only guarantees that
> the *current* node may be removed by the loop body.
> 
> The body is br_multicast_find_del_pg() -> br_multicast_del_pg(), and that
> deletes further port groups of the very same port. br_multicast_del_pg()
> drops the group's sources, and br_multicast_fwd_src_remove()
> (net/bridge/br_multicast.c:583) deletes the (S,G) port group installed on
> that same port; br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
> (net/bridge/br_multicast.c:330) deletes the automatically installed
> MDB_PG_FLAGS_STAR_EXCL entries, again on that same port. All of those sit
> on the same port->mglist.
> 
> When one of them happens to be the node the iterator already latched as
> "next", hlist_del_init() clears its ->next, the walk sees NULL and stops.
> Every port group after it is silently left on the port. port->mglist is
> head-inserted, so this needs the cascade victim to be older than the (*,G)
> entry owning the source - a user-added, non-permanent (S,G) MDB entry added
> before the (*,G) join produces exactly that ordering.
> 
> Hitting it once truncates the disable walk in
> __br_multicast_disable_port_ctx() and once more truncates the flush in
> br_multicast_del_port(), so del_nbp() goes on to free the port with port
> groups still on port->mglist - and still linked in the bridge's mdb, with a
> dangling ->key.port. Any subsequent mdb dump reads the freed port:
> 
>    BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
>    Read of size 8 at addr ffff88803065d008 by task bridge/9527
>     __mdb_fill_info+0x1191/0x1320
>     br_mdb_dump+0x594/0xe40
>     rtnl_mdb_dump+0x1cf/0x5d0
>    Freed by task 0:
>     kfree+0x265/0x740
>     kobject_put+0x212/0x6a0
>     rcu_core+0x5c6/0x1140
>    Last potentially related work creation:
>     __call_rcu_common.constprop.0+0xb7/0x9e0
>     br_del_if+0xdd/0x260
> 
> Don't rely on the pre-latched next pointer. br_multicast_del_port() deletes
> everything, so just take the current list head each round. The filtered
> walk in __br_multicast_disable_port_ctx() keeps its iterator but restarts
> whenever the latched node has left the list; port groups are only freed by
> the multicast GC work, which takes br->multicast_lock, so the node is still
> valid memory for that check.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
> 
>   net/bridge/br_multicast.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..624dfca4066b 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2065,12 +2065,17 @@ void br_multicast_del_port(struct net_bridge_port *port)
>   {
>   	struct net_bridge *br = port->br;
>   	struct net_bridge_port_group *pg;
> -	struct hlist_node *n;
>   
> -	/* Take care of the remaining groups, only perm ones should be left */
> +	/* Take care of the remaining groups, only perm ones should be left.
> +	 * Deleting one can delete others on this same port->mglist, so
> +	 * always restart from the head.
> +	 */
>   	spin_lock_bh(&br->multicast_lock);
> -	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
> +	while (!hlist_empty(&port->mglist)) {
> +		pg = hlist_entry(port->mglist.first,
> +				 struct net_bridge_port_group, mglist);
>   		br_multicast_find_del_pg(br, pg);
> +	}
>   	spin_unlock_bh(&br->multicast_lock);
>   	flush_work(&br->mcast_gc_work);
>   	br_multicast_port_ctx_deinit(&port->multicast_ctx);
> @@ -2126,11 +2132,23 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>   	struct hlist_node *n;
>   	bool del = false;
>   
> -	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
> -		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
> -		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
> -		     pg->key.addr.vid == pmctx->vlan->vid))
> -			br_multicast_find_del_pg(pmctx->port->br, pg);
> +	/* br_multicast_find_del_pg() can delete further entries of this same
> +	 * port->mglist, so the node latched in @n may be unlinked by the loop
> +	 * body. Port groups are only freed by the GC work under multicast_lock,
> +	 * so @n is still valid here; if it left the list, restart.
> +	 */
> +restart:
> +	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist) {
> +		if ((pg->flags & MDB_PG_FLAGS_PERMANENT) ||
> +		    (br_multicast_port_ctx_is_vlan(pmctx) &&
> +		     pg->key.addr.vid != pmctx->vlan->vid))
> +			continue;
> +
> +		br_multicast_find_del_pg(pmctx->port->br, pg);
> +
> +		if (n && hlist_unhashed(n))
> +			goto restart;
> +	}
>   
>   	del |= br_ip4_multicast_rport_del(pmctx);
>   	timer_delete(&pmctx->ip4_mc_router_timer);

Thanks for the report, but instead of all these restarts and checks,
can't we just do:
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 75e1e2a8fc83..62c4008c5bb8 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
         struct hlist_node *tmp;
  
         rcu_assign_pointer(*pp, pg->next);
-       hlist_del_init(&pg->mglist);
+       /* use _rcu to preserve the next pointer because it might be in use */
+       hlist_del_init_rcu(&pg->mglist);
         br_multicast_eht_clean_sets(pg);
         hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
                 br_multicast_del_group_src(ent, false);


I have old patches that remove the mcast open-coded list implementations, I must
revive them and clean all of this up finally. :)

Cheers,
  Nik

