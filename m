Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F93ED3D1
	for <bridge@lists.linux-foundation.org>; Tue,  9 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045728; cv=pass; b=ijcmFhIT6B2JmTdn4+Qmwvz3k4VBEzGGjHLJd17K+IPFY/TuZUeFjQul7Fw5lTqoZkY3TvK5rmkWsLv+0gswvCEm7CyzNouY8t8qqb/Y5CRsvNQbpcQRZGJOwM4cCtcbturXv4vfC5HDKHp6gG6CB7cXg3sGdjcIQqz9lFK6KVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045728; c=relaxed/simple;
	bh=IC5D0q9A1ff1mcEk8QQfu8ghFJ8rLbTLiw0NFDBICco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZV672QOYEUnTHylIiMLotIgTiQNRxh47gjrWUw48A9CwJaWDK5mGV6HDr4/r0FZ40MneorwutyRZw9zYb2EyT5RC8HSu01LBMzhW/G+hVCgIvUvHeHOTgkYgAJC9Rp+I1r0TCUdyElzM2h+QoVrbWCanmaSoZfnWpMM7m2PFeJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+FeJts5; arc=pass smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+FeJts5"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EED14EF55
	for <bridge@lists.linux-foundation.org>; Tue,  9 Jun 2026 22:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MrJsl_tFT1dq for <bridge@lists.linux-foundation.org>;
 Tue,  9 Jun 2026 22:55:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=patrice.brissette@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A6D724EF53
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6D724EF53
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W+FeJts5
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6D724EF53
	for <bridge@lists.linux-foundation.org>; Tue,  9 Jun 2026 22:55:23 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5176465a4a4so82275151cf.2
        for <bridge@lists.linux-foundation.org>; Tue, 09 Jun 2026 15:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781045722; cv=none;
        d=google.com; s=arc-20240605;
        b=SVpNOrCsFa8HxruSTwdxeuZUEuaM0mSw4vWYX/TQkACmW/zK3IZTYMT9Oc9OoYJjJw
         hmiiJ8HbEH/ZiqwOgvuEaD28UolVFKgjvWWZQmQpHIVGABcM7eAnQMBrBB4VPBc9CnQM
         lKbvEyRxAu5/XnlVEqKPDKKrvL1E1at6P2/0utD9TscQLs132s8CHoHu/tlSWkQVBF+o
         7yQNaP/IdHlN4o6wDLeUTyK/SNtftWnAeNCoU5YtJKgO4Cm7DyoQWXLNAbrCtKvq0X+I
         CWojrcdXyOSaylvqyXiMaNc6iVRgGqkL7igVea1GV5ZZF1PhENnaaVHMPt4OY1Un/4ug
         MwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        fh=uyBUI+KtiBRWSwhrRwi30TVhsqZB23GTX/ZSZoRxYFc=;
        b=RvIRW2PHJhj3wOQ0f0sy8xDN9fRaBM/UOBLki34JYuI6rJtNgLcNk3mh4+eyi6xw+3
         rD4t0Ey0mpzwCdh3xcke4r7imlNtMtoIugbbFp63Mti7Fo+rQZ3R+N18AvTq0WdBFuCQ
         fg6ZscPWTxdOTYIJyIIr+3bb40VvLA/Fn5C8sYWLn6Y1QAgXrmhPYnD1cHs/Ta+lvgvR
         lb2ZFRXahA9+f+mDRC2cLm8q0jeuRpx/TQPGXRFkdX0ciM4tH/+dEbShp9dhcoYRae2P
         vwGYgWzkCU3Ae5Bsmp6VL8ZznAUIYMzTdoWtsHYkde3LKfvXOHAXUocS2pM7Q1ZsGzX1
         +HEw==;
        darn=lists.linux-foundation.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781045722; x=1781650522; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        b=W+FeJts5LuF2lVPUASbKB/NruyTlOQN7oHCnUQaXfQtcqJzrfc9BHTUS3H+eou6Yga
         QGPT4r0a8YznpIAG6ojK9OkK2NTuWpZfH83oXGhVTqaWsssBI1VUm2DiSuHANsotABZU
         ULEBSCb5NdCmZ0wCkBA5LY4k1TUpNJVO3yGjo71yKTts464WxPovpWSFBGF4C+j3zgbv
         iXLDEWSzMEb2biR8VpY7ztDshs8b/+9gK/UbmGig/FSdxUOzh4PPtulKzi4VLh1kRDdo
         0wDn/JPamat8nOArTQ+uiENgWhtSO68UIspp3HcU4Dd2tQAF6/7hsPosMjG64/kd8m/k
         CMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781045722; x=1781650522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXXX0AY86nzR+yk44NoqMyCHdnb3/U/EKPFxZz9lZdc=;
        b=rY+rIdtfkPYEpUMCT/udjqQDQa4JUSGGhEoYijkKU6/Yv7UfYQqWpZPGXKfFs8e8EG
         EtRu767RLZbldvK1lcf1vHg5gAr0k4OG9bhM7BFxFm9QCh1+kTVJNV6vNxA6bXvv6QGG
         VDWhYnnrngQNDx/rj0pTsXVSrAw7dWUba3fBwedjSTk4L6ZtAkzwWaBMNMqGsRSZEhc3
         eTMOu6OcAp/dmZpVEDkceMjqG26dvDMFtIT1PCienhwygQJTGrspA6OgWkHKt3f8pHm9
         nfqh/wyTaUrKgdQdybfZMCGs/hyT3P14hwi3RYNpmE1K9ZiejB5SsOJPZMG6xsZw6xFq
         zikw==
X-Forwarded-Encrypted: i=1; AFNElJ/R0fNZDOR/6CDE1rnN22DByfLUIHNcpw4wOj/W9PdMYCtNcBA3RVjnXswGhd6vIzjb3Zu7Zb8=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy0zKwQlTwAns8hMaYcPfysT+8knyERSdF5VTv5nXuJBvlVD1tK
	wJG9ib9nt6jMzeXcSVeE08YPykfZnXRBqGtdVVhfVMwhccqunpaPSMBu3Od4Cq16v9/xwtTxm7a
	P4ryE+QzJEIQ2nsySd6WCb1p//H3iJCo=
X-Gm-Gg: Acq92OGS8F6utJywNd3Oc/QzKuFmwURsypjRuMFXEAzuXYCiMHZ5T/O86v86IUu1UeW
	hMoVpnhT6+MUc8+x7t5XqO+1ZTeosD7mDgkLuFOXUk3V8iLYcwxzeoV6MJsqRTlhAsi7kRAXEAH
	1TdHkSsjqQe3ZaHhzhqvZ3nFE/+2HjMKb9R8Eo1jhlV3bcfnhiXVcHdJf/4rIHPWHt/NtNWZX2O
	Ui4ZAzGPjvUd7yD06gX1maCi0WST/m26nkV+9U9iq/FYC1jT1D9OzGrdA04iNfYGh5X+V2tDKkO
	KPiZhh4Sr8nQxHpeRh4ev/a4bpladR60SR7N62AjRphmTQ48
X-Received: by 2002:a05:622a:2cd:b0:517:6b57:8164 with SMTP id
 d75a77b69052e-51795cda6f0mr336323351cf.55.1781045722193; Tue, 09 Jun 2026
 15:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Patrice Brissette <patrice.brissette@gmail.com>
Date: Tue, 9 Jun 2026 18:55:10 -0400
X-Gm-Features: AVVi8Cd8WNNtCMxDvtFiwmiz7B97V2UaW09A0WMNcdeATbL9C44zOanZ4SJ4J7A
Message-ID: <CACWwMkvCAdjDPEraGhBdH67tkK=3p=aygZ2JYCRPkOzjVghFpw@mail.gmail.com>
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
To: Ido Schimmel <idosch@idosch.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm following up on the status of this patch series. This feature is
critical for our EVPN Multihoming deployments, and the corresponding
FRRouting work is currently blocked pending support for this
functionality.

Has there been any progress on this effort, or has someone else picked
it up? What are the next steps?

For reference, the proposed work includes:

Adding support for a protocol field to bridge and VXLAN FDB entries.

Allowing the protocol field to identify the source of an FDB update,
for example:

Zebra for control-plane-originated entries

HW for data-plane-learned entries (e.g., ASIC-learned MACs)

Extending iproute2 to support configuration and display of this new field.

The primary use case is EVPN Multihoming with ARP/ND synchronization
for hosts that are multihomed to a set of routers. In this
environment, the same MAC address may be learned locally by hardware
when the host is directly attached, or installed by the control plane
when the entry is synchronized through BGP, as commonly occurs in
all-active scenarios.

The protocol field allows FRRouting to distinguish
control-plane-installed entries from hardware-learned entries,
enabling correct MAC mobility handling, ES peer synchronization, and
proper processing of MAC ownership changes.

Please let me know if anyone is already working on this. Otherwise, I
would be happy to pick it up and help move it forward.

Thanks,
Patrice


From: Ido Schimmel <idosch@idosch.org>
Date: Thursday, August 21, 2025 at 07:03
To: Mrinmoy Ghosh (mrghosh) <mrghosh@cisco.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
netdev@vger.kernel.org <netdev@vger.kernel.org>;
bridge@lists.linux-foundation.org <bridge@lists.linux-foundation.org>;
Mrinmoy Ghosh <mrinmoy_g@hotmail.com>; Patrice Brissette (pbrisset)
<pbrisset@cisco.com>
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb

On Mon, Aug 18, 2025 at 05:52:58PM +0000, Mrinmoy Ghosh wrote:
> This is to add optional "protocol" field for bridge fdb entries.
> The introduction of the 'protocol' field in the bridge FDB for EVPN Multi=
home, addresses the need to distinguish between MAC addresses learned via t=
he control plane and those learned via the data plane with data plane aging=
. Specifically:
> * A MAC address in an EVPN Multihome environment can be learned either th=
rough the control plane (static MAC) or the data plane (dynamic MAC with ag=
ing).

This is true for EVPN in general, so why mention MH?

> * The 'protocol' field uses values such as 'HW' for data plane dynamic MA=
Cs and 'ZEBRA' for control plane static MACs.

"HW" does not make sense to me. Why does the control plane care if the
entry was learned dynamically in the software data path (no offload) or
in the hardware data path? Entries installed by the kernel should be
installed with "RTPROT_KERNEL" regardless of the origin of the entry
(software / hardware).

That being said, you can encode whatever you want in the protocol field
and adjust rt_protos to display it however you like.

> * This distinction allows the application to manage the MAC address state=
 machine effectively during transitions, which can occur due to traffic has=
hing between EVPN Multihome peers or mobility of MAC addresses across EVPN =
peers.
> * By identifying the source of the MAC learning (control plane vs. data p=
lane), the system can handle MAC aging and mobility more accurately, ensuri=
ng synchronization between control and data planes and improving stability =
and reliability in MAC route handling.

This is quite vague. Can you be more specific on how exactly the control
plane is expected to use the protocol field in EVPN MH?

AFAIK, when the kernel notifies FRR about an FDB entry that was learned
on an ES peer, FRR installs the entry on all the ES peers as a static
entry (no aging, roaming enabled) with the "activity_notify" and
"inactive" flags so that the control plane will be notified when the
entry becomes active (i.e., was learned locally). See:

https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?i=
d=3De041178ba6bc2af0a1148145ee303c9db79fb4cb
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D5e88777a382480d0b1f7eafb6d0fb680ec7a40bb

I am not against adding a cookie ("protocol") to FDB entries, but I
would like to understand your motivation.

>
> This mechanism supports the complex state transitions and synchronization=
 required in EVPN Multihome scenarios, where MAC addresses may move or be l=
earned differently depending on network events and traffic patterns.
>
> Change Summary:
> vxlan_core.c:  Encode NDA_PROTOCOL, and create and update fdb protocol fi=
eld
>                Use RTPROT_UNSPEC when protocol not specified (default)
> vxlan_private.h: protocol field in vxlan_fdb, function signature updates
> vxlan_vnifilter.c: Use default RTPROT_UNSPEC, for default fdb create
> br.c: Use default RTPROT_UNSPEC as protocol, for swdev event
> br_fdb.c: Set NDA_PROTOCOL from protocol for fdb fill.
>           bridge fdb add, delete, learn update of protocol field
> br_private.h: protocol field in net_bridge_fdb_entry
>
> e.g:
> Test along with iproute2 change i.e https://lore.kernel.org/netdev/202508=
16031145.1153429-1-mrghosh@cisco.com/T/#u
>
> $ bridge fdb add 00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic=
 extern_learn proto hw
>
> $ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
> 00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto hw
>
> $ bridge -d -j -p fdb show dev hostbond2
>
> ...
>
> [ {
>         "mac": "00:00:00:00:00:88",
>         "vlan": 1000,
>         "flags": [ "extern_learn" ],
>         "master": "br1000",
>         "flags_ext": [ ],
>         "protocol": "hw",
>         "state": ""
>     },{
> ...
>
> Transition to Zebra:
> $ bridge fdb replace  00:00:00:00:00:88 dev hostbond2 vlan 1000 master dy=
namic extern_learn proto zebra
>
> $ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
> 00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto zebra
>
> $ bridge -d -j -p fdb show dev hostbond2 ...
> [ {
>         "mac": "00:00:00:00:00:88",
>         "vlan": 1000,
>         "flags": [ "extern_learn" ],
>         "master": "br1000",
>         "flags_ext": [ ],
>         "protocol": "zebra",
>         "state": ""
>     },
> ...
>
> iproute2 review: https://lore.kernel.org/netdev/20250816031145.1153429-1-=
mrghosh@cisco.com/T/#u
>
> Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
> Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
> Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 132 ++++++++++++++--------------
>  drivers/net/vxlan/vxlan_private.h   |  21 +++--
>  drivers/net/vxlan/vxlan_vnifilter.c |  11 +--
>  net/bridge/br.c                     |   4 +-
>  net/bridge/br_fdb.c                 |  52 ++++++++---
>  net/bridge/br_private.h             |   5 +-
>  6 files changed, 127 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index f32be2e301f2..eff342e467a6 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -206,6 +206,8 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct=
 vxlan_dev *vxlan,
>                        peernet2id(dev_net(vxlan->dev), vxlan->net)))
>                goto nla_put_failure;
>
> +     if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))

Maybe fill only if not 0?

You should patch vxlan_nlmsg_size() as well.

> +             goto nla_put_failure;
>        if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.eth_a=
ddr))
>                goto nla_put_failure;
>        if (nh) {
> @@ -852,12 +854,11 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vx=
lan, struct vxlan_fdb *fdb,
>        return err;
>  }
>
> -int vxlan_fdb_create(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __be16 port, __be32 src_vni,
> -                  __be32 vni, __u32 ifindex, __u16 ndm_flags,
> +int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __be16 port,
> +                  __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_f=
lags,
>                     u32 nhid, struct vxlan_fdb **fdb,
> -                  struct netlink_ext_ack *extack)
> +                  struct netlink_ext_ack *extack, u8 protocol)

Move this after 'nhid' so it's closer to the other attributes.

I will add an item to my TODO list to move these arguments into an FDB
config structure.

>  {
>        struct vxlan_rdst *rd =3D NULL;
>        struct vxlan_fdb *f;
> @@ -872,6 +873,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
>        if (!f)
>                return -ENOMEM;
>
> +     f->protocol =3D protocol;

Multicast FDB entries can have multiple remotes and each can be added by
a different entity. I think it makes more sense to move the protocol
field to the remote structure.

>        if (nhid)
>                rc =3D vxlan_fdb_nh_update(vxlan, f, nhid, extack);
>        else
> @@ -964,14 +966,12 @@ static void vxlan_dst_free(struct rcu_head *head)
>        kfree(rd);
>  }
>
> -static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
> -                                  union vxlan_addr *ip,
> -                                  __u16 state, __u16 flags,
> -                                  __be16 port, __be32 vni,
> -                                  __u32 ifindex, __u16 ndm_flags,
> -                                  struct vxlan_fdb *f, u32 nhid,
> -                                  bool swdev_notify,
> -                                  struct netlink_ext_ack *extack)
> +static int
> +vxlan_fdb_update_existing(struct vxlan_dev *vxlan, union vxlan_addr *ip,
> +                       __u16 state, __u16 flags, __be16 port, __be32 vni=
,
> +                       __u32 ifindex, __u16 ndm_flags, struct vxlan_fdb =
*f,
> +                       u32 nhid, bool swdev_notify,
> +                       struct netlink_ext_ack *extack, u8 protocol)
>  {
>        __u16 fdb_flags =3D (ndm_flags & ~NTF_USE);
>        struct vxlan_rdst *rd =3D NULL;
> @@ -1005,6 +1005,11 @@ static int vxlan_fdb_update_existing(struct vxlan_=
dev *vxlan,
>                        f->flags =3D fdb_flags;
>                        notify =3D 1;
>                }
> +             if (f->protocol !=3D protocol) {
> +                     f->protocol =3D protocol;
> +                     f->updated =3D jiffies;
> +                     notify =3D 1;
> +             }
>        }
>
>        if ((flags & NLM_F_REPLACE)) {
> @@ -1063,13 +1068,12 @@ static int vxlan_fdb_update_existing(struct vxlan=
_dev *vxlan,
>        return err;
>  }
>
> -static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
> -                                const u8 *mac, union vxlan_addr *ip,
> -                                __u16 state, __u16 flags,
> -                                __be16 port, __be32 src_vni, __be32 vni,
> -                                __u32 ifindex, __u16 ndm_flags, u32 nhid=
,
> -                                bool swdev_notify,
> -                                struct netlink_ext_ack *extack)
> +static int vxlan_fdb_update_create(struct vxlan_dev *vxlan, const u8 *ma=
c,
> +                                union vxlan_addr *ip, __u16 state,
> +                                __u16 flags, __be16 port, __be32 src_vni=
,
> +                                __be32 vni, __u32 ifindex, __u16 ndm_fla=
gs,
> +                                u32 nhid, bool swdev_notify,
> +                                struct netlink_ext_ack *extack, u8 proto=
col)
>  {
>        __u16 fdb_flags =3D (ndm_flags & ~NTF_USE);
>        struct vxlan_fdb *f;
> @@ -1081,8 +1085,8 @@ static int vxlan_fdb_update_create(struct vxlan_dev=
 *vxlan,
>                return -EOPNOTSUPP;
>
>        netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
> -     rc =3D vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
> -                           vni, ifindex, fdb_flags, nhid, &f, extack);
> +     rc =3D vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni, vni,
> +                           ifindex, fdb_flags, nhid, &f, extack, protoco=
l);
>        if (rc < 0)
>                return rc;
>
> @@ -1099,13 +1103,11 @@ static int vxlan_fdb_update_create(struct vxlan_d=
ev *vxlan,
>  }
>
>  /* Add new entry to forwarding table -- assumes lock held */
> -int vxlan_fdb_update(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __u16 flags,
> -                  __be16 port, __be32 src_vni, __be32 vni,
> -                  __u32 ifindex, __u16 ndm_flags, u32 nhid,
> -                  bool swdev_notify,
> -                  struct netlink_ext_ack *extack)
> +int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __u16 flags,
> +                  __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex=
,
> +                  __u16 ndm_flags, u32 nhid, bool swdev_notify,
> +                  struct netlink_ext_ack *extack, u8 protocol)
>  {
>        struct vxlan_fdb *f;
>
> @@ -1119,7 +1121,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
>
>                return vxlan_fdb_update_existing(vxlan, ip, state, flags, =
port,
>                                                 vni, ifindex, ndm_flags, =
f,
> -                                              nhid, swdev_notify, extack=
);
> +                                              nhid, swdev_notify, extack=
,
> +                                              protocol);
>        } else {
>                if (!(flags & NLM_F_CREATE))
>                        return -ENOENT;
> @@ -1127,7 +1130,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
>                return vxlan_fdb_update_create(vxlan, mac, ip, state, flag=
s,
>                                               port, src_vni, vni, ifindex=
,
>                                               ndm_flags, nhid, swdev_noti=
fy,
> -                                            extack);
> +                                            extack, protocol);
>        }
>  }
>
> @@ -1142,7 +1145,7 @@ static void vxlan_fdb_dst_destroy(struct vxlan_dev =
*vxlan, struct vxlan_fdb *f,
>  static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>                           union vxlan_addr *ip, __be16 *port, __be32 *src=
_vni,
>                           __be32 *vni, u32 *ifindex, u32 *nhid,
> -                        struct netlink_ext_ack *extack)
> +                        struct netlink_ext_ack *extack, u8 *protocol)
>  {
>        struct net *net =3D dev_net(vxlan->dev);
>        int err;
> @@ -1222,6 +1225,11 @@ static int vxlan_fdb_parse(struct nlattr *tb[], st=
ruct vxlan_dev *vxlan,
>
>        *nhid =3D nla_get_u32_default(tb[NDA_NH_ID], 0);
>
> +     if (tb[NDA_PROTOCOL])
> +             *protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +     else
> +             *protocol =3D RTPROT_UNSPEC;
> +
>        return 0;
>  }
>
> @@ -1238,6 +1246,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct =
nlattr *tb[],
>        __be32 src_vni, vni;
>        u32 ifindex, nhid;
>        int err;
> +     u8 protocol;

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-order=
ing-reverse-xmas-tree-rcs

Make this change throughout the patch.

>
>        if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
>                pr_info("RTM_NEWNEIGH with invalid state %#x\n",
> @@ -1249,7 +1258,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct =
nlattr *tb[],
>                return -EINVAL;
>
>        err =3D vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &if=
index,
> -                           &nhid, extack);
> +                           &nhid, extack, &protocol);
>        if (err)
>                return err;
>
> @@ -1257,10 +1266,10 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struc=
t nlattr *tb[],
>                return -EAFNOSUPPORT;
>
>        spin_lock_bh(&vxlan->hash_lock);
> -     err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
> -                            port, src_vni, vni, ifindex,
> -                            ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
> -                            nhid, true, extack);
> +     err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags, p=
ort,
> +                            src_vni, vni, ifindex,
> +                            ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER, nh=
id,
> +                            true, extack, protocol);
>        spin_unlock_bh(&vxlan->hash_lock);
>
>        if (!err)
> @@ -1314,9 +1323,10 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, str=
uct nlattr *tb[],
>        u32 ifindex, nhid;
>        __be16 port;
>        int err;
> +     u8 protocol;
>
>        err =3D vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &if=
index,
> -                           &nhid, extack);
> +                           &nhid, extack, &protocol);
>        if (err)
>                return err;
>
> @@ -1470,13 +1480,12 @@ static enum skb_drop_reason vxlan_snoop(struct ne=
t_device *dev,
>
>                /* close off race between vxlan_flush and incoming packets=
 */
>                if (netif_running(dev))
> -                     vxlan_fdb_update(vxlan, src_mac, src_ip,
> -                                      NUD_REACHABLE,
> -                                      NLM_F_EXCL|NLM_F_CREATE,
> -                                      vxlan->cfg.dst_port,
> -                                      vni,
> -                                      vxlan->default_dst.remote_vni,
> -                                      ifindex, NTF_SELF, 0, true, NULL);
> +                     vxlan_fdb_update(vxlan, src_mac, src_ip, NUD_REACHA=
BLE,
> +                                      NLM_F_EXCL | NLM_F_CREATE,
> +                                      vxlan->cfg.dst_port, vni,
> +                                      vxlan->default_dst.remote_vni, ifi=
ndex,
> +                                      NTF_SELF, 0, true, NULL,
> +                                      RTPROT_UNSPEC);

Entries installed by the kernel should have RTPROT_KERNEL

>                spin_unlock(&vxlan->hash_lock);
>        }
>
> @@ -3963,15 +3972,13 @@ static int __vxlan_dev_create(struct net *net, st=
ruct net_device *dev,
>        /* create an fdb entry for a valid default destination */
>        if (!vxlan_addr_any(&dst->remote_ip)) {
>                spin_lock_bh(&vxlan->hash_lock);
> -             err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
> -                                    &dst->remote_ip,
> +             err =3D vxlan_fdb_update(vxlan, all_zeros_mac, &dst->remote=
_ip,
>                                       NUD_REACHABLE | NUD_PERMANENT,
>                                       NLM_F_EXCL | NLM_F_CREATE,
> -                                    vxlan->cfg.dst_port,
> -                                    dst->remote_vni,
> -                                    dst->remote_vni,
> -                                    dst->remote_ifindex,
> -                                    NTF_SELF, 0, true, extack);
> +                                    vxlan->cfg.dst_port, dst->remote_vni=
,
> +                                    dst->remote_vni, dst->remote_ifindex=
,
> +                                    NTF_SELF, 0, true, extack,
> +                                    RTPROT_UNSPEC);
>                spin_unlock_bh(&vxlan->hash_lock);
>                if (err)
>                        goto unlink;
> @@ -4416,10 +4423,10 @@ static int vxlan_changelink(struct net_device *de=
v, struct nlattr *tb[],
>                                               &conf.remote_ip,
>                                               NUD_REACHABLE | NUD_PERMANE=
NT,
>                                               NLM_F_APPEND | NLM_F_CREATE=
,
> -                                            vxlan->cfg.dst_port,
> -                                            conf.vni, conf.vni,
> -                                            conf.remote_ifindex,
> -                                            NTF_SELF, 0, true, extack);
> +                                            vxlan->cfg.dst_port, conf.vn=
i,
> +                                            conf.vni, conf.remote_ifinde=
x,
> +                                            NTF_SELF, 0, true, extack,
> +                                            RTPROT_UNSPEC);
>                        if (err) {
>                                spin_unlock_bh(&vxlan->hash_lock);
>                                netdev_adjacent_change_abort(dst->remote_d=
ev,
> @@ -4767,14 +4774,11 @@ vxlan_fdb_external_learn_add(struct net_device *d=
ev,
>
>        spin_lock_bh(&vxlan->hash_lock);
>        err =3D vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->rem=
ote_ip,
> -                            NUD_REACHABLE,
> -                            NLM_F_CREATE | NLM_F_REPLACE,
> -                            fdb_info->remote_port,
> -                            fdb_info->vni,
> -                            fdb_info->remote_vni,
> -                            fdb_info->remote_ifindex,
> -                            NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
> -                            0, false, extack);
> +                            NUD_REACHABLE, NLM_F_CREATE | NLM_F_REPLACE,
> +                            fdb_info->remote_port, fdb_info->vni,
> +                            fdb_info->remote_vni, fdb_info->remote_ifind=
ex,
> +                            NTF_USE | NTF_SELF | NTF_EXT_LEARNED, 0, fal=
se,
> +                            extack, RTPROT_UNSPEC);
>        spin_unlock_bh(&vxlan->hash_lock);
>
>        return err;
> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_=
private.h
> index 6c625fb29c6c..19d1b93be279 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -39,6 +39,7 @@ struct vxlan_fdb {
>        struct vxlan_fdb_key key;
>        u16               state; /* see ndm_state */
>        u16               flags; /* see ndm_flags and below */
> +     u8 protocol; /* protocol for FDB entry */
>        struct list_head  nh_list;
>        struct hlist_node fdb_node;
>        struct nexthop __rcu *nh;
> @@ -180,24 +181,22 @@ vxlan_vnifilter_lookup(struct vxlan_dev *vxlan, __b=
e32 vni)
>  }
>
>  /* vxlan_core.c */
> -int vxlan_fdb_create(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __be16 port, __be32 src_vni,
> -                  __be32 vni, __u32 ifindex, __u16 ndm_flags,
> +int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __be16 port,
> +                  __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_f=
lags,
>                     u32 nhid, struct vxlan_fdb **fdb,
> -                  struct netlink_ext_ack *extack);
> +                  struct netlink_ext_ack *extack, u8 protocol);
>  int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>                       const unsigned char *addr, union vxlan_addr ip,
>                       __be16 port, __be32 src_vni, __be32 vni,
>                       u32 ifindex, bool swdev_notify);
>  u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
>  u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
> -int vxlan_fdb_update(struct vxlan_dev *vxlan,
> -                  const u8 *mac, union vxlan_addr *ip,
> -                  __u16 state, __u16 flags,
> -                  __be16 port, __be32 src_vni, __be32 vni,
> -                  __u32 ifindex, __u16 ndm_flags, u32 nhid,
> -                  bool swdev_notify, struct netlink_ext_ack *extack);
> +int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
> +                  union vxlan_addr *ip, __u16 state, __u16 flags,
> +                  __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex=
,
> +                  __u16 ndm_flags, u32 nhid, bool swdev_notify,
> +                  struct netlink_ext_ack *extack, u8 protocol);
>  void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>                    __be32 default_vni, struct vxlan_rdst *rdst, bool did_=
rsc);
>  int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxla=
n_vnifilter.c
> index adc89e651e27..908b6b489ac8 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -482,15 +482,12 @@ static int vxlan_update_default_fdb_entry(struct vx=
lan_dev *vxlan, __be32 vni,
>
>        spin_lock_bh(&vxlan->hash_lock);
>        if (remote_ip && !vxlan_addr_any(remote_ip)) {
> -             err =3D vxlan_fdb_update(vxlan, all_zeros_mac,
> -                                    remote_ip,
> +             err =3D vxlan_fdb_update(vxlan, all_zeros_mac, remote_ip,
>                                       NUD_REACHABLE | NUD_PERMANENT,
>                                       NLM_F_APPEND | NLM_F_CREATE,
> -                                    vxlan->cfg.dst_port,
> -                                    vni,
> -                                    vni,
> -                                    dst->remote_ifindex,
> -                                    NTF_SELF, 0, true, extack);
> +                                    vxlan->cfg.dst_port, vni, vni,
> +                                    dst->remote_ifindex, NTF_SELF, 0, tr=
ue,
> +                                    extack, RTPROT_UNSPEC);
>                if (err) {
>                        spin_unlock_bh(&vxlan->hash_lock);
>                        return err;
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 1885d0c315f0..55f017e00247 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -173,8 +173,8 @@ static int br_switchdev_event(struct notifier_block *=
unused,
>        case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>                fdb_info =3D ptr;
>                err =3D br_fdb_external_learn_add(br, p, fdb_info->addr,
> -                                             fdb_info->vid,
> -                                             fdb_info->locked, false);
> +                                             fdb_info->vid, fdb_info->lo=
cked,
> +                                             false, RTPROT_UNSPEC);
>                if (err) {
>                        err =3D notifier_from_errno(err);
>                        break;
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 902694c0ce64..e1b93e495db3 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -123,6 +123,8 @@ static int fdb_fill_info(struct sk_buff *skb, const s=
truct net_bridge *br,
>                goto nla_put_failure;
>        if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
>                goto nla_put_failure;
> +     if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))
> +             goto nla_put_failure;

Need to patch fdb_nlmsg_size()

>        if (nla_put_u32(skb, NDA_FLAGS_EXT, ext_flags))
>                goto nla_put_failure;
>
> @@ -1153,7 +1155,8 @@ static int fdb_add_entry(struct net_bridge *br, str=
uct net_bridge_port *source,
>  static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>                        struct net_bridge_port *p, const unsigned char *ad=
dr,
>                        u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
> -                     bool *notified, struct netlink_ext_ack *extack)
> +                     bool *notified, struct netlink_ext_ack *extack,
> +                     u8 protocol)

Move this after 'vid' so it's closer to the other attributes.

>  {
>        int err =3D 0;
>
> @@ -1177,7 +1180,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct n=
et_bridge *br,
>                                           "FDB entry towards bridge must =
be permanent");
>                        return -EINVAL;
>                }
> -             err =3D br_fdb_external_learn_add(br, p, addr, vid, false, =
true);
> +             err =3D br_fdb_external_learn_add(br, p, addr, vid, false, =
true,
> +                                             protocol);
>        } else {
>                spin_lock_bh(&br->hash_lock);
>                err =3D fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nf=
ea_tb);
> @@ -1206,6 +1210,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>        struct net_bridge_vlan *v;
>        struct net_bridge *br =3D NULL;
>        u32 ext_flags =3D 0;
> +     u8 protocol =3D RTPROT_UNSPEC;
>        int err =3D 0;
>
>        trace_br_fdb_add(ndm, dev, addr, vid, nlh_flags);
> @@ -1237,6 +1242,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>        if (tb[NDA_FLAGS_EXT])
>                ext_flags =3D nla_get_u32(tb[NDA_FLAGS_EXT]);
>
> +     if (tb[NDA_PROTOCOL])
> +             protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +
>        if (ext_flags & NTF_EXT_LOCKED) {
>                NL_SET_ERR_MSG_MOD(extack, "Cannot add FDB entry with \"lo=
cked\" flag set");
>                return -EINVAL;
> @@ -1261,10 +1269,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *=
tb[],
>
>                /* VID was specified, so use it. */
>                err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfe=
a_tb,
> -                                notified, extack);
> +                                notified, extack, protocol);
>        } else {
>                err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_=
tb,
> -                                notified, extack);
> +                                notified, extack, protocol);
>                if (err || !vg || !vg->num_vlans)
>                        goto out;
>
> @@ -1276,7 +1284,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>                        if (!br_vlan_should_use(v))
>                                continue;
>                        err =3D __br_fdb_add(ndm, br, p, addr, nlh_flags, =
v->vid,
> -                                        nfea_tb, notified, extack);
> +                                        nfea_tb, notified, extack, proto=
col);
>                        if (err)
>                                goto out;
>                }
> @@ -1288,7 +1296,8 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb=
[],
>
>  static int fdb_delete_by_addr_and_port(struct net_bridge *br,
>                                       const struct net_bridge_port *p,
> -                                    const u8 *addr, u16 vlan, bool *noti=
fied)
> +                                    const u8 *addr, u16 vlan, u8 protoco=
l,
> +                                    bool *notified)
>  {
>        struct net_bridge_fdb_entry *fdb;
>
> @@ -1296,6 +1305,13 @@ static int fdb_delete_by_addr_and_port(struct net_=
bridge *br,
>        if (!fdb || READ_ONCE(fdb->dst) !=3D p)
>                return -ENOENT;
>
> +     /* If the delete comes from a different protocol type,
> +     * that type is used in the notification as some software
> +     * may be expecting multiple deletes (control learned +
> +     * hardware datapath learned) */
> +     if (protocol !=3D RTPROT_UNSPEC)
> +             fdb->protocol =3D protocol;

I don't understand this. The protocol that should be notified is the one
of the FDB entry being deleted.

> +
>        fdb_delete(br, fdb, true);
>        *notified =3D true;
>
> @@ -1304,12 +1320,13 @@ static int fdb_delete_by_addr_and_port(struct net=
_bridge *br,
>
>  static int __br_fdb_delete(struct net_bridge *br,
>                           const struct net_bridge_port *p,
> -                        const unsigned char *addr, u16 vid, bool *notifi=
ed)
> +                        const unsigned char *addr, u16 vid, u8 protocol,
> +                        bool *notified)
>  {
>        int err;
>
>        spin_lock_bh(&br->hash_lock);
> -     err =3D fdb_delete_by_addr_and_port(br, p, addr, vid, notified);
> +     err =3D fdb_delete_by_addr_and_port(br, p, addr, vid, protocol, not=
ified);
>        spin_unlock_bh(&br->hash_lock);
>
>        return err;
> @@ -1324,8 +1341,12 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr=
 *tb[],
>        struct net_bridge_vlan_group *vg;
>        struct net_bridge_port *p =3D NULL;
>        struct net_bridge *br;
> +     u8 protocol =3D RTPROT_UNSPEC;
>        int err;
>
> +     if (tb[NDA_PROTOCOL])
> +             protocol =3D nla_get_u8(tb[NDA_PROTOCOL]);
> +
>        if (netif_is_bridge_master(dev)) {
>                br =3D netdev_priv(dev);
>                vg =3D br_vlan_group(br);
> @@ -1341,19 +1362,20 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlatt=
r *tb[],
>        }
>
>        if (vid) {
> -             err =3D __br_fdb_delete(br, p, addr, vid, notified);
> +             err =3D __br_fdb_delete(br, p, addr, vid, protocol, notifie=
d);
>        } else {
>                struct net_bridge_vlan *v;
>
>                err =3D -ENOENT;
> -             err &=3D __br_fdb_delete(br, p, addr, 0, notified);
> +             err &=3D __br_fdb_delete(br, p, addr, 0, protocol, notified=
);
>                if (!vg || !vg->num_vlans)
>                        return err;
>
>                list_for_each_entry(v, &vg->vlan_list, vlist) {
>                        if (!br_vlan_should_use(v))
>                                continue;
> -                     err &=3D __br_fdb_delete(br, p, addr, v->vid, notif=
ied);
> +                     err &=3D __br_fdb_delete(br, p, addr, v->vid, proto=
col,
> +                                            notified);
>                }
>        }
>
> @@ -1414,7 +1436,7 @@ void br_fdb_unsync_static(struct net_bridge *br, st=
ruct net_bridge_port *p)
>
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_p=
ort *p,
>                              const unsigned char *addr, u16 vid, bool loc=
ked,
> -                           bool swdev_notify)
> +                           bool swdev_notify, u8 protocol)
>  {
>        struct net_bridge_fdb_entry *fdb;
>        bool modified =3D false;
> @@ -1445,6 +1467,7 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
>                        err =3D -ENOMEM;
>                        goto err_unlock;
>                }
> +             fdb->protocol =3D protocol;
>                fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>        } else {
>                if (locked &&
> @@ -1483,6 +1506,11 @@ int br_fdb_external_learn_add(struct net_bridge *b=
r, struct net_bridge_port *p,
>                    test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags=
))
>                        atomic_dec(&br->fdb_n_learned);
>
> +             if (fdb->protocol !=3D protocol) {
> +                     modified =3D true;
> +                     fdb->protocol =3D protocol;
> +             }
> +
>                if (modified)
>                        fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>        }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index b159aae594c0..dc14c3c102b2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -291,6 +291,7 @@ struct net_bridge_fdb_entry {
>        struct net_bridge_fdb_key       key;
>        struct hlist_node               fdb_node;
>        unsigned long                   flags;
> +     u8 protocol;

Align the name like other fields. I guess position in the structure is
OK since this field is not write-heavy and there is a 16 bytes hole
here.

>
>        /* write-heavy members should not affect lookups */
>        unsigned long                   updated ____cacheline_aligned_in_s=
mp;
> @@ -870,8 +871,8 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb=
[], struct net_device *dev,
>  int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p)=
;
>  void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port =
*p);
>  int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_p=
ort *p,
> -                           const unsigned char *addr, u16 vid,
> -                           bool locked, bool swdev_notify);
> +                           const unsigned char *addr, u16 vid, bool lock=
ed,
> +                           bool swdev_notify, u8 protocol);
>  int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_p=
ort *p,
>                              const unsigned char *addr, u16 vid,
>                              bool swdev_notify);
> --
> 2.43.0
>
>
