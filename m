Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0ADC832DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0EB2831F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sIJhUs2xs8d8dbgkeos7RFovvkvQarZnFueA0N+X/Co=;
 b=YTvL8gC0cwQNUYYG38j9Sf08AI5fEClrJniPuoEhYYjLT6pJg0RppaZ5kyMC35f5bk
 IcyNtENSW+iuww6lbRNnt7UWtMwRvsVFOdS2suVrA6Y/JpkY7X9//BXES+0FSk/9w5In
 TCZgLFE+u/WiZRXQwSnWzFKT+LbsPbAvZDQe+sLayTyQiJydE0h/pc6C/aoLSAb1OCtF
 KOVz5qHmEb5upCdEMM/APP3zAFJeTNlB3/Xwj9eXpvFxJUFs5za5RvuvD5E8Z28ZGPJy
 9sL8XbdXcxsxrPPP3KVOyAuMSGko7s2xRRG6+Nt+BOlv4Z5ok3v++fOuDAJzl+rOWMXg
 9dBQ==
MIME-Version: 1.0
References: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
 <f7ede054-f0b3-558a-091f-04b4f7139564@blackwall.org>
In-Reply-To: <f7ede054-f0b3-558a-091f-04b4f7139564@blackwall.org>
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 30 Jul 2022 12:46:06 -0400
Message-ID: <CAMWRUK5j4UAwjw4UGN=SVbbDbut0zWg5e03wupAXCPwT8K8zzQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000079a87005e508815d"
Subject: Re: [Bridge] [PATCH net-next 0/3] net: vlan: fix bridge binding
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

--00000000000079a87005e508815d
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 30, 2022 at 12:22 PM Nikolay Aleksandrov <razor@blackwall.org>
wrote:

> On 7/30/22 19:03, Sevinj Aghayeva wrote:
> > When bridge binding is enabled for a vlan interface, it is expected
> > that the link state of the vlan interface will track the subset of the
> > ports that are also members of the corresponding vlan, rather than
> > that of all ports.
> >
> > Currently, this feature works as expected when a vlan interface is
> > created with bridge binding enabled:
> >
> >    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
> >          bridge_binding on
> >
> > However, the feature does not work when a vlan interface is created
> > with bridge binding disabled, and then enabled later:
> >
> >    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
> >          bridge_binding off
> >    ip link set vlan10 type vlan bridge_binding on
> >
> > After these two commands, the link state of the vlan interface
> > continues to track that of all ports, which is inconsistent and
> > confusing to users. This series fixes this bug and introduces two
> > tests for the valid behavior.
> >
> > Sevinj Aghayeva (3):
> >    net: bridge: export br_vlan_upper_change
> >    net: 8021q: fix bridge binding behavior for vlan interfaces
> >    selftests: net: tests for bridge binding behavior
> >
> >   include/linux/if_bridge.h                     |   9 ++
> >   net/8021q/vlan.h                              |   2 +-
> >   net/8021q/vlan_dev.c                          |  21 ++-
> >   net/bridge/br_vlan.c                          |   7 +-
> >   tools/testing/selftests/net/Makefile          |   1 +
> >   .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
> >   6 files changed, 176 insertions(+), 7 deletions(-)
> >   create mode 100755
> tools/testing/selftests/net/bridge_vlan_binding_test.sh
> >
>
> Hmm.. I don't like this and don't think this bridge function should be
> exported at all.
>
> Calling bridge state changing functions from 8021q module is not the
> proper way to solve this. The problem is that the bridge doesn't know
> that the state has changed, so you can process NETDEV_CHANGE events and
> check for the bridge vlan which got its state changed and react based on
> it. I haven't checked in detail, but I think it should be doable. So all
> the logic is kept inside the bridge.
>

Hi Nik,

Can please elaborate on where I should process NETDEV_CHANGE events? I'm
doing this as part of outreachy project and this is my first kernel task,
so I don't know the bridging code that well.

Thanks!


>
> Cheers,
>   Nik
>


-- 

Sevinj.Aghayeva

--00000000000079a87005e508815d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 30, 2022 at 12:22 PM Niko=
lay Aleksandrov &lt;<a href=3D"mailto:razor@blackwall.org">razor@blackwall.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 7/30/22 19:03, Sevinj Aghayeva wrote:<br>
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
&gt;=C2=A0 =C2=A0 ip link add link br name vlan10 type vlan id 10 protocol =
802.1q \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bridge_binding on<br>
&gt; <br>
&gt; However, the feature does not work when a vlan interface is created<br=
>
&gt; with bridge binding disabled, and then enabled later:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 ip link add link br name vlan10 type vlan id 10 protocol =
802.1q \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bridge_binding off<br>
&gt;=C2=A0 =C2=A0 ip link set vlan10 type vlan bridge_binding on<br>
&gt; <br>
&gt; After these two commands, the link state of the vlan interface<br>
&gt; continues to track that of all ports, which is inconsistent and<br>
&gt; confusing to users. This series fixes this bug and introduces two<br>
&gt; tests for the valid behavior.<br>
&gt; <br>
&gt; Sevinj Aghayeva (3):<br>
&gt;=C2=A0 =C2=A0 net: bridge: export br_vlan_upper_change<br>
&gt;=C2=A0 =C2=A0 net: 8021q: fix bridge binding behavior for vlan interfac=
es<br>
&gt;=C2=A0 =C2=A0 selftests: net: tests for bridge binding behavior<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/linux/if_bridge.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 ++<br>
&gt;=C2=A0 =C2=A0net/8021q/vlan.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
&gt;=C2=A0 =C2=A0net/8021q/vlan_dev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 21 ++-<br>
&gt;=C2=A0 =C2=A0net/bridge/br_vlan.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
&gt;=C2=A0 =C2=A0tools/testing/selftests/net/Makefile=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0.../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 176 insertions(+), 7 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100755 tools/testing/selftests/net/bridge_vlan=
_binding_test.sh<br>
&gt; <br>
<br>
Hmm.. I don&#39;t like this and don&#39;t think this bridge function should=
 be <br>
exported at all.<br>
<br>
Calling bridge state changing functions from 8021q module is not the <br>
proper way to solve this. The problem is that the bridge doesn&#39;t know <=
br>
that the state has changed, so you can process NETDEV_CHANGE events and <br=
>
check for the bridge vlan which got its state changed and react based on <b=
r>
it. I haven&#39;t checked in detail, but I think it should be doable. So al=
l<br>
the logic is kept inside the bridge.<br></blockquote><div><br></div><div>Hi=
 Nik,</div><div><br></div><div>Can please elaborate on where I should proce=
ss NETDEV_CHANGE events? I&#39;m doing this as part of outreachy project an=
d this is my first kernel task, so I don&#39;t know the bridging code that =
well.</div><div><br></div><div>Thanks!</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Cheers,<br>
=C2=A0 Nik<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div><div>Sevinj.Agha=
yeva</div></div></div></div>

--00000000000079a87005e508815d--
