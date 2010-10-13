MIME-Version: 1.0
In-Reply-To: <20101012101051.43dfd499@nehalam>
References: <AANLkTin=6Uf_fwGWJ9Q6CQct1cARtHWHJ0geNRz0JDed@mail.gmail.com>
	<20101012101051.43dfd499@nehalam>
Date: Wed, 13 Oct 2010 08:40:22 +0200
Message-ID: <AANLkTiknsL37-LsLRD3Ndv8Qkur8sxW038g3DeXX7Xa1@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: multipart/alternative; boundary=0016364ef610291b76049279defe
Subject: Re: [Bridge] Real time issues when using a bridge
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

--0016364ef610291b76049279defe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2010/10/12 Stephen Hemminger <shemminger@linux-foundation.org>

> > Thus, my jitter is 47=C2=B5s.
> > This may seem low, but this is about two to three times what I expect a=
nd
> I
> > cannot see why a bridge which is only forwarding a frame would have
> jitter ?
> > If you have any idea, everything is interesting for me.
> > I thought maybe to skb_clone ?
>
> You probably have NAPI and/or interrupt coalescing setting
> enabled on one or both of the devices.
>
> --
>

Hi Stephen,

I have NAPI on my ethernet device, at least.
I will check for interrupt coalescing.
AFAIK, there is a skb_clone followed by a kfree in netif_receive_skb (the
frame coming from eth0 to br0).
There is a jitter in this call of "freeing memory". I am looking at the
path, in order to see why there is a clone.

BR,
JM

--0016364ef610291b76049279defe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2010/10/12 Stephen Hemminger <span dir=3D"ltr">&=
lt;<a href=3D"mailto:shemminger@linux-foundation.org">shemminger@linux-foun=
dation.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
<div><div></div><div class=3D"h5">&gt; Thus, my jitter is 47=C2=B5s.<br>
&gt; This may seem low, but this is about two to three times what I expect =
and I<br>
&gt; cannot see why a bridge which is only forwarding a frame would have ji=
tter ?<br>
&gt; If you have any idea, everything is interesting for me.<br>
&gt; I thought maybe to skb_clone ?<br>

<br>
</div></div>You probably have NAPI and/or interrupt coalescing setting<br>
enabled on one or both of the devices.<br>
<font color=3D"#888888"><br>
--<br>
</font></blockquote></div><br>Hi Stephen,<br><br>I have NAPI on my ethernet=
 device, at least.<br>I will check for interrupt coalescing.<br>AFAIK, ther=
e is a skb_clone followed by a kfree in netif_receive_skb (the frame coming=
 from eth0 to br0).<br>
There is a jitter in this call of &quot;freeing memory&quot;. I am looking =
at the path, in order to see why there is a clone.<br><br>BR,<br>JM<br>

--0016364ef610291b76049279defe--
