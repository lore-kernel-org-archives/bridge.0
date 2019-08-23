Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AgwFiLu0EACaDMPU3nVH88QXua+KzaStz26zPOJIN8I=;
	b=uTDQQT6rWKx2Wf4n20xHa+E1yu
	Shj56AdUjogsV/v9JEiBh9YDQYexFknZ4ftWAD7oZuV5Cd9raeljUHsd4dlwdIu/MhopBAp2fzN+4
	HDbyGeT6xGdZ/v79J32sQtrcsUN9Swl+qxJK5JzEtTSRCndImFPuhGbv/mdr7LR+85Zk=; 
Date: Fri, 23 Aug 2019 15:25:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190823132538.GO13020@lunn.ch>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
	<b2c52206-82d1-ef28-aeec-a5dcdbe9df6c@cumulusnetworks.com>
	<20190823122657.njk2tcgur2zu74i7@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823122657.njk2tcgur2zu74i7@soft-dev3.microsemi.net>
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: alexandre.belloni@bootlin.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

> > > Why do the devices have to be from the same driver ?
> After seeing yours and Andrews comments I realize that I try to do two
> things, but I have only explained one of them.
> 
> Here is what I was trying to do:
> A. Prevent ports from going into promisc mode, if it is not needed.

The switch definition is promisc is a bit odd. You really need to
split it into two use cases.

The Linux interface is not a member of a bridge. In this case, promisc
mode would mean all frames ingressing the port should be forwarded to
the CPU. Without promisc, you can program the hardware to just accept
frames with the interfaces MAC address. So this is just the usual
behaviour of an interface.

When the interface is part of the bridge, then you can turn on all the
learning and not forward frames to the CPU, unless the CPU asks for
them. But you need to watch out for various flags. By default, you
should flood to the CPU, unknown destinations to the CPU etc. But some
of these can be turned off by flags.

> B. Prevent adding the CPU to the flood-mask (in Ocelot we have a
> flood-mask controlling who should be included when flooding due to
> destination unknown).

So destination unknown should be flooded to the CPU. The CPU might
know where to send the frame.

> To solve item "B", the network driver needs to detect if there is a
> foreign interfaces added to the bridge. If that is the case then to add
> the CPU port to the flooding mask otherwise no.

It is not just a foreign interface. What about the MAC address on the
bridge interface?

> > > This is too specific targeting some devices.
> Maybe I was wrong to mention specific HW in the commit message. The
> purpose of the patch was to add an optimization (not to copy all the
> frames to the CPU) for HW that is capable of learning and flooding the
> frames.

To some extent, this is also tied to your hardware not learning MAC
addresses from frames passed from the CPU. You should also consider
fixing this. The SW bridge does send out notifications when it
adds/removes MAC addresses to its tables. You probably want to receive
this modifications, and use them to program your hardware to forward
frames to the CPU when needed.

       Andrew
