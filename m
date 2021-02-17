Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613577527; x=1645113527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TrSgV4ppZBB1E4H994V5PZn9jNxoOv0E4rNOorIzQXM=;
 b=JnW1MbcF+8UNeR/RCrYkphHOpCr/Y9U33VBmD6l+WH7sWjG62abFV8LU
 83//qgsR4RtknCqK3+jHdIOXF+YPyDppDucxat1Ycr1RwxYZtCyG6Fmj2
 CY5ZFgKgDAleH5IFCXD4cI3zA2r6dnu+hXroYy8pgAPo0oJ2qlL9Sa783
 KRmVrbpz4tf/YDk+ZGB4P88MtzRgClKq5tq1WcJ8GOI9A7JE7nkE5ZQte
 1jArqUBRNqNv4lR2Vy/Y9a5fTxGCpK/9FrGv2441U9CxXZkt3XxKBkrda
 zYHwf1eWJRsmMs2682YrTBb2uGGgu+mMuVq+DMlLbzGBprWs5QUQdVIT2 A==;
Date: Wed, 17 Feb 2021 16:58:45 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210217155845.oegbmsnxykkqc6um@soft-dev3.localdomain>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-3-horatiu.vultur@microchip.com>
 <20210217103433.bilnuo2tfvgvjmxy@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210217103433.bilnuo2tfvgvjmxy@skbuf>
Subject: Re: [Bridge] [PATCH net-next v4 2/8] switchdev: mrp: Extend
 ring_role_mrp and in_role_mrp
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

The 02/17/2021 10:34, Vladimir Oltean wrote:

Hi Vladimir,

> 
> On Tue, Feb 16, 2021 at 10:41:59PM +0100, Horatiu Vultur wrote:
> > Add the member sw_backup to the structures switchdev_obj_ring_role_mrp
> > and switchdev_obj_in_role_mrp. In this way the SW can call the driver in
> > 2 ways, once when sw_backup is set to false, meaning that the driver
> > should implement this completely in HW. And if that is not supported the
> > SW will call again but with sw_backup set to true, meaning that the
> > HW should help or allow the SW to run the protocol.
> >
> > For example when role is MRM, if the HW can't detect when it stops
> > receiving MRP Test frames but it can trap these frames to CPU, then it
> > needs to return -EOPNOTSUPP when sw_backup is false and return 0 when
> > sw_backup is true.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/net/switchdev.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> > index 465362d9d063..b7fc7d0f54e2 100644
> > --- a/include/net/switchdev.h
> > +++ b/include/net/switchdev.h
> > @@ -127,6 +127,7 @@ struct switchdev_obj_ring_role_mrp {
> >       struct switchdev_obj obj;
> >       u8 ring_role;
> >       u32 ring_id;
> > +     u8 sw_backup;
> >  };
> >
> >  #define SWITCHDEV_OBJ_RING_ROLE_MRP(OBJ) \
> > @@ -161,6 +162,7 @@ struct switchdev_obj_in_role_mrp {
> >       u32 ring_id;
> >       u16 in_id;
> >       u8 in_role;
> > +     u8 sw_backup;
> 
> What was wrong with 'bool'?
Yeah, that would be a better match.
> 
> >  };
> >
> >  #define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
> > --
> > 2.27.0
> >
> 
> If a driver implements full MRP offload for a ring/interconnect
> manager/automanager, should it return -EOPNOTSUPP when sw_backup=false?

In that case it should return 0.
So if the driver can:
- fully support MRP, when sw_backup = false, return 0. Then end of story.
- partially support MRP, when sw_backup = false, return -EOPNOTSUPP,
                         when sw_backup = true, return 0.
- no support at all, return -EOPNOTSUPP.

-- 
/Horatiu
