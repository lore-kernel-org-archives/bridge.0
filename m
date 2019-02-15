Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 15 Feb 2019 18:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550250817; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=ITwO+0JJqe/zXk6PzAQooZh1ESx74BHR5/annv2xpc0=;
	b=XCe/cvZtaCGteCLW/R3SW6RkZU9aVnyWV5w0md6a6SmrbgzOO4Ef2LXgVBdWF5PgPky3Mt
	hYzguaEH8cJNN/AjFx8a/jC+uZf2IhRT6iKjttqfRpCnHMBpIMpnBudqs1722blWaQX1Zx
	uB+hcDmlph0LU+fpA4DyEV2hzgHx9goEKG1aGR0iW21AmW1GvDee6gIqAFDBb9+AmVSZzW
	6rf0Wlhv6XjWy5zZ4lS6NVsHztJUhOjnJiZmPHwvp0hkpatFvAb+NQRy4BbOkb/pU4Qux2
	ckHvGx03k1RTlGapM+2EbCMAHEEHD+SfyXgdLYgfxc1mwVLM4iUP43AvMv0Rdg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190215171332.GA1472@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, Feb 15, 2019 at 03:04:27PM +0200, Nikolay Aleksandrov wrote:
> Every user would expect to have traffic forwarded only to the configured
> mdb destination when snooping is enabled, instead now to get that one
> needs to enable both snooping and querier. Enabling querier on all
> switches could be problematic and is not a good solution,

There is no need to set the querier on all snooping switches.
br_multicast_querier_exists() checks if a querier exists on the
link in general, not if this particular host/bridge is a querier.


> for example as summarized by our multicast experts:
> "every switch would send an IGMP query

What? RFC3810, section 7.1 says:

"If it is the case, a querier election mechanism (described in
 section 7.6.2) is used to elect a single multicast router to be
 in Querier state. [...] Nevertheless, it is only the [elected] Querier
 that sends periodical or triggered query messages on the subnet."

> for any random multicast traffic it
> received across the entire domain and it would send it forever as long as a
> host exists wanting that stream even if it has no downstream/directly
> connected receivers"

Queries are not send for "any random multicast traffic", but
either periodically (general query) or in response to changes on
multicast address listener state (multicast address specific query).
More precisely, if a host leaves a group and sends an IGMPv3/MLDv2 report
or IGMPv2/MLDv1 "Leave Group"/"Done" message for that.

> Sending as an RFC to get the discussion going, but I'm strongly for
> removing this behaviour and would like to send this patch officially.

While reading the code I'm getting confused with the mrouters_only
flag again... (if I remember correctly it never did what its name
implied) I'd have to test / play with your change to check,
but maybe you have tested these scenarios already:

What happens if:

- no querier exists on the link
- you have added static MDB entries from userspace

=> will only ports with statically configured MDB entries receive
   multicast traffic? what happens to other ports?
   => with no queries, those other ports will stay rather silent,
      they will not send any reports
      => do they miss multicast traffic / will IPv6 (ND) break for
         them?

And what happens if:

- no querier exists on the link
- one port gets an unsolicited MLD report, i.e. because a host has just
  started to listen to a particular multicast address
=> will only this port receive multicast traffic? what happens to
   other ports that have listeners for the same multicast group?


(and what currently confuses me while reading the code if a
- a querier exists
- but no listener for a particular IPv6 group / no mdst
- for IPv6 link-local multicast traffic (so mrouters_only = 0?)
=> will this result in always flooding multicast traffic for
   this particular IPv6 link-local multicast group to all ports?
   => reading the code it seems like, but I had remembered it
      differently; for IPv4 this makes sense, as IGMP is not
      mandatory for link-local addresse, however for IPv6 this
      seems unnecessary, dropping should be the correct approach
      if an MLD querier exists)


Have you done some tests with this change yet, Nikolay?

Regards, Linus
