Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sGBr1I+38iZ7SVnFDQNVpTYJGDmr4wfSvLU5slITSjA=;
 b=YcOxJyvtIiLWGDxusQyV7Mqmlk0DFwcmK6bn/eaRqgA0rO7IdzmFOlcOavH/SYkGaj
 nqnb7pQWPXG5UhO5Qg8THbhrZqElOnab8VVU/acYpEtb506ySsNM02Os7mZPj2ZIxLd1
 5yPfZOGq0jqBdyCR9EHZjaZ8HMm5vXzmIYtJMMnMto6+PgEmvAT1HZJci9R0AC1/gq13
 wxjkovi2ItZht+bssZjjErBf3jh5Rk/5Fx/SpN4yAMHJI0QucMvBHhZJiJstbt4b5CYC
 /mrYkmAo1Oum/XFuWDvIQUqfnzAaV7pZ4k2iSpNMOiIR9tU1Y4T5ZIJ1snacVTFpFUah
 DPcg==
Date: Thu, 6 May 2021 13:59:44 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210506105944.tclatsr4jgdk6qw2@skbuf>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <YI6+JXDG/4K30G5L@shredder> <87bl9snocq.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl9snocq.fsf@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 0/9] net: bridge: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, Ido Schimmel <idosch@idosch.org>, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Mon, May 03, 2021 at 11:44:21AM +0200, Tobias Waldekranz wrote:
> > Do you expect this optimization to only work when physical netdevs are
> > enslaved to the bridge? What about LAG/VLANs?
> 
> LAGs should definitely work once the .ndo_dfwd_{add,del}_station helpers
> are in place.
> 
> Stacked VLANs could also be made to work. But they may require some
> extra work.
> 
> In v1, the bridge will always send offloaded frames with the VLAN
> information intact, even if the port is configured to egress the VID
> untagged. This is needed so that the driver can determine the correct
> VID to use in cases where multiple VIDs are set to egress untagged.
> 
> If any kind of VID translation takes place I think things get very
> sticky. Then again, that is maybe not all that defined without this
> change applied either?
> 
> What is the typical use-case for using an "external" stacked VLAN device
> over configuring the VLAN inside the bridge?

I think it will be very sticky to support forwarding offload for this
setup anyway:

            br0
swp0.100  swp0.101   swp1.100

Need to understand what the use case is. The correct behavior IMO is for
the physical switch port to remain standalone and for the bridge to know
that the bridge port (swp0.100) is not offloaded.
FWIW I had an attempt to handle situations like this here:
https://patchwork.kernel.org/project/netdevbpf/patch/20210224114350.2791260-17-olteanv@gmail.com/

I will let Tobias finish with his forwarding offload patch set before
rebasing and resending mine, his work looks a lot better at this point.
