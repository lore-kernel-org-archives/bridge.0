Return-Path: <christian@brauner.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=LwPRrFIFVpFh7windfuH8fQym2aENAjRfJxjWELiSBU=;
	b=Zb5w8rP85WrEmAp+Zr/D+9qTV1RoeJ9+bGxf6ZGFaz//eje5o8iDyuC629FdHNoZHM
	M6NOkiKW5X94YWAH/0ShGapQoZma0hlhSk6PpQEgi915CF1Dv1mhkO/conE2CVt3RObX
	ksdmzpJiEaaT8Yjo9vuQP3/LNVzAO7x6LBf7L7PR+g89d/pcyU9i67wPGHBkQEiC2ISG
	qdF9toeA0vtNzb1Fd88YeDnqmdHXoZrEQoob4+rUi/sJyLbrlfMfj4RPQBeM7Zhz4UQr
	Rps++y3zxLadol/OIc8Cv+L+LUVb9gstJIM2XJOSfG/oNJXv+6ypGOgTjXRr43Utd7px
	oGWw==
Date: Mon, 10 Jun 2019 22:51:36 +0200
From: Christian Brauner <christian@brauner.io>
Message-ID: <20190610205134.6wqparmtsdzbiutv@brauner.io>
References: <20190609162304.3388-1-christian@brauner.io>
	<20190609162304.3388-2-christian@brauner.io>
	<20190610174136.p3fbcbn33en5bb7f@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190610174136.p3fbcbn33en5bb7f@salvia>
Subject: Re: [Bridge] [PATCH net-next v1 1/1] br_netfilter: namespace bridge
 netfilter sysctls
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, bhthompson@google.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, joelhockey@chromium.org, tyhicks@canonical.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, smbarber@chromium.org, davem@davemloft.net

On Mon, Jun 10, 2019 at 07:41:36PM +0200, Pablo Neira Ayuso wrote:
> Thanks for updating this patch to use struct brnf_net.
> 
> A few comments below.
> 
> On Sun, Jun 09, 2019 at 06:23:04PM +0200, Christian Brauner wrote:
> [...]
> > diff --git a/include/net/netfilter/br_netfilter.h b/include/net/netfilter/br_netfilter.h
> > index 89808ce293c4..302fcd3aade2 100644
> > --- a/include/net/netfilter/br_netfilter.h
> > +++ b/include/net/netfilter/br_netfilter.h
> > @@ -85,17 +82,42 @@ static inline __be16 vlan_proto(const struct sk_buff *skb)
> >  		return 0;
> >  }
> >  
> > -#define IS_VLAN_IP(skb) \
> > -	(vlan_proto(skb) == htons(ETH_P_IP) && \
> > -	 brnf_filter_vlan_tagged)
> > +static inline bool is_vlan_ip(const struct sk_buff *skb, const struct net *net)
> > +{
> 
> I like this conversion from macro to static inline a lot.
> 
> But if you let me ask for one more change, would you split this in two
> patches? One to replace #defines by static inline.

Sure.
