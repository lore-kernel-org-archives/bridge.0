MIME-Version: 1.0
In-Reply-To: <4DB540CA.8030903@gmail.com>
References: <4DB540CA.8030903@gmail.com>
Date: Mon, 25 Apr 2011 16:32:18 +0530
Message-ID: <BANLkTimgVfBmKyE8YcO4_TuQvCf_Y-vfNQ@mail.gmail.com>
From: Sasikanth V <sasikanth.v19@gmail.com>
Content-Type: multipart/alternative; boundary=00504502ecd51f46dd04a1bc2465
Subject: Re: [Bridge] mind-boggling questions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-2?Q?Ireneusz_Szcze=B6niak?= <irek.szczesniak@gmail.com>
Cc: bridge@lists.linux-foundation.org

--00504502ecd51f46dd04a1bc2465
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

2011/4/25 Ireneusz Szcze=B6niak <irek.szczesniak@gmail.com>

> Hi,
>
> I have a few questions on the Linux bridge, and I would appreciate it
> if someone could answer them.
>
> 1. Why does a bridge have a MAC address?  A bridge doesn't need a MAC
> address. I understand that a Linux box might offer more than a regular
> switch, and for that you need a MAC address. But the services should
>

    Yes, Linux bridge needs mac address. Because linux works based on the
802.1D bridge
    which has MAC relay entity,  Spanning tree protocol entity. The bridge
required mac-address to communicate
    with other bridges. For example to form a loop-free network
spanning-tree protocol in the bridges will communicate with
    the bridges using BPDU, the bpdus carry the bridge address to identify
from which bridge we have received the BPDU.
    If your bridge just acts as forwarding  agent, then mac address is not
requried.

be provided by a new tap interface added to the bridge. I believe that
> the bridge should not even be shown by ifconfig.
>

    I am not familiar with tap interface, So ignoring it.
    I agree with you that bridge should not be shown in ifconfig. Bridge
must come up  when anyone of the bridge ports are up.
    But in current implementation we have to issue ifconfig <bridge> up  to
make the bridge up. As far as i see it is not required.
    Hope someone can give more clarification and its purpose

>
>
2. Why does a bridge take the lowest MAC address of the interfaces
> connected to it?
>

       From 802.1D

       7.12.5 Unique identification of a bridge
       A unique 48-bit Universally Administered MAC Address, termed the
Bridge Address, shall be assigned to
       each Bridge. The Bridge Address may be the individual MAC Address of
a Bridge Port, in which case, use
       of the address of the lowest numbered Bridge Port (Port 1) is
recommended.

>
> 3. When I send broadcast frames to a bridge interface (etherwake -b -i
> br0 00:00:00:00:00:00), the frames are received by the interfaces of
> the bridge.  But when I send the frames to one of the interfaces, they
> are not broadcasted to other interfaces.  I though that the bridge
> interface (br0) behaves the same as an interface added to the bridge,
> but I was mistaken.  What are the differences?
>
>     no idea

>
> Thanks,
> Irek
>
> --
> Ireneusz (Irek) Szczesniak
> http://www.irkos.org
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--00504502ecd51f46dd04a1bc2465
Content-Type: text/html; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote">2011/4/25 Ireneusz Szcze=B6niak=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:irek.szczesniak@gmail.com">irek.sz=
czesniak@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi,<br>
<br>
I have a few questions on the Linux bridge, and I would appreciate it<br>
if someone could answer them.<br>
<br>
1. Why does a bridge have a MAC address? =A0A bridge doesn&#39;t need a MAC=
<br>
address. I understand that a Linux box might offer more than a regular<br>
switch, and for that you need a MAC address. But the services should<br></b=
lockquote><div>=A0</div><div>=A0=A0=A0 Yes, Linux bridge needs mac address.=
 Because linux works based on the 802.1D bridge <br>
=A0 =A0 which has MAC relay entity,=A0 Spanning tree protocol entity. The b=
ridge required mac-address to communicate<br>=A0=A0=A0 with other bridges. =
For example to form a loop-free network spanning-tree protocol in the bridg=
es will communicate with<br>
=A0=A0=A0 the bridges using BPDU, the bpdus carry the bridge address to ide=
ntify from which bridge we have received the BPDU.<br>=A0=A0=A0 If your bri=
dge just acts as forwarding=A0 agent, then mac address is not requried.<br>=
<br></div>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
be provided by a new tap interface added to the bridge. I believe that<br>
the bridge should not even be shown by ifconfig.<br></blockquote><div><br>=
=A0 =A0 I am not familiar with tap interface, So ignoring it.<br>=A0=A0=A0 =
I agree with you that bridge should not be shown in ifconfig. Bridge must c=
ome up=A0 when anyone of the bridge ports are up.<br>
=A0=A0=A0 But in current implementation we have to issue ifconfig &lt;bridg=
e&gt; up=A0 to make the bridge up. As far as i see it is not required.<br>=
=A0=A0=A0 Hope someone can give more clarification and its purpose<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bord=
er-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

=A0 =A0=A0 <br></blockquote><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-l=
eft: 1ex;">
2. Why does a bridge take the lowest MAC address of the interfaces<br>
connected to it?<br></blockquote><div>=A0<br>=A0=A0=A0=A0=A0=A0 From 802.1D=
<br><br></div><div>=A0=A0=A0=A0=A0=A0 7.12.5 Unique identification of a bri=
dge<br>=A0=A0=A0=A0=A0=A0 A unique 48-bit Universally Administered MAC Addr=
ess, termed the Bridge Address, shall be assigned to<br>
=A0=A0=A0=A0=A0=A0 each Bridge. The Bridge Address may be the individual MA=
C Address of a Bridge Port, in which case, use<br>=A0=A0=A0=A0=A0=A0 of the=
 address of the lowest numbered Bridge Port (Port 1) is recommended. <br></=
div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<br>
3. When I send broadcast frames to a bridge interface (etherwake -b -i<br>
br0 00:00:00:00:00:00), the frames are received by the interfaces of<br>
the bridge. =A0But when I send the frames to one of the interfaces, they<br=
>
are not broadcasted to other interfaces. =A0I though that the bridge<br>
interface (br0) behaves the same as an interface added to the bridge,<br>
but I was mistaken. =A0What are the differences?<br>
<br></blockquote><div>=A0 =A0 no idea <br></div><div></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px soli=
d rgb(204, 204, 204); padding-left: 1ex;">
<br>
Thanks,<br>
Irek<br>
<font color=3D"#888888"><br>
--<br>
Ireneusz (Irek) Szczesniak<br>
<a href=3D"http://www.irkos.org" target=3D"_blank">http://www.irkos.org</a>=
<br>
_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
></font> <br></blockquote></div></div>

--00504502ecd51f46dd04a1bc2465--
