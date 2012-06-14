Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1339676596; bh=Lq28cJFM8fyw0LDmnlKcvLKJLNszVdXCyMuf9+apV5E=;
	h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
	b=jX6shBd6EQyTbWIGBp/zQPzsfE0iwTIeGQapK08HBc24VZxYnpUvagEwTXwV66/a1gjFCuyc0VR5XSZbVwrzAkZC0SpndtNSPP15hcP7UYIEg+XX7AykgIEMDAFX/ZsyAkToNqSG0PU+l8e4Ixys/iq1+87BnRS8K3G1YfT4goQ=
Message-ID: <1339676596.48814.YahooMailClassic@web121304.mail.ne1.yahoo.com>
Date: Thu, 14 Jun 2012 05:23:16 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1671867401-798584372-1339676596=:48814"
Subject: [Bridge] Query on Sapnning tree implementation from standard point
	of view
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--1671867401-798584372-1339676596=:48814
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,

I am going through spanning tree protocol and was testing it on Linux. My o=
bservation is there is no validation of timers for configuration BPDU.=A0 L=
ets say Root bridge received another BPDU from new bridge with invalid time=
r values but less priority, the existing bridge is becoming non-root bridge=
 and is advertising the invalid timer values.=20

As i have gone through 802.1D-1998 standard, i understand that 2004 is curr=
ent one but i was looking into STP not RSTP, i preferred to read this stand=
ard. I find these lines:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
9.3.3 Validation of received BPDUs

A Bridge Protocol Entity shall process a received BPDU as specified in 8.7 =
if and only if the BPDU contains at least four octets and the Protocol Iden=
tifier has the value specified for BPDUs (9.3.2), and
a) The BPDU Type denotes a Configuration BPDU and the BPDU contains at leas=
t 35 octets, and the
value of the BPDUs Message Age parameter is less than that of its Max Age p=
arameter; or

b) The BPDU Type denotes a Topology Change Notification BPDU.
In case a), any octets that are present beyond Octet 35 are ignored, as far=
 as processing according to this
standard is concerned. Similarly, in case b), any octets beyond Octet 4 are=
 ignored.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Does this implies that any value timer values present within octet 35 is va=
lid value and there is no validation done. Even if range for hello timer, m=
ax age and forward delay is defined and is limited. Is it an issue or fine =
within the standard?

Please help me understand this issue and thanks for any comments.

Regards,
Sujata


--1671867401-798584372-1339676596=:48814
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi ,<br><br>I am going through spanning tree =
protocol and was testing it on Linux. My observation is there is no validat=
ion of timers for configuration BPDU.&nbsp; Lets say Root bridge received a=
nother BPDU from new bridge with invalid timer values but less priority, th=
e existing bridge is becoming non-root bridge and is advertising the invali=
d timer values. <br><br>As i have gone through 802.1D-1998 standard, i unde=
rstand that 2004 is current one but i was looking into STP not RSTP, i pref=
erred to read this standard. I find these lines:<br><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>9.3.3 Validation of rec=
eived BPDUs<br><br>A Bridge Protocol Entity shall process a received BPDU a=
s specified in 8.7 if and only if the BPDU contains at least four octets an=
d the Protocol Identifier has the value specified for BPDUs (9.3.2), and<br=
>a) The BPDU Type
 denotes a Configuration BPDU and the BPDU contains at least 35 octets, and=
 the<br>value of the BPDUs Message Age parameter is less than that of its M=
ax Age parameter; or<br><br>b) The BPDU Type denotes a Topology Change Noti=
fication BPDU.<br>In case a), any octets that are present beyond Octet 35 a=
re ignored, as far as processing according to this<br>standard is concerned=
. Similarly, in case b), any octets beyond Octet 4 are ignored.<br><br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Does this imp=
lies that any value timer values present within octet 35 is valid value and=
 there is no validation done. Even if range for hello timer, max age and fo=
rward delay is defined and is limited. Is it an issue or fine within the st=
andard?<br><br>Please help me understand this issue and thanks for any comm=
ents.<br><br>Regards,<br>Sujata<br><br></td></tr></table>
--1671867401-798584372-1339676596=:48814--
