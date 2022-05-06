Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=X1Z9IR3ee1uLnZkYJAlLEPfHnAGa9eV36iTxpDaZ1ks=; b=ZoTQ0OmAGEK5pIMJcAg2BVf1ur
 vp2gdhyfFXKk+TX61BuEJIsWXnFwF4tuX+Rsztf3T5I7EvAKu2oJR5FsaFpq3aMvvYbFBw4afyT4O
 /+KoxwUDJlwEZ6iIKnI+z89yt94hMEBD228crIQIN3/8ilm7ehXbK2pm3bivlHJ6/Q+M=;
Date: Fri, 6 May 2022 18:58:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YnVTwbPH8YU4kciG@lunn.ch>
References: <20220505225904.342388-1-andrew@lunn.ch>
 <20220506143644.mzfffht44t3glwci@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506143644.mzfffht44t3glwci@skbuf>
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ido Schimmel <idosch@mellanox.com>, netdev <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

> Some safer alternatives to this patch are based on the idea that we
> could ignore skb->offload_fwd_mark coming from an unoffloaded bridge
> port (i.e. treat this condition at br1, not at br0). We could:
> - clear skb->offload_fwd_mark in br_handle_frame_finish(), if p->hwdom is 0
> - change nbp_switchdev_allowed_egress() to return true if cb->src_hwdom == 0

O.K, i will try out these solutions.

Thanks
     Andrew
