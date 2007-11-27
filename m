DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
	bh=vMr++c8A6lYrYrMuR97zECkoVj5ofcUSL/7ZxXoBLrU=;
	b=mPPlkAwx1wXSbvAn1HOXFz1Q3epJfHSou5XOUAOw95BhIlBPRnxDy0gfUifTdaQl5Rjg0Of7WZhNeJZcBoeE8C8v0pyIUfabcxTysMWJHQlMTvuxHM6maeE9u44wmkUF9jPoRo8xOMP7pr82TttEQd/7SV066RkkdWR+bPtB71E=
Message-ID: <bdfc5d6e0711270724i3ce7cf41lb5f01dd5dcac98f9@mail.gmail.com>
Date: Tue, 27 Nov 2007 10:24:01 -0500
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
Subject: Re: [Bridge] Re: [RFC] bridging: don't forward EAPOL frames
In-Reply-To: <1196169854.6058.16.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1195737808.6323.102.camel@johannes.berg>
	<20071126093626.08c22a9d@freepuppy.rosehill.pdx.hemminger.net>
	<1196169854.6058.16.camel@johannes.berg>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev <netdev@vger.kernel.org>, bridge <bridge@linux-foundation.org>

On Nov 27, 2007 8:24 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> > > +   if (unlikely(skb->protocol = htons(ETH_P_PAE)))
> > > +           goto drop;
> > > +
> > >     switch (p->state) {
> > >     case BR_STATE_FORWARDING:
> >
> > Not needed because the bridge is already handling it:
> >
> > 1) If running STP (ie true bridge), then all link local multicast is only received by
> > the bridge and never forwarded.
>
> Well, typical access point setups bridge the wireless AP interface with
> wired, EAPOL frames can be unicast (and 802.11 specifies to do so) and
> we want to avoid having them unicast to another host.
>
> Also, 802.1X in C.3.3 recommends not bridging the *ethertype* rather
> than depending on the link-local multicast address because otherwise
> eapol frames can be unicast into the network behind the (authorized)
> port which is undesirable.
>
> johannes
>
>

I agree with Stephen, that based on the way it's likely people use
linux bridges it seems like this is something that could be configured
rather than simply dropping those frames without any chance to forward
them.  There are probably quite a few people out there who will not
expect this change, so it should be easy to change during runtime.

Don't forget that a simple ebtables rule could also drop EAPOL if needed.
