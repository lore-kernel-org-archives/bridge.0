Return-Path: <Horatiu.Vultur@microchip.com>
Date: Sun, 26 Jan 2020 14:01:11 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
 <20200125161615.GD18311@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200125161615.GD18311@lunn.ch>
Subject: Re: [Bridge] [RFC net-next v3 09/10] net: bridge: mrp: Integrate
 MRP into the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

The 01/25/2020 17:16, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> >  br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
> > @@ -338,6 +341,17 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> >                       return RX_HANDLER_CONSUMED;
> >               }
> >       }
> > +#ifdef CONFIG_BRIDGE_MRP
> > +     /* If there is no MRP instance do normal forwarding */
> > +     if (!p->mrp_aware)
> > +             goto forward;
> > +
> > +     if (skb->protocol == htons(ETH_P_MRP))
> > +             return RX_HANDLER_PASS;
> 
> What MAC address is used for these MRP frames? It would make sense to
> use a L2 link local destination address, since i assume they are not
> supposed to be forwarded by the bridge. If so, you could extend the
> if (unlikely(is_link_local_ether_addr(dest))) condition.

The MAC addresses used by MRP frames are:
0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 - used by MRP_Test frames
0x1, 0x15, 0x4e, 0x0, 0x0, 0x2 - used by the rest of MRP frames.

If we will add support also for MIM/MIC. These requires 2 more MAC
addresses:
0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 - used by MRP_InTest frames.
0x1, 0x15, 0x4e, 0x0, 0x0, 0x4 - used by the other MRP interconnect
frames.

Then maybe I shoukd change the check to be something like:
if (unlikely(skb->protocol == htons(ETH_P_MRP)))

> 
> > +
> > +     if (p->state == BR_STATE_BLOCKING)
> > +             goto drop;
> > +#endif
> 
> Is this needed? The next block of code is a switch statement on
> p->state. The default case, which BR_STATE_BLOCKING should hit, is
> drop.

Yes you are rigth, it is not needed anymore.

> 
> This function is on the hot path. So we should try to optimize it as
> much as possible.
> 
>      Andrew

-- 
/Horatiu
