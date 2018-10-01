Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; bh=3vTVcYjBW2fAjb3YteywyE0R8z4Sy
	+mvtl11cFMUmB0=; b=L66I+lz/GAS1MyIyECtkpXiRE2NDuWwyXw1Tf2G1a73q2
	rzgTqZnaHiA3FIEjUOzVNKQuentrcR9t4iM2O7myRf9Pn8eRXD+xh3Uu/Pcavchb
	RMI3EfgTlKofKVHiQHHPRad6Mt3BR6VGwR2yTJAVmZtT/0JVb5IE2Cj1QxLfoh3n
	CaE9gFXTjpZXcpW+JvPMG1aAKbu+Ib6+zJxBPzkF1/FSFVx9tlS5rbF+xRZkPH+O
	4+nS7o58iKhxezxaUUx9Rp2MtuxDFjBqEb0/TLOi1LbrdHLNq9ebmGapdqldPyzN
	OFmClC8T5obxb1q6zbBgTXyPOcpHSpW+SVBCSC1/w==
Date: Mon, 1 Oct 2018 21:25:26 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181001182526.GA28369@splinter>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<CAFLxGvzVbWvQ5YA8NS-zcESguNNvJAbE_99SdFcAjbftCXzsdQ@mail.gmail.com>
	<9331d9d8-fb4b-36f3-9484-fc80f579e617@gmail.com>
	<3581745.3NPUBHfd8z@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3581745.3NPUBHfd8z@blindfold>
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

On Mon, Oct 01, 2018 at 08:16:22PM +0200, Richard Weinberger wrote:
> Florian,
> 
> Am Montag, 1. Oktober 2018, 18:24:25 CEST schrieb Florian Fainelli:
> > If all you are doing is forwarding anything, one thing I experimented
> > with before is the following:
> > 
> > # tc qdisc add dev eth1 handle ffff: ingress
> > # tc qdisc add dev eth3 handle ffff: ingress
> > # tc filter add dev eth3 parent ffff: u32 \
> > > match u32 0 0 \
> > > action mirred egress redirect dev eth1
> > # tc filter add dev eth1 parent ffff: u32 \
> > > match u32 0 0 \
> > > action mirred egress redirect dev eth3
> > # ifconfig eth3 promisc
> > # ifconfig eth1 promisc
> > 
> > and this works just fine actually, bypassing the bridge layer entirely.
> 
> Yeah, mirred is a powerful knife. :-)
> 
> In my case it is too low level since I utilize the netfilter functionality of
> the bridge layer.

You can use mirred only for the specific packets you care about and let
the rest continue to the bridge.
