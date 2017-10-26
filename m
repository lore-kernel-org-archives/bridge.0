Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=NV/nq4gYpVNINaARklPGIRk+REfqrvi4geKKHNzljOg=;
	b=VuP4LQFcK9jIAZ9thCyYRsx8ldZ3mqwcQLSnpnHKQoPuiz/LrvCP5Oi3vf/4QCZvRq
	U8+WywM96IxupIH65qJdWtfqdB68wjrSpBc38alrTnP0Y12Tx/LQdStaw6UO6dT/Y1Rs
	ng26rAphnV7RkQ/CqmFAIQktPhd6Es4pYaRgua6b7D45dZKF0Gl3/eWmZtTsF1UcmDJz
	5ohv7+GhQr4kzANCuVfDFf75bhg0+L21iME0oBTgIYrc+gaDFImq5UAWX93iPwgfmPKb
	hIRE0E4P2ias+mtp3HmWjOwOFbHr+GHi3PKkCdt8YwlsOH9DPwzu6WwGcnSL7nred5+1
	CLsw==
MIME-Version: 1.0
In-Reply-To: <1509039231788.24944@Dell.com>
References: <1508950038625.54184@Dell.com>
	<8ac43814-70e8-81dc-767d-3981d1547ec8@lab.ntt.co.jp>
	<1509039231788.24944@Dell.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 26 Oct 2017 20:55:01 +0200
Message-ID: <CAOaVG17BV21fdqCZOYTgKrLfZ6y5P9Kd6kLSV7F-rU0qDW47Bw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="94eb2c19add6ae2f39055c77b56c"
Subject: Re: [Bridge] Linux Bridge Static FDB move
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Viraj.Raiyani@dell.com
Cc: bridge <bridge@lists.linux-foundation.org>

--94eb2c19add6ae2f39055c77b56c
Content-Type: text/plain; charset="UTF-8"

If you have a moving MAC then you have a network that is flapping,
duplicate MAC, or worse a network loop. All of these are signs of a broken
L2 network. The bridge can't fix these

On Oct 26, 2017 19:33, <Viraj.Raiyani@dell.com> wrote:

> Thank you for the reply.
>
> Viraj
> ________________________________________
> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Sent: Thursday, October 26, 2017 4:13 AM
> To: Raiyani, Viraj; bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] Linux Bridge Static FDB move
>
> On 2017/10/26 1:47, Viraj.Raiyani@dell.com wrote:
> > Hi Everyone,
> >
> >
> > Is it possible to program the FDB entry in Linux Bridge which is static,
> > non-local and doesn't move to new interface when the same source MAC
> > packet comes on a different interface in the same bridge  ?
>
> AFAIK no.
> Bridge supports static fdb entries, but br_fdb_update() updates their
> dst even for static entries.
>
> >
> >
> > I tried programming the MAC as permanent that prevents the moving of MAC
> > to a new interface in the same bridge, however it treats the MAC as
> > local and doesn't do the forwarding ?
>
> Yes, local entries will deliver frames to the bridge device itself.
>
> --
> Toshiaki Makita
>
>

--94eb2c19add6ae2f39055c77b56c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">If you have a moving MAC then you have a network that is =
flapping, duplicate MAC, or worse a network loop. All of these are signs of=
 a broken L2 network. The bridge can&#39;t fix these</div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Oct 26, 2017 19:33,  &lt;<a hre=
f=3D"mailto:Viraj.Raiyani@dell.com">Viraj.Raiyani@dell.com</a>&gt; wrote:<b=
r type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Thank you for the rep=
ly.<br>
<br>
Viraj<br>
______________________________<wbr>__________<br>
From: Toshiaki Makita &lt;<a href=3D"mailto:makita.toshiaki@lab.ntt.co.jp">=
makita.toshiaki@lab.ntt.co.jp</a><wbr>&gt;<br>
Sent: Thursday, October 26, 2017 4:13 AM<br>
To: Raiyani, Viraj; <a href=3D"mailto:bridge@lists.linux-foundation.org">br=
idge@lists.linux-foundation.<wbr>org</a><br>
Subject: Re: [Bridge] Linux Bridge Static FDB move<br>
<br>
On 2017/10/26 1:47, <a href=3D"mailto:Viraj.Raiyani@dell.com">Viraj.Raiyani=
@dell.com</a> wrote:<br>
&gt; Hi Everyone,<br>
&gt;<br>
&gt;<br>
&gt; Is it possible to program the FDB entry in Linux Bridge which is stati=
c,<br>
&gt; non-local and doesn&#39;t move to new interface when the same source M=
AC<br>
&gt; packet comes on a different interface in the same bridge=C2=A0 ?<br>
<br>
AFAIK no.<br>
Bridge supports static fdb entries, but br_fdb_update() updates their<br>
dst even for static entries.<br>
<br>
&gt;<br>
&gt;<br>
&gt; I tried programming the MAC as permanent that prevents the moving of M=
AC<br>
&gt; to a new interface in the same bridge, however it treats the MAC as<br=
>
&gt; local and doesn&#39;t do the forwarding ?<br>
<br>
Yes, local entries will deliver frames to the bridge device itself.<br>
<br>
--<br>
Toshiaki Makita<br>
<br>
</blockquote></div></div>

--94eb2c19add6ae2f39055c77b56c--
