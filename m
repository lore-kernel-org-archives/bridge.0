Message-ID: <4A00B327.6080705@free.fr>
Date: Tue, 05 May 2009 23:44:07 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
In-Reply-To: <4A007103.4010501@gmail.com>
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
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jochen Hebbrecht wrote:
> Nicolas de Peslo=FCan schreef:
>> Can you also please try to change the order of the scanzas in=20
>> /etc/network/interfaces, so that iface br0 comes before iface eth1 in=20
>> the file ? ifup -a is expected to bring the interface in the order=20
>> they appear in the file...
> I tried that. I'm not posting all the outcomes of all the commands here, =

> because it didn''t change the situation :-(. So no success ...
>>
>> Also, you could add "bridge-fd 0" in the br0 stanza. Because you=20
>> bridge is by design loop-free, there is no reason to wait 32 seconds=20
>> before entering the forwarding stat.
> Thnx :-). That saves me some time!

32 seconds per test... :-)

> Now, I changed my wireless security to unsecure, and I was able to get=20
> this:
>=20
> =3D> with this configuration, the bridge works!
>=20
> But, when I add eth0 to bridge_ports, it doesn't work any longer
>=20
> So, maybe, we should try to focus why it doesn't work without security.=20
> If that works, we could check the WPA side. But I think we first need=20
> the bridge running in a "easy" situation, with no security

When you setup the bridge at the beginning, the br0 interface takes the=20
MAC address of eth1. Then you add eth0 and the bridge takes the MAC=20
address of eth0, because it is lower.

Can you try to use the bridge-hw option of /etc/network/interfaces, to=20
force the bridge MAC address to the MAC address of the wireless=20
interface ? This might solve the communication problem for UBUNTU=20
SERVER... but unfortunately probably not for the bridging function.

That beeing said, Jonathan might be right about the need for WDS... Can=20
you have a look at the AP configuration, searching for a WDS setup ?=20
Because if it works on Windows, without WDS (if disabled or unavailable=20
on the AP), then we can assume that WDS is not required, even on Linux=20
(the wifi interface is able to receive traffic for another MAC).

If the AP is WDS enabled, then... WDS might be necessary... and nothing=20
can be done if the driver for you wifi interface does not support it...

	Nicolas.
