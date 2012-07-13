Return-Path: <v.yegyanathan@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=Fv4eCnbMIWZm0mEs1UUipPUbdhusf+AsEuL/CBq13lU=;
	b=cydFzT1iBckTlnRJMM7EgZZNXGPif0es05QtJdsWRwbhNTLIePAjIjsEIY3ZbGUBcs
	lOFCD6awinxlzyfZkRYCfngZoRF8D8565pjABXPQWrPi9WXNrYddB0jXs0vJPKO/9y0A
	VcVKGXlaat5s1Rj630ersBm424i7aiK4S9F3Tu99Ma4p389rK6uF5zmv6IZWg5SNbx94
	qtfF340e4RbCjzRsRrgfHyO9XFBP1uZJ5zdx0DCAk7UfgBLe7cSutMssZcm41XTQ1QAF
	yYHN0ucAB/URHKDGITogd6g5yEUDxhA5TA78SYQn5RRCUYqpNLyhyLx6rokS6odKQZbT
	uKUg==
MIME-Version: 1.0
Date: Fri, 13 Jul 2012 10:01:05 +0530
Message-ID: <CAHa3ZSkKGLcz-JgK2WWtqEcicR=dGZd6pj6Eef4PSMSOyBdPkw@mail.gmail.com>
From: V Yegyanathan <v.yegyanathan@gmail.com>
Content-Type: multipart/alternative; boundary=f46d043749875d67b804c4ae8cca
Subject: [Bridge] how to disable multicast_router in bridge? and get rid of
	the LLDP messages
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--f46d043749875d67b804c4ae8cca
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I  created 3 bridges and inter-connected them with veth links. No external
nodes are connected to this n/w and STP is disabled and hence expected
links to be silent. [Yes, I dont want STP, even though this looped topo]
I got ipv6 multicast LLDPs and hence disabled ipv6 through sysfs for all
nodes.
After that I am getting

  0.000000 86:79:7b:e4:8c:9f -> LLDP_Multicast LLDP 222 Chassis Id =
e8:03:9a:3b:1c:28 Port Id = 86:79:7b:e4:8c:9f TTL = 120
  0.000031 2a:b3:bc:44:7a:44 -> LLDP_Multicast LLDP 221 Chassis Id =
e8:03:9a:3b:1c:28 Port Id = 2a:b3:bc:44:7a:44 TTL = 120
which are LLDP nearest messages which I want to get rid off.

I was suspecting it as due to multicast_router being enabled in bridge by
default and hence want to disable. I able to disable multicast_snooping
(file is written) but could not multicast_router. Manual write with vi
editor fails with sysfs sync failure.

Please let me know how I could stop these messages.
Reference:

http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Snooping

I am not able to set the value in  "multicast_router" file to "0" while I
can do that for "multicast_snooping"


system details :
3.2.0-26-generic-pae #41-Ubuntu SMP Thu Jun 14 16:45:14 UTC 2012 i686 i686
i386 GNU/Linux
brctl -V
bridge-utils, 1.5

Please let me know if any more information is needed.

Thanks and regards,
vy

--f46d043749875d67b804c4ae8cca
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hi All,<br><br>I=A0 created 3 bridges and inter-connected them with=20
veth links. No external nodes are connected to this n/w and STP is=20
disabled and hence expected links to be silent. [Yes, I dont want STP, even=
 though this looped topo]<br>I got ipv6 multicast LLDPs and hence disabled =
ipv6 through sysfs for all nodes.<br>After that I am getting<br><br>=A0 0.0=
00000 86:79:7b:e4:8c:9f -&gt; LLDP_Multicast LLDP 222 Chassis Id =3D e8:03:=
9a:3b:1c:28 Port Id =3D 86:79:7b:e4:8c:9f TTL =3D 120 <br>
=A0 0.000031 2a:b3:bc:44:7a:44 -&gt; LLDP_Multicast LLDP 221 Chassis Id =3D=
 e8:03:9a:3b:1c:28 Port Id =3D 2a:b3:bc:44:7a:44 TTL =3D 120 <br>which are =
LLDP nearest messages which I want to get rid off.<br><br>I
 was suspecting it as due to multicast_router being enabled in bridge by
 default and hence want to disable. I able to disable multicast_snooping
 (file is written) but could not multicast_router. Manual write with vi edi=
tor fails with sysfs sync failure. <br><br>Please let me know how I could s=
top these messages. <br>Reference:<br>=A0 <a href=3D"http://www.linuxfounda=
tion.org/collaborate/workgroups/networking/bridge#Snooping">http://www.linu=
xfoundation.org/collaborate/workgroups/networking/bridge#Snooping</a><br>
<br>I am not able to set the value in=A0 &quot;multicast_router&quot; file =
to &quot;0&quot; while I can do that for &quot;multicast_snooping&quot; <br=
><br><br>system details :<br>3.2.0-26-generic-pae #41-Ubuntu SMP Thu Jun 14=
 16:45:14 UTC 2012 i686 i686 i386 GNU/Linux<br>
brctl -V<br>bridge-utils, 1.5<br><br>Please let me know if any more informa=
tion is needed.<br><br>Thanks and regards,<br>vy<br>

--f46d043749875d67b804c4ae8cca--
