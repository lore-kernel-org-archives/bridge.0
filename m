Return-Path: <paleopoe@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to;
	bh=1vOK7DazMr32IM3UdZQzm8FfxVkHynQrLaSW5qqlq+Q=;
	b=k4dBnF8EQDRtGA3nlmJLb+ax3mwMIa46PgnPIXMR8H2vAJP6WSyzZdnKN+nMbS3V4W
	jhWdLmFt3ueq4x2B5KKlSCqTgtsR0msBvdZRmD+bgZjeqEd3Ofsai1z0MWhI8kEBMpMf
	nL4T8IvqRb2/AMtyfInT2PLAJrqXuBqc+05HPwqWQIarajfcfH9NKodM4md875AD7Zmn
	90G8LEjp93A33qPtGwUGnLm1UguDAevCTK84eOM3vhgWvsKzUXz4vqMD0um7AdI/7IFF
	B/UojrU/dzDwNxMf2G6qLTOBWL+pLoW24uuvPFcj2LdF8D2VFmKPDghSNhvsc8AXumTu
	mmHQ==
MIME-Version: 1.0
Date: Tue, 15 Mar 2016 16:50:44 -0500
Message-ID: <CACyobKnP5mrx5sW9bKt3PQsQib6+VCXArMdBCRXHd4vo3qMHqw@mail.gmail.com>
From: Andy <paleopoe@gmail.com>
Content-Type: multipart/alternative; boundary=001a113d2a96aaf787052e1d6347
Subject: [Bridge] DEI Bit Behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a113d2a96aaf787052e1d6347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Community,



I've been working on a project that requires a very simple setup:



Packet Generator ---> ETH0 --- Bridge --- ETH1 ---> Packet Capture



What I want to see are packets going through my setup unmodified but
instead I'm seeing an interesting behavior when I send QnQ Ethernet traffic=
.

While sending double tagged packets, I=E2=80=99ve noticed that the DEI bit =
in the
VLAN tag is getting reset to zero.  This only happens if my SVLAN tag uses
the TPID value 0x88A8 or 0x8100. If I use a non-standard TPID like 0x9100,
the value of the DEI bit is passed through the system unmodified (as
desired).



To be honest, I'm not sure if this is intentional or unexpected but I've
done a lot of investigating and everything seems to imply that packets
should not be modified as it goes through the setup.



I have run my experiment on multiple devices, different interfaces and
different Linux distributions/Kernels.

As far as I can tell, the behavior seems consistent.



Is the resetting of the DEI bit intentional (seeing how it is not reset
when I pass a non-standard TPID, kind of makes me think it is)? If so, why?

Is there a way to prevent this from happening?



Here are some details:

Packet Generator Used: JDSU test set and Ostinato

Packet Capture: Wireshark running on a Windows

Bridge Commands used (pretty basic):

brctl addbr mybr

brctl addif mybr eth0

brctl addif mybr eth1

ifconfig mybr up



Version of Linux used:

Ubuntu 14.04, Kernel: 3.10

Ubuntu 15.10 Kernel: 3.10

Raspbian Jessie, Kernel: 4.1

Red Hat 7.1, Kernel 3.10



Thank you for any help and clarity you can provide.

Andrew Mao

--001a113d2a96aaf787052e1d6347
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-family:Arial,sans-serif;font-size=
:12pt">Hello Community,</span><br></div><div>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">I&#39;ve been working on a project that requires a very simple
setup:</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Packet Generator ---&gt; ETH0 --- Bridge --- ETH1 ---&gt; Packet
Capture</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">What I want to see are packets going through my setup unmodified
but instead I&#39;m seeing an interesting behavior when I send QnQ Ethernet
traffic.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">While sending double tagged packets, I=E2=80=99ve noticed that the =
DEI
bit in the VLAN tag is getting reset to zero.=C2=A0 This only happens if my
SVLAN tag uses the TPID value 0x88A8 or 0x8100. If I use a non-standard TPI=
D
like 0x9100, the value of the DEI bit is passed through the system unmodifi=
ed
(as desired).</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">To be honest, I&#39;m not sure if this is intentional or unexpected
but I&#39;ve done a lot of investigating and everything seems to imply that=
 packets
should not be modified as it goes through the setup.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">I have run my experiment on multiple devices, different
interfaces and different Linux distributions/Kernels.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">As far as I can tell, the behavior seems consistent.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Is the resetting of the DEI bit intentional (seeing how it is
not reset when I pass a non-standard TPID, kind of makes me think it is)? I=
f so, why?</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Is there a way to prevent this from happening?</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Here are some details:</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Packet Generator Used: JDSU test set and Ostinato</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Packet Capture: Wireshark running on a Windows</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Bridge Commands used (pretty basic):</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">brctl addbr mybr</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">brctl addif mybr eth0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">brctl addif mybr eth1</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">ifconfig mybr up</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Version of Linux used:</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Ubuntu 14.04, Kernel: 3.10</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Ubuntu 15.10 Kernel: 3.10</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Raspbian Jessie, Kernel: 4.1</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Red Hat 7.1, Kernel 3.10</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Thank you for any help and clarity you can provide.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12pt;font-family:Arial,sans=
-serif">Andrew Mao</span></p></div></div>

--001a113d2a96aaf787052e1d6347--
