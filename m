Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=S/UI/eN4HwCCiWLOZ1UqE0EVsAjwaLVp/H45PVQBemM=; b=iz0EavQxhypRm4Zsnq7107JJrz
 tvZaMj0jceqW8uPxBqWzA/GCljz7vWfRAWorUuOYwQsPkF01lPm2Cgqm8VGvS0CbOKZWFdea6Tth3
 l3XIJ91Hv327qn1J5kFTumo78GwXSpcDX74djDySbpqZoFWoUNx+c1WNS2GesReapZ8E=;
Date: Thu, 12 May 2022 22:38:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <Yn1wK78zKzcgzg15@lunn.ch>
References: <20220505225904.342388-1-andrew@lunn.ch>
 <20220506143644.mzfffht44t3glwci@skbuf> <Ynd213m/0uXfjArm@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynd213m/0uXfjArm@shredder>
Subject: Re: [Bridge] [PATCH RFC] net: bridge: Clear offload_fwd_mark when
 passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ido Schimmel <idosch@mellanox.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, netdev <netdev@vger.kernel.org>

> I like Andrew's patch because it is the Rx equivalent of
> br_switchdev_frame_unmark() in br_dev_xmit(). However, if we go with the
> second option, it should allow us to remove the clearing of the mark in
> the Tx path as the control block is cleared in the Tx path since commit
> fd65e5a95d08 ("net: bridge: clear bridge's private skb space on xmit").
> 
> I don't know how far back Nik's patch was backported and I don't know
> how far back Andrew's patch will be backported, so it might be best to
> submit Andrew's patch to net as-is and then in net-next change
> nbp_switchdev_allowed_egress() and remove br_switchdev_frame_unmark()
> from both the Rx and Tx paths.
> 
> Anyway, I have applied this patch to our tree for testing. Will report
> tomorrow in case there are any regressions.

Hi Ido

Did your testing find any issues?

Thanks
	Andrew
