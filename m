MIME-Version: 1.0
In-Reply-To: <20101127141647.6814f62f@nehalam>
References: <AANLkTikviZkym71gVp6BZUeiqHjbARhjB-J-mnE_5A6J@mail.gmail.com>
	<20101127141647.6814f62f@nehalam>
From: Benjamin Vanheuverzwijn <bvanheu@gmail.com>
Date: Sat, 27 Nov 2010 17:21:45 -0500
Message-ID: <AANLkTikRhBENKqbvmuYv=jVoMaFM-2EH57977Yt_1Y5j@mail.gmail.com>
Content-Type: multipart/alternative; boundary=000325574d66d4ed660496104400
Subject: Re: [Bridge] Disable mac address learning
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

--000325574d66d4ed660496104400
Content-Type: text/plain; charset=UTF-8

Hi,

Yes that's wat i thought but reading
http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Showing_devices_in_a_bridge
tells
me that if i set aging time to 0, it will makes all entry permanent.

The aging time is the number of seconds a MAC address will be

kept in the forwarding database after having received a packet

from this MAC address.

The entries in the forwarding database are periodically timed out

to ensure they won't stay around forever.

Normally there should be no need to modify this parameter,

but it can be changed with (time is in seconds).


> # brctl setageing bridgename time


> Setting ageing time to zero makes all entries permanent.


My bad i did not take time to test it.

Thanks for your answer i will try this!

On Sat, Nov 27, 2010 at 5:16 PM, Stephen Hemminger <
shemminger@linux-foundation.org> wrote:

> On Sat, 27 Nov 2010 16:46:34 -0500
> Benjamin Vanheuverzwijn <bvanheu@gmail.com> wrote:
>
> > Hi,
> >
> > Is there a way to disable the mac address learning in linux using "brctl"
> or
> > custom code so any packet sent to the bridge will be flooded in each
> > interfaces.
> >
> > I would like to do something similar as OpenBSD:
> > $ brconfig <bridge> -learn <iface>
> > $ man brconfig
> > ...
> >      -learn interface
> >              Mark interface so that the source address of packets
> received
> >              from interface are not entered into the address cache.
> > ...
> >
> > I tried to search on google and on the mailing-list without success.
>
> Just set ageing time to zero no need for special config option.
>



-- 
Benjamin Vanheuverzwijn

Google Talk/Jabber - bvanheu@gmail.com
http://vanheu.ca

--000325574d66d4ed660496104400
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Yes that&#39;s wat i thought but reading=C2=A0<a hre=
f=3D"http://www.linuxfoundation.org/collaborate/workgroups/networking/bridg=
e#Showing_devices_in_a_bridge" target=3D"_blank">http://www.linuxfoundation=
.org/collaborate/workgroups/networking/bridge#Showing_devices_in_a_bridge</=
a>=C2=A0tells me that if i set aging time to 0, it will makes all entry per=
manent.<br>


<br><blockquote class=3D"gmail_quote" style=3D"margin-top:0px;margin-right:=
0px;margin-bottom:0px;margin-left:0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204, 204, 204);border-left-style:solid;padding-left:1ex">
The aging time is the number of seconds a MAC address will be</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0px;m=
argin-bottom:0px;margin-left:0.8ex;border-left-width:1px;border-left-color:=
rgb(204, 204, 204);border-left-style:solid;padding-left:1ex">


kept in the forwarding database after having received a packet</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0px;=
margin-bottom:0px;margin-left:0.8ex;border-left-width:1px;border-left-color=
:rgb(204, 204, 204);border-left-style:solid;padding-left:1ex">


from this MAC address.</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin-top:0px;margin-right:0px;margin-bottom:0px;margin-left:0.8ex;bor=
der-left-width:1px;border-left-color:rgb(204, 204, 204);border-left-style:s=
olid;padding-left:1ex">


The entries in the forwarding database are periodically timed out</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0=
px;margin-bottom:0px;margin-left:0.8ex;border-left-width:1px;border-left-co=
lor:rgb(204, 204, 204);border-left-style:solid;padding-left:1ex">


to ensure they won&#39;t stay around forever.</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0px;margin-bottom:0px=
;margin-left:0.8ex;border-left-width:1px;border-left-color:rgb(204, 204, 20=
4);border-left-style:solid;padding-left:1ex">


Normally there should be no need to modify this parameter,</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0px;marg=
in-bottom:0px;margin-left:0.8ex;border-left-width:1px;border-left-color:rgb=
(204, 204, 204);border-left-style:solid;padding-left:1ex">


but it can be changed with (time is in seconds).</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin-top:0px;margin-right:0px;margin-bottom:=
0px;margin-left:0.8ex;border-left-width:1px;border-left-color:rgb(204, 204,=
 204);border-left-style:solid;padding-left:1ex">


<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin-top:0px;=
margin-right:0px;margin-bottom:0px;margin-left:0.8ex;border-left-width:1px;=
border-left-color:rgb(204, 204, 204);border-left-style:solid;padding-left:1=
ex">


# brctl setageing bridgename time</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin-top:0px;margin-right:0px;margin-bottom:0px;margin-left=
:0.8ex;border-left-width:1px;border-left-color:rgb(204, 204, 204);border-le=
ft-style:solid;padding-left:1ex">


<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin-top:0px;=
margin-right:0px;margin-bottom:0px;margin-left:0.8ex;border-left-width:1px;=
border-left-color:rgb(204, 204, 204);border-left-style:solid;padding-left:1=
ex">


Setting ageing time to zero makes all entries permanent.</blockquote></div>=
<div><br></div><div>My bad i did not take time to test it.</div><div><br></=
div><div>Thanks for your answer i will try this!</div><div>
<br><div class=3D"gmail_quote">On Sat, Nov 27, 2010 at 5:16 PM, Stephen Hem=
minger <span dir=3D"ltr">&lt;<a href=3D"mailto:shemminger@linux-foundation.=
org" target=3D"_blank">shemminger@linux-foundation.org</a>&gt;</span> wrote=
:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
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
</blockquote></div><br><br clear=3D"all"><br>-- <br>Benjamin Vanheuverzwijn=
<br><br>Google Talk/Jabber - <a href=3D"mailto:bvanheu@gmail.com" target=3D=
"_blank">bvanheu@gmail.com</a><br><a href=3D"http://vanheu.ca" target=3D"_b=
lank">http://vanheu.ca</a><br>

<br>
</div>

--000325574d66d4ed660496104400--
