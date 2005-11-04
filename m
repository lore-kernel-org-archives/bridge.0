Message-ID: <30be90270511040519o45d1dd0dr73834b6424dbe62@mail.gmail.com>
Date: Fri, 4 Nov 2005 08:19:35 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Bridge question
In-Reply-To: <436AA439.7050207@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10379_32605826.1131110375547"
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
	<436AA439.7050207@candelatech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>

This is a multi-part message in MIME format...

------=_Part_10379_32605826.1131110375547
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen,
  Since your trick is using 2 (even 4) priority bits, do you think it could
cause some cmpatibility issue with other STP implementation which still uses
these bits? (it seems to me that port priority is local significant. maybe
we can use all 8 bits for port ID, can't we?)
  If we take other approaches, like create more than one bridges on one
Linux box, I am not sure if it is feasible, since I saw all bridges created
on the box have the same bridge ID.
  Thanks!


 On 11/3/05, Ben Greear <greearb@candelatech.com> wrote:
>
> Hai Wang wrote:
> > Stephen,
> >
> >
> > Did you mean that the #255 limit is set in 2.4 Kernel, not
> > bridge-utility? I am wondering why there is such limit,
> > performance-related, or...? If I have to modify kernel 2.4 to exceed the
> > limit, can you tell me where I should look at? Any drawback if I
> > increase the limit up to 6000?
>
> So, could you add a bridge group of bridge groups?
>
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc http://www.candelatech.com
>
>

------=_Part_10379_32605826.1131110375547
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>&nbsp;</div>
<div>Stephen,</div>
<div>&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Since your trick is u=
sing 2 (even 4)&nbsp;priority bits, do you think it could cause some cmpati=
bility issue with other STP implementation which still uses these bits? (it=
 seems to me that port priority is local significant. maybe we can use all =
8 bits for port ID, can't we?)
</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If we take other approaches=
, like create more than one bridges on one Linux box, I am not sure if it i=
s feasible, since I saw all bridges created on the box have the same bridge=
 ID. </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks!</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 11/3/05, <b class=3D"gmail_sendername">=
Ben Greear</b> &lt;<a href=3D"mailto:greearb@candelatech.com">greearb@cande=
latech.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" DEFANGED_style=3D"PADDING-LEFT: 1ex; MARG=
IN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hai Wang wrote:<br>&gt;=
 Stephen,<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Did you mean that=
 the #255 limit is set in 2.4
 Kernel, not<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bridge-utility? I am wondering=
 why there is such limit,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; performance-relat=
ed, or...? If I have to modify kernel 2.4 to exceed the<br>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp; limit, can you tell me where I should look at? Any drawback if=
 I
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; increase the limit up to 6000?<br><br>So, =
could you add a bridge group of bridge groups?<br><br>Ben<br><br>--<br>Ben =
Greear &lt;<a href=3D"mailto:greearb@candelatech.com">greearb@candelatech.c=
om</a>&gt;<br>Candela Technologies Inc&nbsp;&nbsp;
<a href=3D"http://www.candelatech.com">http://www.candelatech.com</a><br><b=
r></blockquote></div><br>

------=_Part_10379_32605826.1131110375547--
