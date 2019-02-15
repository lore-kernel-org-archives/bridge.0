Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AXgqyq
	kUKhYRKGdlJ6wM1vw+qWa0bHAxgV24NaYqVIE=; b=URvKG/enjcajJapWtMX+YY
	aVn0RtdAlKDuLzIdS3I9IMAX/VPP7K6X8X+TWmw/sl+rfQ3LgaZn5NB8vmyPdP+0
	nLcGC+/6hIathD4YNxvMAmu0y688LzQWoo/A8Z9Mlmz154LJpQgMxhNePCH7Oq/i
	Ad+FtwTPQXpxSAJ1ZW6P3adLMxGgq7RpHj06k2hCE+He5Qu0N2p3hDRhvolWAdkY
	fSNEZVoilkb+ao8O/kpLRVQwDR0Bwo+E3iG35fROCHsInKu0/GvyjtzLYKL0tBjM
	h5WyFPCLTo4D+A6MRzyZ//hERX0nqeEO79DhjNQl3nx4pc1ZyZCVehTd4n+AwpOw
	==
Date: Fri, 15 Feb 2019 15:53:46 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20190215135346.GB13875@splinter>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> The behaviour since b00589af3b04 ("bridge: disable snooping if there is
> no querier") is wrong, we shouldn't be flooding multicast traffic when
> there is an mdb entry and we know where it should be forwarded to when
> multicast snooping is enabled. This patch changes the behaviour to not
> flood known unicast traffic. I'll give two obviously broken cases:
>  - most obvious: static mdb created by the user with snooping enabled
>  - user-space daemon controlling the mdb table (e.g. MLAG)
> 
> Every user would expect to have traffic forwarded only to the configured
> mdb destination when snooping is enabled, instead now to get that one
> needs to enable both snooping and querier. Enabling querier on all
> switches could be problematic and is not a good solution, for example
> as summarized by our multicast experts:
> "every switch would send an IGMP query for any random multicast traffic it
> received across the entire domain and it would send it forever as long as a
> host exists wanting that stream even if it has no downstream/directly
> connected receivers"
> 
> Sending as an RFC to get the discussion going, but I'm strongly for
> removing this behaviour and would like to send this patch officially.
> 
> We could make this behaviour possible via a knob if necessary, but
> it really should not be the default.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Yes. This is great! :)

I had to enable a multicast querier when testing static mdb entries only
because the test was "too long" and this check kicked in. Never made
sense to me. Lets drop it if we can.

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
