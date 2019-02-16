Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=2UhKDSDgUihWj8j1NXQFr2vkI+UzaIow+SmjMUTH3
	2E=; b=hm8rGUE2HS7o6TZqdxT5EUTRWKm5CaD3fDK6PvQQfnnlbKsTIHkDPZbeo
	t+jsPpwAj1069cq+jkrvC+DvG560uQKk8Dx9eEZ77MWLbQ8UA4gzPaz4FNn5jtVS
	eJIv9D+wOJRlbEXvLeuvtFJD64OV4rDs+AXxim2rb5rO3AKbL7G4HVouT/rV7adz
	4EEhV7TtiUoEEyokyoY1MIhYZ+J58jJhyssNKdUePo7zTFIc9uSTtH39sq60bhvn
	Cj6tMC/rvSb7+S1oT2pREQF4fdZcGTmeoD4xO3Cd64aj73qFgi5+uIXNj1qTKZHI
	wU1M/AvjgQHZmfffu1AgSYOq6trdQ==
Date: Sat, 16 Feb 2019 20:43:53 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20190216184353.GA10888@splinter>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190215171332.GA1472@otheros>
	<479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
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

On Sat, Feb 16, 2019 at 10:05:40AM +0200, Nikolay Aleksandrov wrote:
> On 15/02/2019 19:13, Linus L=FCssing wrote:
> > On Fri, Feb 15, 2019 at 03:04:27PM +0200, Nikolay Aleksandrov wrote:
> >> Every user would expect to have traffic forwarded only to the configur=
ed
> >> mdb destination when snooping is enabled, instead now to get that one
> >> needs to enable both snooping and querier. Enabling querier on all
> >> switches could be problematic and is not a good solution,
> >=20
> > There is no need to set the querier on all snooping switches.
> > br_multicast_querier_exists() checks if a querier exists on the
> > link in general, not if this particular host/bridge is a querier.
> >=20
>=20
> We need a generic solution for the case of existing mdst and no querier.
> More below.
>=20
> >=20
> >> for example as summarized by our multicast experts:
> >> "every switch would send an IGMP query
> >=20
> > What? RFC3810, section 7.1 says:
> >=20
> > "If it is the case, a querier election mechanism (described in
> >  section 7.6.2) is used to elect a single multicast router to be
> >  in Querier state. [...] Nevertheless, it is only the [elected] Querier
> >  that sends periodical or triggered query messages on the subnet."
> > >> for any random multicast traffic it
> >> received across the entire domain and it would send it forever as long=
 as a
> >> host exists wanting that stream even if it has no downstream/directly
> >> connected receivers"
> >=20
>=20
> This was taken out of context and it's my bad, I think everyone is aware
> of the election process, please nevermind the above statement.
>=20
> [snip]>=20
> >=20
> > Have you done some tests with this change yet, Nikolay?
> >=20
>=20
> You've raised good questions, IPv6 indeed needs more work - we'll have to=
 flood
> link-local packets etc. but I wanted to have a discussion about no querie=
r/existing mdst.
> To simplify we can modify the patch and have traffic forwarded to the pro=
per ports when an
> mdst exists and there is no querier for both unsolicited report and user-=
added entry.
> We can keep the current behaviour for unknown traffic with and without qu=
erier.
> This would align it closer to what other vendors currently do as well IIR=
C.
> What do you think ?

The no querier condition is not currently reflected via switchdev, so
the behavior you're proposing in your patch is what actually happens in
the data plane.

We already hit the problem Linus mentioned in commit b00589af3b04
("bridge: disable snooping if there is no querier"). Namely, IPv6 ND
broke because a port joined before the bridge was created.

I introduced a workaround in commit 9d45deb04c59 ("mlxsw: spectrum:
Treat IPv6 unregistered multicast as broadcast"). I'm interested to know
what other vendors are doing. Can you elaborate?

We can trap IPv6 ND packets at L2 (we'll eventually need to do for ND
suppression) and let the bridge take care of flooding them correctly.
I'm not sure it's good enough.
