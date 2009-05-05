MIME-Version: 1.0
In-Reply-To: <4A007103.4010501@gmail.com>
References: <20090428124009.GA26387@kallisti.us>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
Date: Tue, 5 May 2009 13:08:10 -0500
Message-ID: <2e59e6970905051108q7448a0ai7f6e5cb16faf1e00@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: multipart/alternative; boundary=001485f33bee5f584d04692e29b3
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

--001485f33bee5f584d04692e29b3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> But, when I add eth0 to bridge_ports, it doesn't work any longer



That and this are your problem:

eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6
          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
         RX packets:3 errors:79 dropped:79 overruns:0 frame:0

All those dropped packets on receive... your wireless card isn't accepting
packets with other destination MAC addresses.  And when you add eth0 into
the bridge, Linux must be choosing eth0's MAC address as the bridge address.

Since bridging works in Windows, your card is capable of doing this with the
right configuration.  But I don't know what to suggest trying next.

--001485f33bee5f584d04692e29b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
But, when I add eth0 to bridge_ports, it doesn&#39;t work any longer</block=
quote><div><br><br>That and this are your problem:<br><br>eth1 =A0 =A0 =A0L=
ink encap:Ethernet =A0HWaddr 00:15:00:1f:20:a6<br>
<div class=3D"im"> =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::215:ff:fe1f:20a6/64=
 Scope:Link<br>
</div> =A0 =A0 =A0 =A0 =A0UP BROADCAST MULTICAST =A0MTU:1500 =A0Metric:1<br=
>
 =A0 =A0 =A0 =A0 =A0RX packets:3 errors:79 dropped:79 overruns:0 frame:0<br=
><br>All those dropped packets on receive... your wireless card isn&#39;t a=
ccepting packets with other destination MAC addresses.=A0 And when you add =
eth0 into the bridge, Linux must be choosing eth0&#39;s MAC address as the =
bridge address.<br>
<br>Since bridging works in Windows, your card is capable of doing this wit=
h the right configuration.=A0 But I don&#39;t know what to suggest trying n=
ext.<br></div></div>

--001485f33bee5f584d04692e29b3--
