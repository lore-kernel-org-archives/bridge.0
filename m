Return-Path: <dhan.lin1989@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=IcTCzGaamLdBBX7BWMByzTFaUuaziPaIgyIeshx7L9g=;
	b=M2DRYR2QKPtG/7LoKxxAtPPLvDKZsdq9sm3UJVkODlGHXhQjUXLtg+/sr6H042Px8B
	HG9OjJe4aYvFNMHP7qJkQ8Gt6bTQceX3s4YVVWwR4FbBKY6Z5yCePRRl4sKaX1zGgo0c
	25OzLKrx48IptyRl/yk7zXYvUXsF9PJKeqhoutP51iNtLiD3rCjgVjVit0eOBlWGDk71
	IaCE5kelc2eytHNWdoSYDoLgIdKZemMQ+z18TXAFStCs7i/wuKOa2JaZ0WGsx8v+Zxdf
	tiLwjlJkub21nn7nm516nXy0tll9ANcAb/m0/dxq5HeYH4f8SFhl8rOJkN7dF8ura+0t
	pr8g==
MIME-Version: 1.0
From: dhan lin <dhan.lin1989@gmail.com>
Date: Sat, 8 Jun 2019 13:11:16 +0530
Message-ID: <CAMvS6vZrRoA-DtFnsOuhdzYyDi9fFCq=pSrxaKqLDC4Xc7=QFg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001df236058acb13e5"
Subject: [Bridge] Originating device info for Packets trapped on Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0000000000001df236058acb13e5
Content-Type: text/plain; charset="UTF-8"

Hi All,

I've a few doubts w.r.t layer2-frame processing in linux and PACKET_ORIGDEV
socket option for getting origdev info.

For example, lets assume below given is the set of net devices that my
frame is intended to traverse over.

eth0(1) -> bond0(2) -> bridge(3) -> vlan100(4). >>> (x) ifindex for
each netdevice

I have created a  RAW socket ( not binded to any interface) , attached with
a socket filter to trap only interested packets.
I am getting a copy of frame trapped from each of the netdevice. is this
expected?

frame trapped from eth0 will have from.sll_ifindex=1
frame trapped from bond0 will have from.sll_ifindex=2
frame trapped from bridge will have from.sll_ifindex=3
frame trapped from vlan100 will have from.sll_ifindex=4

If I set the following socket option PACKET_ORIGDEV , I get the following
result

frame trapped from eth0 will have from.sll_ifindex=1
frame trapped from bond0 will have from.sll_ifindex=1
frame trapped from bridge will have from.sll_ifindex=3.  >> why is this not
set to 1 or 2?
frame trapped from vlan100 will have from.sll_ifindex=3

can someone help me understand the role played by PACKET_ORIGDEV socket
option in the above scenario.

--0000000000001df236058acb13e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi All,<br></div><div><br></div><=
div>I&#39;ve a few doubts w.r.t layer2-frame processing in linux and PACKET=
_ORIGDEV socket option for getting origdev info.</div><div><br></div><div>F=
or example, lets assume below given is the set of net devices that my frame=
 is intended to traverse over.</div><div><pre style=3D"color:rgb(0,0,0)"><s=
pan style=3D"background-color:rgb(238,238,238)"><code>eth0(1) -&gt; bond0(2=
) -&gt; bridge(3) -&gt; vlan100(4). &gt;&gt;&gt; (x) ifindex for each netde=
vice</code></span></pre></div><div>I have created a =C2=A0RAW socket ( not =
binded to any interface) , attached with a socket filter to trap only inter=
ested packets.</div><div>I am getting a copy of frame trapped from each of =
the netdevice. is this expected?</div><div><br></div><div>frame <span style=
=3D"background-color:rgb(255,255,255)">trapped from=C2=A0<span style=3D"col=
or:rgb(0,0,0)">eth0 will have from.sll_ifindex=3D1</span></span></div><div>=
<span style=3D"background-color:rgb(255,255,255)"><span style=3D"color:rgb(=
0,0,0)">frame trapped from bond0 will have=C2=A0</span><span style=3D"color=
:rgb(0,0,0)">from.sll_ifindex=3D2</span></span></div><div><div><span style=
=3D"background-color:rgb(255,255,255)"><span style=3D"color:rgb(0,0,0)">fra=
me trapped from bridge will have=C2=A0</span><span style=3D"color:rgb(0,0,0=
)">from.sll_ifindex=3D3</span></span></div></div><div><div><span style=3D"b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(0,0,0)">frame tr=
apped from vlan100 will have=C2=A0</span><span style=3D"color:rgb(0,0,0)">f=
rom.sll_ifindex=3D4</span></span></div><div><span style=3D"color:rgb(0,0,0)=
;background-color:rgb(255,255,255)"><br></span></div><span style=3D"color:r=
gb(0,0,0);background-color:rgb(255,255,255)"></span></div><div>If I set the=
 following socket option=C2=A0PACKET_ORIGDEV , I get the following result</=
div><div><br></div><div><div>frame=C2=A0trapped from=C2=A0<span style=3D"co=
lor:rgb(0,0,0)">eth0 will have from.sll_ifindex=3D1</span></div><div><span =
style=3D"color:rgb(0,0,0)">frame trapped from bond0 will have=C2=A0</span><=
span style=3D"color:rgb(0,0,0)">from.sll_ifindex=3D1</span></div><div><span=
 style=3D"color:rgb(0,0,0)">frame trapped from bridge will have=C2=A0</span=
><span style=3D"color:rgb(0,0,0)">from.sll_ifindex=3D3. =C2=A0&gt;&gt; why =
is this not set to 1 or 2?</span></div><div><span style=3D"color:rgb(0,0,0)=
">frame trapped from vlan100 will have=C2=A0</span><span style=3D"color:rgb=
(0,0,0)">from.sll_ifindex=3D3</span></div></div><div><span style=3D"color:r=
gb(0,0,0)"><br></span></div><div><font color=3D"#000000">can someone help m=
e understand the role played by=C2=A0</font>PACKET_ORIGDEV socket option in=
 the above scenario.</div></div></div></div></div></div></div></div></div><=
/div></div></div>

--0000000000001df236058acb13e5--
