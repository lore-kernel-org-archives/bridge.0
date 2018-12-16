Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bHvHTB
	gpxWOg10cohFJal6DrcOeRyCQIp+9DNczJ/6c=; b=ji/qNQzJCMjbRnrDlRLIYG
	IFkWVlpyQgLBWlK0xg2/KG6MqrvE2yqEPCyYsVhhJs5HSTlS3Poq+46n2+iu7oc1
	QlFJb3k57DFoeJ6uN7n7bYdhvVi5qGxVPwvtkVyB8+R1cmBAi/DdvRh/qy6Khex/
	8PIEInMwyOTYp23iIizXoQwRU53uFHHXZsgJTfGHxD1flsCy9ObFvOjCXHyS+6ku
	fNlyFsDF+Pcx7gJozPNPNp6a9znat//41KaYwL0ibAYWhFAVcw377kRwIOhrfe2j
	AR905oxlJka3R55l9vyFOaHqbzT7/RXjg7ZWJFOxxaXp8J+ctIJw/9456uJU1Qow
	==
Date: Sun, 16 Dec 2018 09:20:29 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181216072029.GA27582@splinter>
References: <61ecaa9f-f1ba-f79e-1d8b-4ec2eba5dc11@gmail.com>
	<20181212090238.GA1725@splinter.mtl.com>
	<5023d7cd-e5dc-88c9-4fc9-d40d8918c837@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5023d7cd-e5dc-88c9-4fc9-d40d8918c837@gmail.com>
Subject: Re: [Bridge] Correct PVID behavior with bridge's VLAN filtering
	on/off?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

On Wed, Dec 12, 2018 at 11:52:08AM -0800, Florian Fainelli wrote:
> On 12/12/18 1:02 AM, Ido Schimmel wrote:
> > On Tue, Dec 11, 2018 at 11:48:21AM -0800, Florian Fainelli wrote:
> >> Hi Nikolay, Roopa, Jiri, Ido,
> >>
> >> When a bridge has vlan_filtering=0 and notifies a switch driver through
> >> HOST_OBJ_MDB about MC addresses that the CPU/management port is
> >> interested in getting MC traffic for, I am seeing that the mdb->vid is
> >> set to 0 because br_allowed_ingress() checks for BROPT_VLAN_ENABLED
> >> which is now disabled and so we never populated *vid to anything but 0
> >> because the caller: br_handle_frame_finish() zeroed it out.
> > 
> > s/br_handle_frame_finish()/br_dev_xmit()/ ? Since you're talking about
> > HOST_OBJ_MDB
> 
> This affects the bridge ingress path as well, since I use HOST_OBJ_MDB
> to indicate whether the CPU port wants to receive multicast,
> transmitting multicast from the CPU port is almost never a problem. Is
> that a correct use of HOST_OBJ_MDB?

To the best of my knowledge, HOST_OBJ_MDB should be emitted for groups
the bridge itself would like to receive and this is triggered by the
transmission of IGMP membership reports through the bridge.

> 
> > 
> >> This creates a problem with the b53 DSA switch driver because in order
> >> to match the bridge's default_pvid, we did program the switch's "default
> >> tag" to be 1, which gets used for all untagged frames that ingress the
> >> switch (which AFAICT is correct behavior for PVID).
> > 
> > Not sure I'm following. If bridge is not VLAN-aware, then where do you
> > see 'default_pvid' being used?
> 
> A key detail I missed is that this is done with 4.9 (for now, in the
> process of forward porting fixes to net-next right now) which does not
> have this commit from Andrew:
> 
> 2ea7a679ca2abd251c1ec03f20508619707e1749 ("net: dsa: Don't add vlans
> when vlan filtering is disabled")
> 
> so the switch is actually VLAN aware, just it does not do strict VID
> violation enforcement policy, I like that behavior, but Jiri corrected
> me that this is not quite how it is defined.m.

If the Linux bridge is VLAN-aware, then the notification should be sent
with the PVID configured on the bridge port. Otherwise with VID 0.

> 
> > 
> >> Despite having turned off VLAN filtering in the switch such that it does
> >> allow ingress of packets with a VID that is not present in the VLAN
> >> table (violation), Multicast addresses do behave differently and we
> >> really must be strictly matching the programmed PVID in order for MC
> >> frames to ingress the switch even with VLAN filtering turned off.
> >>
> >> So with all that being written, should the bridge still be sending MDB
> >> notifications and use the bridge's default_pvid even with
> >> vlan_filtering=0? And if we did that, what use case could we be possibly
> >> breaking?
> >>
> >> Let me know if this is not clear so I can provide mode details.
> > 
> > I think you need to provide more details about the device you're working
> > with. I can explain what we're doing in mlxsw for reference.
> > 
> > When you use a VLAN-unaware bridge w/o VLAN devices, we make sure all
> > untagged packets get tagged with some arbitrary VLAN (now 1, soon 4095).
> > You never see this VLAN on the wire, since we remove it before sending
> > the packets. It is only used because all packets in the ASIC must be
> > tagged.
> > 
> > After we have a VLAN we classify the packet to a FID (bridge) and it
> > does {FID,DMAC} lookup in the FDB (MDB).
> > 
> > IIUC, your problem is that you also need to tag all the packets (you
> > used '1', can be something else), but then you program the MDB entry
> > according to the VLAN passed in the notification ('0') and not use
> > ('1'). We completely ignore the VID in this case and use the FID which
> > we lookup based on the ifindex of the bridge.
> > 
> 
> We do not have a concept of a FID with Broadcom switches, so we can
> either use a reserved VLAN ID to emulate that behavior and do individual
> MAC address learning which hashes into VID,MAC.
> 
> The switch has a "default 802.1Q tag" which gets used for untagged
> packets. Internally the switch normalizes all incoming frames (when
> 802.1Q is enabled) to have a double VLAN tag, and untagged frames get
> mapped to that "default 802.1Q/PVID tag" in the processing pipeline, and
> then when they ingress the destination switch port, they can get
> untagged again using the ingress port's "default 802.1Q/PVID tag" again.
> 
> The CPU port remains in the "default 802.1Q tag" set to 0, because that
> is also the configuration for non-bridge ports, and I need that to
> continue getting non-bridge ports to function normally and not be
> subjected to vlan_filtering = 1 being applied on the bridge (I will send
> a documentation patch that hopefully clarifies what the correct port
> behavior is and request feedback on that).
> 
> So here are essentially 3 things that could be fixed/tackled more or
> less independently:
> 
> - because vlan_filtering = 0, we have the HOST_OBJ_MDB request coming
> with mdb->vid = 0, which is expected with the current bridge code
> 
> - because the switch is made 802.1Q/VLAN aware, we have the ports that
> are bridge member configured with PVID = default_pvid (old kernel
> behavior, prior to Andrew's change), such that untagged frames show up
> untagged correctly at the network device level
> 
> - CPU/management port's default untagged VID is 0 which matches
> mdb->vid, but the bridged port, which is the ingress port for MC traffic
> is in VID 1 and where MC ingress filter checking is done. So there is a
> VID mismatch, and despite filtering being turned off, MC traffic does
> not evade that restriction (could be a misconfiguration on my side,
> could not find something that would allow it to just pass through).
> 
> With this one liner change both vlan_filtering states now work correctly
> with respect to MC:
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index b6de4f457161..fe446e971456 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -482,6 +482,7 @@ bool br_allowed_ingress(const struct net_bridge *br,
>          */
>         if (!br->vlan_enabled) {
>                 BR_INPUT_SKB_CB(skb)->vlan_filtered = false;
> +               *vid = br->default_pvid;

I don't believe this is correct. If bridge is not VLAN-aware, then PVID
is meaningless. Plus, untagged packets should be tagged with the PVID
configured on the bridge port, which is not necessarily 'default_pvid'.

In any case, it seems to me that your device requires certain
adjustments to correctly emulate the behavior of the Linux bridge. I
believe such changes belong in the relevant driver and not in the bridge
code.

>                 return true;
>         }
> 
> Or I suppose that I could just backport Andrew's patch and that would
> remove all VLAN awareness in the bridge, which would likely solve the
> problem as well, and/or find a way to make sure that MC flows do bypass
> VLAN filtering after all when vlan_filtering = 0.
> 
> Thanks for your patience.
> -- 
> Florian
