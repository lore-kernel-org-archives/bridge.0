Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590082255; x=1621618255;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Jy/N3rXBqaPkEkb9eg+3JzspSpEQo1U1nxztCbeYZ9U=;
 b=ULbE8NFEXrtZAeYWavM34nGAjZQL2VJIlOZuhwnAAFtnvEDjSnjoX/Z4
 nHaWe6KBzWLIgiJnm2cyuOWhxoi89ejNUTyVv2q2Tqd6kSQ3+ym22Fflb
 lrqXvlACL5wRZrxMdmaVkeVBocGDaaZx8VzEmVTS4oHLNxIaDJDwPsHyW
 R7gqFjC6UDRnrZVNK8xAIeftUv7Yjzt3IZ/IkyNP/0TbqWChls/63erVj
 vO1nOlgzhlwc5ZEy82P+5sGClM6/k5XPTsC73EKE+iv1wnc13Dju8ttSD
 sHZwPGSRaL4tDpWurU74bhOKPeP2+8U8SxLl6ef+Q7sNcQM8U4dpBZ4Fr w==;
Date: Thu, 21 May 2020 19:30:33 +0000
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200521193033.3f553xieh2a7eapl@soft-dev3.localdomain>
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-2-horatiu.vultur@microchip.com>
 <cecbdbf0-bb49-1e3c-c163-8e7412c6fcec@cumulusnetworks.com>
 <20200521181337.ory6lxyswatqhoej@soft-dev3.localdomain>
 <39ba5110-2c2a-6fd9-a3e3-000b52a366dc@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <39ba5110-2c2a-6fd9-a3e3-000b52a366dc@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH 1/3] bridge: mrp: Add br_mrp_unique_ifindex
	function
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

The 05/21/2020 19:58, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 21/05/2020 21:49, Horatiu Vultur wrote:
> > The 05/21/2020 11:16, Nikolay Aleksandrov wrote:
> >> On 20/05/2020 16:09, Horatiu Vultur wrote:
> >>> It is not allow to have the same net bridge port part of multiple MRP
> >>> rings. Therefore add a check if the port is used already in a different
> >>> MRP. In that case return failure.
> >>>
> >>> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
> >>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> >>> ---
> >>>  net/bridge/br_mrp.c | 31 +++++++++++++++++++++++++++++++
> >>>  1 file changed, 31 insertions(+)
> >>>
> >>> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> >>> index d7bc09de4c139..a5a3fa59c078a 100644
> >>> --- a/net/bridge/br_mrp.c
> >>> +++ b/net/bridge/br_mrp.c
> >>> @@ -37,6 +37,32 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
> >>>       return res;
> >>>  }
> >>>
> >>> +static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
> >>> +{
> >>> +     struct br_mrp *mrp;
> >>> +     bool res = true;
> >>> +
> >>> +     rcu_read_lock();
> >>
> >> Why do you need the rcu_read_lock() here when lockdep_rtnl_is_held() is used?
> >> You should be able to just do rtnl_dereference() below as this is used only
> >> under rtnl.
> >
> > Hi Nik,
> >
> > Also initially I thought that is not needed, but when I enabled all the
> > RCU debug configs to see if I use correctly the RCU, I got a warning
> > regarding suspicious RCU usage.
> > And that is the reason why I have put it.
> >
> 
> Did you try using rtnl_dereference() instead of rcu_dereference() ?

I have just tried it now and that seems to work fine.
I will redo the patch and send a new patch series.

> 
> >>
> >>> +     list_for_each_entry_rcu(mrp, &br->mrp_list, list,
> >>> +                             lockdep_rtnl_is_held()) {
> >>> +             struct net_bridge_port *p;
> >>> +
> >>> +             p = rcu_dereference(mrp->p_port);
> >>> +             if (p && p->dev->ifindex == ifindex) {
> >>> +                     res = false;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             p = rcu_dereference(mrp->s_port);
> >>> +             if (p && p->dev->ifindex == ifindex) {
> >>> +                     res = false;
> >>> +                     break;
> >>> +             }
> >>> +     }
> >>> +     rcu_read_unlock();
> >>> +     return res;
> >>> +}
> >>> +
> >>>  static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
> >>>                                      struct net_bridge_port *p)
> >>>  {
> >>> @@ -255,6 +281,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
> >>>           !br_mrp_get_port(br, instance->s_ifindex))
> >>>               return -EINVAL;
> >>>
> >>> +     /* It is not possible to have the same port part of multiple rings */
> >>> +     if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
> >>> +         !br_mrp_unique_ifindex(br, instance->s_ifindex))
> >>> +             return -EINVAL;
> >>> +
> >>>       mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
> >>>       if (!mrp)
> >>>               return -ENOMEM;
> >>>
> >>
> >
> 

-- 
/Horatiu
