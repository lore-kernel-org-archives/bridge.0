Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=ZCBQfIgsaaqGa9NdTBKby2K4luKCO2x9ltO+P32Dy1E=; b=ZQvMoWmrRru7q2T1QO7Q5DY945
 INsEvCnlxHc53LgeQB7iZK2L/tRVPegucijhvHQqRM0tcryCYciDk5ehjRhxBTgklPMWc1M1hwcep
 J6001389zlRq0WJ1gXvPebIKhQm+OxtecXRCxDHiEZS10LnSSwLo+bjo6Wl58ueAV0Qc=;
Date: Mon, 7 Feb 2022 14:53:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YgEkXARS160I9Ooe@lunn.ch>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
 <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
 <YgD5MglBy/UbN0uX@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgD5MglBy/UbN0uX@shredder>
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

> > +	if (p->flags & BR_PORT_LOCKED) {
> > +		fdb_entry = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
> > +		if (!(fdb_entry && fdb_entry->dst == p))
> > +			goto drop;
> 
> I'm not familiar with 802.1X so I have some questions:

Me neither.

> 
> 1. Do we need to differentiate between no FDB entry and an FDB entry
> pointing to a different port than we expect?

And extending that question, a static vs a dynamic entry?

    Andrew
