Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594118293; x=1625654293;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ozbUrXV0dyb5Rt/mvrYVy1sz3akHZYnoBX6bcXtjqo4=;
 b=c7dInngBq4gL/N0P9ugCfSs0qWePXixPgz/MMUNwau1+zwZTLBJ4OAuU
 HPN8qx0rUAEpXETxrOdzPxUboxQon8jgeoF9KMjOBK077pwzOAs5SlH92
 dOEsD9SdtS0axXQh/orGY9LijZYPM+3prFsnJpi60dLhTv+03DnlEuvxt
 HpW2qVLeQO6UQbQZB7ht5Ws0E8UCq3GFlPHrsMNncTSouFB850NtjUsZl
 RMHGj3JC3PsFz2a4SueGacADAxbdMU8miDQLnHsvNIcLIm1XWEJ8DO2w5
 fU9T3/DnSfhVcNmxjwqXYurrLtq4xkvLQDU/y1ehRR7XVfXbQHqlJQcka Q==;
Date: Tue, 7 Jul 2020 12:38:06 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200707103806.wlocq6aasbaf4pty@soft-dev3.localdomain>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
 <20200706091842.3324565-2-horatiu.vultur@microchip.com>
 <20200706.122626.2248567362397969247.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200706.122626.2248567362397969247.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH net-next 01/12] switchdev: mrp: Extend
 switchdev API for MRP Interconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

The 07/06/2020 12:26, David Miller wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Horatiu Vultur <horatiu.vultur@microchip.com>
> Date: Mon, 6 Jul 2020 11:18:31 +0200
> 
> > +/* SWITCHDEV_OBJ_ID_IN_TEST_MRP */
> > +struct switchdev_obj_in_test_mrp {
> > +     struct switchdev_obj obj;
> > +     /* The value is in us and a value of 0 represents to stop */
> > +     u32 interval;
> > +     u8 max_miss;
> > +     u32 in_id;
> > +     u32 period;
> > +};
>  ...
> > +#define SWITCHDEV_OBJ_IN_TEST_MRP(OBJ) \
> > +     container_of((OBJ), struct switchdev_obj_in_test_mrp, obj)
> > +
> > +/* SWICHDEV_OBJ_ID_IN_ROLE_MRP */
> > +struct switchdev_obj_in_role_mrp {
> > +     struct switchdev_obj obj;
> > +     u16 in_id;
> > +     u32 ring_id;
> > +     u8 in_role;
> > +     struct net_device *i_port;
> > +};
>  ...
> > +#define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
> > +     container_of((OBJ), struct switchdev_obj_in_role_mrp, obj)
> > +
> > +struct switchdev_obj_in_state_mrp {
> > +     struct switchdev_obj obj;
> > +     u8 in_state;
> > +     u32 in_id;
> > +};
> 
> Please arrange these structure members in a more optimal order so that
> the resulting object is denser.  For example, in switchdev_obj_in_role_mrp
> if you order it such that:
> 
> > +     u32 ring_id;
> > +     u16 in_id;
> > +     u8 in_role;
> 
> You'll have less wasted space from padding.
> 
> Use 'pahole' or similar tools to guide you.

Thanks, I will try to use 'pahole' and see how they need to be arranged.

-- 
/Horatiu
