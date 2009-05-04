MIME-Version: 1.0
In-Reply-To: <49FDD890.1090302@free.fr>
References: <20090428124009.GA26387@kallisti.us>
	<20090429162651.GA9455@kallisti.us> <49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us> <49F8C4C3.9020504@gmail.com>
	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr>
Date: Sun, 3 May 2009 22:59:03 -0500
Message-ID: <2e59e6970905032059u44da74e1x6b96b6c3d0144294@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cb606e40e0304690e2efa
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org, Jochen Hebbrecht <jochenhebbrecht@gmail.com>

--0015175cb606e40e0304690e2efa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2009 at 12:46 PM, Nicolas de Peslo=FCan <
nicolas.2p.debian@free.fr> wrote:

> Jochen Hebbrecht wrote:
> > Nicolas de Peslo=FCan schreef:
> >>
> >> Can you also explain why you are trying to use bridge ?
>
> > Nicolas,
> >
> > I'm not sure that bonding is the thing I need. I'll explain what I want
> > to do.
> >
> > Please check this image: http://www.jochus.be/brol/networking.png
> > * Purple lines: wired (UTP)
> > * Blue (dashed) lines: wireless
> >
> > So in this building, there are 2 locations. Location A and B. There's n=
o
> > possibility to link them using a wired cable, and I don't like the net
> > adapters who transmits packets using the 50Hz channel.
> >
> > In location A, there's a desktop and a notebook a. In location B,
> > there's a notebook, a server which maintains e-mails, backup,
> > Subversion, Archiva, ... and there's also printer (a network printer).
>
> Ok, now we understand what you are trying to do. In particular, I assume
> the DHCP server is on the subnet of location B (or behind a router
> connected on this subnet), so the expected DHCP offer will come from the
> wire interface (eth0) and definitely not from the wireless interface
> (eth1).



Looking at "router" in the provided diagram, plus the placement of A and B,
I am led to believe that location A is the primary network providing DHCP
and outbound access.  Furthermore, Jochen was getting a DHCP assignment ove=
r
his wireless interface before he tried to enable bridging.

Your suggestion of configuration as a router could work.  But NAT would not
if A is the primary location, because the printer would no longer have a
address visible to location A.

--0015175cb606e40e0304690e2efa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, May 3, 2009 at 12:46 PM, Nicolas=
 de Peslo=FCan <span dir=3D"ltr">&lt;<a href=3D"mailto:nicolas.2p.debian@fr=
ee.fr">nicolas.2p.debian@free.fr</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
<div class=3D"im">Jochen Hebbrecht wrote:<br>
&gt; Nicolas de Peslo=FCan schreef:<br>
&gt;&gt;<br>
&gt;&gt; Can you also explain why you are trying to use bridge ?<br>
<br>
</div><div class=3D"im">&gt; Nicolas,<br>
&gt;<br>
&gt; I&#39;m not sure that bonding is the thing I need. I&#39;ll explain wh=
at I want<br>
&gt; to do.<br>
&gt;<br>
&gt; Please check this image: <a href=3D"http://www.jochus.be/brol/networki=
ng.png" target=3D"_blank">http://www.jochus.be/brol/networking.png</a><br>
&gt; * Purple lines: wired (UTP)<br>
&gt; * Blue (dashed) lines: wireless<br>
&gt;<br>
&gt; So in this building, there are 2 locations. Location A and B. There&#3=
9;s no<br>
&gt; possibility to link them using a wired cable, and I don&#39;t like the=
 net<br>
&gt; adapters who transmits packets using the 50Hz channel.<br>
&gt;<br>
&gt; In location A, there&#39;s a desktop and a notebook a. In location B,<=
br>
&gt; there&#39;s a notebook, a server which maintains e-mails, backup,<br>
&gt; Subversion, Archiva, ... and there&#39;s also printer (a network print=
er).<br>
<br>
</div>Ok, now we understand what you are trying to do. In particular, I ass=
ume<br>
the DHCP server is on the subnet of location B (or behind a router<br>
connected on this subnet), so the expected DHCP offer will come from the<br=
>
wire interface (eth0) and definitely not from the wireless interface<br>
(eth1).</blockquote><div><br></div><div><br></div><div>Looking at &quot;rou=
ter&quot; in the provided diagram, plus the placement of A and B, I am led =
to believe that location A is the primary network providing DHCP and outbou=
nd access. =A0Furthermore, Jochen was getting a DHCP assignment over his wi=
reless interface before he tried to enable bridging.</div>
<div><br></div><div>Your suggestion of configuration as a router could work=
. =A0But NAT would not if A is the primary location, because the printer wo=
uld no longer have a address visible to location A.</div><div>=A0</div></di=
v>

--0015175cb606e40e0304690e2efa--
