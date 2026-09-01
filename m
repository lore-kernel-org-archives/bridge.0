Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FF388893;
	Tue,  1 Sep 2026 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224448; cv=none; b=m3u635ZYLodl52ZDIvS2FCFbCtTT1kIBnlwp8bvSN6B+ytU4FUmClftzF1PJ2K+woH3tlFiD/HEeq8vab6+5Fvk3AWbN/yNSs1X3SLTDYI6xQj1gmTeoIfOtUWlJ2cdYTBQsNEeMro+mnK5o9n+0nnvTlYC6hVSYRygXuoELQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224448; c=relaxed/simple;
	bh=QiT13+OIWCaCiVlPkGMnbJiM4DcBFes3m6P7KZOz1MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9qUH87PLMiFH2csVVr3NrKBqGN8BOVmibMmLspaTQwq3tSwjLNRdU6ucnX3L6L2jSuvVi3yyT0S1aXecpA+VyFfq/xRnIk3CIdjcPs6O53juxVCvZIZYZsOeNFdi2GOCM/BwOGrtrf7s7G373VCur7dvZ7T4ByzGVa7GhirE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmc1bhfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmc1bhfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476D51F000E9;
	Tue,  1 Sep 2026 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224446;
	bh=SDImnQGfcSlG5LoYfZvxcRwJ14jQMe/LQ9XqfK6Hru0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xmc1bhfMDaVHMS259QwKZnXJS05wex7JBoXoTF347I3NrdygpPsvyppCGJMojT2E8
	 ngDFxvf6DeAgpOScWfl1ua/xxFbPuhKVCKRFI+b+B8EUR8bu5jK/bwDMhuyW+2QWOM
	 6F/LgBVMg2ALxET6yJbLjUiGGxtYyEAuAomhm2AcPnYO4B+ml+ErtX7UVTyecQD+Ww
	 fG9RnIch1Ua8jDvEKAnBpYh6adgKvheYC2/aCbaFLTKwT4vu7n4hvC1Uc/pHaR4a0Y
	 cHcPp9B2mYFFGI6PHp5GLJ70Z5do9/gXr1pcvrH5GCEvP27x436tx1V7Jfxs7fRKZy
	 qLDtEDCdzAASg==
Date: Mon, 31 Aug 2026 18:00:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: mcast: fix br_multicast_list_adjacent
 rcu walk of mglist
Message-ID: <20260831180045.4491fd1e@kernel.org>
In-Reply-To: <20260828100642.2664347-1-razor@blackwall.org>
References: <20260828100642.2664347-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 13:06:42 +0300 Nikolay Aleksandrov wrote:
> Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
> port group not using proper rcu helper that preserves the next pointer and
> after that immediately frees the port group without waiting for rcu grace
> period. The only rcu walker of mglist is br_multicast_list_adjacent() and
> it turns out that function has always been buggy because mglist was never
> converted to RCU. Fix it by acquiring the bridge's multicast lock for the
> mglist walk. We can do a proper mglist rcu conversion later.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
> 
> Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> We can do a proper mglist rcu conversion when net-next opens up.
> 
>  net/bridge/br_multicast.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 3ef5d8bbf552..7fa5f4444c4c 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4967,15 +4967,19 @@ int br_multicast_list_adjacent(struct net_device *dev,
>  		if (!port->dev || port->dev == dev)
>  			continue;
>  
> -		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
> +		spin_lock_bh(&br->multicast_lock);
> +		hlist_for_each_entry(group, &port->mglist, mglist) {
>  			entry = kmalloc_obj(*entry, GFP_ATOMIC);
> -			if (!entry)
> +			if (!entry) {
> +				spin_unlock_bh(&br->multicast_lock);

Clashiko says that the only caller wants to see a ENOMEM which we never
produce, let's throw it in while we're touching this?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828100642.2664347-1-razor@blackwall.org

>  				goto unlock;
> +			}
>  
>  			entry->addr = group->key.addr;
>  			list_add(&entry->list, br_ip_list);
>  			count++;
>  		}
> +		spin_unlock_bh(&br->multicast_lock);
>  	}
>  
>  unlock:
-- 
pw-bot: cr
