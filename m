MIME-Version: 1.0
In-Reply-To: <20090614204915.0a9a4187@nehalam>
References: <6d6e77f50906140128t65853593y61bf65c200970864@mail.gmail.com>
	<20090614204915.0a9a4187@nehalam>
Date: Wed, 17 Jun 2009 14:04:49 +0800
Message-ID: <6d6e77f50906162304g2d95e14cs66c07bd792b40c54@mail.gmail.com>
From: eko suwarsono <ekoswr76@gmail.com>
Content-Type: multipart/alternative; boundary=001636e90b75a56d35046c851197
Subject: Re: [Bridge] bridge module insertion
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

--001636e90b75a56d35046c851197
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

thank you Stephen

yes i knew that this will be the only one solutions.
the problem that the embedded system which is on ubuntu 7.04 doesn;t have
any compiler or source kernel. do you have any tips or hints for this.
thanks



On Mon, Jun 15, 2009 at 11:49 AM, Stephen Hemminger
<shemminger@vyatta.com>wrote:

>  On Sun, 14 Jun 2009 16:28:36 +0800
> eko suwarsono <ekoswr76@gmail.com> wrote:
>
> > dear all
> > I'm newbie on this. but i need the advise for this problem. sorry if this
> > already in archive
> >
> > I had embedded system from vendor using ubuntu 7.  with kernel 2.6.20.4
> the
> > system is on CF card
> > i need to have the bridge module on that systems, the problem there is no
> > compiler,etc. very minimum system
> > so what i did is install ubuntu on another PC and using exactly the same
> > kernel, gcc version etc to get the kernel with bridge module and then
> > copying all /boot folders and /lib/modules onto my embedded system
> >
> > the bridge module get error: insmod: error inserting bridge.ko : unknown
> > symbol
> >
> > at dmesg
> >
> > bridge: Unknown symbol br_handle_frame_hook
> >
> >
> >
> > is there any way to solve this problem, without rebuilding all OS on CF
> card
>
> If the kernel itself was not built with bridging configured, then
> the hook for the bridge won't be in the receive code in the kernel.
>
> So basically you are out of luck, building bridge out of tree.
> You need to get kernel source for the whole embedeed system, reconfigure
> and rebuild.
>
> --
>

--001636e90b75a56d35046c851197
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>thank you Stephen</div>
<div>=A0</div>
<div>yes i knew that this will be the only one solutions.</div>
<div>the problem that the embedded system which is on ubuntu 7.04 doesn;t h=
ave any compiler or source kernel. do you have any tips or hints for this. =
thanks</div>
<div><br><br>=A0</div>
<div class=3D"gmail_quote">On Mon, Jun 15, 2009 at 11:49 AM, Stephen Hemmin=
ger <span dir=3D"ltr">&lt;<a href=3D"mailto:shemminger@vyatta.com">shemming=
er@vyatta.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Sun, 14 Jun 2009 16:28:36 +0800<br>eko suwarsono &lt;<=
a href=3D"mailto:ekoswr76@gmail.com">ekoswr76@gmail.com</a>&gt; wrote:<br><=
br>&gt; dear all<br>&gt; I&#39;m newbie on this. but i need the advise for =
this problem. sorry if this<br>
&gt; already in archive<br>&gt;<br>&gt; I had embedded system from vendor u=
sing ubuntu 7. =A0with kernel 2.6.20.4 the<br>&gt; system is on CF card<br>=
&gt; i need to have the bridge module on that systems, the problem there is=
 no<br>
&gt; compiler,etc. very minimum system<br>&gt; so what i did is install ubu=
ntu on another PC and using exactly the same<br>&gt; kernel, gcc version et=
c to get the kernel with bridge module and then<br>&gt; copying all /boot f=
olders and /lib/modules onto my embedded system<br>
&gt;<br>&gt; the bridge module get error: insmod: error inserting bridge.ko=
 : unknown<br>&gt; symbol<br>&gt;<br>&gt; at dmesg<br>&gt;<br>&gt; bridge: =
Unknown symbol br_handle_frame_hook<br>&gt;<br>&gt;<br>&gt;<br>&gt; is ther=
e any way to solve this problem, without rebuilding all OS on CF card<br>
<br></div></div>If the kernel itself was not built with bridging configured=
, then<br>the hook for the bridge won&#39;t be in the receive code in the k=
ernel.<br><br>So basically you are out of luck, building bridge out of tree=
.<br>
You need to get kernel source for the whole embedeed system, reconfigure<br=
>and rebuild.<br><font color=3D"#888888"><br>--<br></font></blockquote></di=
v><br>

--001636e90b75a56d35046c851197--
