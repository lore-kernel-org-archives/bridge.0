Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494481E3DCF
	for <bridge@lists.linux.dev>; Tue,  8 Jul 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012053; cv=none; b=qVFdNzGYkjuwss2mDb5Q2H31pfw1U9/bAHRZdJIrimiaiJAbyi+qR4yoOCz6ePWLnFjWWx20d8rg1m01+Hbzcx8Sh+d0PSobNKYzkiYqY1jUhGIG9YjPs9QsWWYSc5Sx9RrmmlwnVZP+9M6OtNR53KWgK8EugsQ8pkVAsqRxvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012053; c=relaxed/simple;
	bh=7mFXvMq75GS63cOsJInVGaQYLNjUOZSwMKZHP+mbRYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz5WYfhAPdu0SksRIg1lGsfHaD9tvx6bsA9kbbL2K/xhpFfkBZvPaIUxiACYPVfi112ht5T50WLsqCpE2ylHZcEsSbqoAuchc6sITR1WGxxwPvFBRVLlGQIiZCsKbnEirl+KBlhhpvHZDh9D2/XTvEeAgCEH8T/cq7FSdg9Al4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2D2CF6122E; Wed,  9 Jul 2025 00:00:49 +0200 (CEST)
Date: Wed, 9 Jul 2025 00:00:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v14 nf-next 2/3] netfilter: bridge: Add conntrack double
 vlan and pppoe
Message-ID: <aG2VDyHfVsp5L2zR@strlen.de>
References: <20250708151209.2006140-1-ericwouds@gmail.com>
 <20250708151209.2006140-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708151209.2006140-3-ericwouds@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge, only when a conntrack zone is set.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
>  1 file changed, 72 insertions(+), 16 deletions(-)
> 
> +			data_len = ntohs(ph->hdr.length) - 2;

Shouldn't there be some validation on data_len here?

> +		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
> +			goto do_not_track;
 
>  		len = skb_ip_totlen(skb);
> -		if (pskb_trim_rcsum(skb, len))
> -			return NF_ACCEPT;
> +		if (data_len < len)
> +			len = data_len;

Hmm.  So if ph->hdr.length is smaller than what ip header claims,
len shrinks.

If its higher, then the mismatch is ignored and we only use
the ip header length (i.e., the smaller value).

> +		if (pskb_trim_rcsum(skb, offset + len))
> +			goto do_not_track;

Is the intent that garbage data_len is caught here and

>  		if (nf_ct_br_ip_check(skb))
> -			return NF_ACCEPT;

here?  If so, maybe a comment could help.

> +		goto do_not_track;
>  	}
>  
> -	if (ret != NF_ACCEPT)
> -		return ret;
> +	if (ret == NF_ACCEPT)
> +		ret = nf_conntrack_in(skb, &bridge_state);
>  
> -	return nf_conntrack_in(skb, &bridge_state);
> +do_not_track:
> +	if (offset) {

if (ret == NF_ACCEPT && offset) { ...

Else skb could have been free'd. There should be test cases for this
functionality included.  If we lack test cases for the existing
functionality, which might be the case, please consider submitting
a reduced test case first so it can be applied regardless of the
remaining functionality.
