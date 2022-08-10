Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BF2B61052
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CED8761044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=H9+C7ir/K3+U6Hi2EPNgTS9vwG14ANU2roIVmwoaGBA=;
 b=j+4DX4cd5684JKLCDrNVS+8evZS/vmWqDPj9KGTqsrWGJoy9dsIE8fYe1IR78lB6AM
 oVfLms2BwDWFtR1y8OrX/Yhc2NK/x53Gh+DUHh8sG2Ub26nT/6lZb+wgnNt6TQEm/6OV
 rCRa+nRWV1Bd78QXW4PZEcacxNCoU4si0Ib+SmyxzHiZnZPfv/rtCxZ5yndB5JTBZked
 aU67uRfa2DM1vGISfvPc4mDQnbctSS9ynqx+rDpdz1IU/iUFk4vTRnM2ciHkoOv8606w
 dsrd7WwV8sUjJeobreDWve5UAXpSVvX33NAK7LeCSLsHKBB+rG7wlmQ1ZRcXbIauKhy/
 jkjw==
MIME-Version: 1.0
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
 <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
In-Reply-To: <94ec6182-0804-7a0e-dcba-42655ff19884@blackwall.org>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Wed, 10 Aug 2022 10:42:09 -0400
Message-ID: <CAMWRUK45nbZS3PeSLR1X=Ko6oavrjKj2AWeh2F1wckMPrz_dEg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000067f5ec05e5e40ed2"
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

--00000000000067f5ec05e5e40ed2
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 10, 2022 at 4:54 AM Nikolay Aleksandrov <razor@blackwall.org>
wrote:

> On 10/08/2022 06:11, Sevinj Aghayeva wrote:
> > When bridge binding is enabled for a vlan interface, it is expected
> > that the link state of the vlan interface will track the subset of the
> > ports that are also members of the corresponding vlan, rather than
> > that of all ports.
> >
> > Currently, this feature works as expected when a vlan interface is
> > created with bridge binding enabled:
> >
> >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
> >         bridge_binding on
> >
> > However, the feature does not work when a vlan interface is created
> > with bridge binding disabled, and then enabled later:
> >
> >   ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
> >         bridge_binding off
> >   ip link set vlan10 type vlan bridge_binding on
> >
> > After these two commands, the link state of the vlan interface
> > continues to track that of all ports, which is inconsistent and
> > confusing to users. This series fixes this bug and introduces two
> > tests for the valid behavior.
> >
> > Sevinj Aghayeva (3):
> >   net: core: export call_netdevice_notifiers_info
> >   net: 8021q: fix bridge binding behavior for vlan interfaces
> >   selftests: net: tests for bridge binding behavior
> >
> >  include/linux/netdevice.h                     |   2 +
> >  net/8021q/vlan.h                              |   2 +-
> >  net/8021q/vlan_dev.c                          |  25 ++-
> >  net/core/dev.c                                |   7 +-
> >  tools/testing/selftests/net/Makefile          |   1 +
> >  .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
> >  6 files changed, 172 insertions(+), 8 deletions(-)
> >  create mode 100755
> tools/testing/selftests/net/bridge_vlan_binding_test.sh
> >
>
> Hi,
> NETDEV_CHANGE event is already propagated when the vlan changes flags,


I'm not sure if NETDEV_CHANGE is actually propagated when the vlan changes
flags. The two functions in the bridge module that handle NETDEV_CHANGE are
br_vlan_port_event  and br_vlan_bridge_event. I've installed probes for
both, and when I'm changing flags using "sudo ip link set vlan10 type vlan
bridge_binding on", I don't see any of those functions getting called,
although I do see vlan_dev_change_flags getting called. I think there may
be a bug in core/dev.c:__dev_notify_flags.


>
> NETDEV_CHANGEUPPER is used when the devices' relationship changes not
> their flags.
> The only problem you have to figure out is that the flag has changed. The
> fix itself
> must be done within the bridge, not 8021q. You can figure it out based on
> current bridge
> loose binding state and the vlan's changed state, again in the bridge's
> NETDEV_CHANGE
> handler. Unfortunately the proper fix is much more involved and will need
> new
> infra, you'll have to track the loose binding vlans in the bridge. To do
> that you should
> add logic that reflects the current vlans' loose binding state *only* for
> vlans that also
> exist in the bridge, the rest which are upper should be carrier off if
> they have the loose
> binding flag set.
>
> Alternatively you can add a new NETDEV_ notifier (using something similar
> to struct netdev_notifier_pre_changeaddr_info)
> and add link type-specific space (e.g. union of link type-specific
> structs) in the struct which will contain
> what changed for 8021q and will be properly interpreted by the bridge. The
> downside is that we'll generate
> 2 notifications when changing the loose binding flag, but on the bright
> side won't have to track anything
> in the bridge, just handle the new notifier type. This might be the
> easiest path, the fix is still in
> the bridge though, the 8021q module just needs to fill in the new struct
> and emit the notification on
> any loose binding changes, the bridge must decide if it should process it
> (i.e. based on upper/lower
> relationship). Such notifier can be also re-used by other link types to
> propagate link-type specific
> changes.
>

I'll discuss this option with my mentors. Thanks.


>
> Both of these avoid any direct dependencies between the bridge and 8021q.
> Any other suggestions that
> are simpler, avoid direct dependencies and solve the issue in a generic
> way would be appreciated.
>
> Just be careful about introducing too much unnecessary processing because
> we
> can have lots of vlan devices in a system.
>
> Cheers,
>  Nik
>


-- 

Sevinj.Aghayeva

--00000000000067f5ec05e5e40ed2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 10, 2022 at 4:54 AM Nikol=
ay Aleksandrov &lt;<a href=3D"mailto:razor@blackwall.org">razor@blackwall.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 10/08/2022 06:11, Sevinj Aghayeva wrote:<br>
&gt; When bridge binding is enabled for a vlan interface, it is expected<br=
>
&gt; that the link state of the vlan interface will track the subset of the=
<br>
&gt; ports that are also members of the corresponding vlan, rather than<br>
&gt; that of all ports.<br>
&gt; <br>
&gt; Currently, this feature works as expected when a vlan interface is<br>
&gt; created with bridge binding enabled:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0ip link add link br name vlan10 type vlan id 10 protocol 8=
02.1q \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_binding on<br>
&gt; <br>
&gt; However, the feature does not work when a vlan interface is created<br=
>
&gt; with bridge binding disabled, and then enabled later:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0ip link add link br name vlan10 type vlan id 10 protocol 8=
02.1q \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_binding off<br>
&gt;=C2=A0 =C2=A0ip link set vlan10 type vlan bridge_binding on<br>
&gt; <br>
&gt; After these two commands, the link state of the vlan interface<br>
&gt; continues to track that of all ports, which is inconsistent and<br>
&gt; confusing to users. This series fixes this bug and introduces two<br>
&gt; tests for the valid behavior.<br>
&gt; <br>
&gt; Sevinj Aghayeva (3):<br>
&gt;=C2=A0 =C2=A0net: core: export call_netdevice_notifiers_info<br>
&gt;=C2=A0 =C2=A0net: 8021q: fix bridge binding behavior for vlan interface=
s<br>
&gt;=C2=A0 =C2=A0selftests: net: tests for bridge binding behavior<br>
&gt; <br>
&gt;=C2=A0 include/linux/netdevice.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 net/8021q/vlan.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-=
<br>
&gt;=C2=A0 net/8021q/vlan_dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 25 ++-<br>
&gt;=C2=A0 net/core/dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A07 +-<br>
&gt;=C2=A0 tools/testing/selftests/net/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++=
++++++<br>
&gt;=C2=A0 6 files changed, 172 insertions(+), 8 deletions(-)<br>
&gt;=C2=A0 create mode 100755 tools/testing/selftests/net/bridge_vlan_bindi=
ng_test.sh<br>
&gt; <br>
<br>
Hi,<br>
NETDEV_CHANGE event is already propagated when the vlan changes flags,</blo=
ckquote><div><br></div><div>I&#39;m not sure if NETDEV_CHANGE is actually p=
ropagated when the vlan changes flags. The two functions in the bridge modu=
le that handle NETDEV_CHANGE are br_vlan_port_event=C2=A0 and br_vlan_bridg=
e_event. I&#39;ve installed probes for both, and when I&#39;m changing flag=
s using &quot;sudo ip link set vlan10 type vlan bridge_binding on&quot;, I =
don&#39;t see any of those functions getting called, although I do see vlan=
_dev_change_flags getting called. I think there may be a bug in core/dev.c:=
__dev_notify_flags.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"> <br>
NETDEV_CHANGEUPPER is used when the devices&#39; relationship changes not t=
heir flags.<br>
The only problem you have to figure out is that the flag has changed. The f=
ix itself<br>
must be done within the bridge, not 8021q. You can figure it out based on c=
urrent bridge<br>
loose binding state and the vlan&#39;s changed state, again in the bridge&#=
39;s NETDEV_CHANGE<br>
handler. Unfortunately the proper fix is much more involved and will need n=
ew<br>
infra, you&#39;ll have to track the loose binding vlans in the bridge. To d=
o that you should<br>
add logic that reflects the current vlans&#39; loose binding state *only* f=
or vlans that also<br>
exist in the bridge, the rest which are upper should be carrier off if they=
 have the loose<br>
binding flag set.<br>
<br>
Alternatively you can add a new NETDEV_ notifier (using something similar t=
o struct netdev_notifier_pre_changeaddr_info)<br>
and add link type-specific space (e.g. union of link type-specific structs)=
 in the struct which will contain<br>
what changed for 8021q and will be properly interpreted by the bridge. The =
downside is that we&#39;ll generate<br>
2 notifications when changing the loose binding flag, but on the bright sid=
e won&#39;t have to track anything<br>
in the bridge, just handle the new notifier type. This might be the easiest=
 path, the fix is still in<br>
the bridge though, the 8021q module just needs to fill in the new struct an=
d emit the notification on<br>
any loose binding changes, the bridge must decide if it should process it (=
i.e. based on upper/lower<br>
relationship). Such notifier can be also re-used by other link types to pro=
pagate link-type specific<br>
changes.<br></blockquote><div><br></div><div>I&#39;ll discuss this option w=
ith my mentors. Thanks.</div><div>=C2=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Both of these avoid any direct dependencies between the bridge and 8021q. A=
ny other suggestions that<br>
are simpler, avoid direct dependencies and solve the issue in a generic way=
 would be appreciated.<br>
<br>
Just be careful about introducing too much unnecessary processing because w=
e<br>
can have lots of vlan devices in a system.<br>
<br>
Cheers,<br>
=C2=A0Nik<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div><div>Sevinj.Agha=
yeva</div></div></div></div>

--00000000000067f5ec05e5e40ed2--
