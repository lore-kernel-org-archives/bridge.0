Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613577779; x=1645113779;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qJK73leWzrkDzeBC+OYmyCx8uVJIE42XDAZUX9Da8BA=;
 b=Igs6n7OMyhkhusjzABztY8T7XHS6MCO76jJ3YQyGDlB2V4tedoSjW/cw
 fBnsMdfmwKNRiMn6jsPl3f2Cm8DIqAgcSGgTPRJeensIqizpK8OwNvQjC
 TED6PViPMJ5DPofCGsgoVsfh0XqRKKhC128rwHY2MJ9moGPTi82UaB9tq
 Lp2zdWjWCi1jZ0/GnOpQHX1JxmcpgJj34NuEzcjUBU1V1nr4bCDslNCye
 6FRFcm9vgfAHKPWMNgleZ/wSlAmSqbLuZxuxHomf+KhTJJmaz+St3AyOB
 hRyGCFBxcN379ye3F5Eici3WMzdXUb67AKzsy3RUPErKx3aRpc8a94sPk Q==;
Date: Wed, 17 Feb 2021 17:02:56 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210217160256.jr33sgi73s7wsaaa@soft-dev3.localdomain>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-5-horatiu.vultur@microchip.com>
 <20210217105624.aehyxw3tfs5uycdl@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210217105624.aehyxw3tfs5uycdl@skbuf>
Subject: Re: [Bridge] [PATCH net-next v4 4/8] bridge: mrp: Extend
 br_mrp_switchdev to detect better the errors
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

The 02/17/2021 10:56, Vladimir Oltean wrote:
> 
> On Tue, Feb 16, 2021 at 10:42:01PM +0100, Horatiu Vultur wrote:
> > This patch extends the br_mrp_switchdev functions to be able to have a
> > better understanding what cause the issue and if the SW needs to be used
> > as a backup.
> >
> > There are the following cases:
> > - when the code is compiled without CONFIG_NET_SWITCHDEV. In this case
> >   return success so the SW can continue with the protocol. Depending
> >   on the function, it returns 0 or BR_MRP_SW.
> > - when code is compiled with CONFIG_NET_SWITCHDEV and the driver doesn't
> >   implement any MRP callbacks. In this case the HW can't run MRP so it
> >   just returns -EOPNOTSUPP. So the SW will stop further to configure the
> >   node.
> > - when code is compiled with CONFIG_NET_SWITCHDEV and the driver fully
> >   supports any MRP functionality. In this case the SW doesn't need to do
> >   anything. The functions will return 0 or BR_MRP_HW.
> > - when code is compiled with CONFIG_NET_SWITCHDEV and the HW can't run
> >   completely the protocol but it can help the SW to run it. For
> >   example, the HW can't support completely MRM role(can't detect when it
> >   stops receiving MRP Test frames) but it can redirect these frames to
> >   CPU. In this case it is possible to have a SW fallback. The SW will
> >   try initially to call the driver with sw_backup set to false, meaning
> >   that the HW should implement completely the role. If the driver returns
> >   -EOPNOTSUPP, the SW will try again with sw_backup set to false,
> >   meaning that the SW will detect when it stops receiving the frames but
> >   it needs HW support to redirect the frames to CPU. In case the driver
> >   returns 0 then the SW will continue to configure the node accordingly.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  net/bridge/br_mrp_switchdev.c | 171 +++++++++++++++++++++-------------
> >  net/bridge/br_private_mrp.h   |  24 +++--
> >  2 files changed, 118 insertions(+), 77 deletions(-)
> >
> > diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
> > index 3c9a4abcf4ee..cb54b324fa8c 100644
> > --- a/net/bridge/br_mrp_switchdev.c
> > +++ b/net/bridge/br_mrp_switchdev.c
> > @@ -4,6 +4,30 @@
> >
> >  #include "br_private_mrp.h"
> >
> > +static enum br_mrp_hw_support
> > +br_mrp_switchdev_port_obj(struct net_bridge *br,
> > +                       const struct switchdev_obj *obj, bool add)
> > +{
> > +     int err;
> > +
> 
> Looks like you could have added this check here and simplified all the
> callers:
> 
>         if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
>                 return BR_MRP_SW;

Yes, good catch!

> 
> > +     if (add)
> > +             err = switchdev_port_obj_add(br->dev, obj, NULL);
> > +     else
> > +             err = switchdev_port_obj_del(br->dev, obj);
> > +
> > +     /* In case of success just return and notify the SW that doesn't need
> > +      * to do anything
> > +      */
> > +     if (!err)
> > +             return BR_MRP_HW;
> > +
> > +     if (err != -EOPNOTSUPP)
> > +             return BR_MRP_NONE;
> > +
> > +     /* Continue with SW backup */
> > +     return BR_MRP_SW;
> > +}
> > +

-- 
/Horatiu
