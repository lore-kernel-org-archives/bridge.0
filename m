Return-Path: <jlausuch@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=v2ts17lJbguiPBCBuFspNEQ9LxCtN28RZAuN5UU/zXA=;
	b=oe+1BVbkrLxYVkHtL7sTJaJsUqOIFXVZT+Qjw+kn7J13oeysG6Exb1JcyAjPTv1Gm1
	qEU3Q5wtC09Rty0PGudtfzx0N2tQEvcdWlI31oXux3bt9gfAnn/Y6cMqliafvWS4GfCU
	fzdVW+05RX+JacauPSSMcQQRRb9WrW7NE0NDiOlMxDMcOVStYYcXYC0ObNmPmLyGI/F1
	onNo4qUJL9eQ/08hFomY5bvapj037RIR6L9gqpPlmHuZYSwao8mwKoHXOksJq2qz/tVZ
	oRcsx/TQjx1Z2ac4pgmiBMp/kaUdi/+Hz94wmJVvfcMsh2/Cj/t4HUp2D7wqVWY3Jud3
	VQwA==
MIME-Version: 1.0
Date: Tue, 17 Feb 2015 11:41:21 +0100
Message-ID: <CAL3uegjAdY2xsJaprsmzdYCVrHvFDZ_OHpJmDLxLn8CE1tZ_cQ@mail.gmail.com>
From: =?UTF-8?Q?Jos=C3=A9_A=2E_Lausuch_Sales?= <jlausuch@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c16dfcf5fd3c050f465778
Subject: [Bridge] Vlan tagging through a bridge to a VM
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a11c16dfcf5fd3c050f465778
Content-Type: text/plain; charset=UTF-8

Hi,

I want to create a guest VM with a single bridge (br0) and I want it to
talk untagged traffic and tagged traffic using vlans 11 and 22.

From the Host where I create the VM, I use the following commands to create
the bridge.
--------------------------------------------------
ip link add name eth1.11 link eth1 type vlan id 11
ip link set eth1.11 up
ip link add name eth1.22 link eth1 type vlan id 22
ip link set eth1.22 up

brctl addbr br0
brctl addif br0 eth1
brctl addif br0 eth1.11
brctl addif br0 eth1.22

ip addr add 192.168.0.100/24 broadcast 192.168.0.255 dev br0
ip addr add 192.168.11.100/24 broadcast 192.168.0.255 dev br0 label br0:11
ip addr add 192.168.22.100/24 broadcast 192.168.0.255 dev br0 label br0:22

--------------------------------------------------

So far, everything ok. I can ping the IPs in vlans 11 and 22 from that
bridge (e.g. ping -I br0 192.168.11.3) and also untagged network (e.g. ping
-I br0 192.168.0.5).

Now when I use that br0 to create a VM, it can ping the untagged network
but not the tagged ones (creating also vlan interfaces in the VM).

What am I missing?

--001a11c16dfcf5fd3c050f465778
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:12.8000001907349px">Hi,</div><div =
style=3D"font-size:12.8000001907349px"><br></div><div style=3D"font-size:12=
.8000001907349px">I want to create a guest VM with a single bridge (br0) an=
d I want it to talk untagged traffic and tagged traffic using vlans 11 and =
22.</div><div style=3D"font-size:12.8000001907349px"><br></div><div style=
=3D"font-size:12.8000001907349px">From the Host where I create the VM, I us=
e the following commands to create the bridge.</div><div style=3D"font-size=
:12.8000001907349px">--------------------------------------------------</di=
v><div style=3D"font-size:12.8000001907349px">ip link add name eth1.11 link=
 eth1 type vlan id 11</div><div style=3D"font-size:12.8000001907349px">ip l=
ink set eth1.11 up</div><div style=3D"font-size:12.8000001907349px">ip link=
 add name eth1.22 link eth1 type vlan id 22</div><div style=3D"font-size:12=
.8000001907349px">ip link set eth1.22 up</div><div style=3D"font-size:12.80=
00001907349px"><br></div><div style=3D"font-size:12.8000001907349px">brctl =
addbr br0</div><div style=3D"font-size:12.8000001907349px">brctl addif br0 =
eth1</div><div style=3D"font-size:12.8000001907349px">brctl addif br0 eth1.=
11</div><div style=3D"font-size:12.8000001907349px">brctl addif br0 eth1.22=
</div><div style=3D"font-size:12.8000001907349px"><br></div><div style=3D"f=
ont-size:12.8000001907349px">ip addr add=C2=A0<a href=3D"http://192.168.0.1=
00/24" target=3D"_blank">192.168.0.100/24</a>=C2=A0broadcast 192.168.0.255 =
dev br0</div><div style=3D"font-size:12.8000001907349px">ip addr add=C2=A0<=
a href=3D"http://192.168.11.100/24" target=3D"_blank">192.168.11.100/24</a>=
=C2=A0broadcast 192.168.0.255 dev br0 label br0:11</div><div style=3D"font-=
size:12.8000001907349px">ip addr add=C2=A0<a href=3D"http://192.168.22.100/=
24" target=3D"_blank">192.168.22.100/24</a>=C2=A0broadcast 192.168.0.255 de=
v br0 label br0:22</div><div style=3D"font-size:12.8000001907349px"><br></d=
iv><div style=3D"font-size:12.8000001907349px">----------------------------=
----------------------</div><div style=3D"font-size:12.8000001907349px"><br=
></div><div style=3D"font-size:12.8000001907349px">So far, everything ok. I=
 can ping the IPs in vlans 11 and 22 from that bridge (e.g. ping -I br0 192=
.168.11.3) and also untagged network (e.g. ping -I br0 192.168.0.5).</div><=
div style=3D"font-size:12.8000001907349px"><br></div><div style=3D"font-siz=
e:12.8000001907349px">Now when I use that br0 to create a VM, it can ping t=
he untagged network but not the tagged ones (creating also vlan interfaces =
in the VM).</div><div style=3D"font-size:12.8000001907349px"><br></div><div=
 style=3D"font-size:12.8000001907349px">What am I missing?</div></div>

--001a11c16dfcf5fd3c050f465778--
