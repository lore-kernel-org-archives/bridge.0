Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F55560B24
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7875760B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=0ArL2S4KtYcSA1bhc/weN5Gx5iI4tg9WM82N3TX5aEw=;
 b=g6Dp6MXEDHLjpoZhwkOZgnFoTuRXR76kW64BXsL8B4QtqaKHH8C1TGlIohpDOFyDMe
 5bwtsEpq4hY1QmlFsoS2rTu7rd6GJOVXkEpEWeSoSwjeBuq23ywZ2iGo44/7soJnt1hr
 ROlwqpiHlKlALHsqqGtC7/VesRVcBsqUo7F7GoE847s4uYR1tyCDSjEsWqKN6GDdZ38L
 H4VftDuEHzQbRWyHJVzOLdqwFgt6X4suau20uMCb6u31a38AVSk9zK5cP1INveSwSAxl
 2YGD7xu7b4w6pCbCyEmWxtAwPKlaWDRT8AzwA5sjoLXLgFwfcJ2rCHL7V9V5acYs1pVM
 ffDA==
MIME-Version: 1.0
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
 <CAMWRUK4Mo2KHfa-6Z4Ka+ZLx8TtmzSvq9CLmMmEwE5S7Yp7-Kw@mail.gmail.com>
 <34228958-081d-52b5-f363-d2df6ecf251d@blackwall.org>
 <CAMWRUK43+NG63J2YCiKijREjUg5zjii=_2knN6ZCL6PHMP3q8w@mail.gmail.com>
 <46deef15-a67b-91ad-bc47-1b1306d1d654@blackwall.org>
 <CAMWRUK6BQpABuutUwaX36rmQsfuJShQbDjyjSdfDawrQ=pcvaA@mail.gmail.com>
 <601ac27e-b1b1-43c0-34fd-15cdc2224d85@blackwall.org>
 <CAMWRUK4J_-siQTrObifPvfLE4CEXAYme6+6JqpR3+qsr5E0-kQ@mail.gmail.com>
In-Reply-To: <CAMWRUK4J_-siQTrObifPvfLE4CEXAYme6+6JqpR3+qsr5E0-kQ@mail.gmail.com>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Mon, 29 Aug 2022 16:22:07 -0400
Message-ID: <CAMWRUK7_w+TLvLBN-tR+f7ygF=Bu9MqY=PQFABA+CsQChGTfTg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003f16ab05e7670576"
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

--0000000000003f16ab05e7670576
Content-Type: text/plain; charset="UTF-8"

Hi Nik,

Please see below.

I had to export call_netdev_notifiers_info. Also, I wanted to define the
vlan-specific detail change struct in if_vlan.h and then include if_vlan.h
from netdevice.h, where the netdev_notifier_change_details_info struct was
defined, but I found out that I cannot include if_vlan.h in netdevice.h.
After consulting with Andy I added a new file for the
netdev_notifier_change_details_info. Again, I will send out a proper RFC
patch once we sort out the details.

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 2be4dd7e90a9..ad0eddf1386f 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -37,6 +37,10 @@ struct vlan_hdr {
  __be16 h_vlan_encapsulated_proto;
 };

+struct vlan_change_details {
+ bool bridge_binding;
+};
+
 /**
  * struct vlan_ethhdr - vlan ethernet header (ethhdr + vlan_hdr)
  * @h_dest: destination ethernet address
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2563d30736e9..ba4746f05d7f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2762,6 +2762,7 @@ enum netdev_cmd {
  NETDEV_UNREGISTER,
  NETDEV_CHANGEMTU, /* notify after mtu change happened */
  NETDEV_CHANGEADDR, /* notify after the address change */
+ NETDEV_CHANGE_DETAILS,
  NETDEV_PRE_CHANGEADDR, /* notify before the address change */
  NETDEV_GOING_DOWN,
  NETDEV_CHANGENAME,
@@ -2898,6 +2899,8 @@ netdev_notifier_info_to_extack(const struct
netdev_notifier_info *info)
 }

 int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
+int call_netdevice_notifiers_info(unsigned long val,
+  struct netdev_notifier_info *info);


 extern rwlock_t dev_base_lock; /* Device list lock */
diff --git a/include/linux/notifier_info.h b/include/linux/notifier_info.h
new file mode 100644
index 000000000000..c103240588dc
--- /dev/null
+++ b/include/linux/notifier_info.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_NOTIFIER_INFO_H_
+#define _LINUX_NOTIFIER_INFO_H_
+
+#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+
+struct netdev_notifier_change_details_info {
+ struct netdev_notifier_info info; /* must be first */
+ union {
+ struct vlan_change_details vlan;
+ } details;
+};
+
+#endif /* !(_LINUX_NOTIFIER_INFO_H_) */
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..71947cdcfaaa 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -130,7 +130,7 @@ void vlan_dev_set_ingress_priority(const struct
net_device *dev,
 int vlan_dev_set_egress_priority(const struct net_device *dev,
  u32 skb_prio, u16 vlan_prio);
 void vlan_dev_free_egress_priority(const struct net_device *dev);
-int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32
mask);
+int vlan_dev_change_flags(struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
        size_t size);

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 839f2020b015..d737e259e295 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -22,6 +22,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
+#include <linux/notifier_info.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
@@ -211,8 +212,9 @@ int vlan_dev_set_egress_priority(const struct
net_device *dev,
 /* Flags are defined in the vlan_flags enum in
  * include/uapi/linux/if_vlan.h file.
  */
-int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32
mask)
+int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask)
 {
+ struct netdev_notifier_change_details_info info;
  struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
  u32 old_flags = vlan->flags;

@@ -223,19 +225,31 @@ int vlan_dev_change_flags(const struct net_device
*dev, u32 flags, u32 mask)

  vlan->flags = (old_flags & ~mask) | (flags & mask);

- if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
+ if (!netif_running(dev))
+ return 0;
+
+ if ((vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
  if (vlan->flags & VLAN_FLAG_GVRP)
  vlan_gvrp_request_join(dev);
  else
  vlan_gvrp_request_leave(dev);
  }

- if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
+ if ((vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
  if (vlan->flags & VLAN_FLAG_MVRP)
  vlan_mvrp_request_join(dev);
  else
  vlan_mvrp_request_leave(dev);
  }
+
+ if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
+    netif_is_bridge_master(vlan->real_dev)) {
+ info.info.dev = dev;
+ info.details.vlan.bridge_binding =
+    !!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING);
+ call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS, &info.info);
+ }
+
  return 0;
 }

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 96e91d69a9a8..62e939c6a3f0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -51,6 +51,11 @@ static int br_device_event(struct notifier_block
*unused, unsigned long event, v
  }
  }

+ if (is_vlan_dev(dev)) {
+ br_vlan_device_event(dev, event, ptr);
+ return NOTIFY_DONE;
+ }
+
  /* not a port of a bridge */
  p = br_port_get_rtnl(dev);
  if (!p)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 06e5f6faa431..a9a08e49c76c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1470,6 +1470,8 @@ void br_vlan_get_stats(const struct net_bridge_vlan
*v,
 void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
 int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
  void *ptr);
+void br_vlan_device_event(struct net_device *dev, unsigned long event,
+  void *ptr);
 void br_vlan_rtnl_init(void);
 void br_vlan_rtnl_uninit(void);
 void br_vlan_notify(const struct net_bridge *br,
@@ -1701,6 +1703,11 @@ static inline int br_vlan_bridge_event(struct
net_device *dev,
  return 0;
 }

+static void br_vlan_device_event(struct net_device *dev,
+ unsigned long event, void *ptr)
+{
+}
+
 static inline void br_vlan_rtnl_init(void)
 {
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 0f5e75ccac79..fe00efa46ce8 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/notifier_info.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <net/switchdev.h>
@@ -1768,6 +1769,23 @@ void br_vlan_port_event(struct net_bridge_port *p,
unsigned long event)
  }
 }

+void br_vlan_device_event(struct net_device *dev, unsigned long event,
void *ptr)
+{
+ struct netdev_notifier_change_details_info *info;
+ struct net_device *br_dev;
+
+ switch (event) {
+ case NETDEV_CHANGE_DETAILS:
+ info = ptr;
+ if (netif_is_bridge_master(vlan_dev_priv(dev)->real_dev)) {
+ br_dev = vlan_dev_priv(dev)->real_dev;
+ br_vlan_upper_change(br_dev, dev,
+    info->details.vlan.bridge_binding);
+ }
+ break;
+ }
+}
+
 static bool br_vlan_stats_fill(struct sk_buff *skb,
        const struct net_bridge_vlan *v)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 30a1603a7225..2eed064e9529 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -160,7 +160,7 @@ struct list_head ptype_base[PTYPE_HASH_SIZE]
__read_mostly;
 struct list_head ptype_all __read_mostly; /* Taps */

 static int netif_rx_internal(struct sk_buff *skb);
-static int call_netdevice_notifiers_info(unsigned long val,
+int call_netdevice_notifiers_info(unsigned long val,
  struct netdev_notifier_info *info);
 static int call_netdevice_notifiers_extack(unsigned long val,
    struct net_device *dev,
@@ -1624,7 +1624,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
  N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER)
  N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING_INFO)
  N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_INFO)
- N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)
+ N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)
  N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)
  N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
  N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
@@ -1927,7 +1927,7 @@ static void move_netdevice_notifiers_dev_net(struct
net_device *dev,
  * are as for raw_notifier_call_chain().
  */

-static int call_netdevice_notifiers_info(unsigned long val,
+int call_netdevice_notifiers_info(unsigned long val,
  struct netdev_notifier_info *info)
 {
  struct net *net = dev_net(info->dev);
@@ -1944,6 +1944,7 @@ static int call_netdevice_notifiers_info(unsigned
long val,
  return ret;
  return raw_notifier_call_chain(&netdev_chain, val, info);
 }
+EXPORT_SYMBOL(call_netdevice_notifiers_info);

 /**
  * call_netdevice_notifiers_info_robust - call per-netns notifier blocks

On Mon, Aug 22, 2022 at 7:18 PM Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
wrote:

>
>
> On Mon, Aug 22, 2022 at 4:01 AM Nikolay Aleksandrov <razor@blackwall.org>
> wrote:
>
>> On 20/08/2022 14:33, Sevinj Aghayeva wrote:
>> > On Thu, Aug 18, 2022 at 8:00 AM Nikolay Aleksandrov <
>> razor@blackwall.org> wrote:
>> >>
>> >> On 18/08/2022 14:50, Sevinj Aghayeva wrote:
>> [snip]
>> >>
>> >> Hi,
>> >> Handling all vlan device-related changes in br_vlan_device_event()
>> sounds good to me.
>> >> Please add it to br_vlan.c.
>> >
>> > Hi Nik,
>> >
>> > Can you please review this diff before I make it into a proper
>> patchset? Thanks!
>> >
>>
>> Hi,
>> A few comments inline below, but in general when you prepare the rfc
>> commit please
>> explain the motivation in detail why this way was chosen and a new
>> notification type
>> is needed (e.g. why not use NETDEV_CHANGEINFODATA or extend
>> NETDEV_CHANGE).
>> As I mentioned earlier it'd be nice to get feedback from others about
>> adding this
>> new notification, so they should know the "why" in detail.
>>
>
> Sure, I will do that in the RFC patchset, but first I want to make sure I
> got the details right before making the RFC patchset. Thanks for the
> feedback. Please see inline.
>
>>
>> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> > index 2563d30736e9..0ce3da42325e 100644
>> > --- a/include/linux/netdevice.h
>> > +++ b/include/linux/netdevice.h
>> > @@ -2762,6 +2762,7 @@ enum netdev_cmd {
>> >   NETDEV_UNREGISTER,
>> >   NETDEV_CHANGEMTU, /* notify after mtu change happened */
>> >   NETDEV_CHANGEADDR, /* notify after the address change */
>> > + NETDEV_CHANGE_DETAILS,
>> >   NETDEV_PRE_CHANGEADDR, /* notify before the address change */
>> >   NETDEV_GOING_DOWN,
>> >   NETDEV_CHANGENAME,
>> > @@ -2837,6 +2838,13 @@ struct netdev_notifier_changelowerstate_info {
>> >   void *lower_state_info; /* is lower dev state */
>> >  };
>> >
>> > +struct netdev_notifier_change_details_info {
>> > + struct netdev_notifier_info info; /* must be first */
>> > + union {
>> > + bool bridge_binding;
>>
>> this should be in a vlan-specific structure, defined in if_vlan.h
>> every other link type which wants to use the notification would define its
>> own struct type
>>
>
> Okay, will move it there.
>
>
>>
>> > + } details;
>> > +};
>> > +
>> >  struct netdev_notifier_pre_changeaddr_info {
>> >   struct netdev_notifier_info info; /* must be first */
>> >   const unsigned char *dev_addr;
>> > @@ -3836,6 +3844,8 @@ int __dev_set_mtu(struct net_device *, int);
>> >  int dev_set_mtu(struct net_device *, int);
>> >  int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
>> >         struct netlink_ext_ack *extack);
>> > +int dev_change_details_notify(struct net_device *dev, bool
>> bridge_binding,
>> > +       struct netlink_ext_ack *extack);
>>
>> this helper is not needed
>
>
>> >  int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>> >   struct netlink_ext_ack *extack);
>> >  int dev_set_mac_address_user(struct net_device *dev, struct sockaddr
>> *sa,
>> > diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
>> > index 5eaf38875554..71947cdcfaaa 100644
>> > --- a/net/8021q/vlan.h
>> > +++ b/net/8021q/vlan.h
>> > @@ -130,7 +130,7 @@ void vlan_dev_set_ingress_priority(const struct
>> > net_device *dev,
>> >  int vlan_dev_set_egress_priority(const struct net_device *dev,
>> >   u32 skb_prio, u16 vlan_prio);
>> >  void vlan_dev_free_egress_priority(const struct net_device *dev);
>> > -int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32
>> mask);
>> > +int vlan_dev_change_flags(struct net_device *dev, u32 flag, u32 mask);
>> >  void vlan_dev_get_realdev_name(const struct net_device *dev, char
>> *result,
>> >          size_t size);
>> >
>> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>> > index 839f2020b015..489baa8435de 100644
>> > --- a/net/8021q/vlan_dev.c
>> > +++ b/net/8021q/vlan_dev.c
>> > @@ -211,7 +211,7 @@ int vlan_dev_set_egress_priority(const struct
>> > net_device *dev,
>> >  /* Flags are defined in the vlan_flags enum in
>> >   * include/uapi/linux/if_vlan.h file.
>> >   */
>> > -int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32
>> mask)
>> > +int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask)
>>
>> please don't remove the const, this function shouldn't change dev's struct
>>
>
> I tried not to remove const, but it seems impossible because
> call_netdevice_notifiers_info that we eventually call from
> vlan_dev_change_flags takes a non-const struct info that has a dev field
> being set from the const vlan_dev_change_flags.
>
>
>>
>> >  {
>> >   struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
>> >   u32 old_flags = vlan->flags;
>> > @@ -223,19 +223,29 @@ int vlan_dev_change_flags(const struct
>> > net_device *dev, u32 flags, u32 mask)
>> >
>> >   vlan->flags = (old_flags & ~mask) | (flags & mask);
>> >
>> > - if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP)
>> {
>> > + if (!netif_running(dev))
>> > + return 0;
>> > +
>> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
>> >   if (vlan->flags & VLAN_FLAG_GVRP)
>> >   vlan_gvrp_request_join(dev);
>> >   else
>> >   vlan_gvrp_request_leave(dev);
>> >   }
>> >
>> > - if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_MVRP)
>> {
>> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
>> >   if (vlan->flags & VLAN_FLAG_MVRP)
>> >   vlan_mvrp_request_join(dev);
>> >   else
>> >   vlan_mvrp_request_leave(dev);
>> >   }
>> > +
>> > + if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
>> > +     netif_is_bridge_master(vlan->real_dev)) {
>> > + dev_change_details_notify(dev,
>> > +     !!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING), NULL);
>>
>> this helper is not needed, just fill in the details here and send the
>> notification
>>
>>
> Okay, in that case I will need to export call_netdevice_notifiers_info so
> that I can call it from here.
>
> > + }
>> > +
>> >   return 0;
>> >  }
>> >
>> > diff --git a/net/bridge/br.c b/net/bridge/br.c
>> > index 96e91d69a9a8..62e939c6a3f0 100644
>> > --- a/net/bridge/br.c
>> > +++ b/net/bridge/br.c
>> > @@ -51,6 +51,11 @@ static int br_device_event(struct notifier_block
>> > *unused, unsigned long event, v
>> >   }
>> >   }
>> >
>> > + if (is_vlan_dev(dev)) {
>> > + br_vlan_device_event(dev, event, ptr);
>> > + return NOTIFY_DONE;
>> > + }
>> > +
>> >   /* not a port of a bridge */
>> >   p = br_port_get_rtnl(dev);
>> >   if (!p)
>> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> > index 06e5f6faa431..a9a08e49c76c 100644
>> > --- a/net/bridge/br_private.h
>> > +++ b/net/bridge/br_private.h
>> > @@ -1470,6 +1470,8 @@ void br_vlan_get_stats(const struct
>> net_bridge_vlan *v,
>> >  void br_vlan_port_event(struct net_bridge_port *p, unsigned long
>> event);
>> >  int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
>> >   void *ptr);
>> > +void br_vlan_device_event(struct net_device *dev, unsigned long event,
>> > +   void *ptr);
>> >  void br_vlan_rtnl_init(void);
>> >  void br_vlan_rtnl_uninit(void);
>> >  void br_vlan_notify(const struct net_bridge *br,
>> > @@ -1701,6 +1703,11 @@ static inline int br_vlan_bridge_event(struct
>> > net_device *dev,
>> >   return 0;
>> >  }
>> >
>> > +static void br_vlan_device_event(struct net_device *dev,
>> > + unsigned long event, void *ptr)
>> > +{
>> > +}
>> > +
>> >  static inline void br_vlan_rtnl_init(void)
>> >  {
>> >  }
>> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> > index 0f5e75ccac79..70a9950df175 100644
>> > --- a/net/bridge/br_vlan.c
>> > +++ b/net/bridge/br_vlan.c
>> > @@ -1768,6 +1768,20 @@ void br_vlan_port_event(struct net_bridge_port
>> > *p, unsigned long event)
>> >   }
>> >  }
>> >
>> > +void br_vlan_device_event(struct net_device *dev, unsigned long
>> > event, void *ptr)
>> > +{
>> > + struct netdev_notifier_change_details_info *info;
>> > + struct net_device *br_dev;
>> > +
>> > + switch (event) {
>> > + case NETDEV_CHANGE_DETAILS:
>> > + info = ptr;
>> > + br_dev = vlan_dev_priv(dev)->real_dev;
>>
>> you're not guaranteed to have a bridge device as its real_dev, so you
>> should
>> validate that the vlan's real dev is a bridge
>>
>
> Okay, will do.
>
>
>>
>> > + br_vlan_upper_change(br_dev, dev, info->details.bridge_binding);
>> > + break;
>> > + }
>> > +}
>> > +
>> >  static bool br_vlan_stats_fill(struct sk_buff *skb,
>> >          const struct net_bridge_vlan *v)
>> >  {
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index 30a1603a7225..dcdbc625585d 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -1624,7 +1624,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd
>> cmd)
>> >   N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER)
>> >   N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING_INFO)
>> >   N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_INFO)
>> > - N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)
>> > + N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)
>> >   N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)
>> >   N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
>> >   N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
>> > @@ -8767,6 +8767,27 @@ int dev_pre_changeaddr_notify(struct net_device
>> > *dev, const char *addr,
>> >  }
>> >  EXPORT_SYMBOL(dev_pre_changeaddr_notify);
>> >
>> > +/**
>> > + * dev_change_details_notify - Call NETDEV_PRE_CHANGE_DETAILS.
>> > + * @dev: device
>> > + * @bridge_binding: bridge binding setting
>> > + * @extack: netlink extended ack
>> > + */
>> > +int dev_change_details_notify(struct net_device *dev, bool
>> bridge_binding,
>> > +       struct netlink_ext_ack *extack)
>> > +{
>> > + struct netdev_notifier_change_details_info info = {
>> > + .info.dev = dev,
>> > + .info.extack = extack,
>> > + .details.bridge_binding = bridge_binding,
>> > + };
>> > + int rc;
>> > +
>> > + rc = call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS, &info.info
>> );
>> > + return notifier_to_errno(rc);
>> > +}
>> > +EXPORT_SYMBOL(dev_change_details_notify);
>> > +
>>
>> this helper is unnecessary, just fill in the struct at the caller site and
>> send the notification directly
>>
>
> Okay, will remove it.
>
> Thanks for the review! I will send the updated patch soon.
>
>>
>> >  /**
>> >   * dev_set_mac_address - Change Media Access Control Address
>> >   * @dev: device
>> >
>> >
>> >>
>> >> Thanks,
>> >>  Nik
>> >>
>> >>
>>
>> Cheers,
>>  Nik
>>
>>
>>
>
> --
>
> Sevinj.Aghayeva
>


-- 

Sevinj.Aghayeva

--0000000000003f16ab05e7670576
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Nik,<div><br></div><div>Please see below.=C2=A0</div><d=
iv><br></div><div>I had to export call_netdev_notifiers_info. Also, I wante=
d to define the vlan-specific detail change struct in if_vlan.h and then in=
clude if_vlan.h from netdevice.h, where the netdev_notifier_change_details_=
info struct was defined, but I found out that I cannot include if_vlan.h in=
 netdevice.h. After consulting with Andy I added a new file for the netdev_=
notifier_change_details_info. Again, I will send out a proper RFC patch onc=
e we sort out the details.</div><div><br></div><div>diff --git a/include/li=
nux/if_vlan.h b/include/linux/if_vlan.h<br>index 2be4dd7e90a9..ad0eddf1386f=
 100644<br>--- a/include/linux/if_vlan.h<br>+++ b/include/linux/if_vlan.h<b=
r>@@ -37,6 +37,10 @@ struct vlan_hdr {<br>=C2=A0	__be16	h_vlan_encapsulated=
_proto;<br>=C2=A0};<br>=C2=A0<br>+struct vlan_change_details {<br>+	bool br=
idge_binding;<br>+};<br>+<br>=C2=A0/**<br>=C2=A0 *	struct vlan_ethhdr - vla=
n ethernet header (ethhdr + vlan_hdr)<br>=C2=A0 *	@h_dest: destination ethe=
rnet address<br>diff --git a/include/linux/netdevice.h b/include/linux/netd=
evice.h<br>index 2563d30736e9..ba4746f05d7f 100644<br>--- a/include/linux/n=
etdevice.h<br>+++ b/include/linux/netdevice.h<br>@@ -2762,6 +2762,7 @@ enum=
 netdev_cmd {<br>=C2=A0	NETDEV_UNREGISTER,<br>=C2=A0	NETDEV_CHANGEMTU,	/* n=
otify after mtu change happened */<br>=C2=A0	NETDEV_CHANGEADDR,	/* notify a=
fter the address change */<br>+	NETDEV_CHANGE_DETAILS,<br>=C2=A0	NETDEV_PRE=
_CHANGEADDR,	/* notify before the address change */<br>=C2=A0	NETDEV_GOING_=
DOWN,<br>=C2=A0	NETDEV_CHANGENAME,<br>@@ -2898,6 +2899,8 @@ netdev_notifier=
_info_to_extack(const struct netdev_notifier_info *info)<br>=C2=A0}<br>=C2=
=A0<br>=C2=A0int call_netdevice_notifiers(unsigned long val, struct net_dev=
ice *dev);<br>+int call_netdevice_notifiers_info(unsigned long val,<br>+			=
	 =C2=A0struct netdev_notifier_info *info);<br>=C2=A0<br>=C2=A0<br>=C2=A0ex=
tern rwlock_t				dev_base_lock;		/* Device list lock */<br>diff --git a/inc=
lude/linux/notifier_info.h b/include/linux/notifier_info.h<br>new file mode=
 100644<br>index 000000000000..c103240588dc<br>--- /dev/null<br>+++ b/inclu=
de/linux/notifier_info.h<br>@@ -0,0 +1,16 @@<br>+/* SPDX-License-Identifier=
: GPL-2.0 */<br>+<br>+#ifndef _LINUX_NOTIFIER_INFO_H_<br>+#define _LINUX_NO=
TIFIER_INFO_H_<br>+<br>+#include &lt;linux/netdevice.h&gt;<br>+#include &lt=
;linux/if_vlan.h&gt;<br>+<br>+struct netdev_notifier_change_details_info {<=
br>+	struct netdev_notifier_info info; /* must be first */<br>+	union {<br>=
+		struct vlan_change_details vlan;<br>+	} details;<br>+};<br>+<br>+#endif =
/* !(_LINUX_NOTIFIER_INFO_H_) */<br>diff --git a/net/8021q/vlan.h b/net/802=
1q/vlan.h<br>index 5eaf38875554..71947cdcfaaa 100644<br>--- a/net/8021q/vla=
n.h<br>+++ b/net/8021q/vlan.h<br>@@ -130,7 +130,7 @@ void vlan_dev_set_ingr=
ess_priority(const struct net_device *dev,<br>=C2=A0int vlan_dev_set_egress=
_priority(const struct net_device *dev,<br>=C2=A0				 u32 skb_prio, u16 vla=
n_prio);<br>=C2=A0void vlan_dev_free_egress_priority(const struct net_devic=
e *dev);<br>-int vlan_dev_change_flags(const struct net_device *dev, u32 fl=
ag, u32 mask);<br>+int vlan_dev_change_flags(struct net_device *dev, u32 fl=
ag, u32 mask);<br>=C2=A0void vlan_dev_get_realdev_name(const struct net_dev=
ice *dev, char *result,<br>=C2=A0			 =C2=A0 =C2=A0 =C2=A0 size_t size);<br>=
=C2=A0<br>diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c<br>index=
 839f2020b015..d737e259e295 100644<br>--- a/net/8021q/vlan_dev.c<br>+++ b/n=
et/8021q/vlan_dev.c<br>@@ -22,6 +22,7 @@<br>=C2=A0#include &lt;linux/skbuff=
.h&gt;<br>=C2=A0#include &lt;linux/netdevice.h&gt;<br>=C2=A0#include &lt;li=
nux/net_tstamp.h&gt;<br>+#include &lt;linux/notifier_info.h&gt;<br>=C2=A0#i=
nclude &lt;linux/etherdevice.h&gt;<br>=C2=A0#include &lt;linux/ethtool.h&gt=
;<br>=C2=A0#include &lt;linux/phy.h&gt;<br>@@ -211,8 +212,9 @@ int vlan_dev=
_set_egress_priority(const struct net_device *dev,<br>=C2=A0/* Flags are de=
fined in the vlan_flags enum in<br>=C2=A0 * include/uapi/linux/if_vlan.h fi=
le.<br>=C2=A0 */<br>-int vlan_dev_change_flags(const struct net_device *dev=
, u32 flags, u32 mask)<br>+int vlan_dev_change_flags(struct net_device *dev=
, u32 flags, u32 mask)<br>=C2=A0{<br>+	struct netdev_notifier_change_detail=
s_info info;<br>=C2=A0	struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);<b=
r>=C2=A0	u32 old_flags =3D vlan-&gt;flags;<br>=C2=A0<br>@@ -223,19 +225,31 =
@@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 m=
ask)<br>=C2=A0<br>=C2=A0	vlan-&gt;flags =3D (old_flags &amp; ~mask) | (flag=
s &amp; mask);<br>=C2=A0<br>-	if (netif_running(dev) &amp;&amp; (vlan-&gt;f=
lags ^ old_flags) &amp; VLAN_FLAG_GVRP) {<br>+	if (!netif_running(dev))<br>=
+		return 0;<br>+<br>+	if ((vlan-&gt;flags ^ old_flags) &amp; VLAN_FLAG_GVR=
P) {<br>=C2=A0		if (vlan-&gt;flags &amp; VLAN_FLAG_GVRP)<br>=C2=A0			vlan_g=
vrp_request_join(dev);<br>=C2=A0		else<br>=C2=A0			vlan_gvrp_request_leave(=
dev);<br>=C2=A0	}<br>=C2=A0<br>-	if (netif_running(dev) &amp;&amp; (vlan-&g=
t;flags ^ old_flags) &amp; VLAN_FLAG_MVRP) {<br>+	if ((vlan-&gt;flags ^ old=
_flags) &amp; VLAN_FLAG_MVRP) {<br>=C2=A0		if (vlan-&gt;flags &amp; VLAN_FL=
AG_MVRP)<br>=C2=A0			vlan_mvrp_request_join(dev);<br>=C2=A0		else<br>=C2=A0=
			vlan_mvrp_request_leave(dev);<br>=C2=A0	}<br>+<br>+	if ((vlan-&gt;flags =
^ old_flags) &amp; VLAN_FLAG_BRIDGE_BINDING &amp;&amp;<br>+	 =C2=A0 =C2=A0n=
etif_is_bridge_master(vlan-&gt;real_dev)) {<br>+		<a href=3D"http://info.in=
fo.dev" target=3D"_blank">info.info.dev</a> =3D dev;<br>+		info.details.vla=
n.bridge_binding =3D<br>+		 =C2=A0 =C2=A0!!(vlan-&gt;flags &amp; VLAN_FLAG_=
BRIDGE_BINDING);<br>+		call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS,=
 &amp;<a href=3D"http://info.info" target=3D"_blank">info.info</a>);<br>+	}=
<br>+<br>=C2=A0	return 0;<br>=C2=A0}<br>=C2=A0<br>diff --git a/net/bridge/b=
r.c b/net/bridge/br.c<br>index 96e91d69a9a8..62e939c6a3f0 100644<br>--- a/n=
et/bridge/br.c<br>+++ b/net/bridge/br.c<br>@@ -51,6 +51,11 @@ static int br=
_device_event(struct notifier_block *unused, unsigned long event, v<br>=C2=
=A0		}<br>=C2=A0	}<br>=C2=A0<br>+	if (is_vlan_dev(dev)) {<br>+		br_vlan_dev=
ice_event(dev, event, ptr);<br>+		return NOTIFY_DONE;<br>+	}<br>+<br>=C2=A0=
	/* not a port of a bridge */<br>=C2=A0	p =3D br_port_get_rtnl(dev);<br>=C2=
=A0	if (!p)<br>diff --git a/net/bridge/br_private.h b/net/bridge/br_private=
.h<br>index 06e5f6faa431..a9a08e49c76c 100644<br>--- a/net/bridge/br_privat=
e.h<br>+++ b/net/bridge/br_private.h<br>@@ -1470,6 +1470,8 @@ void br_vlan_=
get_stats(const struct net_bridge_vlan *v,<br>=C2=A0void br_vlan_port_event=
(struct net_bridge_port *p, unsigned long event);<br>=C2=A0int br_vlan_brid=
ge_event(struct net_device *dev, unsigned long event,<br>=C2=A0			 void *pt=
r);<br>+void br_vlan_device_event(struct net_device *dev, unsigned long eve=
nt,<br>+ 			 =C2=A0void *ptr);<br>=C2=A0void br_vlan_rtnl_init(void);<br>=
=C2=A0void br_vlan_rtnl_uninit(void);<br>=C2=A0void br_vlan_notify(const st=
ruct net_bridge *br,<br>@@ -1701,6 +1703,11 @@ static inline int br_vlan_br=
idge_event(struct net_device *dev,<br>=C2=A0	return 0;<br>=C2=A0}<br>=C2=A0=
<br>+static void br_vlan_device_event(struct net_device *dev,<br>+				 unsi=
gned long event, void *ptr)<br>+{<br>+}<br>+<br>=C2=A0static inline void br=
_vlan_rtnl_init(void)<br>=C2=A0{<br>=C2=A0}<br>diff --git a/net/bridge/br_v=
lan.c b/net/bridge/br_vlan.c<br>index 0f5e75ccac79..fe00efa46ce8 100644<br>=
--- a/net/bridge/br_vlan.c<br>+++ b/net/bridge/br_vlan.c<br>@@ -1,6 +1,7 @@=
<br>=C2=A0// SPDX-License-Identifier: GPL-2.0-only<br>=C2=A0#include &lt;li=
nux/kernel.h&gt;<br>=C2=A0#include &lt;linux/netdevice.h&gt;<br>+#include &=
lt;linux/notifier_info.h&gt;<br>=C2=A0#include &lt;linux/rtnetlink.h&gt;<br=
>=C2=A0#include &lt;linux/slab.h&gt;<br>=C2=A0#include &lt;net/switchdev.h&=
gt;<br>@@ -1768,6 +1769,23 @@ void br_vlan_port_event(struct net_bridge_por=
t *p, unsigned long event)<br>=C2=A0	}<br>=C2=A0}<br>=C2=A0<br>+void br_vla=
n_device_event(struct net_device *dev, unsigned long event, void *ptr)<br>+=
{<br>+	struct netdev_notifier_change_details_info *info;<br>+	struct net_de=
vice *br_dev;<br>+<br>+	switch (event) {<br>+	case NETDEV_CHANGE_DETAILS:<b=
r>+		info =3D ptr;<br>+		if (netif_is_bridge_master(vlan_dev_priv(dev)-&gt;=
real_dev)) {<br>+			br_dev =3D vlan_dev_priv(dev)-&gt;real_dev;<br>+			br_v=
lan_upper_change(br_dev, dev,<br>+			 =C2=A0 =C2=A0info-&gt;details.vlan.br=
idge_binding);<br>+		}<br>+		break;<br>+	}<br>+}<br>+<br>=C2=A0static bool =
br_vlan_stats_fill(struct sk_buff *skb,<br>=C2=A0			 =C2=A0 =C2=A0 =C2=A0 c=
onst struct net_bridge_vlan *v)<br>=C2=A0{<br>diff --git a/net/core/dev.c b=
/net/core/dev.c<br>index 30a1603a7225..2eed064e9529 100644<br>--- a/net/cor=
e/dev.c<br>+++ b/net/core/dev.c<br>@@ -160,7 +160,7 @@ struct list_head pty=
pe_base[PTYPE_HASH_SIZE] __read_mostly;<br>=C2=A0struct list_head ptype_all=
 __read_mostly;	/* Taps */<br>=C2=A0<br>=C2=A0static int netif_rx_internal(=
struct sk_buff *skb);<br>-static int call_netdevice_notifiers_info(unsigned=
 long val,<br>+int call_netdevice_notifiers_info(unsigned long val,<br>=C2=
=A0					 struct netdev_notifier_info *info);<br>=C2=A0static int call_netde=
vice_notifiers_extack(unsigned long val,<br>=C2=A0					 =C2=A0 struct net_d=
evice *dev,<br>@@ -1624,7 +1624,7 @@ const char *netdev_cmd_to_name(enum ne=
tdev_cmd cmd)<br>=C2=A0	N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(C=
HANGEUPPER)<br>=C2=A0	N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BO=
NDING_INFO)<br>=C2=A0	N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PU=
SH_INFO)<br>-	N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)<br>+	N(UDP_TUN=
NEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN) N(CHANGE_DETAILS)<br>=C2=A0	N(CVLAN_F=
ILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)<br>=C2=A0	N(SVLAN_FILTER_PUSH_IN=
FO) N(SVLAN_FILTER_DROP_INFO)<br>=C2=A0	N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_=
ENABLE) N(OFFLOAD_XSTATS_DISABLE)<br>@@ -1927,7 +1927,7 @@ static void move=
_netdevice_notifiers_dev_net(struct net_device *dev,<br>=C2=A0 *	are as for=
 raw_notifier_call_chain().<br>=C2=A0 */<br>=C2=A0<br>-static int call_netd=
evice_notifiers_info(unsigned long val,<br>+int call_netdevice_notifiers_in=
fo(unsigned long val,<br>=C2=A0					 struct netdev_notifier_info *info)<br>=
=C2=A0{<br>=C2=A0	struct net *net =3D dev_net(info-&gt;dev);<br>@@ -1944,6 =
+1944,7 @@ static int call_netdevice_notifiers_info(unsigned long val,<br>=
=C2=A0		return ret;<br>=C2=A0	return raw_notifier_call_chain(&amp;netdev_ch=
ain, val, info);<br>=C2=A0}<br>+EXPORT_SYMBOL(call_netdevice_notifiers_info=
);<br>=C2=A0<br>=C2=A0/**<br>=C2=A0 *	call_netdevice_notifiers_info_robust =
- call per-netns notifier blocks<br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 22, 2022 at 7:18 PM S=
evinj Aghayeva &lt;<a href=3D"mailto:sevinj.aghayeva@gmail.com" target=3D"_=
blank">sevinj.aghayeva@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Aug 22, 2022 at 4:01 AM Nikolay Aleksandrov &lt;<a href=3D"mailto:razor=
@blackwall.org" target=3D"_blank">razor@blackwall.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 20/08/2022 14:33, S=
evinj Aghayeva wrote:<br>
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
<br></blockquote><br><div>Okay, in that case I will need to export=C2=A0cal=
l_netdevice_notifiers_info so that I can call it from here.</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
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
><div dir=3D"ltr"><div><br></div><div>Sevinj.Aghayeva</div></div></div></di=
v>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div><br></div><div>Sevinj.Aghayeva</div></div></div>

--0000000000003f16ab05e7670576--

