Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=FcjVK+RcK9TAEzM4RBPkwMiTGBAh+JGbZg6A9vUVwLE=;
	b=pP++ZoTltyb9FeDrwBPywtRrHy5KkQgBnV6Nobc740Mk1+l43Y69vKLICFHViyRsVj
	TFvR/GyR5pzd09pap9+XzbJsD5Xuic3FH6BW7gRAeCM31slQq99hFJK+z8jXmHkD1huR
	qEc44QuwzRtQ4opKL2bKruGpq6ttfscFGfX3FU1xSinRBR4O0ZLz0bNcyrie6ykyxt/5
	O/xb4x1/FIEd3grvzpJyqMyZZE/vfhuux/UIqJp4U3KhdRp+IQ9HUlIHiX62sA6qffOE
	sLJXJDWpdIJyDWw0aO9inrqo+49w/c47e/5IVgTn2EqiWtLMw7ivPC/AstIk3XmZ3o4T
	Oo8g==
Date: Thu, 21 Feb 2019 16:01:14 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20190221080114.GL10051@dhcp-12-139.nay.redhat.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
	<20181213161027.GC1713@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213161027.GC1713@otheros>
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, Sebastian Gottschall <s.gottschall@newmedia-net.de>, davem@davemloft.net

Hi Linus,

Sorry, my mail client somehow droped your message and I didn't see your reply.
I find this mail after Nikolay pointed out yesterday.

> Hi and thanks for your reply!
> 
> On Fri, Dec 14, 2018 at 10:32:16AM +0800, Ying Xu wrote:
> >  I think the scenario mentioned above is abnormal.
> 
> Can we agree, that this scenario, if switch A and B were using the
> current bridge code, has issues right now which it did
> not have before that patch?

Yes, I agree. But this "regression" could be fixed by setting up correct
switch configuration. See more explains below.

> 
> I also do not quite understand what you mean with "abnormal". Do
> you think that it is unlikely to have two snooping switches and
> general queries with a 0.0.0.0 source?

The "abnormal" means we shouldn't use this kind of configuration on
snooping switch.

We could have general queries with a 0.0.0.0 source, but these queries
are only from proxy Querier, not from real Querier.

Based on RFC 4541,
2.1.1.  IGMP Forwarding Rules
      b) The arrival port for IGMP Queries (sent by multicast routers)
         where the source address is not 0.0.0.0.

         The 0.0.0.0 address represents a special case where the switch
         is proxying IGMP Queries for faster network convergence, but is
         not itself the Querier.  The switch does not use its own IP
         address (even if it has one), because this would cause the
         Queries to be seen as coming from a newly elected Querier.  The
         0.0.0.0 address is used to indicate that the Query packets are
         NOT from a multicast router.

This paragraph specified "0.0.0.0" is only for switch proxying queries.
It should not be used as a IGMP Querier.

"because this would cause the Queries to be seen as coming from a newly
 elected Querier" means other address could be elected as a Querier but
"0.0.0.0" should not.

AFAIK, most verdors(Cisco, HW, etc. expect H3C) use none-zero address
as default address on proxying switches. But H3C also respect the
b) section.

>
> Note that with the current bridge code and according to RFC3376
> and RFC2236, as soon as a query with a 0.0.0.0 source is sent somewhere
> in the broadcast domain, it will become the selected querier [*].

Yes, In RFC 3376

6.6.2. Querier Election

   IGMPv3 elects a single querier per subnet using the same querier
   election mechanism as IGMPv2, namely by IP address.  When a router
   receives a query with a lower IP address, it sets the Other-Querier-
   Present timer to Other Querier Present Interval and ceases to send
   queries on the network if it was the previously elected querier.
   After its Other-Querier Present timer expires, it should begin
   sending General Queries.

It only said we should select lower IP address as Querier, but didn't specify
the "0.0.0.0" address.

While in the later RFC 4541

Abstract
   This memo describes the recommendations for Internet Group Management
   Protocol (IGMP) and Multicast Listener Discovery (MLD) snooping
   switches.  These are based on best current practices for IGMPv2, with
   further considerations for IGMPv3- and MLDv2-snooping.

And section 2.1.1.  IGMP Forwarding Rules(I just pasted above). It did
specify the "0.0.0.0" address issue.

I think we should respect the later and accurater standard, shouldn't we?

>
>
> > The source of query indicats that is a real router or only a switch.(0.0.0.0
> > means switch,non-zero means router).
> > In the scenario above,the switch A was selected to be a querier that means A
> > performs as a router,
> > so switch A should config its query source address to non-zero,and then Host A
> > can recieve the traffic from B.
>
> Even if in the described scenario switch A were configured to use a a non-zero
> source address to become a router, so that switch B would mark the port
> to switch A as a multicast router port, switch A would still loose
> in the querier election right now, as 0.0.0.0 is lower (RFC3376, RFC2236). So
> switch B would then become the selected querier with its 0.0.0.0 source
> and switch A would become silent even though it had a non-zero
> source address.
>
> And then we would have the same issue again, only swapped between
> host+switch A and host+switch B.
>
> Would you agree, does that make sense?
>

Yes, that's why Ying Xu said the topology is "abnormal", or illegal. Because
in a correct configured topology, there should has a Querier with none-zero
IP address.

> Regards, Linus
>
>
> [*]: Looking at br_ip4_multicast_select_querier():
>
> If previously selected querier were 0.0.0.0, it would accept any
> source as a new querier ("!br->ip4_querier.addr.u.ip4"). However,
> if the previously selected querier were non-zero, a query with
> 0.0.0.0 would win, too
> ("ntohl(saddr) <= ntohl(br->ip4_querier.addr.u.ip4)").

In RFC 3810

7.6.2.  Querier Election
   When a router starts operating on a subnet, by default it
   considers itself as being the Querier.

   When a router receives a query with a lower IPv6 address than its
   own, it sets the Other Querier Present timer to Other Querier Present
   Timeout; if it was previously in Querier state, it switches to Non-
   Querier state and ceases to send queries on the link.

   All MLDv2 queries MUST be sent with the FE80::/64 link-local source
   address prefix.

MLDv2 also sepcified the default Querier is itself and electe a lower adddress
as new Querier. And the source address should be link-loacl source address
instead of 0("::"). This is another evidence that we should not use "0.0.0.0"
as a Querier. So I think we should fix the IPv4 election in function
br_ip4_multicast_select_querier().

This looks like a little extreme and may have "regression", but the "regression"
should be fixed by setting up correct router/switch configuration.

What do you think?

Regards
Hangbin
