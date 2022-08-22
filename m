Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C03CC4067F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D9BD404EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=ljiH/9iMaSmij9A6AuMu4EyJi/jE3vRczSUudHqS65c=;
 b=l6PAeGmV4hFItThxnChsi9nE3C/craoYZbja1513x57zqWmFoke/zIma3Ff9nVqxDD
 ULJnSnvjMPIRPwRnUbco+cUdXfAFycWmBMdOQB8Kom9nskzjojGZlIvlAytAUEl3FCnX
 E+bJgz3/66nm6gJnWchgOqsLcG9rtGIu3eg85KfItlohbuhiUrWeZR5DuPb3NKs2o9r4
 FRyGocIwg9g97i7q9tO0+IwdiBvC2bLXLLQZ4IkeX2pVsn3IIDzPftStKA54SeViGCZ1
 eFSWSm5k4TPvxwm4QfH4bVcDYPCwkt9+cJCZ814sUcCqJukFe0+nSdf51hMUg9bLhmrY
 zVCw==
MIME-Version: 1.0
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK4Mo2KHfa-6Z4Ka+ZLx8TtmzSvq9CLmMmEwE5S7Yp7-Kw@mail.gmail.com>
 <34228958-081d-52b5-f363-d2df6ecf251d@blackwall.org>
 <CAMWRUK43+NG63J2YCiKijREjUg5zjii=_2knN6ZCL6PHMP3q8w@mail.gmail.com>
 <46deef15-a67b-91ad-bc47-1b1306d1d654@blackwall.org>
 <CAMWRUK6BQpABuutUwaX36rmQsfuJShQbDjyjSdfDawrQ=pcvaA@mail.gmail.com>
 <601ac27e-b1b1-43c0-34fd-15cdc2224d85@blackwall.org>
In-Reply-To: <601ac27e-b1b1-43c0-34fd-15cdc2224d85@blackwall.org>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Mon, 22 Aug 2022 19:18:52 -0400
Message-ID: <CAMWRUK4J_-siQTrObifPvfLE4CEXAYme6+6JqpR3+qsr5E0-kQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000072b53b05e6dcac19"
Subject: Re: [Bridge] [PATCH RFC net-next 0/3] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

--00000000000072b53b05e6dcac19
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 22, 2022 at 4:01 AM Nikolay Aleksandrov <razor@blackwall.org>
wrote:

> On 20/08/2022 14:33, Sevinj Aghayeva wrote:
> > On Thu, Aug 18, 2022 at 8:00 AM Nikolay Aleksandrov <razor@blackwall.org>
> wrote:
> >>
> >> On 18/08/2022 14:50, Sevinj Aghayeva wrote:
> [snip]
> >>
> >> Hi,
> >> Handling all vlan device-related changes in br_vlan_device_event()
> sounds good to me.
> >> Please add it to br_vlan.c.
> >
> > Hi Nik,
> >
> > Can you please review this diff before I make it into a proper patchset?
> Thanks!
> >
>
> Hi,
> A few comments inline below, but in general when you prepare the rfc
> commit please
> explain the motivation in detail why this way was chosen and a new
> notification type
> is needed (e.g. why not use NETDEV_CHANGEINFODATA or extend NETDEV_CHANGE).
> As I mentioned earlier it'd be nice to get feedback from others about
> adding this
> new notification, so they should know the "why" in detail.
>

Sure, I will do that in the RFC patchset, but first I want to make sure I
got the details right before making the RFC patchset. Thanks for the
feedback. Please see inline.

>
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 2563d30736e9..0ce3da42325e 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2762,6 +2762,7 @@ enum netdev_cmd {
> >   NETDEV_UNREGISTER,
> >   NETDEV_CHANGEMTU, /* notify after mtu change happened */
> >   NETDEV_CHANGEADDR, /* notify after the address change */
> > + NETDEV_CHANGE_DETAILS,
> >   NETDEV_PRE_CHANGEADDR, /* notify before the address change */
> >   NETDEV_GOING_DOWN,
> >   NETDEV_CHANGENAME,
> > @@ -2837,6 +2838,13 @@ struct netdev_notifier_changelowerstate_info {
> >   void *lower_state_info; /* is lower dev state */
> >  };
> >
> > +struct netdev_notifier_change_details_info {
> > + struct netdev_notifier_info info; /* must be first */
> > + union {
> > + bool bridge_binding;
>
> this should be in a vlan-specific structure, defined in if_vlan.h
> every other link type which wants to use the notification would define its
> own struct type
>

Okay, will move it there.


>
> > + } details;
> > +};
> > +
> >  struct netdev_notifier_pre_changeaddr_info {
> >   struct netdev_notifier_info info; /* must be first */
> >   const unsigned char *dev_addr;
> > @@ -3836,6 +3844,8 @@ int __dev_set_mtu(struct net_device *, int);
> >  int dev_set_mtu(struct net_device *, int);
> >  int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
> >         struct netlink_ext_ack *extack);
> > +int dev_change_details_notify(struct net_device *dev, bool
> bridge_binding,
> > +       struct netlink_ext_ack *extack);
>
> this helper is not needed


> >  int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> >   struct netlink_ext_ack *extack);
> >  int dev_set_mac_address_user(struct net_device *dev, struct sockaddr
> *sa,
> > diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
> > index 5eaf38875554..71947cdcfaaa 100644
> > --- a/net/8021q/vlan.h
> > +++ b/net/8021q/vlan.h
> > @@ -130,7 +130,7 @@ void vlan_dev_set_ingress_priority(const struct
> > net_device *dev,
> >  int vlan_dev_set_egress_priority(const struct net_device *dev,
> >   u32 skb_prio, u16 vlan_prio);
> >  void vlan_dev_free_egress_priority(const struct net_device *dev);
> > -int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32
> mask);
> > +int vlan_dev_change_flags(struct net_device *dev, u32 flag, u32 mask);
> >  void vlan_dev_get_realdev_name(const struct net_device *dev, char
> *result,
> >          size_t size);
> >
> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> > index 839f2020b015..489baa8435de 100644
> > --- a/net/8021q/vlan_dev.c
> > +++ b/net/8021q/vlan_dev.c
> > @@ -211,7 +211,7 @@ int vlan_dev_set_egress_priority(const struct
> > net_device *dev,
> >  /* Flags are defined in the vlan_flags enum in
> >   * include/uapi/linux/if_vlan.h file.
> >   */
> > -int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32
> mask)
> > +int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask)
>
> please don't remove the const, this function shouldn't change dev's struct
>

I tried not to remove const, but it seems impossible because
call_netdevice_notifiers_info that we eventually call from
vlan_dev_change_flags takes a non-const struct info that has a dev field
being set from the const vlan_dev_change_flags.


>
> >  {
> >   struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> >   u32 old_flags = vlan->flags;
> > @@ -223,19 +223,29 @@ int vlan_dev_change_flags(const struct
> > net_device *dev, u32 flags, u32 mask)
> >
> >   vlan->flags = (old_flags & ~mask) | (flags & mask);
> >
> > - if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
> > + if (!netif_running(dev))
> > + return 0;
> > +
> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
> >   if (vlan->flags & VLAN_FLAG_GVRP)
> >   vlan_gvrp_request_join(dev);
> >   else
> >   vlan_gvrp_request_leave(dev);
> >   }
> >
> > - if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
> >   if (vlan->flags & VLAN_FLAG_MVRP)
> >   vlan_mvrp_request_join(dev);
> >   else
> >   vlan_mvrp_request_leave(dev);
> >   }
> > +
> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
> > +     netif_is_bridge_master(vlan->real_dev)) {
> > + dev_change_details_notify(dev,
> > +     !!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING), NULL);
>
> this helper is not needed, just fill in the details here and send the
> notification
>
>
Okay, in that case I will need to export call_netdevice_notifiers_info so
that I can call it from here.

> + }
> > +
> >   return 0;
> >  }
> >
> > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > index 96e91d69a9a8..62e939c6a3f0 100644
> > --- a/net/bridge/br.c
> > +++ b/net/bridge/br.c
> > @@ -51,6 +51,11 @@ static int br_device_event(struct notifier_block
> > *unused, unsigned long event, v
> >   }
> >   }
> >
> > + if (is_vlan_dev(dev)) {
> > + br_vlan_device_event(dev, event, ptr);
> > + return NOTIFY_DONE;
> > + }
> > +
> >   /* not a port of a bridge */
> >   p = br_port_get_rtnl(dev);
> >   if (!p)
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index 06e5f6faa431..a9a08e49c76c 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -1470,6 +1470,8 @@ void br_vlan_get_stats(const struct
> net_bridge_vlan *v,
> >  void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
> >  int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
> >   void *ptr);
> > +void br_vlan_device_event(struct net_device *dev, unsigned long event,
> > +   void *ptr);
> >  void br_vlan_rtnl_init(void);
> >  void br_vlan_rtnl_uninit(void);
> >  void br_vlan_notify(const struct net_bridge *br,
> > @@ -1701,6 +1703,11 @@ static inline int br_vlan_bridge_event(struct
> > net_device *dev,
> >   return 0;
> >  }
> >
> > +static void br_vlan_device_event(struct net_device *dev,
> > + unsigned long event, void *ptr)
> > +{
> > +}
> > +
> >  static inline void br_vlan_rtnl_init(void)
> >  {
> >  }
> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> > index 0f5e75ccac79..70a9950df175 100644
> > --- a/net/bridge/br_vlan.c
> > +++ b/net/bridge/br_vlan.c
> > @@ -1768,6 +1768,20 @@ void br_vlan_port_event(struct net_bridge_port
> > *p, unsigned long event)
> >   }
> >  }
> >
> > +void br_vlan_device_event(struct net_device *dev, unsigned long
> > event, void *ptr)
> > +{
> > + struct netdev_notifier_change_details_info *info;
> > + struct net_device *br_dev;
> > +
> > + switch (event) {
> > + case NETDEV_CHANGE_DETAILS:
> > + info = ptr;
> > + br_dev = vlan_dev_priv(dev)->real_dev;
>
> you're not guaranteed to have a bridge device as its real_dev, so you
> should
> validate that the vlan's real dev is a bridge
>

Okay, will do.


>
> > + br_vlan_upper_change(br_dev, dev, info->details.bridge_binding);
> > + break;
> > + }
> > +}
> > +
> >  static bool br_vlan_stats_fill(struct sk_buff *skb,
> >          const struct net_bridge_vlan *v)
> >  {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 30a1603a7225..dcdbc625585d 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1624,7 +1624,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
> >   N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER)
> >   N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING_INFO)
> >   N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_INFO)
> > - N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)
> > + N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)
> >   N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)
> >   N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
> >   N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
> > @@ -8767,6 +8767,27 @@ int dev_pre_changeaddr_notify(struct net_device
> > *dev, const char *addr,
> >  }
> >  EXPORT_SYMBOL(dev_pre_changeaddr_notify);
> >
> > +/**
> > + * dev_change_details_notify - Call NETDEV_PRE_CHANGE_DETAILS.
> > + * @dev: device
> > + * @bridge_binding: bridge binding setting
> > + * @extack: netlink extended ack
> > + */
> > +int dev_change_details_notify(struct net_device *dev, bool
> bridge_binding,
> > +       struct netlink_ext_ack *extack)
> > +{
> > + struct netdev_notifier_change_details_info info = {
> > + .info.dev = dev,
> > + .info.extack = extack,
> > + .details.bridge_binding = bridge_binding,
> > + };
> > + int rc;
> > +
> > + rc = call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS, &info.info);
> > + return notifier_to_errno(rc);
> > +}
> > +EXPORT_SYMBOL(dev_change_details_notify);
> > +
>
> this helper is unnecessary, just fill in the struct at the caller site and
> send the notification directly
>

Okay, will remove it.

Thanks for the review! I will send the updated patch soon.

>
> >  /**
> >   * dev_set_mac_address - Change Media Access Control Address
> >   * @dev: device
> >
> >
> >>
> >> Thanks,
> >>  Nik
> >>
> >>
>
> Cheers,
>  Nik
>
>
>

-- 

Sevinj.Aghayeva

--00000000000072b53b05e6dcac19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 22, 2022 at 4:01 AM Nikol=
ay Aleksandrov &lt;<a href=3D"mailto:razor@blackwall.org">razor@blackwall.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 20/08/2022 14:33, Sevinj Aghayeva wrote:<br>
&gt; On Thu, Aug 18, 2022 at 8:00 AM Nikolay Aleksandrov &lt;<a href=3D"mai=
lto:razor@blackwall.org" target=3D"_blank">razor@blackwall.org</a>&gt; wrot=
e:<br>
&gt;&gt;<br>
&gt;&gt; On 18/08/2022 14:50, Sevinj Aghayeva wrote:<br>
[snip]<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt; Handling all vlan device-related changes in br_vlan_device_event()=
 sounds good to me.<br>
&gt;&gt; Please add it to br_vlan.c.<br>
&gt; <br>
&gt; Hi Nik,<br>
&gt; <br>
&gt; Can you please review this diff before I make it into a proper patchse=
t? Thanks!<br>
&gt; <br>
<br>
Hi,<br>
A few comments inline below, but in general when you prepare the rfc commit=
 please<br>
explain the motivation in detail why this way was chosen and a new notifica=
tion type<br>
is needed (e.g. why not use NETDEV_CHANGEINFODATA or extend NETDEV_CHANGE).=
<br>
As I mentioned earlier it&#39;d be nice to get feedback from others about a=
dding this<br>
new notification, so they should know the &quot;why&quot; in detail.<br></b=
lockquote><div><br></div><div>Sure, I will do that in the RFC patchset, but=
 first I want to make sure I got the details right before making the RFC pa=
tchset. Thanks for the feedback. Please see inline.=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h<br>
&gt; index 2563d30736e9..0ce3da42325e 100644<br>
&gt; --- a/include/linux/netdevice.h<br>
&gt; +++ b/include/linux/netdevice.h<br>
&gt; @@ -2762,6 +2762,7 @@ enum netdev_cmd {<br>
&gt;=C2=A0 =C2=A0NETDEV_UNREGISTER,<br>
&gt;=C2=A0 =C2=A0NETDEV_CHANGEMTU, /* notify after mtu change happened */<b=
r>
&gt;=C2=A0 =C2=A0NETDEV_CHANGEADDR, /* notify after the address change */<b=
r>
&gt; + NETDEV_CHANGE_DETAILS,<br>
&gt;=C2=A0 =C2=A0NETDEV_PRE_CHANGEADDR, /* notify before the address change=
 */<br>
&gt;=C2=A0 =C2=A0NETDEV_GOING_DOWN,<br>
&gt;=C2=A0 =C2=A0NETDEV_CHANGENAME,<br>
&gt; @@ -2837,6 +2838,13 @@ struct netdev_notifier_changelowerstate_info {<=
br>
&gt;=C2=A0 =C2=A0void *lower_state_info; /* is lower dev state */<br>
&gt;=C2=A0 };<br>
&gt; <br>
&gt; +struct netdev_notifier_change_details_info {<br>
&gt; + struct netdev_notifier_info info; /* must be first */<br>
&gt; + union {<br>
&gt; + bool bridge_binding;<br>
<br>
this should be in a vlan-specific structure, defined in if_vlan.h<br>
every other link type which wants to use the notification would define its<=
br>
own struct type<br></blockquote><div><br></div><div>Okay, will move it ther=
e.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; + } details;<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 struct netdev_notifier_pre_changeaddr_info {<br>
&gt;=C2=A0 =C2=A0struct netdev_notifier_info info; /* must be first */<br>
&gt;=C2=A0 =C2=A0const unsigned char *dev_addr;<br>
&gt; @@ -3836,6 +3844,8 @@ int __dev_set_mtu(struct net_device *, int);<br>
&gt;=C2=A0 int dev_set_mtu(struct net_device *, int);<br>
&gt;=C2=A0 int dev_pre_changeaddr_notify(struct net_device *dev, const char=
 *addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack);<br>
&gt; +int dev_change_details_notify(struct net_device *dev, bool bridge_bin=
ding,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack);<br>
<br>
this helper is not needed=C2=A0</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt;=C2=A0 int dev_set_mac_address(struct net_device *dev, struct sockaddr =
*sa,<br>
&gt;=C2=A0 =C2=A0struct netlink_ext_ack *extack);<br>
&gt;=C2=A0 int dev_set_mac_address_user(struct net_device *dev, struct sock=
addr *sa,<br>
&gt; diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h<br>
&gt; index 5eaf38875554..71947cdcfaaa 100644<br>
&gt; --- a/net/8021q/vlan.h<br>
&gt; +++ b/net/8021q/vlan.h<br>
&gt; @@ -130,7 +130,7 @@ void vlan_dev_set_ingress_priority(const struct<br=
>
&gt; net_device *dev,<br>
&gt;=C2=A0 int vlan_dev_set_egress_priority(const struct net_device *dev,<b=
r>
&gt;=C2=A0 =C2=A0u32 skb_prio, u16 vlan_prio);<br>
&gt;=C2=A0 void vlan_dev_free_egress_priority(const struct net_device *dev)=
;<br>
&gt; -int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32=
 mask);<br>
&gt; +int vlan_dev_change_flags(struct net_device *dev, u32 flag, u32 mask)=
;<br>
&gt;=C2=A0 void vlan_dev_get_realdev_name(const struct net_device *dev, cha=
r *result,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size);<br>
&gt; <br>
&gt; diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c<br>
&gt; index 839f2020b015..489baa8435de 100644<br>
&gt; --- a/net/8021q/vlan_dev.c<br>
&gt; +++ b/net/8021q/vlan_dev.c<br>
&gt; @@ -211,7 +211,7 @@ int vlan_dev_set_egress_priority(const struct<br>
&gt; net_device *dev,<br>
&gt;=C2=A0 /* Flags are defined in the vlan_flags enum in<br>
&gt;=C2=A0 =C2=A0* include/uapi/linux/if_vlan.h file.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u3=
2 mask)<br>
&gt; +int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask=
)<br>
<br>
please don&#39;t remove the const, this function shouldn&#39;t change dev&#=
39;s struct<br></blockquote><div><br></div><div>I tried not to remove const=
, but it seems impossible because call_netdevice_notifiers_info that we eve=
ntually call from vlan_dev_change_flags takes a non-const struct info that =
has a dev field being set from the const vlan_dev_change_flags.=C2=A0</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);<br>
&gt;=C2=A0 =C2=A0u32 old_flags =3D vlan-&gt;flags;<br>
&gt; @@ -223,19 +223,29 @@ int vlan_dev_change_flags(const struct<br>
&gt; net_device *dev, u32 flags, u32 mask)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0vlan-&gt;flags =3D (old_flags &amp; ~mask) | (flags &amp; =
mask);<br>
&gt; <br>
&gt; - if (netif_running(dev) &amp;&amp; (vlan-&gt;flags ^ old_flags) &amp;=
 VLAN_FLAG_GVRP) {<br>
&gt; + if (!netif_running(dev))<br>
&gt; + return 0;<br>
&gt; +<br>
&gt; + if ((vlan-&gt;flags ^ old_flags) &amp; VLAN_FLAG_GVRP) {<br>
&gt;=C2=A0 =C2=A0if (vlan-&gt;flags &amp; VLAN_FLAG_GVRP)<br>
&gt;=C2=A0 =C2=A0vlan_gvrp_request_join(dev);<br>
&gt;=C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0vlan_gvrp_request_leave(dev);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; - if (netif_running(dev) &amp;&amp; (vlan-&gt;flags ^ old_flags) &amp;=
 VLAN_FLAG_MVRP) {<br>
&gt; + if ((vlan-&gt;flags ^ old_flags) &amp; VLAN_FLAG_MVRP) {<br>
&gt;=C2=A0 =C2=A0if (vlan-&gt;flags &amp; VLAN_FLAG_MVRP)<br>
&gt;=C2=A0 =C2=A0vlan_mvrp_request_join(dev);<br>
&gt;=C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0vlan_mvrp_request_leave(dev);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + if ((vlan-&gt;flags ^ old_flags) &amp; VLAN_FLAG_BRIDGE_BINDING &amp=
;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0netif_is_bridge_master(vlan-&gt;real_dev)) {<br>
&gt; + dev_change_details_notify(dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0!!(vlan-&gt;flags &amp; VLAN_FLAG_BRIDGE_BINDING)=
, NULL);<br>
<br>
this helper is not needed, just fill in the details here and send the notif=
ication<br>
<br></blockquote><br class=3D"gmail-Apple-interchange-newline"><div>Okay, i=
n that case I will need to export=C2=A0call_netdevice_notifiers_info so tha=
t I can call it from here.</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt; + }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; diff --git a/net/bridge/br.c b/net/bridge/br.c<br>
&gt; index 96e91d69a9a8..62e939c6a3f0 100644<br>
&gt; --- a/net/bridge/br.c<br>
&gt; +++ b/net/bridge/br.c<br>
&gt; @@ -51,6 +51,11 @@ static int br_device_event(struct notifier_block<br=
>
&gt; *unused, unsigned long event, v<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; + if (is_vlan_dev(dev)) {<br>
&gt; + br_vlan_device_event(dev, event, ptr);<br>
&gt; + return NOTIFY_DONE;<br>
&gt; + }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* not a port of a bridge */<br>
&gt;=C2=A0 =C2=A0p =3D br_port_get_rtnl(dev);<br>
&gt;=C2=A0 =C2=A0if (!p)<br>
&gt; diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h<br>
&gt; index 06e5f6faa431..a9a08e49c76c 100644<br>
&gt; --- a/net/bridge/br_private.h<br>
&gt; +++ b/net/bridge/br_private.h<br>
&gt; @@ -1470,6 +1470,8 @@ void br_vlan_get_stats(const struct net_bridge_v=
lan *v,<br>
&gt;=C2=A0 void br_vlan_port_event(struct net_bridge_port *p, unsigned long=
 event);<br>
&gt;=C2=A0 int br_vlan_bridge_event(struct net_device *dev, unsigned long e=
vent,<br>
&gt;=C2=A0 =C2=A0void *ptr);<br>
&gt; +void br_vlan_device_event(struct net_device *dev, unsigned long event=
,<br>
&gt; +=C2=A0 =C2=A0void *ptr);<br>
&gt;=C2=A0 void br_vlan_rtnl_init(void);<br>
&gt;=C2=A0 void br_vlan_rtnl_uninit(void);<br>
&gt;=C2=A0 void br_vlan_notify(const struct net_bridge *br,<br>
&gt; @@ -1701,6 +1703,11 @@ static inline int br_vlan_bridge_event(struct<b=
r>
&gt; net_device *dev,<br>
&gt;=C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +static void br_vlan_device_event(struct net_device *dev,<br>
&gt; + unsigned long event, void *ptr)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static inline void br_vlan_rtnl_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c<br>
&gt; index 0f5e75ccac79..70a9950df175 100644<br>
&gt; --- a/net/bridge/br_vlan.c<br>
&gt; +++ b/net/bridge/br_vlan.c<br>
&gt; @@ -1768,6 +1768,20 @@ void br_vlan_port_event(struct net_bridge_port<=
br>
&gt; *p, unsigned long event)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +void br_vlan_device_event(struct net_device *dev, unsigned long<br>
&gt; event, void *ptr)<br>
&gt; +{<br>
&gt; + struct netdev_notifier_change_details_info *info;<br>
&gt; + struct net_device *br_dev;<br>
&gt; +<br>
&gt; + switch (event) {<br>
&gt; + case NETDEV_CHANGE_DETAILS:<br>
&gt; + info =3D ptr;<br>
&gt; + br_dev =3D vlan_dev_priv(dev)-&gt;real_dev;<br>
<br>
you&#39;re not guaranteed to have a bridge device as its real_dev, so you s=
hould<br>
validate that the vlan&#39;s real dev is a bridge<br></blockquote><div><br>=
</div><div>Okay, will do.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; + br_vlan_upper_change(br_dev, dev, info-&gt;details.bridge_binding);<=
br>
&gt; + break;<br>
&gt; + }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static bool br_vlan_stats_fill(struct sk_buff *skb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct net_bridge_vlan *v)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/net/core/dev.c b/net/core/dev.c<br>
&gt; index 30a1603a7225..dcdbc625585d 100644<br>
&gt; --- a/net/core/dev.c<br>
&gt; +++ b/net/core/dev.c<br>
&gt; @@ -1624,7 +1624,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd c=
md)<br>
&gt;=C2=A0 =C2=A0N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUP=
PER)<br>
&gt;=C2=A0 =C2=A0N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING=
_INFO)<br>
&gt;=C2=A0 =C2=A0N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_IN=
FO)<br>
&gt; - N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)<br>
&gt; + N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)<br>
&gt;=C2=A0 =C2=A0N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)<br>
&gt;=C2=A0 =C2=A0N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)<br>
&gt;=C2=A0 =C2=A0N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTAT=
S_DISABLE)<br>
&gt; @@ -8767,6 +8767,27 @@ int dev_pre_changeaddr_notify(struct net_device=
<br>
&gt; *dev, const char *addr,<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 EXPORT_SYMBOL(dev_pre_changeaddr_notify);<br>
&gt; <br>
&gt; +/**<br>
&gt; + * dev_change_details_notify - Call NETDEV_PRE_CHANGE_DETAILS.<br>
&gt; + * @dev: device<br>
&gt; + * @bridge_binding: bridge binding setting<br>
&gt; + * @extack: netlink extended ack<br>
&gt; + */<br>
&gt; +int dev_change_details_notify(struct net_device *dev, bool bridge_bin=
ding,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct netlink_ext_ack *extack)<br>
&gt; +{<br>
&gt; + struct netdev_notifier_change_details_info info =3D {<br>
&gt; + .<a href=3D"http://info.dev" rel=3D"noreferrer" target=3D"_blank">in=
fo.dev</a> =3D dev,<br>
&gt; + .info.extack =3D extack,<br>
&gt; + .details.bridge_binding =3D bridge_binding,<br>
&gt; + };<br>
&gt; + int rc;<br>
&gt; +<br>
&gt; + rc =3D call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS, &amp;<a =
href=3D"http://info.info" rel=3D"noreferrer" target=3D"_blank">info.info</a=
>);<br>
&gt; + return notifier_to_errno(rc);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(dev_change_details_notify);<br>
&gt; +<br>
<br>
this helper is unnecessary, just fill in the struct at the caller site and<=
br>
send the notification directly<br></blockquote><div><br></div><div>Okay, wi=
ll remove it.</div><div><br></div><div>Thanks for the review! I will send t=
he updated patch soon.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* dev_set_mac_address - Change Media Access Control Addres=
s<br>
&gt;=C2=A0 =C2=A0* @dev: device<br>
&gt; <br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;=C2=A0 Nik<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
Cheers,<br>
=C2=A0Nik<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div><div>Sevinj.Agha=
yeva</div></div></div></div>

--00000000000072b53b05e6dcac19--
