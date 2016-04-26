Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=iScVjj8XVlPm5YCv45ovCw5rPodtNlWmnIzG3bfvlec=;
	b=TmhVq2vwDzgclG+LvtjfN2QGxFXGgncscvcj0GkDfnB8w9bmTYrcrlKEZaX5Y7+Ze7
	dyCpi/rmOITpvuzTdold49E2tV6XlZXmEN2Vi1wNhNMlb4BEzolfsHeVOamx3wbAcxZ5
	gmmyMH2aTsrFfys/nfAls2JbJY0uncG9KAFfQjuYqOC5vn6vjSD/y6MqtLyTB2sKXSto
	WPEEnTjsOQ7naDIbfJK58A/oWwla98TeG7C5mvDpFlzyBhYMHYfxVkv6bTKqu8rRrkhw
	GjaA7eN5er95qrF3qs4KiR5M80LlvtqkX5jTdXiqTd96CxmIeXjf+FdBl9/zVkPyOq/C
	RNKg==
MIME-Version: 1.0
In-Reply-To: <571F6F45.7070000@man.szczecin.pl>
References: <571F6F45.7070000@man.szczecin.pl>
Date: Tue, 26 Apr 2016 09:49:59 -0700
Message-ID: <CAOaVG17inj4fb8R42q5PTMPUtgS0SQHErZmoNEUGFsJeXFdB=A@mail.gmail.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Content-Type: multipart/alternative; boundary=001a113f328a68b2ad05316615cf
Subject: Re: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Seweryn Niemiec <ser@man.szczecin.pl>
Cc: bridge <bridge@lists.linux-foundation.org>

--001a113f328a68b2ad05316615cf
Content-Type: text/plain; charset=UTF-8

This usualy happens when you either have a loop or packet leaks in from
other port.


On Tue, Apr 26, 2016 at 6:38 AM, Seweryn Niemiec <ser@man.szczecin.pl>
wrote:

> Hi,
>
> On one of my servers, the most basic thing doesn't work and after 2 days
> of unsuccessful digging in my severs and the Internet, I'm desperate enough
> to write to this list :)
>
> Ubuntu server with kernel 3.19.0-33-generic #38~14.04.1-Ubuntu has p2p1.17
> physical interface attached to bri17 bridge. When I start some LXC
> container, it creates for ex. vethPQORXD interface and adds it to bri17
> bridge. It looks like this:
>
> # brctl show bri17
> bridge name     bridge id               STP enabled     interfaces
> bri17           8000.00163eaaaa30       no              p2p1.17
>                                                         vethPQORXD
>
> LXC container's eth0 interface (linked to vethPQORXD) has mac
> 00:16:3e:aa:aa:66. When I add IP do this eth0 and ping something to
> generate eth frame, that mac is learned on p2p1.17 port instead of
> vethPQORXD:
>
> # brctl showmacs bri17
> port no mac addr                is local?       ageing timer
>   1     00:16:3e:aa:aa:66       no               112.50
> [... some other macs ...]
>   1     3c:fd:fe:01:ee:e0       yes                0.00
>   1     3c:fd:fe:01:ee:e0       yes                0.00
>   2     fe:56:74:59:a4:9e       yes                0.00
>   2     fe:56:74:59:a4:9e       yes                0.00
>
> Of course it makes communication of outside world with that container
> impossible (host<->container works).
>
> Any ideas why this happens?
>
> --
> Best regards,
> Seweryn Niemiec
>
>

--001a113f328a68b2ad05316615cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This usualy happens when you either have a loop or packet =
leaks in from other port.<div><br></div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Tue, Apr 26, 2016 at 6:38 AM, Seweryn Niemi=
ec <span dir=3D"ltr">&lt;<a href=3D"mailto:ser@man.szczecin.pl" target=3D"_=
blank">ser@man.szczecin.pl</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi,<br>
<br>
On one of my servers, the most basic thing doesn&#39;t work and after 2 day=
s of unsuccessful digging in my severs and the Internet, I&#39;m desperate =
enough to write to this list :)<br>
<br>
Ubuntu server with kernel 3.19.0-33-generic #38~14.04.1-Ubuntu has p2p1.17 =
physical interface attached to bri17 bridge. When I start some LXC containe=
r, it creates for ex. vethPQORXD interface and adds it to bri17 bridge. It =
looks like this:<br>
<br>
# brctl show bri17<br>
bridge name=C2=A0 =C2=A0 =C2=A0bridge id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0STP enabled=C2=A0 =C2=A0 =C2=A0interfaces<br>
bri17=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08000.00163eaaaa30=C2=A0 =C2=
=A0 =C2=A0 =C2=A0no=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p2p1.17=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vethPQORXD<br>
<br>
LXC container&#39;s eth0 interface (linked to vethPQORXD) has mac 00:16:3e:=
aa:aa:66. When I add IP do this eth0 and ping something to generate eth fra=
me, that mac is learned on p2p1.17 port instead of vethPQORXD:<br>
<br>
# brctl showmacs bri17<br>
port no mac addr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is =
local?=C2=A0 =C2=A0 =C2=A0 =C2=A0ageing timer<br>
=C2=A0 1=C2=A0 =C2=A0 =C2=A000:16:3e:aa:aa:66=C2=A0 =C2=A0 =C2=A0 =C2=A0no=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0112.50<br>
[... some other macs ...]<br>
=C2=A0 1=C2=A0 =C2=A0 =C2=A03c:fd:fe:01:ee:e0=C2=A0 =C2=A0 =C2=A0 =C2=A0yes=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00<br>
=C2=A0 1=C2=A0 =C2=A0 =C2=A03c:fd:fe:01:ee:e0=C2=A0 =C2=A0 =C2=A0 =C2=A0yes=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00<br>
=C2=A0 2=C2=A0 =C2=A0 =C2=A0fe:56:74:59:a4:9e=C2=A0 =C2=A0 =C2=A0 =C2=A0yes=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00<br>
=C2=A0 2=C2=A0 =C2=A0 =C2=A0fe:56:74:59:a4:9e=C2=A0 =C2=A0 =C2=A0 =C2=A0yes=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00<br>
<br>
Of course it makes communication of outside world with that container impos=
sible (host&lt;-&gt;container works).<br>
<br>
Any ideas why this happens?<span class=3D"HOEnZb"><font color=3D"#888888"><=
br>
<br>
-- <br>
Best regards,<br>
Seweryn Niemiec<br>
<br>
</font></span></blockquote></div><br></div>

--001a113f328a68b2ad05316615cf--
