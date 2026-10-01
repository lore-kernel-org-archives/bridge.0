Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61943ED5B9
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856453; cv=none; b=NMfLqi6NDkJtcA98/B8NLN3QRFK71bKkTGv+KeXWsVLoNANU+XQrXgsjaFlLDCKNQsVI1QGNkT4HMAKvto4p8x+nwmgrOEnBu43Ff9DwVJQRbp+pGOrzT3qRFQoJhj8yyI6MOhUFGan0R/sO07sGS5EtHdJhKBKUy9cJhUjqsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856453; c=relaxed/simple;
	bh=THUYFu6sAj7ZsQg03U1SBfX/R1UfJ52AW7mFtCGdIQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT4FO/ZwvPaJ+EIeDVkWnu3krfpGofhD+pUKfKkIR7pz8Hv7vt3fNjCQvjzCDTPK9t8/QNtTPnXXzM3XeuTPpsd2fyolCwcbxfQUgGLwmaDH8eznwPnWg/4ZTM8Sb5XnlysZ3M86QXGsDdRA9Gj5Hlia9TF4TX6eZMAv6B3nLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hrpQOSKo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hrpQOSKo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso39207405e9.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790856443; x=1791461243; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xuEUyonZ+x3J1OyEqFQIWsDxR3lMvEKhljQtywXlu4c=;
        b=hrpQOSKooXG3eat5ZZ7HAqf5+cO+BnGUTOBGUMp/WuydPrFnyl64FbmO4QzGW0IkCn
         NBH21i+A8IYu4IMB0e0B65Tlvp38zjS+DZN7aCTUoTs046CXOFRPST/pXSXOGLK1gs4b
         7m0yjbIYxg2Yn5UeaHR6+8B9jr43hn8XWlTfXBvm0rYhdTTchYO6yyW3uAFmU+3wOZDG
         G1Dgokn3O84S/vo230Si2z+q+gXv6t6wDaNtoUsVeRd7iROBSWy7pLZKtu0X6vtvBrJJ
         noMxHoAuBs8scZisA5h/w5iArfqNb7JqCQIieRIRVukRaRQW+jy1GCx6jHqfFIHaxyrm
         cUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856443; x=1791461243;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuEUyonZ+x3J1OyEqFQIWsDxR3lMvEKhljQtywXlu4c=;
        b=SSlqtY78Yjx9QavOuvLCRkEaBH5/oF5QBuARcUBmsq17AhLd98LQXx1qcxDuFE6DD4
         9dPZ9o6okT/KWZZ/3ds9f1EACMmoQ/YPDoy4Z59tDEHXGIIVftvN9XeSzYABExbgmwiW
         gb08OuinG1LZSTGFhGYlSshhFpGFTkVETYgRNK3wHI0l8rSydk2vtiJ6HeZ0XTijV7S8
         QdvlmUZ8aTXZ6qLUBSLGPwLAWOB0tNYcPSSZQ3g6pZNEBwxw/y9qdkT/o9RBlViRrxtT
         hEFiV7LANNP3NadrrgdGmnfkxrc6mtlX9WPsgJkK7MfoqihoxGExRCjlF2d8snL5qAL8
         bBBg==
X-Forwarded-Encrypted: i=1; AKwUvBxl0Um1rEj5PrLzeRPjXcuINt9OWH8xBirxkmgdprGp5DP9t9r2SroBdfQNjDU5ssnHq9Wtyhc=@lists.linux.dev
X-Gm-Message-State: AFuF++kCx+FUZtJAjV1OEMqqIYJ12T3qR89erKuAgc543OpP+g5d7P/J
	tMbNvkYMA6t1mGZ9nutImL8RdcGC1e4cUXaSBKSYDGxALT1z2arclwN/GuWfGl6qD0w=
X-Gm-Gg: AYBFou27/E9sJap3Cb9M2YKc4Mov+mvzwrE25JzCQjL6U2T0ZBeTcJc9oeIYixaFCdx
	JCcxbnZgRRIcBaQjenrOoUDGutftLGLxbcRfYlXLfc8EedEtDWmUiRuePcDBHE9qFnpXTXL7qWb
	x2/W3b7vOK4WU0CGixsNaRWU+QOIi7BIv9ntNivw1Y31jnWs03py3OhuO9/7WYt2XtwDfFP75nj
	c53xLgJ5A4CPDl7HCl9OLEV5X2GmoZwvtmA8Jg0uuCPZ4LSlqdXzqNYe6sjk+tm/62T4YHjz7qu
	JvaoQ9qgeZyG35Yuwp2wJrKRusbqiNRIAkjoNTzK1+LLE8bQjW40WKozkEJCZ9L23+e+9ZCNSzq
	8GH0HjKCn2o+f1pvjTDdqd/7FjMl5YzgNxCW1a14F5EoQd+IZ6KTyptlCaFhj99fcXh83DdoN0i
	GIOcDJhlnCO07uqVPV4xlZJxvli+TtuwSeDTsT/DR2wOYgBP9Gn5qzkPRnTdyRf6OhbqUPzobFn
	4iG6DSDDZOPaPepXvpRqpXaJY3Kq+v8GHHn5SM=
X-Received: by 2002:a05:600c:a02:b0:4a0:1efa:c748 with SMTP id 5b1f17b1804b1-4a01efad866mr43064615e9.15.1790856443256;
        Thu, 01 Oct 2026 05:07:23 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa137basm61069715e9.1.2026.10.01.05.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:07:22 -0700 (PDT)
Message-ID: <f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
Date: Thu, 1 Oct 2026 15:07:21 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-9-razor@blackwall.org>
 <179085595119.434549.4421493167752460988@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179085595119.434549.4421493167752460988@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2026 14:59, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] nbp_vlan_delete() in net/bridge/br_vlan.c now calls
>    synchronize_net() for every port-VLAN it deletes.
> - [Low] br_fdb_cleanup_by_dst() in net/bridge/br_fdb.c reads f->dst once
>    into `dst`.
> 
> --
> 

I already answered, but here it is again:

> net: bridge: vlan: quiesce readers before freeing port VLANs
> 
> This patch prepares for fdb entries caching port-VLAN pointers. A port
> VLAN is now unpublished, a grace period passes, and only then are the fdb
> references purged or rewritten and the VLAN freed. During port teardown
> the whole VLAN group is unpublished first, so all VLANs share one grace
> period.
> 
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 7c68b540b3580..307f9c12914ef 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -883,7 +883,9 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
>>
>>   	spin_lock_bh(&br->hash_lock);
>>   	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
>> -		if (br_fdb_dst_port(f) != p)
>> +		struct net_bridge_dst dst = br_fdb_dst_read(f);
>> +
>> +		if (br_dst_port(dst) != p)
>>   			continue;
>>
> 
> [ ... ]
> 
>> +			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {
>> +				/* The entry outlives the VLAN, so it must fall
>> +				 * back to the raw port destination
>> +				 */
>> +				if (vlan && br_dst_vlan(dst) == vlan)
>> +					br_fdb_dst_write(f,
>> +							 br_port_to_dst(p));
> 
> [Severity: Low]
> Can this unconditional write lose a concurrent roam?
> 
> dst is read once at the top of the loop. br_fdb_update() roams entries by
> writing fdb->dst under RCU only, without br->hash_lock:
> 
> br_fdb_update()
>      br_fdb_dst_write(fdb, br_port_to_dst(source));
> 
> If a roam lands between br_fdb_dst_read() and this br_fdb_dst_write(), the
> new port would be overwritten with p.
> 
> This branch can't be reached at this commit. Every br_fdb_dst_write()
> caller stores br_port_to_dst(), so br_dst_vlan(dst) is always NULL here.
> 
> Later in the series, "net: bridge: fdb: cache port VLANs in learned
> entries" replaces this with br_fdb_dst_replace(f, dst, br_port_to_dst(p)).
> That is a cmpxchg against the snapshot, so a concurrent roam is kept.
> 
> Would it make sense to use the conditional replace here from the start?
> 

- No, we're fine with the roam race, it is normal. Trying to change these races
   requires much more work and isn't worth it at the moment.

>>   				continue;
>> +			}
>> +		}
> 
> [ ... ]
> 
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 8a914e249767a..0675f74cf1b99 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -1406,23 +1406,32 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
>>   	v = br_vlan_find(vg, vid);
>>   	if (!v)
>>   		return -ENOENT;
>> -	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>>   	__vlan_unpublish(vg, v);
>> +	synchronize_net();
> 
> [Severity: Medium]
> Does this add one expedited grace period for each port VLAN deleted, all
> while RTNL is held?
> 
> Every caller of nbp_vlan_delete() holds RTNL, so synchronize_net() always
> goes through synchronize_rcu_expedited(). Range requests are processed one
> VID at a time under a single RTNL hold:
> 
> br_process_vlan_info()
>      for (v = (*vinfo_last)->vid; v <= vinfo_curr->vid; v++) {
>          br_vlan_info()
>              nbp_vlan_delete(p, vinfo->vid)
>                  synchronize_net()
> 
> So a request like "bridge vlan del dev swp1 vid 1-4094" could run up to
> 4094 expedited grace periods back to back with RTNL held. The
> cond_resched() in that loop doesn't drop RTNL.
> 
> The per-port loops in br_vlan_disable_default_pvid() and
> __br_vlan_set_default_pvid() also now take one grace period per bridge
> port. That includes the error unwind loop in __br_vlan_set_default_pvid().
> 
> Before this patch, nbp_vlan_delete() waited for no grace period at all,
> because __vlan_del() only queues call_rcu().
> 
> The commit message only describes batching for port teardown:
> 
>    "This lets all VLANs share one grace period."
> 
> Could range deletion be batched the same way? For example, unpublish the
> whole range, wait once, then clean the fdbs and free the VLANs.
> 
> At this commit, no fdb writer stores a VLAN dst yet. That starts with "net:
> bridge: fdb: cache port VLANs in learned entries". The per-VLAN
> synchronize_net() is still unchanged at the end of the series, in "net:
> bridge: fdb: avoid VLAN lookups in unicast forwarding".
> 

- Yes, they can be batched and I had them batched initially but when I ran my tests I didn't
   notice any problems deleting a full VLAN range. It took 79ms on my host to delete 4k VLANs.
   As I've stated in my cover letter - the complexity is not worth it, so I dropped that patch.

   (from my previous reply)

>> +	/* Traffic may still use v through cached fdb dsts until they are
>> +	 * cleaned below. This is acceptable during vlan deletion. Above we
>> +	 * drain the readers that could republish the dst before cleaning it
>> +	 */
>> +	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>>   	__vlan_del(vg, v);
>>
>>   	return 0;
>>   }
> 
> [ ... ]
> 

