Return-Path: <sujataverma3@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1340093729; bh=AtAwq7Tam9gJnGXYUep3szebmLLrHMwVpZUpAGVexg0=;
	h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type;
	b=EM/Vup5raWo9O+vJo7/S5r+QVzXZBU7hSGK1+5eN9Vsha2T7bKpwhW6G0ilXQs5QUzg8JausfNiCL1DetJtbRQ+ryNt4ZMWUk4HucocX4jr8G7iv/4NVgqOyEcKBxtKHt2pukzTJz8izCNxPf+jrUSCuc2BiMh8TqIztRjTH2no=
Message-ID: <1340093729.30122.YahooMailClassic@web121306.mail.ne1.yahoo.com>
Date: Tue, 19 Jun 2012 01:15:29 -0700 (PDT)
From: Sujata Verma <sujataverma3@yahoo.com>
In-Reply-To: <201206181448.33159.vitas@nppfactor.kiev.ua>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="353665373-2062676326-1340093729=:30122"
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
To: bridge@lists.linux-foundation.org, Vitalii Demianets <vitas@nppfactor.kiev.ua>

--353665373-2062676326-1340093729=:30122
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

With below setting I was able to run the test on all 4 devices

Message Age =3D 19 (encoded as 0x13 0x00)
Max Age =3D 20 (encoded as 0x14 0x00)
Hello Time =3D 255 (encoded as 0xFF 0xFF)
Forward Delay =3D 255 (encoded as 0xFF 0xFF)

The results are:

Linux bridge:

Accepting the new BPDU and accepting all fields as it is given above.


Netgear:

Not accepting the BPDU, advertising its own with values message age:0, max =
age: 20, hello time :2 and forward delay 15=20


Dlink:
Not accepting the BPDU , advertising its own with values message age:0, max=
 age: 20,=20

hello time :2 and forward delay 15=20


Cisco:=20

Not accepting the BPDU, advertising its own with values message age:0, max =
age: 20,=20

hello time :2 and forward delay 15.

In Cisco the configuration is=20

2950#show spanning-tree summary
Root bridge for: VLAN0001.
Extended system ID is enabled.
PortFast BPDU Guard is disabled
EtherChannel misconfiguration guard is enabled
UplinkFast is disabled
BackboneFast is disabled
Default pathcost method used is short

Name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Blocking Listeni=
ng Learning Forwarding STP Active
---------------------- -------- --------- -------- ---------- ----------
VLAN0001=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2
---------------------- -------- --------- -------- ---------- ----------
1 vlan=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 2

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So for the given values except linux all switches are dropping/ignoring the=
 packet.=20

Regards,
Sujata

--- On Mon, 6/18/12, Vitalii Demianets <vitas@nppfactor.kiev.ua> wrote:

From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard p=
oint of view
To: bridge@lists.linux-foundation.org
Date: Monday, June 18, 2012, 5:18 PM

On Friday 15 June 2012 15:25:39 Sujata Verma wrote:
> Thanks. I was doing the same experiment on few switches, i could get hold
> of and this is the result:
>
> Cisco Switch catalyst 2950 : Completely ignoring the packet, so validatio=
ns
> are proper.

Hello, Sujata!
Would the result of the experiment differ if you set Message Age and Max Ag=
e=20
to the correct values while leaving Hello Time and Forward Delay incorrect:
Message Age =3D 19 (encoded as 0x13 0x00)
Max Age =3D 20 (encoded as 0x14 0x00)
Hello Time =3D 255 (encoded as 0xFF 0x00)
Forward Delay =3D 255 (encoded as 0xFF 0x00)

How would Cisco switch handle such BPDUs?

--=20
With Best Regards,
Vitalii Demianets
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/bridge

--353665373-2062676326-1340093729=:30122
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><span class=3D"email"></span>With below setti=
ng I was able to run the test on all 4 devices<br><br>Message Age =3D 19 (e=
ncoded as 0x13 0x00)<br>Max Age =3D 20 (encoded as 0x14 0x00)<br>Hello Time=
 =3D 255 (encoded as 0xFF 0xFF)<br>Forward Delay =3D 255 (encoded as 0xFF 0=
xFF)<br><br>The results are:<br><br>Linux bridge:<br><br>Accepting the new =
BPDU and accepting all fields as it is given above.<br><br><br>Netgear:<br>=
<br>Not accepting the BPDU, advertising its own with values message age:0, =
max age: 20, hello time :2 and forward delay 15 <br><br><br>Dlink:<br>Not a=
ccepting the BPDU , advertising its own with values message age:0, max age:=
 20, <br><br>hello time :2 and forward delay 15 <br><br><br>Cisco: <br><br>=
Not accepting the BPDU, advertising its own with values message age:0, max =
age: 20, <br><br>hello time :2 and forward delay 15.<br><br>In Cisco the co=
nfiguration
 is <br><br>2950#show spanning-tree summary<br>Root bridge for: VLAN0001.<b=
r>Extended system ID is enabled.<br>PortFast BPDU Guard is disabled<br>Ethe=
rChannel misconfiguration guard is enabled<br>UplinkFast is disabled<br>Bac=
kboneFast is disabled<br>Default pathcost method used is short<br><br>Name&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Blocking Listening Learning Forwarding STP=
 Active<br>---------------------- -------- --------- -------- ---------- --=
--------<br>VLAN0001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 2<br>---------------------- -------- --------- -------- --=
-------- ----------<br>1
 vlan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 2<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>So f=
or the given values except linux all switches are dropping/ignoring the pac=
ket. <br><br>Regards,<br>Sujata<br><br>--- On <b>Mon, 6/18/12, Vitalii Demi=
anets <i>&lt;vitas@nppfactor.kiev.ua&gt;</i></b> wrote:<br><blockquote styl=
e=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-lef=
t: 5px;"><br>From: Vitalii Demianets &lt;vitas@nppfactor.kiev.ua&gt;<br>Sub=
ject: Re: [Bridge] Query on Sapnning tree implementation from standard poin=
t of view<br>To: bridge@lists.linux-foundation.org<br>Date: Monday, June 18=
, 2012, 5:18 PM<br><br><div class=3D"plainMail">On Friday 15 June 2012
 15:25:39 Sujata Verma wrote:<br>&gt; Thanks. I was doing the same experime=
nt on few switches, i could get hold<br>&gt; of and this is the result:<br>=
&gt;<br>&gt; Cisco Switch catalyst 2950 : Completely ignoring the packet, s=
o validations<br>&gt; are proper.<br><br>Hello, Sujata!<br>Would the result=
 of the experiment differ if you set Message Age and Max Age <br>to the cor=
rect values while leaving Hello Time and Forward Delay incorrect:<br>Messag=
e Age =3D 19 (encoded as 0x13 0x00)<br>Max Age =3D 20 (encoded as 0x14 0x00=
)<br>Hello Time =3D 255 (encoded as 0xFF 0x00)<br>Forward Delay =3D 255 (en=
coded as 0xFF 0x00)<br><br>How would Cisco switch handle such BPDUs?<br><br=
>-- <br>With Best Regards,<br>Vitalii Demianets<br>________________________=
_______________________<br>Bridge mailing list<br><a ymailto=3D"mailto:Brid=
ge@lists.linux-foundation.org" href=3D"/mc/compose?to=3DBridge@lists.linux-=
foundation.org">Bridge@lists.linux-foundation.org</a><br><a
 href=3D"https://lists.linuxfoundation.org/mailman/listinfo/bridge" target=
=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/bridge</a><b=
r></div></blockquote></td></tr></table>
--353665373-2062676326-1340093729=:30122--
