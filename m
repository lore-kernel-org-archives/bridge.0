Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0W0+mRwLqmOfmgb+U09T1ELePqWxxs2khnaIID5pQgE=;
	b=b0KlczLt2Z1pkj5Zj0Mvo5i21d
	+HAHbbFYbXFpKPTJWXQmCP2UAmWm8z0keX1iaNubOR3Uo6eft1WySXrrJ9CvIyTEOlzs78zMNvfVS
	3X1RmVB9G0dv299nrNfe/avRnp7UvYu2O+q0hL85TQNNYrUFWBagdFmyJyaEOUUmYF14=; 
Date: Tue, 30 Jul 2019 16:34:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190730143400.GO28552@lunn.ch>
References: <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
	<20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
	<3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
	<20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
	<e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
	<20190729143508.tcyebbvleppa242d@lx-anielsen.microsemi.net>
	<20190729175136.GA28572@splinter>
	<20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730062721.p4vrxo5sxbtulkrx@lx-anielsen.microsemi.net>
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, Horatiu Vultur <horatiu.vultur@microchip.com>

Hi Allan

Just throwing out another idea....

The whole offloading story has been you use the hardware to accelerate
what the Linux stack can already do.

In this case, you want to accelerate Device Level Ring, DLR.  But i've
not yet seen a software implementation of DLR. Should we really be
considering first adding DLR to the SW bridge? Make it an alternative
to the STP code? Once we have a generic implementation we can then
look at how it can be accelerated using switchdev.

     Andrew
