MIME-Version: 1.0
In-Reply-To: <20090820092510.20609ed5@nehalam>
References: <f0a957c30908191856x75df858bybfbdac23ad5a01e@mail.gmail.com>
	<20090820092510.20609ed5@nehalam>
Date: Fri, 21 Aug 2009 01:13:34 +0200
Message-ID: <f0a957c30908201613p2d10660agf6810551bd6883c@mail.gmail.com>
From: Gustavo Martin <gu.martinm@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cf8a0a08ff704719ae62b
Subject: Re: [Bridge] SPT functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

--0015175cf8a0a08ff704719ae62b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thank you very much!!!

- --
Gustavo Mart=EDn Morcuende
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Use GnuPG with Firefox : http://getfiregpg.org (Version: 0.7.8)

iEYEARECAAYFAkqN3AsACgkQ/bktI8Hg05DUDQCgm72GWMXgMc0rCSGtq2Fk24qo
H4EAnA4Vm4kpB86HMj1Kz476WiD1LiHQ
=3DL76l
-----END PGP SIGNATURE-----



2009/8/20 Stephen Hemminger <shemminger@linux-foundation.org>

> On Thu, 20 Aug 2009 03:56:16 +0200
> Gustavo Martin <gu.martinm@gmail.com> wrote:
>
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hello,
> >
> >      First, sorry for my english. I have to get better it.
> >      I am trying to develop a new protocol for the linux kernel 2.6.26
> > similar to RSTP by my free time. Because of it I am searching the
> bridging
> > code. I began from the function netif_receive_skb (I don't need to know
> > anything about the hardware or the interruptions) looking for the first
> > functions connected with the spanning tree protocol implementation.
> >      I found this:
> >
> > 1- The function netif_receive_skb calls to:  skb =3D handle_bridge(skb,
> > &amp;pt_prev, &amp;ret, orig_dev)
> > 2- In handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev) I found:
> return
> > br_handle_frame_hook(port, skb)
> > 3- In br_handle_frame I found:  if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN,
> skb,
> > skb->dev, NULL, br_handle_local_finish))
> > 4- In br_handle_local_finish I didn't find anything.
> >
> >      I have been reading the book "Understanding Linux Network Internal=
s
> > (2005)" but this book (I think) is for the kernel 2.6.16. In this book
> the
> > author speaks about the function br_stp_handle_bpdu. With the kernel
> 2.6.26
> > in spite of that function you can find br_handle_local_finish.
> >
> >      I continued searching in netif_receive_skb. In this function after
> the
> > call to handle_bridge I found this code:
> >
> > 2016       skb =3D handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev)=
;
> > 2107        if (!skb)
> > 2108                goto out;
> > 2109        skb =3D handle_macvlan(skb, &amp;pt_prev, &amp;ret, orig_de=
v);
> > 2110        if (!skb)
> > 2111                goto out;
> > 2112
> > 2113        type =3D skb->protocol;
> > 2114        list_for_each_entry_rcu(ptype,
> > 2115                        &amp;ptype_base[ntohs(type) &amp;
> > PTYPE_HASH_MASK], list) {
> > 2116                if (ptype->type =3D=3D type &amp;&amp;
> > 2117                    (!ptype->dev || ptype->dev =3D=3D skb->dev)) {
> > 2118                        if (pt_prev)
> > 2119                                ret =3D deliver_skb(skb, pt_prev,
> > orig_dev);
> > 2120                        pt_prev =3D ptype;
> > 2121                }
> > 2122        }
> > 2123
> > 2124        if (pt_prev) {
> > 2125                ret =3D pt_prev->func(skb, skb->dev, pt_prev,
> orig_dev);
> > 2126        } else {
> > 2127                kfree_skb(skb);
> > 2128                /* Jamal, now you will not able to escape explainin=
g
> > 2129                 * me how you were going to use this. :-)
> > 2130                 */
> > 2131                ret =3D NET_RX_DROP;
> > 2132        }
> >
> >
> >      My question (probably stupid question, sorry but this is my first
> time
> > with the linux kernel) is:  Where connect the SPANING TREE PROTOCOL
> > functions with the bridging code?
>
> net/bridge/br_stp_*.c
>
> You might be better off looking at the RSTP code in user space.
> See:
>   http://git.kernel.org/?p=3Dlinux/kernel/git/shemminger/rstp.git;a=3Dsum=
mary
>
> To get:
>   git clone git://
> git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
>
>

--0015175cf8a0a08ff704719ae62b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br>Thank you very much=
!!!<br><br>- -- <br>Gustavo Mart=EDn Morcuende<br>-----BEGIN PGP SIGNATURE-=
----<br>Version: GnuPG v1.4.9 (GNU/Linux)<br>Comment: Use GnuPG with Firefo=
x : <a href=3D"http://getfiregpg.org">http://getfiregpg.org</a> (Version: 0=
.7.8)<br>
<br>iEYEARECAAYFAkqN3AsACgkQ/bktI8Hg05DUDQCgm72GWMXgMc0rCSGtq2Fk24qo<br>H4E=
AnA4Vm4kpB86HMj1Kz476WiD1LiHQ<br>=3DL76l<br>-----END PGP SIGNATURE-----<br>=
<br><br><br><div class=3D"gmail_quote">2009/8/20 Stephen Hemminger <span di=
r=3D"ltr">&lt;<a href=3D"mailto:shemminger@linux-foundation.org" target=3D"=
_blank">shemminger@linux-foundation.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div>On Thu, 20 Aug 2009 03:56:16 +0200<br>
Gustavo Martin &lt;<a href=3D"mailto:gu.martinm@gmail.com" target=3D"_blank=
">gu.martinm@gmail.com</a>&gt; wrote:<br>
<br>
&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; Hash: SHA1<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; =A0 =A0 =A0First, sorry for my english. I have to get better it.<br>
&gt; =A0 =A0 =A0I am trying to develop a new protocol for the linux kernel =
2.6.26<br>
&gt; similar to RSTP by my free time. Because of it I am searching the brid=
ging<br>
&gt; code. I began from the function netif_receive_skb (I don&#39;t need to=
 know<br>
&gt; anything about the hardware or the interruptions) looking for the firs=
t<br>
&gt; functions connected with the spanning tree protocol implementation.<br=
>
&gt; =A0 =A0 =A0I found this:<br>
&gt;<br>
&gt; 1- The function netif_receive_skb calls to: =A0skb =3D handle_bridge(s=
kb,<br>
&gt; &amp;amp;pt_prev, &amp;amp;ret, orig_dev)<br>
&gt; 2- In handle_bridge(skb, &amp;amp;pt_prev, &amp;amp;ret, orig_dev) I f=
ound: return<br>
&gt; br_handle_frame_hook(port, skb)<br>
&gt; 3- In br_handle_frame I found: =A0if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_I=
N, skb,<br>
&gt; skb-&gt;dev, NULL, br_handle_local_finish))<br>
&gt; 4- In br_handle_local_finish I didn&#39;t find anything.<br>
&gt;<br>
&gt; =A0 =A0 =A0I have been reading the book &quot;Understanding Linux Netw=
ork Internals<br>
&gt; (2005)&quot; but this book (I think) is for the kernel 2.6.16. In this=
 book the<br>
&gt; author speaks about the function br_stp_handle_bpdu. With the kernel 2=
.6.26<br>
&gt; in spite of that function you can find br_handle_local_finish.<br>
&gt;<br>
&gt; =A0 =A0 =A0I continued searching in netif_receive_skb. In this functio=
n after the<br>
&gt; call to handle_bridge I found this code:<br>
&gt;<br>
&gt; 2016 =A0 =A0 =A0 skb =3D handle_bridge(skb, &amp;amp;pt_prev, &amp;amp=
;ret, orig_dev);<br>
&gt; 2107 =A0 =A0 =A0 =A0if (!skb)<br>
&gt; 2108 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
&gt; 2109 =A0 =A0 =A0 =A0skb =3D handle_macvlan(skb, &amp;amp;pt_prev, &amp=
;amp;ret, orig_dev);<br>
&gt; 2110 =A0 =A0 =A0 =A0if (!skb)<br>
&gt; 2111 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
&gt; 2112<br>
&gt; 2113 =A0 =A0 =A0 =A0type =3D skb-&gt;protocol;<br>
&gt; 2114 =A0 =A0 =A0 =A0list_for_each_entry_rcu(ptype,<br>
&gt; 2115 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&amp;amp;ptype_bas=
e[ntohs(type) &amp;amp;<br>
&gt; PTYPE_HASH_MASK], list) {<br>
&gt; 2116 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ptype-&gt;type =3D=3D type &am=
p;amp;&amp;amp;<br>
&gt; 2117 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(!ptype-&gt;dev || ptype-&=
gt;dev =3D=3D skb-&gt;dev)) {<br>
&gt; 2118 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pt_prev)<br>
&gt; 2119 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0re=
t =3D deliver_skb(skb, pt_prev,<br>
&gt; orig_dev);<br>
&gt; 2120 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pt_prev =3D ptype;=
<br>
&gt; 2121 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
&gt; 2122 =A0 =A0 =A0 =A0}<br>
&gt; 2123<br>
&gt; 2124 =A0 =A0 =A0 =A0if (pt_prev) {<br>
&gt; 2125 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D pt_prev-&gt;func(skb, skb-=
&gt;dev, pt_prev, orig_dev);<br>
&gt; 2126 =A0 =A0 =A0 =A0} else {<br>
&gt; 2127 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree_skb(skb);<br>
&gt; 2128 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Jamal, now you will not able to=
 escape explaining<br>
&gt; 2129 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * me how you were going to use th=
is. :-)<br>
&gt; 2130 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */<br>
&gt; 2131 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D NET_RX_DROP;<br>
&gt; 2132 =A0 =A0 =A0 =A0}<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0My question (probably stupid question, sorry but this is my=
 first time<br>
&gt; with the linux kernel) is: =A0Where connect the SPANING TREE PROTOCOL<=
br>
&gt; functions with the bridging code?<br>
<br>
</div></div>net/bridge/br_stp_*.c<br>
<br>
You might be better off looking at the RSTP code in user space.<br>
See:<br>
 =A0 <a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/shemminger/rstp=
.git;a=3Dsummary" target=3D"_blank">http://git.kernel.org/?p=3Dlinux/kernel=
/git/shemminger/rstp.git;a=3Dsummary</a><br>
<br>
To get:<br>
 =A0 git clone git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/=
git/shemminger/rstp.git" target=3D"_blank">git.kernel.org/pub/scm/linux/ker=
nel/git/shemminger/rstp.git</a><br>
<br>
</blockquote></div><br><br>

--0015175cf8a0a08ff704719ae62b--
