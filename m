Return-Path: <saurav.barik@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=wAkvAGcbkx8bAmy7WMtP2hPeZmmr9ZZZDXO/UvKQ6Ro=;
	b=nWvE3Jct1JlXKWWPU0o+6uQVD7Ku5XMCaeTPuololx54oJX3bJWfaapXL3Jo4zWdFh
	7D25cK6tkCM0OMk8etsHcxMbw1V4+SkzLH6PYW0EF/lWZvSykmYDYs9Jv+TMnha13nAz
	hqtkTBO2oqslB2npaqWOc93Ib/qvA6sJVmeW/f8z5yRdv+CJjy+LUVIWrhxOyYB2ed7m
	07KHADSbtw57wvcFxucDzoFSrhWy78KBvKpSr76Nz1um0Ezb1bCS8B8ezwmLWX/Int9E
	fEnUBG+nqDZLVtrbzE7o/PoXbEgh9F7gKmkMFGnsE5x0wQtDcDL+zXM59z0EAfG9gDsQ
	J41A==
MIME-Version: 1.0
In-Reply-To: <20150731135728.GG6366@odroid>
References: <CAJkjprMLMZXqPuAEX3Hi46Wsu1QxUuPjK-mK_M9CHPsUFvv3nA@mail.gmail.com>
	<20150731135728.GG6366@odroid>
Date: Fri, 31 Jul 2015 19:56:12 +0530
Message-ID: <CAJkjprPDtCvofL13CxBwhB=+kjKDP21BZpb40ycaipFcQWN+vw@mail.gmail.com>
From: saurav barik <saurav.barik@gmail.com>
Content-Type: multipart/alternative; boundary=047d7bfcf3060dc717051c2c9a9a
Subject: Re: [Bridge] Multicast packets are not bridged from ethernet to
 wireless interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux-foundation.org

--047d7bfcf3060dc717051c2c9a9a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks Linus.
Sorry, it will not be possible to move to recent kernel.

How does the mdb gets updated for multicast addresses? Is it learnt on
basis of packets received from the network? For example, the multicast
address I use for iperf is 234.100.100.100. I mentioned two scenarios in my
earlier email. In case of eth0 being the active port on the mbr (multicast
working scenario), I see br_multicast_new_group() and
br_multicast_add_group() being called for this IP address moments after mbr
is up. However in case of wlan0 as the uplink port of mbr, I don't see
those functions being called.

I guess for unicast packets, if the entry is not present in fdb, the packet
is flooded on all other ports and its learnt and added to fdb based on the
port on which response packet arrives. Is it true for Multicast packets too=
?

Regards,
Saurav

On Fri, Jul 31, 2015 at 7:27 PM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue>
wrote:

> Hi Saurav,
>
> On Fri, Jul 31, 2015 at 03:50:35PM +0530, saurav barik wrote:
> > I am working on an Access Point device (AP1) running linux kernel 3.0.3=
4
> on
> > which my bridge configuration is as follows.
>
> There were quite some crucial bugs, I'm not quite sure whether
> 3.0.34 was actually usuable for multicast snooping.
>
> Any chance to try a recent kernel?
>
> Cheers, Linus
>

--047d7bfcf3060dc717051c2c9a9a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Than=
ks Linus.<br>Sorry, it will not be possible to move to recent kernel.<br><b=
r></div><div class=3D"gmail_quote">How does the mdb gets updated for multic=
ast addresses? Is it learnt on basis of packets received from the network? =
For example, the multicast address I use for iperf is 234.100.100.100. I me=
ntioned two scenarios in my earlier email. In case of eth0 being the active=
 port on the mbr (multicast working scenario), I see br_multicast_new_group=
() and br_multicast_add_group() being called for this IP address moments af=
ter mbr is up. However in case of wlan0 as the uplink port of mbr, I don&#3=
9;t see those functions being called.<br><br></div><div class=3D"gmail_quot=
e">I guess for unicast packets, if the entry is not present in fdb, the pac=
ket is flooded on all other ports and its learnt and added to fdb based on =
the port on which response packet arrives. Is it true for Multicast packets=
 too?<br></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quo=
te">Regards,<br></div><div class=3D"gmail_quote">Saurav<br></div><div class=
=3D"gmail_quote"><br>On Fri, Jul 31, 2015 at 7:27 PM, Linus L=C3=BCssing <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:linus.luessing@c0d3.blue" target=3D"_=
blank">linus.luessing@c0d3.blue</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Saurav,<br>
<span class=3D""><br>
On Fri, Jul 31, 2015 at 03:50:35PM +0530, saurav barik wrote:<br>
&gt; I am working on an Access Point device (AP1) running linux kernel 3.0.=
34 on<br>
&gt; which my bridge configuration is as follows.<br>
<br>
</span>There were quite some crucial bugs, I&#39;m not quite sure whether<b=
r>
3.0.34 was actually usuable for multicast snooping.<br>
<br>
Any chance to try a recent kernel?<br>
<br>
Cheers, Linus<br>
</blockquote></div><br></div></div>

--047d7bfcf3060dc717051c2c9a9a--
