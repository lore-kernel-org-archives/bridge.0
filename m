From: Patrick Nagel <mail@patrick-nagel.net>
Date: Wed, 13 Dec 2006 21:26:57 +0100
References: <200612101909.39202.mail@patrick-nagel.net>
	<20061213101442.058d4968@dxpl.pdx.osdl.net>
In-Reply-To: <20061213101442.058d4968@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1879876.mOMkbS2vHG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612132127.09421.mail@patrick-nagel.net>
Subject: Re: [Bridge] Man-in-the-middle scenario within vmware - problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

--nextPart1879876.mOMkbS2vHG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stephen,

thanks for answering!

> Did you wait until after the "forwarding delay" expired (30 seconds) or s=
et
> turn forwarding delay off?
Yes to waiting.

> It may be that the ehternet driver doesn't support promiscious mode
> and/or doesn't expect non-local source adresses. You need to see where
> packets are being dropped, could be the ethernet driver, or switch with
> network access control or inside the bridge.
The driver seems to support promiscious mode, as I get the following from=20
dmesg after setting up the bridge:

[17179785.256000] Bridge firewalling registered
[17179785.264000] device eth0 entered promiscuous mode
[17179785.264000] audit(1166040131.368:2): dev=3Deth0 prom=3D256 old_prom=
=3D0=20
auid=3D4294967295
[17179785.268000] device eth1 entered promiscuous mode
[17179785.268000] audit(1166040131.372:3): dev=3Deth1 prom=3D256 old_prom=
=3D0=20
auid=3D4294967295
[17179785.272000] eth0: link up
[17179785.280000] eth1: link up
[17179785.284000] lnxbr0: port 2(eth1) entering learning state
[17179785.284000] lnxbr0: port 1(eth0) entering learning state
[17179795.336000] eth1: no IPv6 routers present
[17179795.848000] eth0: no IPv6 routers present
[17179796.040000] lnxbr0: no IPv6 routers present
[17179800.284000] lnxbr0: topology change detected, propagating
[17179800.284000] lnxbr0: port 2(eth1) entering forwarding state
[17179800.284000] lnxbr0: topology change detected, propagating
[17179800.284000] lnxbr0: port 1(eth0) entering forwarding state

Look at those "screenshots":

After some "ping" packets from PC1 to PC2, the statistics look like this:

$ ifconfig eth0 && ifconfig eth1 && ifconfig lnxbr0
eth0      Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:55
          inet6 addr: fe80::20c:29ff:fe6d:f055/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2880 (2.8 KiB)  TX bytes:468 (468.0 b)
          Interrupt:177 Base address:0x1080

eth1      Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:5F
          inet6 addr: fe80::20c:29ff:fe6d:f05f/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:54 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:3348 (3.2 KiB)
          Interrupt:185 Base address:0x1400

lnxbr0    Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:55
          inet6 addr: fe80::20c:29ff:fe6d:f055/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2208 (2.1 KiB)  TX bytes:468 (468.0 b)

So the packets come in on eth0, and they're sent out on eth1, but there is =
no=20
answer received from PC2. BUT on PC2, ifconfig says that there were 57=20
packets in and 57 packets out on eth0.

Now let's do it the other way round:

$ ifconfig eth0 && ifconfig eth1 && ifconfig lnxbr0
eth0      Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:55 =20
          inet6 addr: fe80::20c:29ff:fe6d:f055/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:24 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:2880 (2.8 KiB)  TX bytes:1548 (1.5 KiB)
          Interrupt:177 Base address:0x1080=20

eth1      Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:5F =20
          inet6 addr: fe80::20c:29ff:fe6d:f05f/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:18 errors:0 dropped:0 overruns:0 frame:0
          TX packets:54 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:1080 (1.0 KiB)  TX bytes:3348 (3.2 KiB)
          Interrupt:185 Base address:0x1400=20

lnxbr0    Link encap:Ethernet  HWaddr 00:0C:29:6D:F0:55 =20
          inet6 addr: fe80::20c:29ff:fe6d:f055/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:66 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:3036 (2.9 KiB)  TX bytes:468 (468.0 b)

And it's the same - the packets come in on eth1, go out on eth0, but the=20
echoes never make it back through eth0.

So where exactly do they get stuck? I really don't know how to proceed...

> Also check that the drivers correctly report carrier state.
>
> brctl show lnxbr0
=2E.. is always like this:

bridge name	bridge id		STP enabled	interfaces
lnxbr0		8000.000c296df055	no		eth1
							eth0

> Should show both devices in forwarding atate.
Where could I see that?

Thanks for your help!

Patrick.

=2D-=20
Key ID: 0x86E346D4 =A0 =A0 =A0 =A0 =A0 =A0http://patrick-nagel.net/key.asc
=46ingerprint: 7745 E1BE FA8B FBAD 76AB 2BFC C981 E686 86E3 46D4

--nextPart1879876.mOMkbS2vHG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFgGIdyYHmhobjRtQRAnyyAKC9F2LN3z6XAYBPZHuHgOx357xeHQCgkb6O
qG+LkCsLMOArwoCYbBK3r4c=
=zM6d
-----END PGP SIGNATURE-----

--nextPart1879876.mOMkbS2vHG--
