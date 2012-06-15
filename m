Return-Path: <sasikanth.v19@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=QrUd+c+I8foVL3aDaEAfOFUHOxZM1+cS9bCWyGbgwPo=;
	b=KeuyQYqdDHpiLs52GI/yXvvp4XffeNPtp8tRC4yBpgtgBflhj9oQJWJeG+nX7vqPUi
	jYardD0RBUOO1PkOb/I+4zokcjqWv+lV0bc5inmJndjJxJFu0hYNC8C4kbP+4AxoTF4N
	uobzT6aw67Kcy71ecAc/YAPwlpETSeyV+2ymYsUHVCY9qWZI60ObXI3MAD5qUmobW82s
	MWiQ64jwX1ug6n5pcA99YR6rFdUVrAVm8uGxKdFjlqA8luORcHBFU8sduYX/39ZIPwHg
	M1qJQva7pREaGHwnL0o94L1wkeIR5VYOWNwCN+UNePIBn7q47BS/W+S6buzZKKqxmoBZ
	dmhg==
MIME-Version: 1.0
In-Reply-To: <1339763139.49767.YahooMailClassic@web121306.mail.ne1.yahoo.com>
References: <1339763139.49767.YahooMailClassic@web121306.mail.ne1.yahoo.com>
Date: Fri, 15 Jun 2012 19:25:09 +0530
Message-ID: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
From: Sasikanth babu <sasikanth.v19@gmail.com>
Content-Type: multipart/alternative; boundary=e89a8ff24bcb244eec04c2832add
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
To: Sujata Verma <sujataverma3@yahoo.com>
Cc: bridge@lists.linux-foundation.org

--e89a8ff24bcb244eec04c2832add
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jun 15, 2012 at 5:55 PM, Sujata Verma <sujataverma3@yahoo.com>wrote:

> Thanks. I was doing the same experiment on few switches, i could get hold
> of and this is the result:
>
> Cisco Switch catalyst 2950 : Completely ignoring the packet, so
> validations are proper.
>
> Netgear FSM726V3 : Hello timer is validated and is propagated as 10
> instead of 255 ( which i sent) other max age and forward delay still it
> accepts as 255.
>
>    I don't think STP std has mentioned this propagation, As far as I know
this prorogation is wrong. I think this must be a bug in Netgear switch.

DLINK-DES-3026 : No validation done and accepts all as 255 ( max age,
> forward delay and hello timer)
>
> In both Netgear and Dlink the message age is changed to 16, which i am not
> sure why it has happened ?
>
> my setup is simple
>
>   PC1------Switch------PC2
>
> From PC1 i am sending invalid timer values and observing on PC2.
>

    Are you doing any port mirroring here to capture packets on PC2?. How
are you sending packets from PC1 (running linux bridge?)?

>
> I am attaching wireshark capture for Dlink and Netgear STP packets.
>
>    Can you send out complete packet capture from start of your test to the
end to analyze

    Thanks
    Sasi

Please let me know if any one has any idea or comment on this.
>
> Thanks,
> Sujata
>


>
>
>
>
>
> --- On *Thu, 6/14/12, Sasikanth babu <sasikanth.v19@gmail.com>* wrote:
>
>
> From: Sasikanth babu <sasikanth.v19@gmail.com>
> Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
> point of view
> To: "Sujata Verma" <sujataverma3@yahoo.com>
> Cc: bridge@lists.linux-foundation.org
> Date: Thursday, June 14, 2012, 6:09 PM
>
>
>
> On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <sujataverma3@yahoo.com<http://mc/compose?to=sujataverma3@yahoo.com>
> > wrote:
>
> Hi ,
>
> I am going through spanning tree protocol and was testing it on Linux. My
> observation is there is no validation of timers for configuration BPDU.
> Lets say Root bridge received another BPDU from new bridge with invalid
> timer values but less priority, the existing bridge is becoming non-root
> bridge and is advertising the invalid timer values.
>
> As i have gone through 802.1D-1998 standard, i understand that 2004 is
> current one but i was looking into STP not RSTP, i preferred to read this
> standard. I find these lines:
>
> ===============================================
> 9.3.3 Validation of received BPDUs
>
> A Bridge Protocol Entity shall process a received BPDU as specified in 8.7
> if and only if the BPDU contains at least four octets and the Protocol
> Identifier has the value specified for BPDUs (9.3.2), and
> a) The BPDU Type denotes a Configuration BPDU and the BPDU contains at
> least 35 octets, and the
> value of the BPDUs Message Age parameter is less than that of its Max Age
> parameter; or
>
> b) The BPDU Type denotes a Topology Change Notification BPDU.
> In case a), any octets that are present beyond Octet 35 are ignored, as
> far as processing according to this
> standard is concerned. Similarly, in case b), any octets beyond Octet 4
> are ignored.
>
> ============================================
>
> Does this implies that any value timer values present within octet 35 is
> valid value and there is no validation done. Even if range for hello timer,
> max age and forward delay is defined and is limited. Is it an issue or fine
> within the standard?
>
>   Not all STP implementation do BPDU validations i.e validates all BPDU
> parameters present within 35 octet. The validation checks for invalid
> values present in the bpdu,
>   if the BPDU validation fails it drops the BPDU. The have seen this
> validations in proprietary software.
>
>
> Please help me understand this issue and thanks for any comments.
>
> Regards,
> Sujata
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org<http://mc/compose?to=Bridge@lists.linux-foundation.org>
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>

--e89a8ff24bcb244eec04c2832add
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">On Fri, Jun 15, 2012 at 5:5=
5 PM, Sujata Verma <span dir=3D"ltr">&lt;<a href=3D"mailto:sujataverma3@yah=
oo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Thanks. I was doing the same experiment o=
n few switches, i could get hold of and this is the result:<br><br>Cisco Sw=
itch catalyst 2950 : Completely ignoring the packet, so validations are pro=
per.<br>
<br>Netgear FSM726V3 : Hello timer is validated and is propagated as 10 ins=
tead of 255 ( which i sent) other max age and forward delay still it accept=
s as 255. <br><br></td></tr></tbody></table></blockquote><div>=A0=A0 I don&=
#39;t think STP std has mentioned this propagation, As far as I know this p=
rorogation is wrong. I think this must be a bug in Netgear switch.<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><table cellpadd=
ing=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td style=3D"font:inher=
it" valign=3D"top">
DLINK-DES-3026 : No validation done and accepts all as 255 ( max age, forwa=
rd delay and hello timer)<br><br>In both Netgear and Dlink the message age =
is changed to 16, which i am not sure why it has happened ? <br><br>my setu=
p is simple<br>
<br>=A0 PC1------Switch------PC2<br><br>From PC1 i am sending invalid timer=
 values and observing on PC2.<br></td></tr></tbody></table></blockquote><di=
v><br>=A0 =A0 Are you doing any port mirroring here to capture packets on P=
C2?. How are you sending packets from PC1 (running linux bridge?)?<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td style=3D"font:inherit"=
 valign=3D"top">
<br>I am attaching wireshark capture for Dlink and Netgear STP packets.<br>=
<br></td></tr></tbody></table></blockquote><div>=A0=A0 Can you send out com=
plete packet capture from start of your test to the end to analyze<br>=A0=
=A0 <br>
=A0=A0=A0 Thanks<br>=A0=A0=A0 Sasi<br><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><table cellpadding=3D"0" cellspacing=3D"0" border=3D=
"0"><tbody><tr><td style=3D"font:inherit" valign=3D"top">
Please let me know if any one has any idea or comment on
 this.<br><br>Thanks,<br>Sujata<br></td></tr></tbody></table></blockquote><=
div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><table cellp=
adding=3D"0" cellspacing=3D"0" border=3D"0">
<tbody><tr><td style=3D"font:inherit" valign=3D"top"><br><br><br><br><br>--=
- On <b>Thu, 6/14/12, Sasikanth babu <i>&lt;<a href=3D"mailto:sasikanth.v19=
@gmail.com" target=3D"_blank">sasikanth.v19@gmail.com</a>&gt;</i></b> wrote=
:<br>
<blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;p=
adding-left:5px"><br>From: Sasikanth babu &lt;<a href=3D"mailto:sasikanth.v=
19@gmail.com" target=3D"_blank">sasikanth.v19@gmail.com</a>&gt;<br>Subject:=
 Re: [Bridge] Query on Sapnning tree implementation from standard point of =
view<br>
To: &quot;Sujata Verma&quot; &lt;<a href=3D"mailto:sujataverma3@yahoo.com" =
target=3D"_blank">sujataverma3@yahoo.com</a>&gt;<br>Cc: <a href=3D"mailto:b=
ridge@lists.linux-foundation.org" target=3D"_blank">bridge@lists.linux-foun=
dation.org</a><br>
Date: Thursday, June 14, 2012, 6:09 PM<div><div class=3D"h5"><br><br><div><=
div dir=3D"ltr"><br><div>On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <spa=
n dir=3D"ltr">&lt;<a rel=3D"nofollow" href=3D"http://mc/compose?to=3Dsujata=
verma3@yahoo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</span> w=
rote:<br>
<blockquote style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Hi ,<br><br>I am going through spanning t=
ree protocol and was testing it on Linux. My observation is there is no val=
idation of timers for configuration BPDU.=A0 Lets say Root bridge received =
another BPDU from new bridge with invalid timer values but less priority, t=
he existing bridge is becoming non-root bridge and is advertising the inval=
id timer values. <br>

<br>As i have gone through 802.1D-1998 standard, i understand that 2004 is =
current one but i was looking into STP not RSTP, i preferred to read this s=
tandard. I find these lines:<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>

9.3.3 Validation of received BPDUs<br><br>A Bridge Protocol Entity shall pr=
ocess a received BPDU as specified in 8.7 if and only if the BPDU contains =
at least four octets and the Protocol Identifier has the value specified fo=
r BPDUs (9.3.2), and<br>

a) The BPDU Type
 denotes a Configuration BPDU and the BPDU contains at least 35 octets, and=
 the<br>value of the BPDUs Message Age parameter is less than that of its M=
ax Age parameter; or<br><br>b) The BPDU Type denotes a Topology Change Noti=
fication BPDU.<br>

In case a), any octets that are present beyond Octet 35 are ignored, as far=
 as processing according to this<br>standard is concerned. Similarly, in ca=
se b), any octets beyond Octet 4 are ignored.<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>

<br>Does this implies that any value timer values present within octet 35 i=
s valid value and there is no validation done. Even if range for hello time=
r, max age and forward delay is defined and is limited. Is it an issue or f=
ine within the standard?<br>

<br></td></tr></tbody></table></blockquote><div>=A0 Not all STP implementat=
ion do BPDU validations i.e validates all BPDU parameters present within 35=
 octet. The validation checks for invalid values present in the bpdu, <br>

=A0 if the BPDU validation fails it drops the BPDU. The have seen this vali=
dations in proprietary software.<br>=A0 <br></div><blockquote style=3D"marg=
in:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">

<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Please help me understand this issue and =
thanks for any comments.<br><br>Regards,<br>Sujata<br><br></td></tr></tbody=
></table>

<br>_______________________________________________<br>
Bridge mailing list<br>
<a rel=3D"nofollow" href=3D"http://mc/compose?to=3DBridge@lists.linux-found=
ation.org" target=3D"_blank">Bridge@lists.linux-foundation.org</a><br>
<a rel=3D"nofollow" href=3D"https://lists.linuxfoundation.org/mailman/listi=
nfo/bridge" target=3D"_blank">https://lists.linuxfoundation.org/mailman/lis=
tinfo/bridge</a><br></blockquote></div><br></div>
</div></div></div></blockquote></td></tr></tbody></table><br>______________=
_________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/bridge" targe=
t=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/bridge</a><=
br></blockquote></div><br></div>

--e89a8ff24bcb244eec04c2832add--
