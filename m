Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k1P3Y5KcTgUHU2mC7q6Eh1Wa9ToCw2l2iR/tA2vzR4I=;
 b=Ck6x8U6cRd++Vs08614bd5FirYAglGi7jdxollKezH8QXJK7JK1O3fRZ5xieiLgCy+
 zjkyhCLZH+gKaBVtHX5RxG8hZvxZUQLTvfKbBxLlB0+aZt91I5mlMZFqciAlC9FZWJlW
 T4qG/mhSJ0C1HSgpqHuetEx1IdzV21DaumvZL2fnJIABxWjOJpTprN1TCJH97sUgvt1+
 y4lyd4b6l5tkntLKOSVdZNzVtwGy7v5EqzHQ+DPx+4k/u2GGyTNHRqQiNEACaX/oByZP
 i5n8PxKc6lrahgbpLli6O5GaUbxRnXCTaS6m2kTQo5Yupkjq3vP9lfpNrn+40uduSU9F
 UvDA==
MIME-Version: 1.0
References: <86sfov2w8k.fsf@gmail.com> <YpCgxtJf9Qe7fTFd@shredder>
 <86sfoqgi5e.fsf@gmail.com> <YpYk4EIeH6sdRl+1@shredder>
 <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
 <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
 <YpiTbOsh0HBMwiTE@shredder>
 <86mtevjmie.fsf@gmail.com> <YpiqlziXDCg/1FJH@shredder>
In-Reply-To: <YpiqlziXDCg/1FJH@shredder>
From: Hans S <schultz.hans@gmail.com>
Date: Thu, 2 Jun 2022 14:53:00 +0200
Message-ID: <CAKUejP5Wa5hLZ_SfETPFewUiHgdnkYsCwbx7WcW1Uw7HBQ9icA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000009789005e0767df3"
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

--00000000000009789005e0767df3
Content-Type: text/plain; charset="UTF-8"

On tor, jun 02, 2022 at 15:18, Ido Schimmel <idosch@nvidia.com> wrote:
> On Thu, Jun 02, 2022 at 02:08:41PM +0200, Hans Schultz wrote:
>
> br_fdb_find_rcu() does a lookup in the bridge driver FDB, but per the
> output above, the entry isn't there for some reason. It's only in HW.
>
> Can it be that you driver is deleting these entries from the bridge
> driver FDB via SWITCHDEV_FDB_DEL_TO_BRIDGE for some reason?
>

Yes, that sounds much like the case. So the replace of course just
modifies the SW fdb entry, and then it obviously removes the HW entry,
which triggers SWITCHDEV_FDB_DEL_TO_BRIDGE and then adds the replaced,
but because it comes from the SW bridge it doesn't need to do more.
But as there are only ops for port_fdb_add() and port_fdb_del(), there
is no way to know how to handle a replace. So it ends up just deleting
the SW fdb entry after all...

It is difficult for me to see how this scenario will be able to work
differently, or?

On Thu, Jun 2, 2022 at 2:18 PM Ido Schimmel <idosch@nvidia.com> wrote:

> On Thu, Jun 02, 2022 at 02:08:41PM +0200, Hans Schultz wrote:
> > >
> > > I think Hans is testing with mv88e6xxx which dumps entries directly
> from
> > > HW via ndo_fdb_dump(). See dsa_slave_port_fdb_do_dump() which sets
> > > NTF_SELF.
> > >
> > > Hans, are you seeing the entry twice? Once with 'master' and once with
> > > 'self'?
> > >
> >
> > When replacing a locked entry it looks like this:
> >
> > # bridge fdb show dev eth6 | grep 4c
> > 00:4c:4c:4c:4c:4c vlan 1 master br0 extern_learn offload locked
> >
> > # bridge fdb replace 00:4c:4c:4c:4c:4c dev eth6 vlan 1 master static ;
> bridge fdb show dev eth6 | grep 4c
> > 00:4c:4c:4c:4c:4c vlan 1 self static
>
> This output means that the FDB entry was deleted from the bridge driver
> FDB.
>
> >
> > The problem is then that the function
> > br_fdb_find_rcu(br,eth_hdr(skb)->h_source, vid);
> > , where the h_source and vid is the entry above, does not find the entry.
> > My hypothesis was then that this is because of the 'self' flag that I
> > see.
>
> br_fdb_find_rcu() does a lookup in the bridge driver FDB, but per the
> output above, the entry isn't there for some reason. It's only in HW.
>
> Can it be that you driver is deleting these entries from the bridge
> driver FDB via SWITCHDEV_FDB_DEL_TO_BRIDGE for some reason?
>
> >
> > I am thinking that the function dsa_slave_port_fdb_do_dump() is only for
> > debug, and thus does not really set any flags in the bridge modules FDB,
> > but then I don't understand why the above find function does not find
> > the entry?
>

--00000000000009789005e0767df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On tor, jun 02, 2022 at 15:18, Ido Schimmel &lt;<a href=3D=
"mailto:idosch@nvidia.com">idosch@nvidia.com</a>&gt; wrote:<br>&gt; On Thu,=
 Jun 02, 2022 at 02:08:41PM +0200, Hans Schultz wrote:<br>&gt;<br>&gt; br_f=
db_find_rcu() does a lookup in the bridge driver FDB, but per the<br>&gt; o=
utput above, the entry isn&#39;t there for some reason. It&#39;s only in HW=
.<br>&gt;<br>&gt; Can it be that you driver is deleting these entries from =
the bridge<br>&gt; driver FDB via SWITCHDEV_FDB_DEL_TO_BRIDGE for some reas=
on?<br>&gt;<br><br>Yes, that sounds much like the case. So the replace of c=
ourse just<br>modifies the SW fdb entry, and then it obviously removes the =
HW entry,<br>which triggers SWITCHDEV_FDB_DEL_TO_BRIDGE and then adds the r=
eplaced,<br>but because it comes from the SW bridge it doesn&#39;t need to =
do more.<br>But as there are only ops for port_fdb_add() and port_fdb_del()=
, there<br>is no way to know how to handle a replace. So it ends up just de=
leting<br>the SW fdb entry after all...<br><br>It is difficult for me to se=
e how this scenario will be able to work<br>differently, or?<br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun=
 2, 2022 at 2:18 PM Ido Schimmel &lt;<a href=3D"mailto:idosch@nvidia.com">i=
dosch@nvidia.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Thu, Jun 02, 2022 at 02:08:41PM +0200, Hans Schultz wrot=
e:<br>
&gt; &gt;<br>
&gt; &gt; I think Hans is testing with mv88e6xxx which dumps entries direct=
ly from<br>
&gt; &gt; HW via ndo_fdb_dump(). See dsa_slave_port_fdb_do_dump() which set=
s<br>
&gt; &gt; NTF_SELF.<br>
&gt; &gt;<br>
&gt; &gt; Hans, are you seeing the entry twice? Once with &#39;master&#39; =
and once with<br>
&gt; &gt; &#39;self&#39;?<br>
&gt; &gt;<br>
&gt; <br>
&gt; When replacing a locked entry it looks like this:<br>
&gt; <br>
&gt; # bridge fdb show dev eth6 | grep 4c<br>
&gt; 00:4c:4c:4c:4c:4c vlan 1 master br0 extern_learn offload locked<br>
&gt; <br>
&gt; # bridge fdb replace 00:4c:4c:4c:4c:4c dev eth6 vlan 1 master static ;=
 bridge fdb show dev eth6 | grep 4c<br>
&gt; 00:4c:4c:4c:4c:4c vlan 1 self static<br>
<br>
This output means that the FDB entry was deleted from the bridge driver<br>
FDB.<br>
<br>
&gt; <br>
&gt; The problem is then that the function<br>
&gt; br_fdb_find_rcu(br,eth_hdr(skb)-&gt;h_source, vid);<br>
&gt; , where the h_source and vid is the entry above, does not find the ent=
ry.<br>
&gt; My hypothesis was then that this is because of the &#39;self&#39; flag=
 that I<br>
&gt; see.<br>
<br>
br_fdb_find_rcu() does a lookup in the bridge driver FDB, but per the<br>
output above, the entry isn&#39;t there for some reason. It&#39;s only in H=
W.<br>
<br>
Can it be that you driver is deleting these entries from the bridge<br>
driver FDB via SWITCHDEV_FDB_DEL_TO_BRIDGE for some reason?<br>
<br>
&gt; <br>
&gt; I am thinking that the function dsa_slave_port_fdb_do_dump() is only f=
or<br>
&gt; debug, and thus does not really set any flags in the bridge modules FD=
B,<br>
&gt; but then I don&#39;t understand why the above find function does not f=
ind<br>
&gt; the entry?<br>
</blockquote></div>

--00000000000009789005e0767df3--
