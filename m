Return-Path: <eriktar@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=XTC22IvM3TkYLd/TjgRecHAb4GupdsZvKfeKA08qfAU=;
	b=EL8AXE5eZUvmlafz1qPtc/ui+NMzXji8N+wocjQbSxRuFPNS6HGwmfLGkG6z+tackZ
	AYA5/7DvdFF737zpRAf6CcFca3Bbgi2HevBliAYFk8nT3jEhA38W0l/6sK50oQWe1l4n
	8rOUN0d4vwKlNVjXzcsSeDJ2TNhtG22Bz8zGHGECwrm470NDh/L6VqWjB85N/3Pl6F8C
	TDamhpfZfTTg0ylReRda8rXAH7dTTE8LTAyx3k4YyIF/+b1THXE7KmSi/S3SmPyjo/+/
	YGdfy24SXJfVFLHtkkXl+CrkTYcZ3wpGImaXQ722TrDc0By+0qE+8NWioUjHINqqJMis
	fj/g==
MIME-Version: 1.0
Date: Thu, 13 Sep 2012 10:41:31 +0200
Message-ID: <CAD-Tc1d+G19+W1S-88Sf3FPNyUe0_An0Pf8OzsFp7OcG9sOuSQ@mail.gmail.com>
From: Erik Taraldsen <eriktar@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cdf134228aeb004c99146d8
Subject: [Bridge] tc does not affect multicast traffic over bridge interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000e0cdf134228aeb004c99146d8
Content-Type: text/plain; charset=ISO-8859-1

Hi!

I am rigging a IPTV multicast test-bed.  The goal is to be able to simulate
network scenarios such as loss, duplicates, jitter, reordering to benchmark
the IPTV solutions.  And benchmark the quality reporting tool as well.  My
problem is that multicast traffic is unaffected by 'tc' (traffic control)
operations.  Unicast, such as video on demand and management traffic, is
affected by tc.

Is there some special treatment of multicast by linux bridging?  Hardware
acceleration for example?

My setup:
I have a four port network card.  br0 is used for wan side of the
residential gateway.  br1 is used between the RG and the IPTV Set Top Box.

Linux version 3.5.3-1.fc17.i686 (mockbuild@) (gcc version 4.7.0 20120507
(Red Hat 4.7.0-5) (GCC) ) #1 SMP Wed Aug 29 19:25:38 UTC 2012

[root@bridgemaster proc]# brctl show
bridge name    bridge id        STP enabled    interfaces
br0        8000.001b21bba80c    no        p1p1
                            p1p2
br1        8000.001b21bba80e    no        p1p3
                            p1p4
[root@bridgemaster proc]#


           *-network:0
                description: Ethernet interface
                product: 82580 Gigabit Network Connection
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:01:00.0
                logical name: p1p1
                version: 01
                serial: 00:1b:21:bb:a8:0c
                size: 1Gbit/s
                capacity: 1Gbit/s
                width: 32 bits
                clock: 33MHz
                capabilities: pm msi msix pciexpress bus_master cap_list
rom ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd
autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=igb
driverversion=3.4.7-k duplex=full firmware=3.19-0 latency=0 link=yes
multicast=yes port=twisted pair speed=1Gbit/s



-Erik Taraldsen

--000e0cdf134228aeb004c99146d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!<br><br>I am rigging a IPTV multicast test-bed.=A0 The goal is to be abl=
e to simulate network scenarios such as loss, duplicates, jitter, reorderin=
g to benchmark the IPTV solutions.=A0 And benchmark the quality reporting t=
ool as well.=A0 My problem is that multicast traffic is unaffected by &#39;=
tc&#39; (traffic control) operations.=A0 Unicast, such as video on demand a=
nd management traffic, is affected by tc.=A0 <br>
<br>Is there some special treatment of multicast by linux bridging?=A0 Hard=
ware acceleration for example?<br><br>My setup:<br>I have a four port netwo=
rk card.=A0 br0 is used for wan side of the residential gateway.=A0 br1 is =
used between the RG and the IPTV Set Top Box.<br>
<br>Linux version 3.5.3-1.fc17.i686 (mockbuild@) (gcc version 4.7.0 2012050=
7 (Red Hat 4.7.0-5) (GCC) ) #1 SMP Wed Aug 29 19:25:38 UTC 2012<br><br>[roo=
t@bridgemaster proc]# brctl show<br>bridge name=A0=A0=A0 bridge id=A0=A0=A0=
 =A0=A0=A0 STP enabled=A0=A0=A0 interfaces<br>
br0=A0=A0=A0 =A0=A0=A0 8000.001b21bba80c=A0=A0=A0 no=A0=A0=A0 =A0=A0=A0 p1p=
1<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
p1p2<br>br1=A0=A0=A0 =A0=A0=A0 8000.001b21bba80e=A0=A0=A0 no=A0=A0=A0 =A0=
=A0=A0 p1p3<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 p1p4<br>[root@bridgemaster proc]# <br><br><br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 *-network:0<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 description: Ethernet interfa=
ce<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product: 82580 Gigabit =
Network Connection<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vendor:=
 Intel Corporation<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 physica=
l id: 0<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bus info: pci@0000=
:01:00.0<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logical name: p1p1<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 version: 01<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial: 00:1b:21:bb:a8:0c<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 size: 1Gbit/s<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 capacity: 1Gbit/s<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 width: 32 bits<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
lock: 33MHz<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 capabilities: pm msi msix pci=
express bus_master cap_list rom ethernet physical tp 10bt 10bt-fd 100bt 100=
bt-fd 1000bt-fd autonegotiation<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 configuration: autonegotiation=3Don broadcast=3Dyes driver=3Digb dri=
verversion=3D3.4.7-k duplex=3Dfull firmware=3D3.19-0 latency=3D0 link=3Dyes=
 multicast=3Dyes port=3Dtwisted pair speed=3D1Gbit/s<br>
<br><br><br>-Erik Taraldsen<br>

--000e0cdf134228aeb004c99146d8--
