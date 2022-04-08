Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649386140;
 bh=MoTQZqWDRmP60IMR3gk1tvBf4pwyjG0fN9vCUUQXZpg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WUSCjrtM2yniH6HNZyuC26xa7axjkpyVjG9HQ9H5faUYHwXUCVQ5G63l+9wnjxbjq
 H4bUqgChCeqqDrgDCMLJiAp7m0frf9MVrd9yy1VD0H6eKeOWWfAb8QRohwaoA8eEzm
 JxtYCa1sw+Mzo+H7nQhjI5Xs1rbDSso/F0t9lhYRQ1CtUDsDfAZnDcVI6D0G95QvFU
 w5Gc8NrhauOT4syIzMnjP6cMckI8qne8F/edsdKcuKxq9x5fGvHNPEN/z298P/q8lI
 x5wSCymS5TQJnVSVTUnoiok4bpdEeTI09L6dKKUUecooRiUuXWiyQBpu1bt9RTioLV
 lSYfslMZbIBiw==
Date: Thu, 7 Apr 2022 19:48:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220407194859.1e897edf@kernel.org>
In-Reply-To: <20220407091640.1551b9d4@hermes.local>
References: <20220407151217.GA8736@codemonkey.org.uk>
 <20220407091640.1551b9d4@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] decouple llc/bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org, Dave Jones <davej@codemonkey.org.uk>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org

On Thu, 7 Apr 2022 09:16:40 -0700 Stephen Hemminger wrote:
> > I was wondering why the llc code was getting compiled and it turned out
> > to be because I had bridging enabled. It turns out to only needs it for
> > a single function (llc_mac_hdr_init).

> > +static inline int llc_mac_hdr_init(struct sk_buff *skb,
> > +				   const unsigned char *sa, const unsigned char *da)
> > +{
> > +	int rc = -EINVAL;
> > +
> > +	switch (skb->dev->type) {
> > +	case ARPHRD_ETHER:
> > +	case ARPHRD_LOOPBACK:
> > +		rc = dev_hard_header(skb, skb->dev, ETH_P_802_2, da, sa,
> > +				     skb->len);
> > +		if (rc > 0)
> > +			rc = 0;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return rc;
> > +}
> > +
> >  

nit: extra new line

> > -int llc_mac_hdr_init(struct sk_buff *skb,
> > -		     const unsigned char *sa, const unsigned char *da)
> > -{
> > -	int rc = -EINVAL;
> > -
> > -	switch (skb->dev->type) {
> > -	case ARPHRD_ETHER:
> > -	case ARPHRD_LOOPBACK:
> > -		rc = dev_hard_header(skb, skb->dev, ETH_P_802_2, da, sa,
> > -				     skb->len);
> > -		if (rc > 0)
> > -			rc = 0;
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > -	return rc;
> > -}

There's also an EXPORT somewhere in this file that has to go.

> >  /**
> >   *	llc_build_and_send_ui_pkt - unitdata request interface for upper layers
> >   *	@sap: sap to use  
> 
> You may break other uses of LLC.
> 
> Why not open code as different function.  I used the llc stuff because there
> were multiple copies of same code (DRY).

I didn't quite get what you mean, Stephen, would you mind restating?
