Message-ID: <bdfc5d6e0609111226t3cd26152te880bcefcae4055f@mail.gmail.com>
Date: Mon, 11 Sep 2006 15:26:16 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <4505B4ED.9080901@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911174928.GA3451@devicescape.com>
	<bdfc5d6e0609111155s58677c8bx2533330a18238aca@mail.gmail.com>
	<4505B4ED.9080901@candelatech.com>
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@lists.osdl.org

On 9/11/06, Ben Greear <greearb@candelatech.com> wrote:
> Andy Gospodarek wrote:
> > On 9/11/06, David Kimdon <david.kimdon@devicescape.com> wrote:
> >> Hi,
> >>
> >> The attached patches enables the bridge to filter and forward packets
> >> according to their IEEE 802.1q headers.  The goals behind this change
> >> include :
> >>
> >> - Enable running STP on 802.1q tagged networks.  STP packets
> >>   must be untagged.  It isn't obvious how else to enable STP
> >>   with the current bridge and vlan code.
> >> - Add native support for an untagged vlan.  Currently an untagged
> >>   vlan can be implimented using ebtables or similar.
> >> - On devices bridging a large number of interfaces across various
> >>   vlans this significantly simplifies configuration and, depending on
> >>   configuration, can improve performance.
> >>
> >> Comments appreciated,
> >>
> >> David
> >
> >
> > David,
> >
> > It looks like this code specifically ignores (which is OK for now) and
> > clears (which is not OK) the frame's 802.1p priority.  Have you tested
> > priority-tagged frames to see if they are passed correctly?  It seems
> > like you should consider adding another field to the sk_buff structure
> > so priority of the incoming frame can be tracked as well as add logic
> > to br_vlan_output_frame and br_vlan_input_frame so the tag is saved.
> > Something like this would probably be fine:
> >
> > Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
> >
> > --- ./include/linux/skbuff.h.gospo      2006-09-11 14:41:54.000000000 -0400
> > +++ ./include/linux/skbuff.h    2006-09-11 14:43:27.000000000 -0400
> > @@ -297,6 +297,7 @@ struct sk_buff {
> >         __u32                   nfmark;
> >  #endif /* CONFIG_NETFILTER */
> >  #ifdef CONFIG_BRIDGE_VLAN
> > +       unsigned int            vlan_priority;
> >         unsigned int            vlan;
> >  #endif
>
> SKB bloat is not good for performance.  You can store the priority and the VID in
> a single 32-bit number with room to spare...
>
> The skb->priority is also a possible place to store the VLAN priority.

Good.  I didn't like the idea of increasing the bloat factor of an skb.

>
> The actual VLAN code has a mapping from vlan-priority -> skb priority on ingress,
> and another mapping of skb->priority -> vlan-priority on egress.  You probably
> don't need to worry about this mapping for a bridge, however.

If the bridge destroys your existing priority then that's bad however.
 Am I seeing this wrong or will this not reset bridged frames to
priority zero in the case where untagged frames need to be given a tag
as they are bridged?


>
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>
