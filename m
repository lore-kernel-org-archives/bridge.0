Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+mtxU4kPaFVXLTg7SEgmeFMg0p7UMWatGkhCYMXP18E=;
	b=rHzG2smaK1Wz7NWiFnh1tRR59CnuzsVUusuZZGWGpZS3MWRrKicC2mbL8bENuG+k5KHoqVNEU8MonIV1iD6r7S2Q4V8bD2Uq9i2pgqu+MaA4Xbpp0cEqXcGgC/kyc6oKRlL2a2hZhEPe6VOBCW0YmkI56f0XI2JhUjrUO+susOo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 11 Jan 2019 19:20:59 +0000
Message-ID: <20190111192056.GA13325@splinter.mtl.com>
References: <20190110193206.9872-1-f.fainelli@gmail.com>
	<20190111150637.GA897@splinter.mtl.com>
	<232e03c9-e2c8-9ad1-0a60-183dcbac72a5@gmail.com>
In-Reply-To: <232e03c9-e2c8-9ad1-0a60-183dcbac72a5@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4666E0DC6BD5845999D29C36479869C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "ivan.khoronzhuk@linaro.org" <ivan.khoronzhuk@linaro.org>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "davem@davemloft.net" <davem@davemloft.net>

On Fri, Jan 11, 2019 at 10:34:01AM -0800, Florian Fainelli wrote:
> On 1/11/19 7:06 AM, Ido Schimmel wrote:
> > On Thu, Jan 10, 2019 at 11:32:06AM -0800, Florian Fainelli wrote:
> >> +- with VLAN filtering turned on: frames ingressing the device with a =
VID that is
> >> +  not programmed into the bridges/switch's VLAN table must be dropped=
.
> >> +
> >> +Non-bridged network ports of the same switch fabric must not be distu=
rbed in any
> >> +way, shape or form by the enabling of VLAN filtering.
> >=20
> > "shape or form" ?
>=20
> It's just an expression, I can remove it :)

Yes, please. I think it is weird to use it in this context.

> >> +VLAN devices configured on top of a switchdev network device (e.g: sw=
0p1.100)
> >> +which is a bridge port member must also observe the following behavio=
r:
> >=20
> > It is not clear where VLAN filtering is on / off. On the bridge the VLA=
N
> > device is enslaved to I believe? Not the bridge the physical port is
> > enslaved to.
>=20
> Actually the later, at least in the hardware that I have access to, VLAN
> filtering is global to the entire switch, whether the physical switch
> ports are enslaved in a bridge or not.
>=20
> Once you add support for ndo_rx_vlan_{add,kill}_vid(), which ends up
> programming VLAN objects down the physical port, this is not a concern
> anymore because you can seamlessly support the following cases:
>=20
> - 1 or more physical ports enslaved into a VLAN aware bridge, 1 or more
> physical ports not enslaved at all with, or without VLAN devices on top
> of these non-bridged physical ports
>=20
> - all ports enslaved into a VLAN aware bridge, or multiple bridges, that
> all have the same VLAN filtering attributes (specific to my case here,
> obviously)
>=20
> Does that make sense? Some switches like mv88e6xxx do support a per-port
> VLAN filtering/secure/unsecure option.
>=20
> >=20
> >> +
> >> +- with VLAN filtering turned off, these VLAN devices must be fully fu=
nctional
> >> +  since the hardware is allowed VID frames. Enslaving VLAN devices in=
to the
> >=20
> > "the hardware is allowed VID frames" ?
>=20
> I meant to write that the hardware is not doing any ingress VID
> checking, therefore, it allows any VID frame to ingress the physical
> switch port.
>=20
> >=20
> >> +  bridge might be allowed provided that there is sufficient separatio=
n using
> >> +  e.g.: a reserved VLAN ID (4095 for instance) for untagged traffic.
> >> +
> >> +- with VLAN filtering turned on, these VLAN devices should not be all=
owed to
> >> +  be created because they duplicate functionality/use case with the b=
ridge's
> >> +  VLAN functionality.
> >=20
> > We always allow VLAN devices to be created. It is just that we don't
> > allow their *enslavement* to VLAN-aware bridges.
>=20
> If you have a bridge that is VLAN aware (br0), and you have a physical
> port enslaved in that bridge (sw0p0) and you create a VLAN device:
> sw0p0.100, it is equivalent to doing:
>=20
> bridge vlan add vid 100 dev sw0p0
> bridge vlan add vid 100 dev br0 self
> ip link add name br0.100 link eth0 type vlan id 100
>=20
> and use a VLAN device (br0.100) on top of the bridge, because if you do
> either of these two things, it means that you want the host to utilize
> those network interfaces.
>=20
> Would you disagree? The difference is basically in the data path
> handling of the VLAN (sort of).

If sw0p0.100 is not present, then a packet with VID 100 received through
sw0p0 will be picked up by the bridge's Rx handler. The bridge will then
forward it.

If sw0p0.100 is present, then the same packet will not be forwarded by
the bridge. The VLAN device will untag it and inject it back into the Rx
path as if it was received by the VLAN device that does not have the
bridge's Rx handler set.

>=20
> >=20
> >> +
> >> +Because VLAN filtering can be turned on/off at runtime, the switchdev=
 driver
> >> +must be able to re-configure the underlying hardware on the fly to ho=
nor the
> >> +toggling of that option and behave appropriately.
> >> +
> >> +A switchdev driver can also refuse to support dynamic toggling of the=
 VLAN
> >> +filtering knob at runtime and require a destruction of the bridge dev=
ice(s) and
> >> +creation of new bridge device(s) with a different VLAN filtering valu=
e to
> >> +ensure VLAN awareness is pushed down to the HW.
> >> +
> >> +IGMP snooping
> >> +~~~~~~~~~~~~~
> >> +
> >> +The Linux bridge allows the configuration of IGMP snooping (compile a=
nd run
> >> +time) which must be observed by the underlying switchdev network devi=
ce/hardware
> >> +in the following way:
> >> +
> >> +- when IGMP snooping is turned off, multicast traffic must be flooded=
 to all
> >> +  switch ports within the same broadcast domain. The CPU/management p=
ort
> >> +  should ideally not be flooded and continue to learn multicast traff=
ic through
> >> +  the network stack notifications. If the hardware is not capable of =
doing that
> >> +  then the CPU/management port must also be flooded and multicast fil=
tering
> >> +  happens in software.
> >> +
> >> +- when IGMP snooping is turned on, multicast traffic must selectively=
 flow
> >> +  to the appropriate network ports (including CPU/management port) an=
d not flood
> >> +  the switch.
> >> +
> >> +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Net=
work
> >> +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and shoul=
d always
> >> +be flooded.
> >=20
> > I'm not sure that these paragraphs are actually needed. You're basicall=
y
> > describing RFC 4541 on which the IGMP snooping functionality in the
> > Linux bridge is based on.
> >=20
> >> +
> >> +Because IGMP snooping can be turned on/off at runtime, the switchdev =
driver must
> >> +be able to re-configure the underlying hardware on the fly to honor t=
he toggling
> >> +of that option and behave appropriately.
> >> +
> >> +A switchdev driver can also refuse to support dynamic toggling of the=
 multicast
> >> +snooping knob at runtime and require the destruction of the bridge de=
vice(s)
> >> +and creation of a new bridge device(s) with a different multicast sno=
oping
> >> +value.
> >=20
> > You should probably get the patch that allows this vetoing merged befor=
e
> > sending this documentation patch.
>=20
> Well, technically the switchdev attribute allows returning an error, it
> is just that we do not act (yet) on it in the bridge code, I can take
> that part out fo correctness for now and submit a patch to that
> documentation file once I submit the change to the bridge layer.

+1

> --=20
> Florian
