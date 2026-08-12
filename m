Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361F2C1586
	for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537308; cv=none; b=rVUk4rtuKJurOGp548da8yYPuKxY2B7p8LuaPOpOisg13wLQFq0QmgEihjSXW8RTyPuq7LJMiWt1Y2cXvz/xui6nnws6sOl6U0MjgyppyQmb1shs2LHM9HgBpSNJOYovm04cynwXQVgT9gptjN8BmyiqKdlWWQ+Bd+rFRyCVyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537308; c=relaxed/simple;
	bh=TTHgu+gUw3ElDGaCBq4zqG4/5Ftus7R7onl0s5VlgJs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uFHZKb3er0RhN3shWqQwvvlgD7k9CBcu/0/LPys+d+MMQHF7x8TzNdvzBZU3bN2nkCnIZz6EGfgaNpogrkezO680K2+aKY6fSxLV17VxwbUzgAR9Q+t9h0XIpjtHUBgWWUQZ5RQczHiU14gZkQZN6mDhmZYO7rY2gi+XxgQqez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=eDNXQz69; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="eDNXQz69"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fd66a094eso309680f8f.3
        for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786537304; x=1787142104; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSo+zX34PXZ6cG3/vTToUAI0Vx7jC2jXqMYjh9Sy5Mw=;
        b=eDNXQz69aedQ/dkb2zCxxRBW1g4mbvBFqV2dINrI1AroOo4BR9bFe/40jvvTfIwcBj
         nRwhkwWPvrQ0yHPf8bDLI+MI8a/YIZ3UTYgWt+8Wymc3EF8/vkVJMauhzx90+cQmYNlo
         oetPfa9elxqVT2ssm4+7WdnQJEyxZ4/ZUGL6t9sSHGyJomzBTGgx0l97/uIEIfMlkxTF
         tPwgIwnT8KfHqrq5Ck8GSHMLbVDvNi0ncoVMpmpwa9BLa7O/tpK4uwSjoWTDnjTwdn5J
         wOqW4/DjyYRyel5Rqqt1xPkxUM7wKqISJd3him4iAp3dDQcZxHbrG31SgdtUkiQO8CFj
         JNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537304; x=1787142104;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSo+zX34PXZ6cG3/vTToUAI0Vx7jC2jXqMYjh9Sy5Mw=;
        b=DrP7kIc+w5f6w/pRdQbRHGDWO4VRLH80CPE89deCiMk8VsN8M49XvRXcSq0EunOPWM
         Q4lnIwO8xHMPJtmLKmOkUAHUS5PtQBOUUzQ5Gk9wsa+p9tqxPPTD1XjjH1GeyErbL0Iy
         /9FdSoi45pqYen75OQOVZ5M2GwBH/JTGlUgxH54tHHqINwDYv/TNMTiCUwpVwzzeWHjU
         Jj+Y1t98COnLovaQxXD1exgNlYgqTm9S1LvROOZUhvQp1TPIda2FMGYotOE6IcekRjqE
         1UDPnobE+fVIEkCB9qncvFHAKpG2PsHiadlJgq8rAAhHs3E3Oh/2rZM3ABOOfG2ijXY8
         L7gA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5ttYYkOuXkVLgAmZ7YQnBGWU4eJmm54ZN/2ZWLnEQPEjYjzn2cy2pRTXBBs0B5EwBUWWJqaU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyTBG5dQL900YqzhMJEIHMXArEOYkGQQvOcTaceOJU4PJIb2Xkb
	DW3TqPRMefv9FCbulajaeA+Nr9+1youihyqH189mm1P+bqHj0+YKhUqGUnQ0VsHmhpc=
X-Gm-Gg: AR+sD11mQcY1VDWBTHw8lcrIRGtYxM6yrRrD00Q/vLyPT3V96rbuURvkrNcD7ktbtS1
	FpQj2Q7Lb233Jyx8zsOQ+TQ/rxYqrAvDYqnKHzog0lvCqw6XJjRIE+qi/u1fIUBZUBA6FDtQVp5
	WJ2pZZ1OM7sc8oyOLTNJIz/8A6SCQpdG0nTDT1e/twDKWHpjP+ZFhNyOs4RRx8iGRfs5pxbnd9J
	cGUTA4nsuQhzPljgCvECfrxea4w6SzYNe9fwrLyE3B2Ac64p4tQ2VXD3wlzNX6cA4b2ScvpzkFx
	8SMVNK4sNLKM3rAndgUgerVVVMvAi4t2/KCR+04PN3qeQA45LPX2DO+A47Z4tUcQK6HGVA2jlyT
	5rzAH7mRyRdb37X6HvL6K7zHlueuQBteW7EPPc5bxTLpyUwm2Sv/68lP/IcajKRldhGNjFb/xQA
	fBI/pURKrnSHBY6X+yzZ/jnmBxi5WNEecmwdgj/9lTxS9nUveJ+M2Xt+c/IiaODC6xICcESSjxj
	MUHYOkWRSufnsqg9JI=
X-Received: by 2002:a05:6000:4808:b0:47f:8fc9:6eaa with SMTP id ffacd0b85a97d-48152b149bfmr6617925f8f.8.1786537303719;
        Wed, 12 Aug 2026 05:21:43 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d7010asm7043286f8f.33.2026.08.12.05.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:21:43 -0700 (PDT)
Message-ID: <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
Date: Wed, 12 Aug 2026 15:21:41 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
 TencentOS Corvus AI <corvus@tencent.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
In-Reply-To: <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/08/2026 15:17, Nikolay Aleksandrov wrote:
> On 12/08/2026 14:34, Jun Yang wrote:
>> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
>> port->mglist with hlist_for_each_entry_safe(), which only guarantees that
>> the *current* node may be removed by the loop body.
>>
>> The body is br_multicast_find_del_pg() -> br_multicast_del_pg(), and that
>> deletes further port groups of the very same port. br_multicast_del_pg()
>> drops the group's sources, and br_multicast_fwd_src_remove()
>> (net/bridge/br_multicast.c:583) deletes the (S,G) port group installed on
>> that same port; br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
>> (net/bridge/br_multicast.c:330) deletes the automatically installed
>> MDB_PG_FLAGS_STAR_EXCL entries, again on that same port. All of those sit
>> on the same port->mglist.
>>
>> When one of them happens to be the node the iterator already latched as
>> "next", hlist_del_init() clears its ->next, the walk sees NULL and stops.
>> Every port group after it is silently left on the port. port->mglist is
>> head-inserted, so this needs the cascade victim to be older than the (*,G)
>> entry owning the source - a user-added, non-permanent (S,G) MDB entry added
>> before the (*,G) join produces exactly that ordering.
>>
>> Hitting it once truncates the disable walk in
>> __br_multicast_disable_port_ctx() and once more truncates the flush in
>> br_multicast_del_port(), so del_nbp() goes on to free the port with port
>> groups still on port->mglist - and still linked in the bridge's mdb, with a
>> dangling ->key.port. Any subsequent mdb dump reads the freed port:
>>
>>    BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
>>    Read of size 8 at addr ffff88803065d008 by task bridge/9527
>>     __mdb_fill_info+0x1191/0x1320
>>     br_mdb_dump+0x594/0xe40
>>     rtnl_mdb_dump+0x1cf/0x5d0
>>    Freed by task 0:
>>     kfree+0x265/0x740
>>     kobject_put+0x212/0x6a0
>>     rcu_core+0x5c6/0x1140
>>    Last potentially related work creation:
>>     __call_rcu_common.constprop.0+0xb7/0x9e0
>>     br_del_if+0xdd/0x260
>>
>> Don't rely on the pre-latched next pointer. br_multicast_del_port() deletes
>> everything, so just take the current list head each round. The filtered
>> walk in __br_multicast_disable_port_ctx() keeps its iterator but restarts
>> whenever the latched node has left the list; port groups are only freed by
>> the multicast GC work, which takes br->multicast_lock, so the node is still
>> valid memory for that check.
>>
>> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
>> Cc: stable@vger.kernel.org
>> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>> Assisted-by: tencentos-corvus-ai:kimi-k3
>> Signed-off-by: Jun Yang <junvyyang@tencent.com>
>> ---
>> A KASAN reproducer for this issue is available if requested.
>>
>>   net/bridge/br_multicast.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 00aa9b2879d6..624dfca4066b 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -2065,12 +2065,17 @@ void br_multicast_del_port(struct net_bridge_port *port)
>>   {
>>       struct net_bridge *br = port->br;
>>       struct net_bridge_port_group *pg;
>> -    struct hlist_node *n;
>> -    /* Take care of the remaining groups, only perm ones should be left */
>> +    /* Take care of the remaining groups, only perm ones should be left.
>> +     * Deleting one can delete others on this same port->mglist, so
>> +     * always restart from the head.
>> +     */
>>       spin_lock_bh(&br->multicast_lock);
>> -    hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
>> +    while (!hlist_empty(&port->mglist)) {
>> +        pg = hlist_entry(port->mglist.first,
>> +                 struct net_bridge_port_group, mglist);
>>           br_multicast_find_del_pg(br, pg);
>> +    }
>>       spin_unlock_bh(&br->multicast_lock);
>>       flush_work(&br->mcast_gc_work);
>>       br_multicast_port_ctx_deinit(&port->multicast_ctx);
>> @@ -2126,11 +2132,23 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>>       struct hlist_node *n;
>>       bool del = false;
>> -    hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
>> -        if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
>> -            (!br_multicast_port_ctx_is_vlan(pmctx) ||
>> -             pg->key.addr.vid == pmctx->vlan->vid))
>> -            br_multicast_find_del_pg(pmctx->port->br, pg);
>> +    /* br_multicast_find_del_pg() can delete further entries of this same
>> +     * port->mglist, so the node latched in @n may be unlinked by the loop
>> +     * body. Port groups are only freed by the GC work under multicast_lock,
>> +     * so @n is still valid here; if it left the list, restart.
>> +     */
>> +restart:
>> +    hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist) {
>> +        if ((pg->flags & MDB_PG_FLAGS_PERMANENT) ||
>> +            (br_multicast_port_ctx_is_vlan(pmctx) &&
>> +             pg->key.addr.vid != pmctx->vlan->vid))
>> +            continue;
>> +
>> +        br_multicast_find_del_pg(pmctx->port->br, pg);
>> +
>> +        if (n && hlist_unhashed(n))
>> +            goto restart;
>> +    }
>>       del |= br_ip4_multicast_rport_del(pmctx);
>>       timer_delete(&pmctx->ip4_mc_router_timer);
> 
> Thanks for the report, but instead of all these restarts and checks,
> can't we just do:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 75e1e2a8fc83..62c4008c5bb8 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -808,7 +808,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>          struct hlist_node *tmp;
> 
>          rcu_assign_pointer(*pp, pg->next);
> -       hlist_del_init(&pg->mglist);
> +       /* use _rcu to preserve the next pointer because it might be in use */

Just to be clear - I'd expand the comment to include why it is safe to do so and under
what conditions (multicast_lock held)

> +       hlist_del_init_rcu(&pg->mglist);
>          br_multicast_eht_clean_sets(pg);
>          hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
>                  br_multicast_del_group_src(ent, false);
> 
> 
> I have old patches that remove the mcast open-coded list implementations, I must
> revive them and clean all of this up finally. :)
> 
> Cheers,
>   Nik
> 



