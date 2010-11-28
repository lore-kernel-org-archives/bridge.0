MIME-Version: 1.0
In-Reply-To: <AANLkTikRhBENKqbvmuYv=jVoMaFM-2EH57977Yt_1Y5j@mail.gmail.com>
References: <AANLkTikviZkym71gVp6BZUeiqHjbARhjB-J-mnE_5A6J@mail.gmail.com>
	<20101127141647.6814f62f@nehalam>
	<AANLkTikRhBENKqbvmuYv=jVoMaFM-2EH57977Yt_1Y5j@mail.gmail.com>
From: matan monitz <mmonitz@gmail.com>
Date: Sun, 28 Nov 2010 15:27:19 +0200
Message-ID: <AANLkTi=sSZNYgQS4BNf1qZkboNB2grvgN1-xDQmWKGBi@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016364ed8026ed24204961ceb43
Subject: Re: [Bridge] Disable mac address learning
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benjamin Vanheuverzwijn <bvanheu@gmail.com>
Cc: bridge@lists.linux-foundation.org

--0016364ed8026ed24204961ceb43
Content-Type: text/plain; charset=UTF-8

it works
i use it for transfering a port monitor via bridge
On Sun, Nov 28, 2010 at 12:21 AM, Benjamin Vanheuverzwijn <bvanheu@gmail.com
> wrote:

> Hi,
>
> Yes that's wat i thought but reading
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Showing_devices_in_a_bridge tells
> me that if i set aging time to 0, it will makes all entry permanent.
>
> The aging time is the number of seconds a MAC address will be
>
> kept in the forwarding database after having received a packet
>
> from this MAC address.
>
> The entries in the forwarding database are periodically timed out
>
> to ensure they won't stay around forever.
>
> Normally there should be no need to modify this parameter,
>
> but it can be changed with (time is in seconds).
>
>
>> # brctl setageing bridgename time
>
>
>> Setting ageing time to zero makes all entries permanent.
>
>
> My bad i did not take time to test it.
>
> Thanks for your answer i will try this!
>
> On Sat, Nov 27, 2010 at 5:16 PM, Stephen Hemminger <
> shemminger@linux-foundation.org> wrote:
>
>> On Sat, 27 Nov 2010 16:46:34 -0500
>> Benjamin Vanheuverzwijn <bvanheu@gmail.com> wrote:
>>
>> > Hi,
>> >
>> > Is there a way to disable the mac address learning in linux using
>> "brctl" or
>> > custom code so any packet sent to the bridge will be flooded in each
>> > interfaces.
>> >
>> > I would like to do something similar as OpenBSD:
>> > $ brconfig <bridge> -learn <iface>
>> > $ man brconfig
>> > ...
>> >      -learn interface
>> >              Mark interface so that the source address of packets
>> received
>> >              from interface are not entered into the address cache.
>> > ...
>> >
>> > I tried to search on google and on the mailing-list without success.
>>
>> Just set ageing time to zero no need for special config option.
>>
>
>
>
> --
> Benjamin Vanheuverzwijn
>
> Google Talk/Jabber - bvanheu@gmail.com
> http://vanheu.ca
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

--0016364ed8026ed24204961ceb43
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>it works<br>i use it for transfering a port monitor vi=
a bridge<br><div class=3D"gmail_quote">On Sun, Nov 28, 2010 at 12:21 AM, Be=
njamin Vanheuverzwijn <span dir=3D"ltr">&lt;<a href=3D"mailto:bvanheu@gmail=
.com">bvanheu@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi,<div><br></div=
><div>Yes that&#39;s wat i thought but reading=C2=A0<a href=3D"http://www.l=
inuxfoundation.org/collaborate/workgroups/networking/bridge#Showing_devices=
_in_a_bridge" target=3D"_blank">http://www.linuxfoundation.org/collaborate/=
workgroups/networking/bridge#Showing_devices_in_a_bridge</a>=C2=A0tells me =
that if i set aging time to 0, it will makes all entry permanent.<br>




<br><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
The aging time is the number of seconds a MAC address will be</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border=
-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


kept in the forwarding database after having received a packet</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


from this MAC address.</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">


The entries in the forwarding database are periodically timed out</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; bo=
rder-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


to ensure they won&#39;t stay around forever.</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">


Normally there should be no need to modify this parameter,</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


but it can be changed with (time is in seconds).</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px so=
lid rgb(204, 204, 204); padding-left: 1ex;">


<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px=
 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


# brctl setageing bridgename time</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">


<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px=
 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


Setting ageing time to zero makes all entries permanent.</blockquote></div>=
<div><br></div><div>My bad i did not take time to test it.</div><div><br></=
div><div>Thanks for your answer i will try this!</div><div><div class=3D"im=
">


<br><div class=3D"gmail_quote">On Sat, Nov 27, 2010 at 5:16 PM, Stephen Hem=
minger <span dir=3D"ltr">&lt;<a href=3D"mailto:shemminger@linux-foundation.=
org" target=3D"_blank">shemminger@linux-foundation.org</a>&gt;</span> wrote=
:<br>



<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div>On Sat, 27 Nov 2010 16:46:34 -0500<br>
Benjamin Vanheuverzwijn &lt;<a href=3D"mailto:bvanheu@gmail.com" target=3D"=
_blank">bvanheu@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; Is there a way to disable the mac address learning in linux using &quo=
t;brctl&quot; or<br>
&gt; custom code so any packet sent to the bridge will be flooded in each<b=
r>
&gt; interfaces.<br>
&gt;<br>
&gt; I would like to do something similar as OpenBSD:<br>
&gt; $ brconfig &lt;bridge&gt; -learn &lt;iface&gt;<br>
&gt; $ man brconfig<br>
&gt; ...<br>
&gt; =C2=A0 =C2=A0 =C2=A0-learn interface<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mark interface so that=
 the source address of packets received<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from interface are not=
 entered into the address cache.<br>
&gt; ...<br>
&gt;<br>
&gt; I tried to search on google and on the mailing-list without success.<b=
r>
<br>
</div>Just set ageing time to zero no need for special config option.<br>
</blockquote></div><br><br clear=3D"all"><br></div><div class=3D"im">-- <br=
>Benjamin Vanheuverzwijn<br><br>Google Talk/Jabber - <a href=3D"mailto:bvan=
heu@gmail.com" target=3D"_blank">bvanheu@gmail.com</a><br><a href=3D"http:/=
/vanheu.ca" target=3D"_blank">http://vanheu.ca</a><br>



<br>
</div></div>
<br>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/bridge" targ=
et=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/bridge</a=
><br></blockquote></div><br></div>

--0016364ed8026ed24204961ceb43--
