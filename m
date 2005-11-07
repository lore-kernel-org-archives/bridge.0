Message-ID: <30be90270511071331n49630de5h6c3f771536107d4f@mail.gmail.com>
Date: Mon, 7 Nov 2005 16:31:08 -0500
From: Hai Wang <u2.ireland@gmail.com>
Subject: Re: [Bridge] Backport
In-Reply-To: <20051107131836.3ce41eb0@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4829_504258.1131399068817"
References: <30be90270511071302vbcad09fl148b5e742ae489b9@mail.gmail.com>
	<20051107131836.3ce41eb0@dxpl.pdx.osdl.net>
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

------=_Part_4829_504258.1131399068817
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I know this, but since there are MANY other changes on bridge driver made
since 2.4.x kernel besides RCU, I do not know which change or fixes might
already fix some problem I encountered, for example,
 1. randomly kernel panic when we removed interfaces from bridge
  So it would be good if there is latest bridge driver on kernel 2.4.X
 Regards!


 On 11/7/05, Stephen Hemminger <shemminger@osdl.org> wrote:
>
> On Mon, 7 Nov 2005 16:02:41 -0500
> Hai Wang <u2.ireland@gmail.com> wrote:
>
> > Hell everyone,
> > I am wondering if any of you had backported bridge driver to kernel
> 2.4.x?
> > Thanks!
> > Hai
>
> There already is a bridge driver in 2.4 but it is older.
> The 2.6 code relies on RCU, which is not in 2.4.
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

------=_Part_4829_504258.1131399068817
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I know this, but since there are MANY other&nbsp;changes on bridge dri=
ver&nbsp;made&nbsp;since 2.4.x kernel besides RCU, I do not know which chan=
ge or fixes might already fix some problem I encountered, for example,</div>
<div>&nbsp;</div>
<div>1. randomly kernel panic when we removed interfaces from bridge</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>So it would be good if there is latest bridge driver on kernel 2.4.X</=
div>
<div>&nbsp;</div>
<div>Regards!</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 11/7/05, <b class=3D"gmail_sendername">=
Stephen Hemminger</b> &lt;<a href=3D"mailto:shemminger@osdl.org">shemminger=
@osdl.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" DEFANGED_style=3D"PADDING-LEFT: 1ex; MARG=
IN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Mon, 7 Nov 2005 16:0=
2:41 -0500<br>Hai Wang &lt;<a href=3D"mailto:u2.ireland@gmail.com">u2.irela=
nd@gmail.com
</a>&gt; wrote:<br><br>&gt; Hell everyone,<br>&gt;&nbsp;&nbsp; I am wonderi=
ng if any of you had backported bridge driver to kernel 2.4.x?<br>&gt;&nbsp=
;&nbsp;Thanks!<br>&gt;&nbsp;&nbsp;Hai<br><br>There already is a bridge driv=
er in 2.4 but it is older.
<br>The 2.6 code relies on RCU, which is not in 2.4.<br><br><br>--<br>Steph=
en Hemminger &lt;<a href=3D"mailto:shemminger@osdl.org">shemminger@osdl.org=
</a>&gt;<br>OSDL <a href=3D"http://developer.osdl.org/~shemminger">http://d=
eveloper.osdl.org/~shemminger
</a><br></blockquote></div><br>

------=_Part_4829_504258.1131399068817--
