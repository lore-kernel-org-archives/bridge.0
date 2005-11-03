Message-ID: <30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
Date: Thu, 3 Nov 2005 18:17:37 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Bridge question
In-Reply-To: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4281_24467.1131059857998"
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_4281_24467.1131059857998
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Stephen,

Did you mean that the #255 limit is set in 2.4 Kernel, not
> bridge-utility? I am wondering why there is such limit,
> performance-related, or...? If I have to modify kernel 2.4 to exceed the
> limit, can you tell me where I should look at? Any drawback if I increase
> the limit up to 6000?
>
> Many thanks
>
>
> From: bridge-bounces@lists.osdl.org
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Stephen Hemminger
> Sent: Thursday, November 03, 2005 6:06 PM
> To: Hai Wang
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Bridge question
>
> On Thu, 3 Nov 2005 17:16:45 -0500
> Hai Wang <u2.ireland@gmail.com> wrote:
>
> > Hello,
> >
> > Do you know why it is impossible to add more than #254 interfaces on
> a
> > bridge, why we need such a limit, how it can be exceeded?
> >
> > Thanks!
> >
> > Regards!
>
> You can have up 1023 interfaces with 2.6. I didn't want to change the
> 2.4
> code, only critical bug fixes get backported.
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

------=_Part_4281_24467.1131059857998
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<div>Stephen,</div>
<div>&nbsp;</div><br>
<blockquote class=3D"gmail_quote" DEFANGED_style=3D"PADDING-LEFT: 1ex; MARG=
IN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Did you mean that the #=
255 limit is set in 2.4 Kernel, not<br>bridge-utility? I am wondering why t=
here is such limit,
<br>performance-related, or...? If I have to modify kernel 2.4 to exceed th=
e<br>limit, can you tell me where I should look at? Any drawback if I incre=
ase the limit up to 6000?<br><br>Many thanks<br><br><br>From: <a href=3D"ma=
ilto:bridge-bounces@lists.osdl.org">
bridge-bounces@lists.osdl.org</a><br>[mailto:<a href=3D"mailto:bridge-bounc=
es@lists.osdl.org">bridge-bounces@lists.osdl.org</a>] On Behalf Of Stephen =
Hemminger<br>Sent: Thursday, November 03, 2005 6:06 PM<br>To: Hai Wang<br>
Cc: <a href=3D"mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>S=
ubject: Re: [Bridge] Bridge question<br><br>On Thu, 3 Nov 2005 17:16:45 -05=
00<br>Hai Wang &lt;<a href=3D"mailto:u2.ireland@gmail.com">u2.ireland@gmail=
.com
</a>&gt; wrote:<br><br>&gt; Hello,<br>&gt;<br>&gt;&nbsp;&nbsp;Do you know w=
hy it is impossible to add more than #254 interfaces on<br>a<br>&gt; bridge=
, why we need such a limit, how it can be exceeded?<br>&gt;<br>&gt;&nbsp;&n=
bsp; Thanks!<br>
&gt;<br>&gt;&nbsp;&nbsp;Regards!<br><br>You can have up 1023 interfaces wit=
h 2.6.&nbsp;&nbsp;I didn't want to change the<br>2.4<br>code, only critical=
 bug fixes get backported.<br><br>--<br>Stephen Hemminger &lt;<a href=3D"ma=
ilto:shemminger@osdl.org">
shemminger@osdl.org</a>&gt;<br>OSDL <a href=3D"http://developer.osdl.org/~s=
hemminger">http://developer.osdl.org/~shemminger</a><br></blockquote></div>=
<br>

------=_Part_4281_24467.1131059857998--
