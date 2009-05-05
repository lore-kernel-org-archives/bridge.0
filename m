Message-ID: <4A007103.4010501@gmail.com>
Date: Tue, 05 May 2009 19:01:55 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr>
In-Reply-To: <49FFDABF.4030500@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org



Nicolas de Peslo=FCan schreef:
> Can you also please try to change the order of the scanzas in=20
> /etc/network/interfaces, so that iface br0 comes before iface eth1 in=20
> the file ? ifup -a is expected to bring the interface in the order=20
> they appear in the file...
I tried that. I'm not posting all the outcomes of all the commands here,=20
because it didn''t change the situation :-(. So no success ...
>
> Also, you could add "bridge-fd 0" in the br0 stanza. Because you=20
> bridge is by design loop-free, there is no reason to wait 32 seconds=20
> before entering the forwarding stat.
Thnx :-). That saves me some time!

Now, I changed my wireless security to unsecure, and I was able to get this:

=3D> with this configuration, the bridge works!
auto lo
iface lo inet loopback

auto br0
iface br0 inet dhcp
bridge_ports eth1
bridge-fd 0

auto eth0
iface eth0 inet manual

auto eth1
iface eth1 inet manual
wireless-essid ##SSID##


jochus@Bacardi ~ $ ping www.google.be
PING www.l.google.com (74.125.77.99) 56(84) bytes of data.
64 bytes from ew-in-f99.google.com (74.125.77.99): icmp_seq=3D1 ttl=3D242=20
time=3D74.5 ms
64 bytes from ew-in-f99.google.com (74.125.77.99): icmp_seq=3D2 ttl=3D242=20
time=3D17.4 ms
64 bytes from ew-in-f99.google.com (74.125.77.99): icmp_seq=3D3 ttl=3D242=20
time=3D21.4 ms


But, when I add eth0 to bridge_ports, it doesn't work any longer

So, maybe, we should try to focus why it doesn't work without security.=20
If that works, we could check the WPA side. But I think we first need=20
the bridge running in a "easy" situation, with no security
