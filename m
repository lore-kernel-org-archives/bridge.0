Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4636A017
	for <bridge@lists.linux.dev>; Mon, 23 Feb 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874127; cv=none; b=Fqwu6s4VtbrQd0oltti+uwV+QK3iAZ56WvBiVCQLS2o5I2acKiLyCrRIS8Nh0ZwB/ncycok6C/7sk43QD7L87M9ZUAWBu28wpkxSdJt6XMuIyXRCGxN3F9GZmqGpcjNQ1T2nBuzSav60v3ZAM3XvPUREhquNZk00IpQMoShh1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874127; c=relaxed/simple;
	bh=euGYXGgYWMyZMGsz4MxkxdkxaAM2S/q1TAQT4GS79vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmQIWGKLEp37z/LiqAPppNNBy/Msc1Cx6/8Penu7AXBaWJxcOwKJ06fFQO7vdN+Fs2BS4FAImEVo1zde2EsOIu4SnCj7QeHykTL+XXCxem6OvKOoAVKHw/emNUyf/VvvZ0Jz8LHpL3D3nuVhgJCgjf0PJvBTO0bZGCBvBHuWgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 929E56033B; Mon, 23 Feb 2026 20:15:22 +0100 (CET)
Date: Mon, 23 Feb 2026 20:15:22 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH v18 nf-next 4/4] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
Message-ID: <aZynSuGMtK7JOOCj@strlen.de>
References: <20260222195845.77880-1-ericwouds@gmail.com>
 <20260222195845.77880-5-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222195845.77880-5-ericwouds@gmail.com>

Eric Woudstra <ericwouds@gmail.com> wrote:
> In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
> and packets encapsulated in single 802.1q or 802.1ad.
> 
> When implementing the software bridge-fastpath and testing all possible
> encapulations, there can be more encapsulations:
> 
> The packet could (also) be encapsulated in PPPoE, or the packet could be
> encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
> encapsulation.
> 
> nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
> known from the conntrack-tuplehash. To access the header it uses
> nft_thoff(), but for these packets it returns zero.
> 
> Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
> offsets.
 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
> index d4d5eadaba9c..66ef30c60e56 100644
> --- a/net/netfilter/nft_chain_filter.c
> +++ b/net/netfilter/nft_chain_filter.c
> @@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
>  #endif /* CONFIG_NF_TABLES_IPV6 */
>  
>  #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
> +static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
> +				  const struct nf_hook_state *state,
> +				  __be16 *proto)
> +{
> +	nft_set_pktinfo(pkt, skb, state);
> +
> +	switch (*proto) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;

Hmm, this seems to trigger warning on NIPAs build_allmodconfig_warn test:

../include/uapi/linux/if_pppox.h:153:29: warning: array of flexible structures

Would you mind a new version?  Its the last patch, so I leave it up to
you if you want to resend the whole series or just 4/4.

Sorry, I did not have time to run the entire test pipeline with the
pending patches until today.
