Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=u9W97fbiFQUEwjhVOikf4tlKSO2SuX1jhn+tPi6t4ew=; 
	b=aWkkPHvOWkt9DJmGXly2nBDjVJfLlB+dTauQSNYJPDbje/2MNWnwwLhy3Wj6JRywmiHhVWToRRA9tBRyHYfPFwbe+HiPOt+YF5JVwMOhWD+JRdOlHZBSSrCgZjnaDW52R9qlTlO9iYrB6+mlMdUvQH7ujPP3Z96JQtCFkGjQZQ0=;
Date: Wed, 26 Sep 2018 17:01:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180926150102.GA1251@lunn.ch>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
	<20180926121802.27851-3-nikolay@cumulusnetworks.com>
	<20180926144808.GM1676@lunn.ch>
	<e5b4f87d-c665-9476-c9d3-a7254394c13f@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b4f87d-c665-9476-c9d3-a7254394c13f@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 2/9] net: bridge: add bitfield for
 options and convert vlan opts
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Wed, Sep 26, 2018 at 05:55:47PM +0300, Nikolay Aleksandrov wrote:
> On 26/09/18 17:48, Andrew Lunn wrote:
> > Hi Nikolay
> > 
> >>  struct net_bridge {
> >>  	spinlock_t			lock;
> >>  	spinlock_t			hash_lock;
> >>  	struct list_head		port_list;
> >>  	struct net_device		*dev;
> >>  	struct pcpu_sw_netstats		__percpu *stats;
> >> +	unsigned long			options;
> > 
> > Maybe a u32 would be better, so we run out of bits at the same time on
> > 32 and 64 bit systems?
> > 
> >    Andrew
> > 
> 
> Bitops operate on an unsigned long, I actually had a BUILD_BUG_ON() for
> 32 bits initially, but checked other places and they seem to be using it
> as-is without any checks so I decided to leave it as well (e.g.
> sock_flags).

O.K.

I assume we get compiler warnings anyway, when we use bit 32 on a
32bit system. The build-bots should let us know.

      Andrew
