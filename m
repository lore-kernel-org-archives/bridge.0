Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1606134694; x=1637670694;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OLdDCWuWqpqn05lwFSC/SLaom41YK6TRggAoCaO8jHE=;
 b=J4s6z1RxZu/QoKnwPuDlrtQCL/MMM85GTk/aVSyQGZo90hEjcmXiYtb/
 EyjLAQb1hjbOaVzLuCd73eXNHRRmCvueDiOaElHSr5jWT9st73DQ4/J4C
 AWzqFLRIuze1uKukEiVWyVjeRQq8V2Yl2l7307iTBqLYRepw+rh1kJ3fb
 2P+hTfeocXFoej8+3UAvcZWX2Z2/HKBhjBCIk1UOuqzG9QgZ3m9ZAM6FR
 C+Mh8qjNQS5eo6s3SAT5ejotqAS4fPC0ktSqICZJeFl9pAgZ/hJ3v8Jhn
 n0C1heOqbGhDR/YbPs+/C0lcfoAtlAbEieWtuXJ0pTN80Wex9aIvQHDmh Q==;
Date: Mon, 23 Nov 2020 13:31:32 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20201123123132.uxvec6uwuegioc25@soft-dev3.localdomain>
References: <20201123111401.136952-1-horatiu.vultur@microchip.com>
 <5ffa6f9f-d1f3-adc7-ddb8-e8107ea78da5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5ffa6f9f-d1f3-adc7-ddb8-e8107ea78da5@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: mrp: Implement LC mode for MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

The 11/23/2020 14:13, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 23/11/2020 13:14, Horatiu Vultur wrote:
> > Extend MRP to support LC mode(link check) for the interconnect port.
> > This applies only to the interconnect ring.
> >
> > Opposite to RC mode(ring check) the LC mode is using CFM frames to
> > detect when the link goes up or down and based on that the userspace
> > will need to react.
> > One advantage of the LC mode over RC mode is that there will be fewer
> > frames in the normal rings. Because RC mode generates InTest on all
> > ports while LC mode sends CFM frame only on the interconnect port.
> >
> > All 4 nodes part of the interconnect ring needs to have the same mode.
> > And it is not possible to have running LC and RC mode at the same time
> > on a node.
> >
> > Whenever the MIM starts it needs to detect the status of the other 3
> > nodes in the interconnect ring so it would send a frame called
> > InLinkStatus, on which the clients needs to reply with their link
> > status.
> >
> > This patch adds the frame header for the frame InLinkStatus and
> > extends existing rules on how to forward this frame.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/mrp_bridge.h |  7 +++++++
> >  net/bridge/br_mrp.c             | 18 +++++++++++++++---
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> >
> 
> Hi Horatiu,
> The patch looks good overall, just one question below.

Hi Nik,

Thanks for taking time to review the patch.

> 
> > diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
> > index 6aeb13ef0b1e..450f6941a5a1 100644
> > --- a/include/uapi/linux/mrp_bridge.h
> > +++ b/include/uapi/linux/mrp_bridge.h
> > @@ -61,6 +61,7 @@ enum br_mrp_tlv_header_type {
> >       BR_MRP_TLV_HEADER_IN_TOPO = 0x7,
> >       BR_MRP_TLV_HEADER_IN_LINK_DOWN = 0x8,
> >       BR_MRP_TLV_HEADER_IN_LINK_UP = 0x9,
> > +     BR_MRP_TLV_HEADER_IN_LINK_STATUS = 0xa,
> >       BR_MRP_TLV_HEADER_OPTION = 0x7f,
> >  };
> >
> > @@ -156,4 +157,10 @@ struct br_mrp_in_link_hdr {
> >       __be16 interval;
> >  };
> >
> > +struct br_mrp_in_link_status_hdr {
> > +     __u8 sa[ETH_ALEN];
> > +     __be16 port_role;
> > +     __be16 id;
> > +};
> > +
> 
> I didn't see this struct used anywhere, am I missing anything?

Yes, you are right, the struct is not used any. But I put it there as I
put the other frame types for MRP.

> 
> Cheers,
>  Nik
> 
> >  #endif
> > diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> > index bb12fbf9aaf2..cec2c4e4561d 100644
> > --- a/net/bridge/br_mrp.c
> > +++ b/net/bridge/br_mrp.c
> > @@ -858,7 +858,8 @@ static bool br_mrp_in_frame(struct sk_buff *skb)
> >       if (hdr->type == BR_MRP_TLV_HEADER_IN_TEST ||
> >           hdr->type == BR_MRP_TLV_HEADER_IN_TOPO ||
> >           hdr->type == BR_MRP_TLV_HEADER_IN_LINK_DOWN ||
> > -         hdr->type == BR_MRP_TLV_HEADER_IN_LINK_UP)
> > +         hdr->type == BR_MRP_TLV_HEADER_IN_LINK_UP ||
> > +         hdr->type == BR_MRP_TLV_HEADER_IN_LINK_STATUS)
> >               return true;
> >
> >       return false;
> > @@ -1126,9 +1127,9 @@ static int br_mrp_rcv(struct net_bridge_port *p,
> >                                               goto no_forward;
> >                               }
> >                       } else {
> > -                             /* MIM should forward IntLinkChange and
> > +                             /* MIM should forward IntLinkChange/Status and
> >                                * IntTopoChange between ring ports but MIM
> > -                              * should not forward IntLinkChange and
> > +                              * should not forward IntLinkChange/Status and
> >                                * IntTopoChange if the frame was received at
> >                                * the interconnect port
> >                                */
> > @@ -1155,6 +1156,17 @@ static int br_mrp_rcv(struct net_bridge_port *p,
> >                            in_type == BR_MRP_TLV_HEADER_IN_LINK_DOWN))
> >                               goto forward;
> >
> > +                     /* MIC should forward IntLinkStatus frames only to
> > +                      * interconnect port if it was received on a ring port.
> > +                      * If it is received on interconnect port then, it
> > +                      * should be forward on both ring ports
> > +                      */
> > +                     if (br_mrp_is_ring_port(p_port, s_port, p) &&
> > +                         in_type == BR_MRP_TLV_HEADER_IN_LINK_STATUS) {
> > +                             p_dst = NULL;
> > +                             s_dst = NULL;
> > +                     }
> > +
> >                       /* Should forward the InTopo frames only between the
> >                        * ring ports
> >                        */
> >
> 

-- 
/Horatiu
