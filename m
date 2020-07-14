Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594739268; x=1626275268;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=r4E3DoO/243oOPim9W7seyYjqcxT6G/IVb7gOQ45Lro=;
 b=AGWRpHeszTOBX4YzrSB4SM1AejH2NxEwLxxFi7NhpcNmAdcKB1SlMVam
 L8b4rZ8uFi+/3Wu2hhKGMRINQ/dsAZiyBB2A3xwFX8AfRq1KMmjeYpi55
 ighoe5xHq4r+gVbP/vjjeVTjzKxUT+qDLxVVMQBTSweWjqGZeJfvrQFBW
 Z13HdKvJqwdlKXh1Z64wyALR1qKFNqBJEO4hbJ2GpQPSMvT/sofgl5rsv
 D1CV6kDY/MvF3fbGoVTL1RnN3kqqr1ZJ4CEGuYEExm1eSTGjoLRn9s1x2
 PTWNB2uQ4nmR3yCvO9VUX39aQO9lYqdsxpnCdXazE2vKUyOFb5lZfE9SF g==;
Date: Tue, 14 Jul 2020 17:07:40 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200714150740.3ji3qhtvikhrizfn@soft-dev3.localdomain>
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-13-horatiu.vultur@microchip.com>
 <9eeb89c5-865f-2b21-c7c6-7f4479bf4175@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <9eeb89c5-865f-2b21-c7c6-7f4479bf4175@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v4 12/12] net: bridge: Add port
 attribute IFLA_BRPORT_MRP_IN_OPEN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, davem@davemloft.net

The 07/14/2020 16:29, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 14/07/2020 10:34, Horatiu Vultur wrote:
> > This patch adds a new port attribute, IFLA_BRPORT_MRP_IN_OPEN, which
> > allows to notify the userspace when the node lost the contiuity of
> > MRP_InTest frames.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/if_link.h       | 1 +
> >  net/bridge/br_netlink.c            | 3 +++
> >  tools/include/uapi/linux/if_link.h | 1 +
> >  3 files changed, 5 insertions(+)
> >

Hi Nik,

> 
> It's kind of late by now, but I'd wish these were contained in a nested MRP attribute. :)
> Horatiu, do you expect to have many more MRP attributes outside of MRP netlink code?

I don't expect to add any other MRP attributes outside of MRP netlink
code.

> 
> Perhaps we should at least dump them only for MRP-aware ports, that should be easy.
> They make no sense outside of MRP anyway, but increase the size of the dump for all
> right now.

You are right. Then should I first send a fix on the net for this and
after that I will fix these patches or just fix this in the next patch
series?

> 
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index cc185a007ade8..26842ffd0501d 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -344,6 +344,7 @@ enum {
> >       IFLA_BRPORT_ISOLATED,
> >       IFLA_BRPORT_BACKUP_PORT,
> >       IFLA_BRPORT_MRP_RING_OPEN,
> > +     IFLA_BRPORT_MRP_IN_OPEN,
> >       __IFLA_BRPORT_MAX
> >  };
> >  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index c532fa65c9834..147d52596e174 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -152,6 +152,7 @@ static inline size_t br_port_info_size(void)
> >  #endif
> >               + nla_total_size(sizeof(u16))   /* IFLA_BRPORT_GROUP_FWD_MASK */
> >               + nla_total_size(sizeof(u8))    /* IFLA_BRPORT_MRP_RING_OPEN */
> > +             + nla_total_size(sizeof(u8))    /* IFLA_BRPORT_MRP_IN_OPEN */
> >               + 0;
> >  }
> >
> > @@ -216,6 +217,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
> >                      !!(p->flags & BR_NEIGH_SUPPRESS)) ||
> >           nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
> >                                                         BR_MRP_LOST_CONT)) ||
> > +         nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
> > +                    !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
> >           nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
> >               return -EMSGSIZE;
> >
> > diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> > index cafedbbfefbe9..781e482dc499f 100644
> > --- a/tools/include/uapi/linux/if_link.h
> > +++ b/tools/include/uapi/linux/if_link.h
> > @@ -344,6 +344,7 @@ enum {
> >       IFLA_BRPORT_ISOLATED,
> >       IFLA_BRPORT_BACKUP_PORT,
> >       IFLA_BRPORT_MRP_RING_OPEN,
> > +     IFLA_BRPORT_MRP_IN_OPEN,
> >       __IFLA_BRPORT_MAX
> >  };
> >  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> >
> 

-- 
/Horatiu
