Return-Path: <yinxu@redhat.com>
MIME-Version: 1.0
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
	<20181213161027.GC1713@otheros>
In-Reply-To: <20181213161027.GC1713@otheros>
From: Ying Xu <yinxu@redhat.com>
Date: Fri, 14 Dec 2018 10:32:16 +0800
Message-ID: <CALRz_Py6ogxQsnR-5w-92At1z51M76bgMAeO9A9xqhCFy1pApA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000002a11d057cf23e60"
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, liuhangbin@gmail.com, davem@davemloft.net

--00000000000002a11d057cf23e60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 I think the scenario mentioned above is abnormal.
According to rfc 4541, multicast router port means this port is attached to
a real router.

The source of query indicats that is a real router or only a
switch.(0.0.0.0 means switch,non-zero means router).
In the scenario above,the switch A was selected to be a querier that means
A performs as a router,
so switch A should config its query source address to non-zero,and then
Host A can recieve the traffic from B.

On Fri, Dec 14, 2018 at 12:10 AM Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue>
wrote:

> Even though RFC4541 recommends this, I'm not quite sure whether
> this works... even for IGMP.
>
> I think this would lead to multicast packet loss in a scenario
> like this:
>
> ----------
>
>      [Switch A] -------------- [Switch B]
>         /                          /
>        /                          /
>       /                          /
>  (Host A)                   (Host B)
>
>
> - Snooping Switches: Switch A + Switch B
> - Selected Querier: Switch A, with 0.0.0.0 query source
> - Multicast Listener: Host A
> - Multicast Data Sender: Host B
>
> 1) Host A sends IGMP report to Switch A
> 2) Switch A refrains from forwarding it to Switch B
>    (reports are only forwarded to multicast routers according to
>     RFC4541)
>    =3D> Switch B does not learn about listeners on Host A
>
> Now, with this patch and recommendation in RFC4541 to not add queries
> with a 0.0.0.0 source address to the multicast router port list:
>
> 3) Host B sends multicast data to Switch B
>    =3D> Switch B does not forward it to Switch A as it neither
>       detected a multicast listener nor multicast router on
>       the according port.
>    =3D> Host A does not receive the multicast data it signed up for
>
> (Or with colors:
>
> https://metameute.de/~tux/linux/bridge/query-zero-source-no-mcrouter-port=
.png
> )
>
> ----------
>
> Alternatively we would need to ignore 0.0.0.0 for the querier
> election and "querier present" detection. And by that disable
> multicast snooping if there are no queries from a non-zero source
> address.
>
> But I'm a little hesitant whether ignoring is a reliable way as
> IGMPv3 (RFC3376) and IGMPv2 (RFC2236) make no such restrictions
> regarding the query source address.
>
> With no such restrictions according to RFC3376/RFC2236 a 0.0.0.0
> would always win the querier election. Meaning any potential
> querier with a non-zero source address would remain silent.
> Meaning we would always disable multicast snooping then?
>
>
> Adding queriers with a 0.0.0.0 source address to the multicast
> router list, too, seems like a less harmful way then disabling multicast
> snooping completely?
>
> ----------
>
> However, one of the two options seems to be necessary. Either
> reverting the patch for the IGMP part, too. Or Ignoring 0.0.0.0
> sources for querier eletcion and presence detection.
>
> The current state seems broken to me unless I'm missing something.
>

--00000000000002a11d057cf23e60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">=C2=A0I think the scenario mentioned abov=
e is abnormal.<br>According to rfc 4541, multicast router port means this p=
ort is attached to a real router. <br><br>The source of query indicats that=
 is a real router or only a switch.(0.0.0.0 means switch,non-zero means rou=
ter).<br>In the scenario above,the switch A was selected to be a querier th=
at means A performs as a router,<br>so switch A should config its query sou=
rce address to non-zero,and then Host A can recieve the traffic from B.<br>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Dec 14,=
 2018 at 12:10 AM Linus L=C3=BCssing &lt;linus.luessing@c0d3.blue&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Even though RFC4541 recommends th=
is, I&#39;m not quite sure whether<br>
this works... even for IGMP.<br>
<br>
I think this would lead to multicast packet loss in a scenario<br>
like this:<br>
<br>
----------<br>
<br>
=C2=A0 =C2=A0 =C2=A0[Switch A] -------------- [Switch B]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /<br>
=C2=A0 =C2=A0 =C2=A0 /=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /<br>
=C2=A0(Host A)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(Host B)<br>
<br>
<br>
- Snooping Switches: Switch A + Switch B<br>
- Selected Querier: Switch A, with 0.0.0.0 query source<br>
- Multicast Listener: Host A<br>
- Multicast Data Sender: Host B<br>
<br>
1) Host A sends IGMP report to Switch A<br>
2) Switch A refrains from forwarding it to Switch B<br>
=C2=A0 =C2=A0(reports are only forwarded to multicast routers according to<=
br>
=C2=A0 =C2=A0 RFC4541)<br>
=C2=A0 =C2=A0=3D&gt; Switch B does not learn about listeners on Host A<br>
<br>
Now, with this patch and recommendation in RFC4541 to not add queries<br>
with a 0.0.0.0 source address to the multicast router port list:<br>
<br>
3) Host B sends multicast data to Switch B<br>
=C2=A0 =C2=A0=3D&gt; Switch B does not forward it to Switch A as it neither=
<br>
=C2=A0 =C2=A0 =C2=A0 detected a multicast listener nor multicast router on<=
br>
=C2=A0 =C2=A0 =C2=A0 the according port.<br>
=C2=A0 =C2=A0=3D&gt; Host A does not receive the multicast data it signed u=
p for<br>
<br>
(Or with colors:<br>
<a href=3D"https://metameute.de/~tux/linux/bridge/query-zero-source-no-mcro=
uter-port.png" rel=3D"noreferrer" target=3D"_blank">https://metameute.de/~t=
ux/linux/bridge/query-zero-source-no-mcrouter-port.png</a>)<br>
<br>
----------<br>
<br>
Alternatively we would need to ignore 0.0.0.0 for the querier<br>
election and &quot;querier present&quot; detection. And by that disable<br>
multicast snooping if there are no queries from a non-zero source<br>
address.<br>
<br>
But I&#39;m a little hesitant whether ignoring is a reliable way as<br>
IGMPv3 (RFC3376) and IGMPv2 (RFC2236) make no such restrictions<br>
regarding the query source address.<br>
<br>
With no such restrictions according to RFC3376/RFC2236 a 0.0.0.0<br>
would always win the querier election. Meaning any potential<br>
querier with a non-zero source address would remain silent.<br>
Meaning we would always disable multicast snooping then?<br>
<br>
<br>
Adding queriers with a 0.0.0.0 source address to the multicast<br>
router list, too, seems like a less harmful way then disabling multicast<br=
>
snooping completely?<br>
<br>
----------<br>
<br>
However, one of the two options seems to be necessary. Either<br>
reverting the patch for the IGMP part, too. Or Ignoring 0.0.0.0<br>
sources for querier eletcion and presence detection.<br>
<br>
The current state seems broken to me unless I&#39;m missing something.<br>
</blockquote></div>

--00000000000002a11d057cf23e60--
