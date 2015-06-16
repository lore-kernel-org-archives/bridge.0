Return-Path: <fahd.abbasi@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=7UMZiPaJCBZvMuvgrzBGasaaH4nyjkZDvphywmERJKY=;
	b=dAGWKA9O1wbnlaIMMuLQyRsWfNitxDUg3pa4jE4H9sB2K3pMmGk3HHJgwK+0Kmu2HB
	fiUgnG8hwB4L4Ik4H+UlYd2huZ25AGki9I0svF4fWBwFyw2tlCUImLLwadk1yIuR47QM
	iFMWj4uAZhviMDRhSkdDiRp3ikFL9wMrl14ezfPjyjgELdaBZz1cji0r+BGlTrhHgkz8
	OW/UxFAL8CSvDsDTEOqcxkXkZAkb+czyCnlx3JXreh0j4NllNWcnTWglHmIknHtS9E93
	Cm8/dOpI4efHSm9NI5yBYV8MN0YKesnS200cQfkxVE8H8WsH7+ne/sSTRUtRPnYkzNjK
	1xHQ==
MIME-Version: 1.0
In-Reply-To: <20150614104939.65756b54@urahara>
References: <CAMT8_GOqHD0vQcsfrgLZaMiynbHXc-LijsWpjrtMR+S_Eofk9g@mail.gmail.com>
	<20150614104939.65756b54@urahara>
Date: Tue, 16 Jun 2015 23:15:38 +0500
Message-ID: <CAMT8_GP5phobUBg6TmbjObv9f8KhdoMS1y2CUkCH5bdzN8iE5w@mail.gmail.com>
From: Fahd Abbasi <fahd.abbasi@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c23d3ebebb1a0518a68f81
Subject: Re: [Bridge] Bridge created on centos6.4 running as a virtual
 machine over vmware does not work
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

--001a11c23d3ebebb1a0518a68f81
Content-Type: text/plain; charset=UTF-8

Thanks for the feedback.

 Best Regards,
Fahd.

On Sun, Jun 14, 2015 at 10:49 PM, Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Tue, 09 Jun 2015 23:18:46 +0000
> Fahd Abbasi <fahd.abbasi@gmail.com> wrote:
>
> > Hello,
> >
> > I have centos running as a virtual machine using vmware on top of
> Windows 7.
> >
> > Created a bridge which is up and learns the end Devices mac addresses as
> > well.
> >
> > However ping does not work.
> >
> > Any ideas what can be the issue or any config guide for such a scenario?
> >
> > Thanks,
> > Fahd.
>
> VMware switch does not allow guests to go into promicious mode.
>

--001a11c23d3ebebb1a0518a68f81
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the feedback.<div><br></div><div>=C2=A0Best Reg=
ards,</div><div>Fahd.</div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Sun, Jun 14, 2015 at 10:49 PM, Stephen Hemminger <span dir=3D"=
ltr">&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">st=
ephen@networkplumber.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Tue, 09 Jun 2015 23:18:46 =
+0000<br>
Fahd Abbasi &lt;<a href=3D"mailto:fahd.abbasi@gmail.com">fahd.abbasi@gmail.=
com</a>&gt; wrote:<br>
<br>
&gt; Hello,<br>
&gt;<br>
&gt; I have centos running as a virtual machine using vmware on top of Wind=
ows 7.<br>
&gt;<br>
&gt; Created a bridge which is up and learns the end Devices mac addresses =
as<br>
&gt; well.<br>
&gt;<br>
&gt; However ping does not work.<br>
&gt;<br>
&gt; Any ideas what can be the issue or any config guide for such a scenari=
o?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Fahd.<br>
<br>
</div></div>VMware switch does not allow guests to go into promicious mode.=
<br>
</blockquote></div><br>
</div></div>

--001a11c23d3ebebb1a0518a68f81--
