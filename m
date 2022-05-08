Return-Path: <idosch@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+coYDT6nC/hhcdlPzwpYMKSVihK1EjX5fUZMAByoGU4=;
 b=DNNzCL6nnPSFKejjL96mrY+2VS0LSYr/ZDJe8wBB2vdp834d5KKpFL/rD2imqIX0YURxcc1QnHHYnQpkBmlC3krRInUyPRkcjsJHc8zwITrZr+FSVrUhiEhW/KkbrxhEJlIof/gYNMRKyFVHqHWk6tFHWmW4Viv4TFp/1nKfyw+fUjO07NxdiFh3lvmzBiE0wujzy2wrJZsmVPIrEobc6Wejd0wtqLOqq96nrpQLQ8iB2FHe2brFUC8Z1smw/meP6LS8bVuu6rlimdp6FiWw72Bsm947bo/MtyN7hp/sbr/uvmd5gBIpwaFjrLjKXIR3CfoGdp1O/UJ0o4Zww1ESbg==
Date: Sun, 8 May 2022 10:52:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ynd213m/0uXfjArm@shredder>
References: <20220505225904.342388-1-andrew@lunn.ch>
 <20220506143644.mzfffht44t3glwci@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506143644.mzfffht44t3glwci@skbuf>
MIME-Version: 1.0
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
Cc: Ido Schimmel <idosch@mellanox.com>, Andrew Lunn <andrew@lunn.ch>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, netdev <netdev@vger.kernel.org>

On Fri, May 06, 2022 at 02:36:45PM +0000, Vladimir Oltean wrote:
> Hi Andrew,
> 
> On Fri, May 06, 2022 at 12:59:04AM +0200, Andrew Lunn wrote:
> > It is possible to stack bridges on top of each other. Consider the
> > following which makes use of an Ethernet switch:
> > 
> >        br1
> >      /    \
> >     /      \
> >    /        \
> >  br0.11    wlan0
> >    |
> >    br0
> >  /  |  \
> > p1  p2  p3
> > 
> > br0 is offloaded to the switch. Above br0 is a vlan interface, for
> > vlan 11. This vlan interface is then a slave of br1. br1 also has
> > wireless interface as a slave. This setup trunks wireless lan traffic
> > over the copper network inside a VLAN.
> > 
> > A frame received on p1 which is passed up to the bridge has the
> > skb->offload_fwd_mark flag set to true, indicating it that the switch
> > has dealt with forwarding the frame out ports p2 and p3 as
> > needed. This flag instructs the software bridge it does not need to
> > pass the frame back down again. However, the flag is not getting reset
> > when the frame is passed upwards. As a result br1 sees the flag,
> > wrongly interprets it, and fails to forward the frame to wlan0.
> > 
> > When passing a frame upwards, clear the flag.
> > 
> > RFC because i don't know the bridge code well enough if this is the
> > correct place to do this, and if there are any side effects, could the
> > skb be a clone, etc.
> 
> Each skb has its own offload_fwd_mark, so clearing it for this skb does
> not affect a clone. And when a packet is simultaneously forwarded and
> locally received, the order is first forward/flood it, then receive it.
> Cloning takes place during forwarding using deliver_clone(), so it
> shouldn't be the case that you are clearing the offload_fwd_mark for a
> yet-to-be-forwarded packet, either. So I think we're good there.
> 
> > 
> > Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward mark")
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  net/bridge/br_input.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index 196417859c4a..9327a5fad1df 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -39,6 +39,13 @@ static int br_pass_frame_up(struct sk_buff *skb)
> >  	dev_sw_netstats_rx_add(brdev, skb->len);
> >  
> >  	vg = br_vlan_group_rcu(br);
> > +
> > +	/* Reset the offload_fwd_mark because there could be a stacked
> > +	 * bridge above, and it should not think this bridge it doing
> > +	 * that bridges work forward out its ports.
> 
> "this bridge is doing that bridge's work forwarding out its ports"
> 
> > +	 */
> > +	br_switchdev_frame_unmark(skb);
> > +
> >  	/* Bridge is just like any other port.  Make sure the
> >  	 * packet is allowed except in promisc mode when someone
> >  	 * may be running packet capture.
> > -- 
> > 2.36.0
> >
> 
> The good thing with this patch is that it avoids conditionals.
> The bad thing is that it prevents true offloading of this configuration
> from being possible (when "wlan0" is "p4").
> 
> I don't know what hardware is capable of doing this, but I think it's
> cautious to not exclude it, either.
> 
> Some safer alternatives to this patch are based on the idea that we
> could ignore skb->offload_fwd_mark coming from an unoffloaded bridge
> port (i.e. treat this condition at br1, not at br0). We could:
> - clear skb->offload_fwd_mark in br_handle_frame_finish(), if p->hwdom is 0
> - change nbp_switchdev_allowed_egress() to return true if cb->src_hwdom == 0

I like Andrew's patch because it is the Rx equivalent of
br_switchdev_frame_unmark() in br_dev_xmit(). However, if we go with the
second option, it should allow us to remove the clearing of the mark in
the Tx path as the control block is cleared in the Tx path since commit
fd65e5a95d08 ("net: bridge: clear bridge's private skb space on xmit").

I don't know how far back Nik's patch was backported and I don't know
how far back Andrew's patch will be backported, so it might be best to
submit Andrew's patch to net as-is and then in net-next change
nbp_switchdev_allowed_egress() and remove br_switchdev_frame_unmark()
from both the Rx and Tx paths.

Anyway, I have applied this patch to our tree for testing. Will report
tomorrow in case there are any regressions.
