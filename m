Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587223751; x=1618759751;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6TbKFtDMJl3rttAHpd29hde3tTCeTElBmhYZKfSkNuc=;
 b=jAYMsp+Gz2sxxW/3UY8u03kDygJxxBqt4Kkxiy/yt6Wg/oa47/jMb2du
 jg9EfFEDWOMu6F3Pu3kUeLiDXvjgBl/1JKnQQ9jblEvtkjLLZ1uSImKWG
 f2/pTLhRzaF+smUebDiySl+asB7EKNv15Ix8HPfa7oKTdhh7OmMWGK55F
 bPwnO0hwu05AP9vhyAdZkie9D6SNoAHiH4kgOzlLGmStPufduxq57/VtY
 +Xi1a9xMZsIradcRPs/DhZW9K93u/5nnpbR41nd15cHRVrneb66xCJU7X
 Klgxwh6e2YB+2DuZf+0gGOUQVPoQ+ToZnepUNBEaA7KMJiwe/2JwKQqZ1 w==;
Date: Sat, 18 Apr 2020 17:29:08 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200418152908.ifaszlvmp5htr3x7@soft-dev3.microsemi.net>
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-4-horatiu.vultur@microchip.com>
 <2b387697-0e4c-7d8a-ae52-d1e8ce1f6bf4@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2b387697-0e4c-7d8a-ae52-d1e8ce1f6bf4@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next v5 3/9] bridge: mrp: Expose function
 br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

The 04/18/2020 11:11, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 14/04/2020 14:26, Horatiu Vultur wrote:
> > In case the HW is capable to detect when the MRP ring is open or closed. It is
> > expected that the network driver will notify the SW that the ring is open or
> > closed.
> >
> > The function br_mrp_port_open is used to notify the kernel that one of the ports
> > stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
> > the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/linux/mrp_bridge.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 include/linux/mrp_bridge.h
> >
> > diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
> > new file mode 100644
> > index 000000000000..23d46b356263
> > --- /dev/null
> > +++ b/include/linux/mrp_bridge.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +#ifndef _LINUX_MRP_BRIDGE_H
> > +#define _LINUX_MRO_BRIDGE_H
> > +
> > +#include <linux/netdevice.h>
> > +
> > +/* The drivers are responsible to call this function when it detects that the
> > + * MRP port stopped receiving MRP_Test frames or it started to receive MRP_Test.
> > + * The argument dev represents the port and loc(Lost of Continuity) has a value
> > + * of 1 when it stopped receiving MRP_Test frames and a value of 0 when it
> > + * started to receive frames.
> > + *
> > + * This eventually notify the userspace which is required to react on these
> > + * changes.
> > + */
> > +
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +int br_mrp_port_open(struct net_device *dev, u8 loc);
> > +#else
> > +inline int br_mrp_port_open(struct net_device *dev, u8 loc)  {}
> 
> static and put {} on their own, check how such functions are defined in other places (e.g. br_private.h)
> but in general I think you can drop this function favor of br_ifinfo_notify(). More about that in my review
> of next patches.

I have seen the other reviews but I am not sure I can completly drop
this function. I can have this function as a small wrapper over
br_ifinfo_notify.  The reason is that I want that also the drivers to be
able to notify when a port get lost of continuity.

> 
> > +#endif
> > +
> > +#endif
> >
> 

-- 
/Horatiu
