Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tN/4dk4E58XistgDJ6zOTKtSRYqHTx/a1QOwwGKZMmk=;
	b=eUp19m/y/Qg1oORIbOZgd/lgOH
	dU1x4yAORlsvB70utYGcZLTwWnbrpNdkE7MYvHycUmKDhdJNay1C1zWz9TrPxN3INRKVF9XHSSupf
	aBX961lzv4uzmUhvzpmGFQZqpRpzlpaSNm7sKFvaywt+8zVZA/E+URoyEHPR5rlto02w=; 
Date: Sat, 27 Jul 2019 05:02:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190727030223.GA29731@lunn.ch>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<20190726134613.GD18223@lunn.ch>
	<20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726195010.7x75rr74v7ph3m6m@lx-anielsen.microsemi.net>
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

> As you properly guessed, this model is quite different from what we are used to.

Yes, it takes a while to get the idea that the hardware is just an
accelerator for what the Linux stack can already do. And if the switch
cannot do some feature, pass the frame to Linux so it can handle it.

You need to keep in mind that there could be other ports in the bridge
than switch ports, and those ports might be interested in the
multicast traffic. Hence the CPU needs to see the traffic. But IGMP
snooping can be used to optimise this. But you still need to be
careful, eg. IPv6 Neighbour discovery has often been broken on
mv88e6xxx because we have been too aggressive with filtering
multicast.

	Andrew
