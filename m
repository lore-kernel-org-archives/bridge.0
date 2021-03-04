Return-Path: <gustavoars@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614898574;
 bh=TqV0c+qFdMK17XDBnAl5PwNX6LR+uIj0XIxFtvKZG9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qGxF/T+ME1pGAXWjTTgXhZ6KIUh+eScYjYGJMgJgfrfbpQqDtO0K+7gpdHpOKi2AJ
 Yvkpf0eaP3HnBIZPig1PlDEalYqpiyGtweNaG0MIo3ulwAg39FK5NbuYLNzFWenz6N
 wdmw4fTvYof24vnqjUrwbaqhkfA6yS4kP0z9yDbAq61KObcVQwq1xrP5f/ibcTjERx
 xFYLTqiZefWafGDeuNi+pPuCXQRTex8cmbsClkTc+lU1Un2CSOMt1FBD3q5zHG6eij
 XQKEKWn2duNhrJ1E7YKqJsteG759HE0xsiLBgMmD+to11EHiZAQVX83jwUAF2zwpZB
 oCkyY9dY6w36A==
Date: Thu, 4 Mar 2021 16:56:11 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <20210304225611.GF105908@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <44b2e50d345f1319071a53fb191ac0a0cf3fcf37.1605896060.git.gustavoars@kernel.org>
 <143dd4a9-b0b7-36a6-ee33-0b5cb024c1e6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143dd4a9-b0b7-36a6-ee33-0b5cb024c1e6@nvidia.com>
Subject: Re: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings
	for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joerg Reuter <jreuter@yaina.de>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

Hi all,

It's been more than 3 months; who can take this, please? :)

Thanks
--
Gustavo

On Tue, Feb 02, 2021 at 04:16:07PM +0200, Nikolay Aleksandrov wrote:
> On 20/11/2020 20:37, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  net/bridge/br_input.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index 59a318b9f646..8db219d979c5 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -148,6 +148,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  		break;
> >  	case BR_PKT_UNICAST:
> >  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > 
> 
> Somehow this hasn't hit my inbox, good thing I just got the reply and saw the
> patch. Anyway, thanks!
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
