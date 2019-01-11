Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=OgPj8P++ZhLQ+47ER+bIDyoC8972Pe7h96HpMP/idLw=; 
	b=3FI0+SMSp+O/2amFlgHp893dQF451jYCFmePkzMWjKAaHNOvrMw4yYNcTgTM7f4Le73tSV7c6ifjurHDtbqOUtr2SYFUJ7XnLBescSwBjioREG5dyCSrgzthz3INDLHxNoEVsx1zr6h5bHg3p4i4kLmz1DyiHlJulxFs3iQ9tdU=;
Date: Fri, 11 Jan 2019 16:43:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190111154331.GE20924@lunn.ch>
References: <20190110193206.9872-1-f.fainelli@gmail.com>
	<20190111150637.GA897@splinter.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111150637.GA897@splinter.mtl.com>
Subject: Re: [Bridge] [PATCH net-next v4] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "ivan.khoronzhuk@linaro.org" <ivan.khoronzhuk@linaro.org>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>

> > +IGMP snooping
> > +~~~~~~~~~~~~~
> > +
> > +The Linux bridge allows the configuration of IGMP snooping (compile and run
> > +time) which must be observed by the underlying switchdev network device/hardware
> > +in the following way:
> > +
> > +- when IGMP snooping is turned off, multicast traffic must be flooded to all
> > +  switch ports within the same broadcast domain. The CPU/management port
> > +  should ideally not be flooded and continue to learn multicast traffic through
> > +  the network stack notifications. If the hardware is not capable of doing that
> > +  then the CPU/management port must also be flooded and multicast filtering
> > +  happens in software.
> > +
> > +- when IGMP snooping is turned on, multicast traffic must selectively flow
> > +  to the appropriate network ports (including CPU/management port) and not flood
> > +  the switch.
> > +
> > +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Network
> > +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and should always
> > +be flooded.
> 
> I'm not sure that these paragraphs are actually needed. You're basically
> describing RFC 4541 on which the IGMP snooping functionality in the
> Linux bridge is based on.

Hi Ido

My experience talking with people is that IGMP snooping is a bit
mystical and not well understood. I would not be surprised if
community driver writers, as opposed to vendor driver writers, don't
actually know how snooping works. So i find having some hints is good.

	 Andrew
