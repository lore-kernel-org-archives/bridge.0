Return-Path: <sasikanth.v19@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=IS9etpMkv9waz0RQnJos15kft1/1COtcW0Lv1P2M/lM=;
	b=Pk1ik1Ha2Ho0oQwGqcKFRiaAqX2HSbJJGgBO0hXLhPNx3uchaOJjCWKAXJ/AeIxmM+
	JC4EsbE24EV3JxgQg2f5EfxjT+60sQzfjEYuLGtxu6J7uNrmCeBOGM2kgPtxGVnXNmV+
	88oUTod/9vvBRzWtPXMbbQ7KTPN2yD9TUap2oNjZLPh+kT4PLOl7JZ1vqvumorTTyyBb
	8ukZJWD5A2CKo5lceLM9UIKS1qbpwLOYTODvsZBKy9nFZ0ptU+iIcnv2vbcuIt9IUwHc
	3K+DrrF6Dkjk5ZB0ynlcVMn/0AM3NicrqfZRaJtaV65qcUwS0ueHquPpMWtPoblci8Ra
	7f8A==
MIME-Version: 1.0
In-Reply-To: <1339676596.48814.YahooMailClassic@web121304.mail.ne1.yahoo.com>
References: <1339676596.48814.YahooMailClassic@web121304.mail.ne1.yahoo.com>
Date: Thu, 14 Jun 2012 18:09:27 +0530
Message-ID: <CAOJFanXrnuQxyCxTJ76i9Qy_rcBpSKJq9tY=2+b4uVVG5ig2LQ@mail.gmail.com>
From: Sasikanth babu <sasikanth.v19@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b339dd9832d6104c26dfd4b
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

--047d7b339dd9832d6104c26dfd4b
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <sujataverma3@yahoo.com>wrote:

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
parameters present within 35 octet. The validation checks for invalid
values present in the bpdu,
  if the BPDU validation fails it drops the BPDU. The have seen this
validations in proprietary software.


> Please help me understand this issue and thanks for any comments.
>
> Regards,
> Sujata
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/bridge
>

--047d7b339dd9832d6104c26dfd4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">On Thu, Jun 14, 2012 at 5:5=
3 PM, Sujata Verma <span dir=3D"ltr">&lt;<a href=3D"mailto:sujataverma3@yah=
oo.com" target=3D"_blank">sujataverma3@yahoo.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
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
dations in proprietary software.<br>=A0 <br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"><tbody><tr><td styl=
e=3D"font:inherit" valign=3D"top">Please help me understand this issue and =
thanks for any comments.<br><br>Regards,<br>Sujata<br><br></td></tr></tbody=
></table>
<br>_______________________________________________<br>
Bridge mailing list<br>
<a href=3D"mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-fou=
ndation.org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/bridge" targe=
t=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/bridge</a><=
br></blockquote></div><br></div>

--047d7b339dd9832d6104c26dfd4b--
