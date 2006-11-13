Message-ID: <4558F86D.6010504@volunteermatch.org>
Date: Mon, 13 Nov 2006 14:57:49 -0800
From: Melissa Meyer <melissa@volunteermatch.org>
MIME-Version: 1.0
References: <4554f533.18d37d8d.5d69.ffffc5a2@mx.google.com>
In-Reply-To: <4554f533.18d37d8d.5d69.ffffc5a2@mx.google.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridge - canopy - cisco catalyst 2950
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Alonso Enero V." <alonso.enero@gmail.com>
Cc: bridge@lists.osdl.org, bridge@siennax.com



Did you get an answer to this?

I had a similar experience. To fix, I had to turn off spanning tree on=20
the cisco switch connected to the bridges as well as turn on dot1q=20
trunking on the ports on the switch the bridges used.

So the cisco config for my bridge ports:

switchport trunk encapsulation dot1q
switchport mode trunk
switchport nonegotiate

For the other ports on the switch, the switchport mode was set to access.

Hope this helps.



Alonso Enero V. wrote:
>
> Hi Friends!
>
> Sorry for disturb you=85
>
> I want to ask you something about a bridge implementation that I need=20
> to make work.
>
> This implementation uses *Motorola* *Canopy* (a wireless=20
> implementation) to link two sites of my work company backing up an=20
> optic fiber link (the main link) like appears in the following picture:
>
> Everything works ok in a laboratory environment, without the Cisco=20
> Catalyst switch, but when link the #1 bridge to the Cisco Catalyst=20
> respective port (the one with the needed VLAN), starts a horrible loop=20
> in our LAN. I think something happens inside the Cisco switch that=20
> difficult the STP traffic between the #1 bridge and out site 3. I=20
> heard of something called *bdpufilter*, which is not set in out=20
> Catalyst switch, said our ISP. I read a page were you give some=20
> suggestions of tweak the Linux Kernel that I did=20
> (http://lists.osdl.org/pipermail/bridge/2005-October/001116.html), but=20
> still didn=92t tested, until have a clear idea of what happens inside=20
> the Cisco switch.
>
> Thanks in advice!
>
> Alonso Enero V.
>
> alonso.enero@gmail.com <mailto:alonso.enero@gmail.com>
>
> Santiago, Chile
>
>
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>  =20
