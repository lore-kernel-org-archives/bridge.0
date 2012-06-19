Return-Path: <sasikanth.v19@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=dBXw/e1c1cSyxS095Iaprnb6te0i8GFcjrOOrRPGBjU=;
	b=d068dAb9ViZ8CpVuDeCK0FyJeRbAxJbWKB5cGXIzvSiUoHtp4wn4AvbeRX6/rgIgpA
	TYpeYDxePadbRrD/WANBrhlE58cROZwKCzSehLHl9J8I9S2e25WFQhCvHtCJcaDDAWZb
	s+HXuiWcnhDoPniBnpaejlXuU1UiEqWmt0/1rP0ZCy+glByR7wNQk7QTDOVuZfBYqUqx
	FrIS/XMN2eDm5ddvvNjjBOYa7YShwQXAGrUzhlu5rR4nRLiJCnKWkZ4/ZDiAyS3B3RN+
	+wWESOjbNQXQU1W+3NjiKTOqMAtAcz9XJh6bz9BOcYVuRXf6NqvOp1JDfnizR3k4eIb7
	Fq5g==
MIME-Version: 1.0
In-Reply-To: <201206191048.10023.vitas@nppfactor.kiev.ua>
References: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
	<CAOJFanURN8_LfYLWHFEtACc9_8mNb1vZ=mENnNR=0v6ZXTk=Tg@mail.gmail.com>
	<20120618135450.27473585@nehalam.linuxnetplumber.net>
	<201206191048.10023.vitas@nppfactor.kiev.ua>
Date: Tue, 19 Jun 2012 13:24:13 +0530
Message-ID: <CAOJFanXztn4LMSLyqDH5zPBKXHKGztiSQPZmcSQ-4Px7zV54Bg@mail.gmail.com>
From: Sasikanth babu <sasikanth.v19@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b33c710a1c36c04c2ce9601
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
 point of view
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

--047d7b33c710a1c36c04c2ce9601
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jun 19, 2012 at 1:18 PM, Vitalii Demianets
<vitas@nppfactor.kiev.ua>wrote:

> On Monday 18 June 2012 23:54:50 Stephen Hemminger wrote:
> >
> > First off, STP is not a secure protocol. It assumes a trust in any bridge
> > it excepts PDU's from. That is why Cisco as bpdu guard to ignore stuff
> > from rogue endpoints. In Linux, you can do the same with netfilter but
> > most users dont.
> >
> > Second, the standard (Linux is based on old 1998 version) allows any
> > value for forwarding delay (0 .. 255 seconds). The encoding of timer
> > value section implies that.
> >
>
> Hello, Stephen!
> Standards (both -1998 and -2004 revisions) do say nothing about validation
> of
> timers (except one issue) and you gave a good point that encoding clearly
> allows any timer value from 0.0 s to 255+255/256 s.
>
> Now, to the exceptional issue:
> 9.3.3 a) of -1998 (9.3.4 a) of -2004)
> ===============================================
> a) The BPDU Type denotes a Configuration BPDU and the BPDU contains at
> least
> 35 octets, and the value of the BPDUs Message Age parameter is less than
> that
> of its Max Age parameter ... [skip]
> ===============================================
>
> So, the standard clearly requires the BPDU where MessageAge < MaxAge to be
> dropped.
>
> Don't you think that including this check in Linux bridging code is
> worthwhile?
>
>   Are you talking about this check (in function br_stp_rcv)?

                if (bpdu.message_age > bpdu.max_age) {
                        if (net_ratelimit())
                                br_notice(p->br,
                                          "port %u config from %pM"
                                          " (message_age %ul > max_age
%ul)\n",
                                          p->port_no,
                                          eth_hdr(skb)->h_source,
                                          bpdu.message_age, bpdu.max_age);
                        goto out;
                }


> --
> With Best Regards,
> Vitalii Demianets
>

 Thanks
Sasi

--047d7b33c710a1c36c04c2ce9601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Tue, Jun 19, 2012 at=
 1:18 PM, Vitalii Demianets <span dir=3D"ltr">&lt;<a href=3D"mailto:vitas@n=
ppfactor.kiev.ua" target=3D"_blank">vitas@nppfactor.kiev.ua</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Monday 18 June 2012 23:=
54:50 Stephen Hemminger wrote:<br>
&gt;<br>
&gt; First off, STP is not a secure protocol. It assumes a trust in any bri=
dge<br>
&gt; it excepts PDU&#39;s from. That is why Cisco as bpdu guard to ignore s=
tuff<br>
&gt; from rogue endpoints. In Linux, you can do the same with netfilter but=
<br>
&gt; most users dont.<br>
&gt;<br>
&gt; Second, the standard (Linux is based on old 1998 version) allows any<b=
r>
&gt; value for forwarding delay (0 .. 255 seconds). The encoding of timer<b=
r>
&gt; value section implies that.<br>
&gt;<br>
<br>
</div>Hello, Stephen!<br>
Standards (both -1998 and -2004 revisions) do say nothing about validation =
of<br>
timers (except one issue) and you gave a good point that encoding clearly<b=
r>
allows any timer value from 0.0 s to 255+255/256 s.<br>
<br>
Now, to the exceptional issue:<br>
9.3.3 a) of -1998 (9.3.4 a) of -2004)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<div class=3D"im">a) The BPDU Type denotes a Configuration BPDU and the BPD=
U contains at least<br>
35 octets, and the value of the BPDUs Message Age parameter is less than th=
at<br>
</div>of its Max Age parameter ... [skip]<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
So, the standard clearly requires the BPDU where MessageAge &lt; MaxAge to =
be<br>
dropped.<br>
<br>
Don&#39;t you think that including this check in Linux bridging code is<br>
worthwhile?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div>=
=A0 Are you talking about this check (in function br_stp_rcv)?<br><br></div=
><div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (bpdu.message_age &g=
t; bpdu.max_age) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if (net_ratelimit())<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 br_notice(p-&gt;br,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 &quot;port %u config from %pM&quot;<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot; (message_age %ul &gt; max_age %ul)\n&=
quot;,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p-&gt;port_no,<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eth_hdr(skb)-&gt;h_source,<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bpdu.message_age, bpdu.max=
_age);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 goto out;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">
--<br>
With Best Regards,<br>
Vitalii Demianets<br>
</div></div></blockquote></div><br>=A0Thanks<br>Sasi<br></div>

--047d7b33c710a1c36c04c2ce9601--
