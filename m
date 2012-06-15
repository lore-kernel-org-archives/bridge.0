Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1339763140; bh=CkgD3W6FE0yKbAw8PFKInlkyc8U7LJ+4/VdIUmSFffY=;
	h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
	b=MGUuVEPuCmDWX9kQYRWqegwMg/7Rf1IZWcLiI/pQhEOcBAteLh/Oo2ZQQFAyeJQb1x1m/wFW4m+CSNzdx/QIwyXtmIsWPfStJz8rOc2OZJmsOsKDQ6dzQZYI0gUZnKolDp9Az1gTc7cVEQvYnjHwMphnjmPAN6Bzm8az4Q7q2iM=
Message-ID: <1339763139.49767.YahooMailClassic@web121306.mail.ne1.yahoo.com>
Date: Fri, 15 Jun 2012 05:25:39 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="353665373-701004562-1339763140=:49767"
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
To: bridge@lists.linux-foundation.org

--353665373-701004562-1339763140=:49767
Content-Type: multipart/alternative; boundary="353665373-2083184595-1339763140=:49767"

--353665373-2083184595-1339763140=:49767
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks. I was doing the same experiment on few switches, i could get hold o=
f and this is the result:

Cisco Switch catalyst 2950 : Completely ignoring the packet, so validations=
 are proper.

Netgear FSM726V3 : Hello timer is validated and is propagated as 10 instead=
 of 255 ( which i sent) other max age and forward delay still it accepts as=
 255.=20

DLINK-DES-3026 : No validation done and accepts all as 255 ( max age, forwa=
rd delay and hello timer)

In both Netgear and Dlink the message age is changed to 16, which i am not =
sure why it has happened ?=20

my setup is simple

=A0 PC1------Switch------PC2

From PC1 i am sending invalid timer values and observing on PC2.

I am attaching wireshark capture for Dlink and Netgear STP packets.

Please let me know if any one has any idea or comment on this.

Thanks,
Sujata







--- On Thu, 6/14/12, Sasikanth babu <sasikanth.v19@gmail.com> wrote:

From: Sasikanth babu <sasikanth.v19@gmail.com>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view
To: "Sujata Verma" <sujataverma3@yahoo.com>
Cc: bridge@lists.linux-foundation.org
Date: Thursday, June 14, 2012, 6:09 PM


On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verma <sujataverma3@yahoo.com> wrot=
e:
=0AHi ,

I am going through spanning tree protocol and was testing it on Linux. My o=
bservation is there is no validation of timers for configuration BPDU.=A0 L=
ets say Root bridge received another BPDU from new bridge with invalid time=
r values but less priority, the existing bridge is becoming non-root bridge=
 and is advertising the invalid timer values.=20
=0A
As i have gone through 802.1D-1998 standard, i understand that 2004 is curr=
ent one but i was looking into STP not RSTP, i preferred to read this stand=
ard. I find these lines:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=0A9.3.3 Validation of received BPDUs

A Bridge Protocol Entity shall process a received BPDU as specified in 8.7 =
if and only if the BPDU contains at least four octets and the Protocol Iden=
tifier has the value specified for BPDUs (9.3.2), and
=0Aa) The BPDU Type=0A denotes a Configuration BPDU and the BPDU contains a=
t least 35 octets, and the
value of the BPDUs Message Age parameter is less than that of its Max Age p=
arameter; or

b) The BPDU Type denotes a Topology Change Notification BPDU.
=0AIn case a), any octets that are present beyond Octet 35 are ignored, as =
far as processing according to this
standard is concerned. Similarly, in case b), any octets beyond Octet 4 are=
 ignored.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=0A
Does this implies that any value timer values present within octet 35 is va=
lid value and there is no validation done. Even if range for hello timer, m=
ax age and forward delay is defined and is limited. Is it an issue or fine =
within the standard?
=0A
=A0 Not all STP implementation do BPDU validations i.e validates all BPDU p=
arameters present within 35 octet. The validation checks for invalid values=
 present in the bpdu,=20
=0A=A0 if the BPDU validation fails it drops the BPDU. The have seen this v=
alidations in proprietary software.
=A0=20
=0APlease help me understand this issue and thanks for any comments.

Regards,
Sujata

=0A
_______________________________________________
=0ABridge mailing list
=0ABridge@lists.linux-foundation.org
=0Ahttps://lists.linuxfoundation.org/mailman/listinfo/bridge

=0A
--353665373-2083184595-1339763140=:49767
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Thanks. I was doing the same experiment on fe=
w switches, i could get hold of and this is the result:<br><br>Cisco Switch=
 catalyst 2950 : Completely ignoring the packet, so validations are proper.=
<br><br>Netgear FSM726V3 : Hello timer is validated and is propagated as 10=
 instead of 255 ( which i sent) other max age and forward delay still it ac=
cepts as 255. <br><br>DLINK-DES-3026 : No validation done and accepts all a=
s 255 ( max age, forward delay and hello timer)<br><br>In both Netgear and =
Dlink the message age is changed to 16, which i am not sure why it has happ=
ened ? <br><br>my setup is simple<br><br>&nbsp; PC1------Switch------PC2<br=
><br>From PC1 i am sending invalid timer values and observing on PC2.<br><b=
r>I am attaching wireshark capture for Dlink and Netgear STP packets.<br><b=
r>Please let me know if any one has any idea or comment on
 this.<br><br>Thanks,<br>Sujata<br><br><br><br><br><br><br><br>--- On <b>Th=
u, 6/14/12, Sasikanth babu <i>&lt;sasikanth.v19@gmail.com&gt;</i></b> wrote=
:<br><blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-l=
eft: 5px; padding-left: 5px;"><br>From: Sasikanth babu &lt;sasikanth.v19@gm=
ail.com&gt;<br>Subject: Re: [Bridge] Query on Sapnning tree implementation =
from standard point of view<br>To: "Sujata Verma" &lt;sujataverma3@yahoo.co=
m&gt;<br>Cc: bridge@lists.linux-foundation.org<br>Date: Thursday, June 14, =
2012, 6:09 PM<br><br><div id=3D"yiv908397253"><div dir=3D"ltr"><br><div cla=
ss=3D"yiv908397253gmail_quote">On Thu, Jun 14, 2012 at 5:53 PM, Sujata Verm=
a <span dir=3D"ltr">&lt;<a rel=3D"nofollow" ymailto=3D"mailto:sujataverma3@=
yahoo.com" target=3D"_blank" href=3D"/mc/compose?to=3Dsujataverma3@yahoo.co=
m">sujataverma3@yahoo.com</a>&gt;</span> wrote:<br><blockquote class=3D"yiv=
908397253gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc
 solid;padding-left:1ex;">=0A<table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0"><tbody><tr><td style=3D"font:inherit;" valign=3D"top">Hi ,<br><br=
>I am going through spanning tree protocol and was testing it on Linux. My =
observation is there is no validation of timers for configuration BPDU.&nbs=
p; Lets say Root bridge received another BPDU from new bridge with invalid =
timer values but less priority, the existing bridge is becoming non-root br=
idge and is advertising the invalid timer values. <br>=0A<br>As i have gone=
 through 802.1D-1998 standard, i understand that 2004 is current one but i =
was looking into STP not RSTP, i preferred to read this standard. I find th=
ese lines:<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>=0A9.3.3 Validation of received BPDUs<br><br>A Bridge Protocol=
 Entity shall process a received BPDU as specified in 8.7 if and only if th=
e BPDU contains at least four octets and the Protocol Identifier has the va=
lue specified for BPDUs (9.3.2), and<br>=0Aa) The BPDU Type=0A denotes a Co=
nfiguration BPDU and the BPDU contains at least 35 octets, and the<br>value=
 of the BPDUs Message Age parameter is less than that of its Max Age parame=
ter; or<br><br>b) The BPDU Type denotes a Topology Change Notification BPDU=
.<br>=0AIn case a), any octets that are present beyond Octet 35 are ignored=
, as far as processing according to this<br>standard is concerned. Similarl=
y, in case b), any octets beyond Octet 4 are ignored.<br><br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=0A<br>Does this implies t=
hat any value timer values present within octet 35 is valid value and there=
 is no validation done. Even if range for hello timer, max age and forward =
delay is defined and is limited. Is it an issue or fine within the standard=
?<br>=0A<br></td></tr></tbody></table></blockquote><div>&nbsp; Not all STP =
implementation do BPDU validations i.e validates all BPDU parameters presen=
t within 35 octet. The validation checks for invalid values present in the =
bpdu, <br>=0A&nbsp; if the BPDU validation fails it drops the BPDU. The hav=
e seen this validations in proprietary software.<br>&nbsp; <br></div><block=
quote class=3D"yiv908397253gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex;">=0A<table border=
=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"font:inh=
erit;" valign=3D"top">Please help me understand this issue and thanks for a=
ny comments.<br><br>Regards,<br>Sujata<br><br></td></tr></tbody></table>=0A=
<br>_______________________________________________<br>=0ABridge mailing li=
st<br>=0A<a rel=3D"nofollow" ymailto=3D"mailto:Bridge@lists.linux-foundatio=
n.org" target=3D"_blank" href=3D"/mc/compose?to=3DBridge@lists.linux-founda=
tion.org">Bridge@lists.linux-foundation.org</a><br>=0A<a rel=3D"nofollow" t=
arget=3D"_blank" href=3D"https://lists.linuxfoundation.org/mailman/listinfo=
/bridge">https://lists.linuxfoundation.org/mailman/listinfo/bridge</a><br><=
/blockquote></div><br></div>=0A</div></blockquote></td></tr></table>
--353665373-2083184595-1339763140=:49767--

--353665373-701004562-1339763140=:49767
Content-Type: application/cap; name="STP_packet.pcap"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="STP_packet.pcap"

1MOyoQIABAAAAAAAAAAAAP//AAABAAAAPtTZT+4ECwA8AAAAPAAAAAGAwgAA
AAAbERG9QgAmQkIDAAAAAAEQAAAgofCIUAADDUSAAAAbERG9QoABEAD/AP8A
/wAAAAAAAAAAACXY2U9fswsAPAAAADwAAAABgMIAAAAAJvKvk6cAJkJCAwAA
AAAAEAAAIKHwiFAAAw1EEAAAJvKvk6WAARAA//8KAP//AAAAAAAAAAA=

--353665373-701004562-1339763140=:49767--
