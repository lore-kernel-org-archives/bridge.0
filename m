Message-ID: <30be90270511040955t7362da37m640573ff06c24243@mail.gmail.com>
Date: Fri, 4 Nov 2005 12:55:28 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Bridge question
In-Reply-To: <20051104092654.417b4ce6@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13956_4124521.1131126928291"
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
	<436AA439.7050207@candelatech.com>
	<30be90270511040519o45d1dd0dr73834b6424dbe62@mail.gmail.com>
	<20051104092654.417b4ce6@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Ben Greear <greearb@candelatech.com>, bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_13956_4124521.1131126928291
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Stephen,
  I was not talking about nested bridges, I meant all bridges created on one
Linux are independent. As matter of fact, brctl does not allow to add a
bridge to another bridge.
  In my case, I have 10 BR2684 interfaces and eth0 on one linux PC with the
same MAC address, nas0....nas9.
  I create two bridges br0 and br1, and add nas0....nas5 and eth0.32 (VLAN)
into br0, and add nas6..nas9 and eth0.33 into br1, as I mentioned above,
nas0...nas9 have the same MAC whereas eth0.32 and eth0.32 also share a MAC,
so br0 and br1 have the same Bridge ID, do you think that the scenario will
work?
  Thanks!
 Regards!
              I am not talking about nested

 On 11/4/05, Stephen Hemminger <shemminger@osdl.org> wrote:
>
> On Fri, 4 Nov 2005 08:19:35 -0500
> Hai Wang <u2.ireland@gmail.com> wrote:
>
> > Stephen,
> > Since your trick is using 2 (even 4) priority bits, do you think it
> could
> > cause some cmpatibility issue with other STP implementation which still
> uses
> > these bits? (it seems to me that port priority is local significant.
> maybe
> > we can use all 8 bits for port ID, can't we?)
> > If we take other approaches, like create more than one bridges on one
> > Linux box, I am not sure if it is feasible, since I saw all bridges
> created
> > on the box have the same bridge ID.
> > Thanks!
>
> The port id is treated as a 16 bit ordered field by STP. So the other
> side won't have any problem. Nested bridge's won't work for a bunch of
> implementation related reasons, it's not impossible to change to allow
> that just a lot of work getting rid of all the possible race issues.
>
> The bridge id comes from the Mac of the first interface in bridge.
> So if you have mulitple bridges they all would have different bridge ids.
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

------=_Part_13956_4124521.1131126928291
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello Stephen,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I was not talking about nested bridges, I mea=
nt all bridges created on one Linux are independent. As matter of fact, brc=
tl does not allow to add a bridge to another&nbsp;bridge.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; In my case, I have 10 BR2684 interfaces and eth0 on=
 one linux PC with the same MAC address, nas0....nas9.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; I create two bridges br0 and br1, and add nas0....n=
as5 and eth0.32 (VLAN) into br0, and add nas6..nas9 and eth0.33 into br1, a=
s I mentioned above, nas0...nas9 have the same MAC whereas eth0.32 and eth0=
.32 also share a MAC, so br0 and br1 have the same Bridge ID, do you think =
that the scenario will work?
</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;</div>
<div>Thanks!</div>
<div>&nbsp;</div>
<div>Regards!</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I am not talking about nested <br><br>&nbsp;<=
/div>
<div><span class=3D"gmail_quote">On 11/4/05, <b class=3D"gmail_sendername">=
Stephen Hemminger</b> &lt;<a href=3D"mailto:shemminger@osdl.org">shemminger=
@osdl.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" DEFANGED_style=3D"PADDING-LEFT: 1ex; MARG=
IN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Fri, 4 Nov 2005 08:1=
9:35 -0500<br>Hai Wang &lt;<a href=3D"mailto:u2.ireland@gmail.com">u2.irela=
nd@gmail.com
</a>&gt; wrote:<br><br>&gt; Stephen,<br>&gt;&nbsp;&nbsp; Since your trick i=
s using 2 (even 4) priority bits, do you think it could<br>&gt; cause some =
cmpatibility issue with other STP implementation which still uses<br>&gt; t=
hese bits? (it seems to me that port priority is local significant. maybe
<br>&gt; we can use all 8 bits for port ID, can't we?)<br>&gt;&nbsp;&nbsp; =
If we take other approaches, like create more than one bridges on one<br>&g=
t; Linux box, I am not sure if it is feasible, since I saw all bridges crea=
ted<br>
&gt; on the box have the same bridge ID.<br>&gt;&nbsp;&nbsp; Thanks!<br><br=
>The port id is treated as a 16 bit ordered field by STP. So the other<br>s=
ide won't have any problem. Nested bridge's won't work for a bunch of<br>im=
plementation related reasons, it's not impossible to change to allow
<br>that just a lot of work getting rid of all the possible race issues.<br=
><br>The bridge id comes from the Mac of the first interface in bridge.<br>=
So if you have mulitple bridges they all would have different bridge ids.
<br><br><br>--<br>Stephen Hemminger &lt;<a href=3D"mailto:shemminger@osdl.o=
rg">shemminger@osdl.org</a>&gt;<br>OSDL <a href=3D"http://developer.osdl.or=
g/~shemminger">http://developer.osdl.org/~shemminger</a><br></blockquote></=
div>
<br>

------=_Part_13956_4124521.1131126928291--
