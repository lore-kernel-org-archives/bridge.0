Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ML/U6GeUuR8T3SyeUgFEK2FTyyJf1genMhIvuiP8ZaI=;
	b=dM0970wlvHxnA2o2DJTtZuZ8MeVNEOwpGesMQfblX6hKXz5kZm/UKnzJ+QbflkhPdm
	kKg9HcJYD/l+PVIDmIxHqxrQv0HihUhWBOyrOS8/+j8L8y9VJuOch7UzpcS7IXnpDwxc
	fx6WhGYaMvKPofJlc3T8DEFEAg7NSUAxibEAAJXuFzLLrmiAwIvmBDX7woiyumpRczrl
	RZHT9BC6r4xbR9qol7hZxui7f603yNmo+06zd2jWzr7oYgK3k1XsQOh3toOk9eeUV1NE
	z5JZf+brOE0Lr/zf17OFGBoi8aZUPLSA8PSgCj5FWuUlp1SHLGAmpgrnSU/WZ7SDfw0r
	cBfA==
Date: Fri, 22 Feb 2019 15:57:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20190222075705.GN10051@dhcp-12-139.nay.redhat.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
	<20181213161027.GC1713@otheros>
	<20190221080114.GL10051@dhcp-12-139.nay.redhat.com>
	<9db055dd-6486-1d6e-7dce-edc511650af9@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db055dd-6486-1d6e-7dce-edc511650af9@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, Sebastian Gottschall <s.gottschall@newmedia-net.de>, davem@davemloft.net

Hi Nikolay,

On Thu, Feb 21, 2019 at 03:20:14PM +0200, Nikolay Aleksandrov wrote:
> > 
> > Yes, I agree. But this "regression" could be fixed by setting up correct
> > switch configuration. See more explains below.
> > 
> 
> That is irrelevant, if the setup once worked we should not break it unless
> it's in RFC requirement violation and RFC 4541 is only suggestive, not required.

Thanks for your reply. I just noticed the RFC4541 category is informational.

> > "because this would cause the Queries to be seen as coming from a newly
> >  elected Querier" means other address could be elected as a Querier but
> > "0.0.0.0" should not.
> > 
> 
> But this change hasn't been incorporated, has it ? A 0.0.0.0 address currently
> will always win the election and silence all of the rest. Current bridge state
> is simply broken for some cases because of that.

Yes. I agree. I realized linus also said

"""
However, one of the two options seems to be necessary. Either
reverting the patch for the IGMP part, too. Or Ignoring 0.0.0.0
sources for querier eletcion and presence detection.
"""

> 
> Removing 0.0.0.0 from the election will effectively disable snooping even if there's
> a configured bridge unless it has an address. You can see that this will end up in
> people having suddenly their multicast flooded with current setups, right ?

Yes

> Any big behaviour change like that should be optional, but I don't think we need 
> another option as this is not so big of a deal because we're not breaking any
> required behaviour.

Just a little curious, RFC 3376 said the General Queries are sent from multicast
routers. I think a router *should* has a IP address, isn't it?

RFC 4541 also suggested:

      If the switch is not the Querier, it should use the 'all-zeros' IP
      Source Address in these proxy queries (even though some hosts may
      elect to not process queries with a 0.0.0.0 IP Source Address).
      When such proxy queries are received, they must not be included in
      the Querier election process.

And what I got is most vendors apply this suggestion.

> In case you decide to follow the option path, please use the new boolopt api to avoid
> adding new fields to the bridge, this should be an on/off thing. I still vote for a
> revert though.

For consistency with other vendors and rfc, I would prefer to remove zero address election.
For compatibility with previous users, I'm also OK to revert it.

Regards
Hangbin
