Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613578730; x=1645114730;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cs4BA7FTmjYzHJsFq1qDXA+grIoaOTs9jb/eR7cncrc=;
 b=EZ14kR3rjvYRt1242CdfpIjaakRelewHHAfJPsUSXAQkybJoQYxmb5pF
 Nt3nj1rKZhZo2re86ysA9nbw6QMjkXYbB1FUo8ZEOyrCwL9pWK+7EHeh0
 ezwRN5zRwlcJBo9OLLXzDyaiTJ0ZXSilFzDcjLgdx3956XLOqI4hSF/f8
 CRl45vcqCmKUAu295ljC7lRJQGlT6n+nCJGQXwJSJj/3QfY6/dBl7Vwas
 pN/54CaRGp0biX8UwlFAyjIfS7J5DUCq3bld6qVmTjnG6IPEmK7+IBk5s
 Ikw3pJyLAK0NyBwsQf/Xxem42lf6TfHu+zsVk3IuH0vkc466jsodP4DVi g==;
Date: Wed, 17 Feb 2021 17:18:47 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210217161847.6ntm52kqk7ygata7@soft-dev3.localdomain>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-6-horatiu.vultur@microchip.com>
 <20210217105951.5nyfclvf6e2p2nkf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210217105951.5nyfclvf6e2p2nkf@skbuf>
Subject: Re: [Bridge] [PATCH net-next v4 5/8] bridge: mrp: Update br_mrp to
 use new return values of br_mrp_switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

The 02/17/2021 10:59, Vladimir Oltean wrote:
> 
> On Tue, Feb 16, 2021 at 10:42:02PM +0100, Horatiu Vultur wrote:
> > diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> > index 01c67ed727a9..12487f6fe9b4 100644
> > --- a/net/bridge/br_mrp.c
> > +++ b/net/bridge/br_mrp.c
> > @@ -639,7 +639,7 @@ int br_mrp_set_ring_role(struct net_bridge *br,
> >                        struct br_mrp_ring_role *role)
> >  {
> >       struct br_mrp *mrp = br_mrp_find_id(br, role->ring_id);
> > -     int err;
> > +     enum br_mrp_hw_support support;
> >
> >       if (!mrp)
> >               return -EINVAL;
> > @@ -647,9 +647,9 @@ int br_mrp_set_ring_role(struct net_bridge *br,
> >       mrp->ring_role = role->ring_role;
> >
> >       /* If there is an error just bailed out */
> > -     err = br_mrp_switchdev_set_ring_role(br, mrp, role->ring_role);
> > -     if (err && err != -EOPNOTSUPP)
> > -             return err;
> > +     support = br_mrp_switchdev_set_ring_role(br, mrp, role->ring_role);
> > +     if (support == BR_MRP_NONE)
> > +             return -EOPNOTSUPP;
> 
> It is broken to update the return type and value of a function in one
> patch, and check for the updated return value in another patch.
> 

Yes, I will be more careful next time. I have tried to compile between
the patches and I have not see any issues here so I though that
everything is good.

> >
> >       /* Now detect if the HW actually applied the role or not. If the HW
> >        * applied the role it means that the SW will not to do those operations
> > @@ -657,7 +657,7 @@ int br_mrp_set_ring_role(struct net_bridge *br,
> >        * SW when ring is open, but if the is not pushed to the HW the SW will
> >        * need to detect when the ring is open
> >        */
> > -     mrp->ring_role_offloaded = err == -EOPNOTSUPP ? 0 : 1;
> > +     mrp->ring_role_offloaded = support == BR_MRP_SW ? 0 : 1;
> >
> >       return 0;
> >  }

-- 
/Horatiu
