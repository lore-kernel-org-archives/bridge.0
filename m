Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l5amRRhffN7SW+44mi2KiL5Riiwg1WKIl4fQH5PcALQ=; b=gdiTF4HzVAZqXHazDeHDojZQmF
 OoDj01/uxiE5MDEfOJoqDGfqqBk/NKjf7bwsWcexlTw2IBQgFSGKBS4HPQBl+LmH4Bx4zD6IYfkuj
 K3Y3naQ8t4KO3zeswScGgZXhuWMRYYkt7c97i9gObQzDMI78/Mfr8d6Kct4zoameC4ps=;
Date: Sun, 26 Jan 2020 18:12:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200126171251.GK18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
 <20200125161615.GD18311@lunn.ch>
 <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
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
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

On Sun, Jan 26, 2020 at 02:01:11PM +0100, Horatiu Vultur wrote:
> The 01/25/2020 17:16, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > >  br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
> > > @@ -338,6 +341,17 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
> > >                       return RX_HANDLER_CONSUMED;
> > >               }
> > >       }
> > > +#ifdef CONFIG_BRIDGE_MRP
> > > +     /* If there is no MRP instance do normal forwarding */
> > > +     if (!p->mrp_aware)
> > > +             goto forward;
> > > +
> > > +     if (skb->protocol == htons(ETH_P_MRP))
> > > +             return RX_HANDLER_PASS;
> > 
> > What MAC address is used for these MRP frames? It would make sense to
> > use a L2 link local destination address, since i assume they are not
> > supposed to be forwarded by the bridge. If so, you could extend the
> > if (unlikely(is_link_local_ether_addr(dest))) condition.
> 
> The MAC addresses used by MRP frames are:
> 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 - used by MRP_Test frames
> 0x1, 0x15, 0x4e, 0x0, 0x0, 0x2 - used by the rest of MRP frames.
> 
> If we will add support also for MIM/MIC. These requires 2 more MAC
> addresses:
> 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 - used by MRP_InTest frames.
> 0x1, 0x15, 0x4e, 0x0, 0x0, 0x4 - used by the other MRP interconnect
> frames.

Hi Horatiu

I made the wrong guess about how this protocol worked when i said L2
link local. These MAC addresses are L2 multicast.

And you are using a raw socket to receive them into userspace when
needed.

'Thinking allowed' here.

    +------------------------------------------+
    |                                          |
    +-->|H1|<---------->|H2|<---------->|H3|<--+
    eth0    eth1    eth0    eth1    eth0    eth1
     ^
     |
  Blocked


There are three major classes of user case here:

1) Pure software solution

You need the software bridge in the client to forward these frames
from the left side to the right side. (Does the standard give these
two ports names)? In the master, the left port is blocked, so the
bridge drops them anyway. You have a RAW socket open on both eth0 and
eth1, so you get to see the frames, even if the bridge drops them.

2) Hardware offload to an MRP unaware switch.

I'm thinking about a plain switch supported by DSA, Marvell, Broadcom,
etc. It has no special knowledge of MRP.

Ideally, you want the switch to forward MRP_Test frames left to right
for a client. In a master, i think you have a problem, since the port
is blocked. The hardware is unlikely to recognise these frames as
special, since they are not in the 01-80-C2-XX-XX-XX block, and let
them through. So your raw socket is never going to see them, and you
cannot detect open/closed ring.

I don't know how realistic it is to support MRP in this case, and i
also don't think you can fall back to a pure software solution,
because the software bridge is going to offload the basic bridge
operation to the hardware. It would be nice if you could detect this,
and return -EOPNOTSUPP.

3) Hardware offload to an MRP aware switch.

For a client, you tell it which port is left, which is right, and
assume it forwards the frames. For a master, you again tell it which
is left, which is right, and ask it send MRP_Test frames out right,
and report changes in open/closed on the right port. You don't need
the CPU to see the MRP_Test frames, so the switch has no need to
forward them to the CPU.

We should think about the general case of a bridge with many ports,
and many pairs of ports using MRP. This makes the forwarding of these
frames interesting. Given that they are multicast, the default action
of the software bridge is that it will flood them. Does the protocol
handle seeing MRP_Test from some other loop? Do we need to avoid this?
You could avoid this by adding MDB entries to the bridge. However,
this does not scale to more then one ring. I don't think an MDB is
associated to an ingress port. So you cannot say 

0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 ingress port1 egress port2
0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 ingress port3 egress port4

The best you can say is

0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 egress port2, port4

I'm sure there are other issues i'm missing, but it is interesting to
think about all this.

Andrew
