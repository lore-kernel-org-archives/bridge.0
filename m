Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; bh=g0ji6QPzo0W2UksAqaOMSCTSqCoDD
	uj4yYHs1wLe6xc=; b=QnCFD5Qmp4ljAnw9VRXAJ9ZRM38H8pNYfivjTpZd28OBo
	ZMs7qNmJwBb3PMZnGprZrqNZPOjwxqbOqCSzRl8rnfPVrAG2+yYNwVNb/TmAvzQb
	MpdacfXrueZv4AzwEyzmKIi3Iu9SkHyvOZAL/l/oDm60uYOXaqpu5+2IvwKQHhDE
	TOl4t/uxdRq2oPMbjTCBZmdZ79PORiWWAqj0xEt+YLl6TaImI8/obTNGxVffBX+F
	RP/ZCKrb3giWsTMn3+H6tMOxkEZuJFHRroEYSeZB0UwXRFEDyeAflFdbIChWZp4O
	WHDrCwvPdD74FwfHiOP/SlwhthuEIFbwmSpKJLwOQ==
Date: Mon, 1 Oct 2018 21:48:21 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181001184821.GA29148@splinter>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<3581745.3NPUBHfd8z@blindfold> <20181001182526.GA28369@splinter>
	<2327925.x0GQ7AZp12@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2327925.x0GQ7AZp12@blindfold>
Subject: Re: [Bridge] [PATCH 1/1] bridge: remove BR_GROUPFWD_RESTRICTED for
 arbitrary forwarding of reserved addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

On Mon, Oct 01, 2018 at 08:32:12PM +0200, Richard Weinberger wrote:
> Am Montag, 1. Oktober 2018, 20:25:26 CEST schrieb Ido Schimmel:
> > On Mon, Oct 01, 2018 at 08:16:22PM +0200, Richard Weinberger wrote:
> > > Florian,
> > > 
> > > Am Montag, 1. Oktober 2018, 18:24:25 CEST schrieb Florian Fainelli:
> > > > If all you are doing is forwarding anything, one thing I experimented
> > > > with before is the following:
> > > > 
> > > > # tc qdisc add dev eth1 handle ffff: ingress
> > > > # tc qdisc add dev eth3 handle ffff: ingress
> > > > # tc filter add dev eth3 parent ffff: u32 \
> > > > > match u32 0 0 \
> > > > > action mirred egress redirect dev eth1
> > > > # tc filter add dev eth1 parent ffff: u32 \
> > > > > match u32 0 0 \
> > > > > action mirred egress redirect dev eth3
> > > > # ifconfig eth3 promisc
> > > > # ifconfig eth1 promisc
> > > > 
> > > > and this works just fine actually, bypassing the bridge layer entirely.
> > > 
> > > Yeah, mirred is a powerful knife. :-)
> > > 
> > > In my case it is too low level since I utilize the netfilter functionality of
> > > the bridge layer.
> > 
> > You can use mirred only for the specific packets you care about and let
> > the rest continue to the bridge.
> 
> This is my plan b, having a u32 classifier that transports STP directly
> to the other interface.
> But IMHO this all is a bit hacky and a "forward anything" bridge mode
> sounds more natural to me.

But "forwarding STP and PAUSE if the number of slaves is restricted to
2" is a hack. The Linux bridge (like other networking equipment) needs
to conform to standards and to the best of my knowledge what you're
requesting is explicitly forbidden by IEEE standards.

Also, if what you need is "forward anything", then Florian's suggestion
should work for you.
