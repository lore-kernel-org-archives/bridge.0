MIME-Version: 1.0
Date: Thu, 20 Aug 2009 03:56:16 +0200
Message-ID: <f0a957c30908191856x75df858bybfbdac23ad5a01e@mail.gmail.com>
From: Gustavo Martin <gu.martinm@gmail.com>
Content-Type: multipart/alternative; boundary=0015175d026c9704750471890e43
Subject: [Bridge] SPT functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0015175d026c9704750471890e43
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

     First, sorry for my english. I have to get better it.
     I am trying to develop a new protocol for the linux kernel 2.6.26
similar to RSTP by my free time. Because of it I am searching the bridging
code. I began from the function netif_receive_skb (I don't need to know
anything about the hardware or the interruptions) looking for the first
functions connected with the spanning tree protocol implementation.
     I found this:

1- The function netif_receive_skb calls to:  skb =3D handle_bridge(skb,
&amp;pt_prev, &amp;ret, orig_dev)
2- In handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev) I found: return
br_handle_frame_hook(port, skb)
3- In br_handle_frame I found:  if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb,
skb->dev, NULL, br_handle_local_finish))
4- In br_handle_local_finish I didn't find anything.

     I have been reading the book "Understanding Linux Network Internals
(2005)" but this book (I think) is for the kernel 2.6.16. In this book the
author speaks about the function br_stp_handle_bpdu. With the kernel 2.6.26
in spite of that function you can find br_handle_local_finish.

     I continued searching in netif_receive_skb. In this function after the
call to handle_bridge I found this code:

2016       skb =3D handle_bridge(skb, &amp;pt_prev, &amp;ret, orig_dev);
2107        if (!skb)
2108                goto out;
2109        skb =3D handle_macvlan(skb, &amp;pt_prev, &amp;ret, orig_dev);
2110        if (!skb)
2111                goto out;
2112
2113        type =3D skb->protocol;
2114        list_for_each_entry_rcu(ptype,
2115                        &amp;ptype_base[ntohs(type) &amp;
PTYPE_HASH_MASK], list) {
2116                if (ptype->type =3D=3D type &amp;&amp;
2117                    (!ptype->dev || ptype->dev =3D=3D skb->dev)) {
2118                        if (pt_prev)
2119                                ret =3D deliver_skb(skb, pt_prev,
orig_dev);
2120                        pt_prev =3D ptype;
2121                }
2122        }
2123
2124        if (pt_prev) {
2125                ret =3D pt_prev->func(skb, skb->dev, pt_prev, orig_dev)=
;
2126        } else {
2127                kfree_skb(skb);
2128                /* Jamal, now you will not able to escape explaining
2129                 * me how you were going to use this. :-)
2130                 */
2131                ret =3D NET_RX_DROP;
2132        }


     My question (probably stupid question, sorry but this is my first time
with the linux kernel) is:  Where connect the SPANING TREE PROTOCOL
functions with the bridging code?


     Thanks in advance.

- --
Gustavo Mart=EDn Morcuende
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Use GnuPG with Firefox : http://getfiregpg.org (Version: 0.7.8)

iEYEARECAAYFAkqMsJMACgkQ/bktI8Hg05BBtACeI3MSI3HgY2rX5p+zoOi6NOKA
uxEAn1WAk3W+a9r8gsvHWhRGr78hMrih
=3DYALX
-----END PGP SIGNATURE-----

--0015175d026c9704750471890e43
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----<br>Hash: SHA1<br><br>Hello,<br><br>=A0=
=A0=A0=A0 First, sorry for my english. I have to get better it. <br>=A0=A0=
=A0=A0 I am trying to develop a new protocol for the linux kernel 2.6.26 si=
milar to RSTP by my free time. Because of it I am searching the bridging co=
de. I began from the function netif_receive_skb (I don&#39;t need to know a=
nything about the hardware or the interruptions) looking for the first func=
tions connected with the spanning tree protocol implementation.<br>
=A0=A0=A0=A0 I found this:<br><br>1- The function netif_receive_skb calls t=
o:=A0 skb =3D handle_bridge(skb, &amp;amp;pt_prev, &amp;amp;ret, orig_dev)<=
br>2- In handle_bridge(skb, &amp;amp;pt_prev, &amp;amp;ret, orig_dev) I fou=
nd: return br_handle_frame_hook(port, skb)<br>
3- In br_handle_frame I found:=A0 if (NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, sk=
b, skb-&gt;dev, NULL, br_handle_local_finish))<br>4- In br_handle_local_fin=
ish I didn&#39;t find anything.<br><br>=A0=A0=A0=A0 I have been reading the=
 book &quot;Understanding Linux Network Internals (2005)&quot; but this boo=
k (I think) is for the kernel 2.6.16. In this book the author speaks about =
the function br_stp_handle_bpdu. With the kernel 2.6.26 in spite of that fu=
nction you can find br_handle_local_finish. <br>
<br>=A0=A0=A0=A0 I continued searching in netif_receive_skb. In this functi=
on after the call to handle_bridge I found this code:<br><br>2016=A0=A0=A0=
=A0=A0=A0 skb =3D handle_bridge(skb, &amp;amp;pt_prev, &amp;amp;ret, orig_d=
ev);<br>2107=A0=A0=A0=A0=A0=A0=A0 if (!skb)<br>
2108=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;<br>2109=A0=A0=
=A0=A0=A0=A0=A0 skb =3D handle_macvlan(skb, &amp;amp;pt_prev, &amp;amp;ret,=
 orig_dev);<br>2110=A0=A0=A0=A0=A0=A0=A0 if (!skb)<br>2111=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;<br>2112<br>2113=A0=A0=A0=A0=A0=A0=
=A0 type =3D skb-&gt;protocol;<br>
2114=A0=A0=A0=A0=A0=A0=A0 list_for_each_entry_rcu(ptype,<br>2115=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &amp;amp;ptype=
_base[ntohs(type) &amp;amp; PTYPE_HASH_MASK], list) {<br>2116=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ptype-&gt;type =3D=3D type &amp;amp;&=
amp;amp;<br>2117=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (=
!ptype-&gt;dev || ptype-&gt;dev =3D=3D skb-&gt;dev)) {<br>
2118=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i=
f (pt_prev)<br>2119=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D deliver_skb(skb, pt_prev, o=
rig_dev);<br>2120=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 pt_prev =3D ptype;<br>2121=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 }<br>2122=A0=A0=A0=A0=A0=A0=A0 }<br>2123<br>
2124=A0=A0=A0=A0=A0=A0=A0 if (pt_prev) {<br>2125=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ret =3D pt_prev-&gt;func(skb, skb-&gt;dev, pt_prev, orig=
_dev);<br>2126=A0=A0=A0=A0=A0=A0=A0 } else {<br>2127=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 kfree_skb(skb);<br>2128=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 /* Jamal, now you will not able to escape explaining<br>
2129=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * me how you were goin=
g to use this. :-)<br>2130=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
*/<br>2131=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D NET_RX_DROP=
;<br>2132=A0=A0=A0=A0=A0=A0=A0 }<br><br><br>=A0=A0=A0=A0 My question (proba=
bly stupid question, sorry but this is my first time with the linux kernel)=
 is:=A0 Where connect the SPANING TREE PROTOCOL functions with the bridging=
 code?<br>
=A0=A0=A0 <br><br>=A0=A0=A0=A0 Thanks in advance.<br><br>- -- <br>Gustavo M=
art=EDn Morcuende<br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.9=
 (GNU/Linux)<br>Comment: Use GnuPG with Firefox : <a href=3D"http://getfire=
gpg.org">http://getfiregpg.org</a> (Version: 0.7.8)<br>
<br>iEYEARECAAYFAkqMsJMACgkQ/bktI8Hg05BBtACeI3MSI3HgY2rX5p+zoOi6NOKA<br>uxE=
An1WAk3W+a9r8gsvHWhRGr78hMrih<br>=3DYALX<br>-----END PGP SIGNATURE-----<br>=
<br>

--0015175d026c9704750471890e43--
