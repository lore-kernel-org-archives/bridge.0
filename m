Return-Path: <08beesmmkazmi@seecs.edu.pk>
MIME-Version: 1.0
Date: Mon, 27 Feb 2012 19:12:42 +0500
Message-ID: <CAAZheXnhvhT7SUyq2CNXDM3TUGe-ZpT1BNb87u2oC5yuNgkc8A@mail.gmail.com>
From: Syed Muhammad Mohsin Kazmi <08beesmmkazmi@seecs.edu.pk>
Content-Type: multipart/alternative; boundary=f46d043bdfe420f7ea04b9f2b495
Subject: [Bridge] Problem regarding TRILL encapsulated packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--f46d043bdfe420f7ea04b9f2b495
Content-Type: text/plain; charset=ISO-8859-1

hi all,
       I have written a code which encapsulates the bridge forwarding
traffic with TRILL header for OTHERHOST and OUTGOING and send it by calling
a function (forward) in linux bridging module.
On the other side, these packets are received by (br_handle_frames), where
i call a function (decapsulate_trill_header) within a check ethernet_type
== 0x88c8 (as this is ether_type for trill protocol). But trill
encapsulated packets have not processed there. When i ran the Wireshark and
captured the outgoing traffic from sending side and incoming traffic from
receiving side. These encapsulated packets are shown as LLC packets on both
sending and receiving sides. I don't know why these packets are shown as
LLC.  I am trapped here. I have no idea , what should i do now.
I need some help, suggestion or tactics to resolve this problem.


regards,
Mohsin Kazmi

--f46d043bdfe420f7ea04b9f2b495
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi all,<br>=A0=A0=A0=A0=A0=A0 I have written a code which encapsulates the =
bridge forwarding traffic=20
with TRILL header for OTHERHOST and OUTGOING and send it by calling a=20
function (forward) in linux bridging module. <br>On the other side, these p=
ackets are received by=20
(br_handle_frames), where i call a function (decapsulate_trill_header)=20
within a check ethernet_type =3D=3D 0x88c8 (as this is ether_type for trill=
=20
protocol). But trill encapsulated packets have not processed there. When
 i ran the Wireshark and captured the outgoing traffic from sending side
 and incoming traffic from receiving side. These encapsulated packets=20
are shown as LLC packets on both sending and receiving sides. I don&#39;t=
=20
know why these packets are shown as LLC.=A0 I am trapped here. I have no=20
idea , what should i do now. <br>
I need some help, suggestion or tactics to resolve this problem.=A0 <br><br=
><br>regards,<br>Mohsin Kazmi




--f46d043bdfe420f7ea04b9f2b495--
