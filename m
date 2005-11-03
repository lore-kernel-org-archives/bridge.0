Message-ID: <30be90270511031548o6201f7f8i78908d2fa3b61cc9@mail.gmail.com>
Date: Thu, 3 Nov 2005 18:48:52 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Bridge question
In-Reply-To: <DE026503646E7F40AF97BAB98334333BF0C973@uss-republic.finepoint.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4441_10655393.1131061732070"
References: <DE026503646E7F40AF97BAB98334333BF0C973@uss-republic.finepoint.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <hwang@finepoint.com>
Cc: bridge@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>

This is a multi-part message in MIME format...

------=_Part_4441_10655393.1131061732070
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Stephen,
  Can you tell me how you did the trick in code? From what you said that max
of limit only can be 1023, 6000 is not doable, right?

Regards!


On 11/3/05, Hai Wang <hwang@finepoint.com> wrote:
>
> Can you tell me how you did the trick? From what you said that max of
> limit only can be 1028, no more, right?
>
> Regards!
>
> --
> Hai Wang
> Principle Software Engineer
> Fine Point Technologies, Inc.
> 139 Centre Street, 6th Floor
> New York, New York 10013-4408
> email: hwang@finepoint.com
> phone: +1.212.962.7410 x 326
> fax: +1.212.962.7404
> web: http://www.finepoint.com
>
> -----Original Message-----
> From: bridge-bounces@lists.osdl.org
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Stephen Hemminger
> Sent: Thursday, November 03, 2005 6:33 PM
> To: Hai Wang
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Bridge question
>
> On Thu, 3 Nov 2005 18:17:37 -0500
> Hai Wang <u2.ireland@gmail.com> wrote:
>
> > Stephen,
> >
> > Did you mean that the #255 limit is set in 2.4 Kernel, not
> > > bridge-utility? I am wondering why there is such limit,
> > > performance-related, or...? If I have to modify kernel 2.4 to exceed
> the
> > > limit, can you tell me where I should look at? Any drawback if I
> increase
> > > the limit up to 6000?
> > >
>
> Spanning tree protocol has limit on the protocol of 16 bits for port_id.
> originally 8 bits were for priority and 8 bits were for port number,
> but I added the cheat that vendors were using of using 2 bits of
> priority
> for port number.
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

------=_Part_4441_10655393.1131061732070
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<font size=3D"2">
<div>Stephen,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can you tell me how you did the t=
rick in code? From what you said that max of limit only can be 1023, 6000 i=
s not doable, right?</div>
<p>Regards!</p></font><br><br>
<div><span class=3D"gmail_quote">On 11/3/05, <b class=3D"gmail_sendername">=
Hai Wang</b> &lt;<a href=3D"mailto:hwang@finepoint.com">hwang@finepoint.com=
</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" DEFANGED_style=3D"PADDING-LEFT: 1ex; MARG=
IN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Can you tell me how you=
 did the trick? From what you said that max of<br>limit only can be 1028, n=
o more, right?
<br><br>Regards!<br><br>--<br>Hai Wang<br>Principle Software Engineer<br>Fi=
ne Point Technologies, Inc.<br>139 Centre Street, 6th Floor<br>New York, Ne=
w York 10013-4408<br>email: <a href=3D"mailto:hwang@finepoint.com">hwang@fi=
nepoint.com
</a><br>phone: +1.212.962.7410 x 326<br>fax: +1.212.962.7404<br>web: <a hre=
f=3D"http://www.finepoint.com">http://www.finepoint.com</a><br><br>-----Ori=
ginal Message-----<br>From: <a href=3D"mailto:bridge-bounces@lists.osdl.org=
">
bridge-bounces@lists.osdl.org</a><br>[mailto:<a href=3D"mailto:bridge-bounc=
es@lists.osdl.org">bridge-bounces@lists.osdl.org</a>] On Behalf Of Stephen =
Hemminger<br>Sent: Thursday, November 03, 2005 6:33 PM<br>To: Hai Wang<br>
Cc: <a href=3D"mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>S=
ubject: Re: [Bridge] Bridge question<br><br>On Thu, 3 Nov 2005 18:17:37 -05=
00<br>Hai Wang &lt;<a href=3D"mailto:u2.ireland@gmail.com">u2.ireland@gmail=
.com
</a>&gt; wrote:<br><br>&gt;&nbsp;&nbsp;Stephen,<br>&gt;<br>&gt; Did you mea=
n that the #255 limit is set in 2.4 Kernel, not<br>&gt; &gt; bridge-utility=
? I am wondering why there is such limit,<br>&gt; &gt; performance-related,=
 or...? If I have to modify kernel=20
2.4 to exceed<br>the<br>&gt; &gt; limit, can you tell me where I should loo=
k at? Any drawback if I<br>increase<br>&gt; &gt; the limit up to 6000?<br>&=
gt; &gt;<br><br>Spanning tree protocol has limit on the protocol of 16 bits=
 for port_id.
<br>originally 8 bits were for priority and 8 bits were for port number,<br=
>but I added the cheat that vendors were using of using 2 bits of<br>priori=
ty<br>for port number.<br><br>--<br>Stephen Hemminger &lt;<a href=3D"mailto=
:shemminger@osdl.org">
shemminger@osdl.org</a>&gt;<br>OSDL <a href=3D"http://developer.osdl.org/~s=
hemminger">http://developer.osdl.org/~shemminger</a><br></blockquote></div>=
<br>

------=_Part_4441_10655393.1131061732070--
