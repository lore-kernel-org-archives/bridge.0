MIME-Version: 1.0
In-Reply-To: <AANLkTiknsL37-LsLRD3Ndv8Qkur8sxW038g3DeXX7Xa1@mail.gmail.com>
References: <AANLkTin=6Uf_fwGWJ9Q6CQct1cARtHWHJ0geNRz0JDed@mail.gmail.com>
	<20101012101051.43dfd499@nehalam>
	<AANLkTiknsL37-LsLRD3Ndv8Qkur8sxW038g3DeXX7Xa1@mail.gmail.com>
Date: Wed, 13 Oct 2010 08:44:12 +0200
Message-ID: <AANLkTinekwamO6frk0YM85ptVa79pNhO7Lk+n84b2_Db@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: multipart/alternative; boundary=001485f723d0e01293049279ebfa
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

--001485f723d0e01293049279ebfa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2010/10/13 Jean-Michel Hautbois <jhautbois@gmail.com>

> 2010/10/12 Stephen Hemminger <shemminger@linux-foundation.org>
>
>> > Thus, my jitter is 47=C2=B5s.
>> > This may seem low, but this is about two to three times what I expect
>> and I
>> > cannot see why a bridge which is only forwarding a frame would have
>> jitter ?
>> > If you have any idea, everything is interesting for me.
>> > I thought maybe to skb_clone ?
>>
>> You probably have NAPI and/or interrupt coalescing setting
>> enabled on one or both of the devices.
>>
>> --
>>
>
> Hi Stephen,
>
> I have NAPI on my ethernet device, at least.
> I will check for interrupt coalescing.
> AFAIK, there is a skb_clone followed by a kfree in netif_receive_skb (the
> frame coming from eth0 to br0).
> There is a jitter in this call of "freeing memory". I am looking at the
> path, in order to see why there is a clone.
>
> BR,
> JM
>

I have to tell I am working on a mpc52xx and am currently only interested i=
n
the eth->br path for the moment.
JM

--001485f723d0e01293049279ebfa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2010/10/13 Jean-Michel Hautbois <span dir=3D"ltr=
">&lt;<a href=3D"mailto:jhautbois@gmail.com">jhautbois@gmail.com</a>&gt;</s=
pan><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid r=
gb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"gmail_quote">2010/10/12 Stephen Hemminger <span dir=3D"ltr">&=
lt;<a href=3D"mailto:shemminger@linux-foundation.org" target=3D"_blank">she=
mminger@linux-foundation.org</a>&gt;</span><br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">
<div><div></div><div>&gt; Thus, my jitter is 47=C2=B5s.<br>
&gt; This may seem low, but this is about two to three times what I expect =
and I<br>
&gt; cannot see why a bridge which is only forwarding a frame would have ji=
tter ?<br>
&gt; If you have any idea, everything is interesting for me.<br>
&gt; I thought maybe to skb_clone ?<br>

<br>
</div></div></div><div class=3D"im">You probably have NAPI and/or interrupt=
 coalescing setting<br>
enabled on one or both of the devices.<br>
<font color=3D"#888888"><br>
--<br>
</font></div></blockquote></div><br>Hi Stephen,<br><br>I have NAPI on my et=
hernet device, at least.<br>I will check for interrupt coalescing.<br>AFAIK=
, there is a skb_clone followed by a kfree in netif_receive_skb (the frame =
coming from eth0 to br0).<br>

There is a jitter in this call of &quot;freeing memory&quot;. I am looking =
at the path, in order to see why there is a clone.<br><br>BR,<br><font colo=
r=3D"#888888">JM<br>
</font></blockquote></div><br>I have to tell I am working on a mpc52xx and =
am currently only interested in the eth-&gt;br path for the moment.<br>JM<b=
r>

--001485f723d0e01293049279ebfa--
