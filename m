Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=jstbdztW1HJaeXhZCz
	AZWXfSfEXFzxjNnK6SZnpYMrE=; b=jzxDGW/kYQqNQj2wPVGnqs8F/VTAF4P2D6
	pnJXplTlI/MldBTwnKXRjFx3MnbsBELJyXTsSKF+GxWLQRZX2TwJSbiZm/nqGV/J
	KFiyxB/W5yj9wu9AGTHT60Ufk5doBsQWX1Tz+C+17uyrcgLhWXGyNPCACY72ta5J
	v0ERCZ3Kw8RGJ5pcKDQYLuG5bFgMJJAU9I1G7yqqbDAWn3VWKZardIx/CNFuwa3W
	PeHjaqCBmkrq0Tjg8So4t9WhG+AmUjKqXNgqzbQiF7lwBrz7xuJoPa9QObmOvmJS
	TUCQTHHP3VA32gYWKMJh0nhOfdve4Us5bnorEOuvjxcpI728uB1A==
Date: Sat, 8 Apr 2017 16:49:38 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20170408134938.GA28955@splinter>
References: <20170408114159.12722-1-idosch@mellanox.com>
	<20170408114159.12722-2-idosch@mellanox.com>
	<20170408093042.20b08c5d@plumbers-lap.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170408093042.20b08c5d@plumbers-lap.home.lan>
Subject: Re: [Bridge] [PATCH net v2 1/2] bridge: implement missing
	ndo_uninit()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: cera@cera.cz, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Sat, Apr 08, 2017 at 09:30:42AM -0400, Stephen Hemminger wrote:
> On Sat, 8 Apr 2017 14:41:58 +0300
> <idosch@mellanox.com> wrote:
> 
> >  static void br_dev_free(struct net_device *dev)
> >  {
> > -	struct net_bridge *br = netdev_priv(dev);
> > -
> > -	free_percpu(br->stats);
> >  	free_netdev(dev);
> >  }
> >  
> 
> Since the only thing left is free_netdev, you can now just set dev->destructor
> to be free_netdev.

Fine.

Beside stylistic issues, I would appreciate comments on how this should
be handled. Are we reverting the patch in the Fixes line or applying
this patchset?

I prefer the first option. Then after net is merged into net-next I can
re-post this patchset with the requested changes.
