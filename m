Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1600158568; x=1631694568;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fTwn5T1pKJoEK59ue7GNAJ2X0iCUowH1el/JpPlsyUU=;
 b=lQhjU+I+GdpllOf3d8j099orGe/okkaTrxVNPgdYD2PC7owKKNSAh11G
 +pkn2lCV1oSp24KlSn8ItsZWFEA0XXxJRrGta3/ZEDfgN1GFZDLSauUpR
 dgB4veDdbmsDiuhOzGZohzH4vFORPSQAidfZri/u89J6PlYxkCEMiDC+L
 uxWWFqFwTLJLkDbhzegHd+i2XhDp5enpOCMfkukY+2MBMaj3uheuPZ9mN
 AyuMRHoy4gc7n3dLkpR3glCDuUnfs8690ohSlQ55MuCISJLFb9OtLeUDq
 bdoEO+eO0Coqf5kVv5GEGwWR5aAiB9xXdy8sCjXBsaFm7CGixZr+tqE8p Q==;
Date: Tue, 15 Sep 2020 08:26:51 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20200915082651.4c5s734la37iqwfz@soft-test08>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
 <20200904091527.669109-3-henrik.bjoernlund@microchip.com>
 <e145b130ba56460ecf11318f9a4550d2637aa222.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e145b130ba56460ecf11318f9a4550d2637aa222.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH RFC 2/7] bridge: cfm: Add BRIDGE_CFM to Kconfig.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "idosch@mellanox.com" <idosch@mellanox.com>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Thanks for your review. I will update in the next version as suggested.

Regards
Henrik


The 09/08/2020 12:18, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-09-04 at 09:15 +0000, Henrik Bjoernlund wrote:
> > This makes it possible to include or exclude the CFM
> > protocol according to 802.1Q section 12.14.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > ---
> >  net/bridge/Kconfig      | 11 +++++++++++
> >  net/bridge/br_device.c  |  3 +++
> >  net/bridge/br_private.h |  3 +++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> > index 80879196560c..3c8ded7d3e84 100644
> > --- a/net/bridge/Kconfig
> > +++ b/net/bridge/Kconfig
> > @@ -73,3 +73,14 @@ config BRIDGE_MRP
> >         Say N to exclude this support and reduce the binary size.
> >
> >         If unsure, say N.
> > +
> > +config BRIDGE_CFM
> > +     bool "CFM protocol"
> > +     depends on BRIDGE
> > +     help
> > +       If you say Y here, then the Ethernet bridge will be able to run CFM
> > +       protocol according to 802.1Q section 12.14
> > +
> > +       Say N to exclude this support and reduce the binary size.
> > +
> > +       If unsure, say N.
> > diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> > index a9232db03108..d12f5626a4b1 100644
> > --- a/net/bridge/br_device.c
> > +++ b/net/bridge/br_device.c
> > @@ -476,6 +476,9 @@ void br_dev_setup(struct net_device *dev)
> >       INIT_LIST_HEAD(&br->ftype_list);
> >  #if IS_ENABLED(CONFIG_BRIDGE_MRP)
> >       INIT_LIST_HEAD(&br->mrp_list);
> > +#endif
> > +#if IS_ENABLED(CONFIG_BRIDGE_CFM)
> > +     INIT_LIST_HEAD(&br->mep_list);
> >  #endif
> >       spin_lock_init(&br->hash_lock);
> >
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index e67c6d9e8bea..6294a3e51a33 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -445,6 +445,9 @@ struct net_bridge {
> >  #if IS_ENABLED(CONFIG_BRIDGE_MRP)
> >       struct list_head                mrp_list;
> >  #endif
> > +#if IS_ENABLED(CONFIG_BRIDGE_CFM)
> > +     struct list_head                mep_list;
> > +#endif
> >  };
> >
> >  struct br_input_skb_cb {
> 
> Looks good, perhaps also can use hlist to reduce the head size in net_bridge.
> 

-- 
/Henrik
