Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=k6zchpLUT39RU5ntPZG8TmaYJNj5xg2jcPd61CUs2KQ=;
	b=XZXZXmNOrWg9QwwzJXazOYpXitywHJh5lQ1YoKhxf02iKnAqGxtFZWGIafGVdd0aqW47dWIJ5GPBscqAcJMw4FYZHEAy8DIgACSIjD5CZC3uLy6t3wZtQWFyu1EpLh2uUzJ5zoim7wzE+8QCdcQVA5lQn0kdV9ko0dtb2cJjxtE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 11 Jan 2019 15:06:39 +0000
Message-ID: <20190111150637.GA897@splinter.mtl.com>
References: <20190110193206.9872-1-f.fainelli@gmail.com>
In-Reply-To: <20190110193206.9872-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEA1A3163932334D871CECAF8B7BD4F7@eurprd05.prod.outlook.com>
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

On Thu, Jan 10, 2019 at 11:32:06AM -0800, Florian Fainelli wrote:
> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v4:
>=20
> - more spelling/grammar/sentence fixes (Randy)
>=20
> Changes in v3:
>=20
> - spell checks, past vs. present use (Randy)
> - clarified some behaviors a bit more regarding multicast flooding
> - added some missing sentence about multicast snopping knob being
>   dynamically turned on/off
>=20
> Changes in v2:
>=20
> - clarified a few parts about VLAN devices wrt. VLAN filtering and their
>   behavior during enslaving.
>=20
>  Documentation/networking/switchdev.txt | 105 +++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>=20
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/netwo=
rking/switchdev.txt
> index 82236a17b5e6..dd58c957c557 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -392,3 +392,108 @@ switchdev_trans_item_dequeue()
> =20
>  If a transaction is aborted during "prepare" phase, switchdev code will =
handle
>  cleanup of the queued-up objects.
> +
> +Switchdev enabled network device expected behavior
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Below is a set of defined behavior that switchdev enabled network device=
s must
> +adhere to.
> +
> +Configuration less state
> +------------------------
> +
> +Upon driver bring up, the network devices must be fully operational, and=
 the
> +backing driver must configure the network device such that it is possibl=
e to
> +send and receive traffic to this network device and it is properly separ=
ated
> +from other network devices/ports (e.g.: as is frequent with a switch ASI=
C). How
> +this is achieved is heavily hardware dependent, but a simple solution ca=
n be to
> +use per-port VLAN identifiers unless a better mechanism is available
> +(proprietary metadata for each network port for instance).
> +
> +The network device must be capable of running a full IP protocol stack
> +including multicast, DHCP, IPv4/6, etc. If necessary, it should be progr=
am the
> +appropriate filters for VLAN, multicast, unicast etc. The underlying dev=
ice
> +driver must effectively be configured in a similar fashion to what it wo=
uld do
> +when IGMP snooping is enabled for IP multicast over these switchdev netw=
ork
> +devices and unsolicited multicast must be filtered as early as possible =
into
> +the hardware.
> +
> +When configuring VLANs on top of the network device, all VLANs must be w=
orking,
> +irrespective of the state of other network devices (e.g.: other ports be=
ing part
> +of a VLAN aware bridge doing ingress VID checking). See below for detail=
s.
> +
> +Bridged network devices
> +-----------------------
> +
> +When a switchdev enabled network device is added as a bridge member, it =
should
> +not disrupt any functionality of non-bridged network devices and they
> +should continue to behave as normal network devices. Depending on the br=
idge
> +configuration knobs below, the expected behavior is documented.
> +
> +VLAN filtering
> +~~~~~~~~~~~~~~
> +
> +The Linux bridge allows the configuration of a VLAN filtering mode (comp=
ile and
> +run time) which must be observed by the underlying switchdev network
> +device/hardware:
> +
> +- with VLAN filtering turned off: frames ingressing the device with a VI=
D that
> +  is not programmed into the bridge/switch's VLAN table must be forwarde=
d.

When VLAN filtering is turned off the expectation is that only untagged
frames will ingress the bridge. Either because they were sent untagged
or because a VLAN device enslaved to the bridge untagged them.

> +
> +- with VLAN filtering turned on: frames ingressing the device with a VID=
 that is
> +  not programmed into the bridges/switch's VLAN table must be dropped.
> +
> +Non-bridged network ports of the same switch fabric must not be disturbe=
d in any
> +way, shape or form by the enabling of VLAN filtering.

"shape or form" ?

> +
> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1=
.100)
> +which is a bridge port member must also observe the following behavior:

It is not clear where VLAN filtering is on / off. On the bridge the VLAN
device is enslaved to I believe? Not the bridge the physical port is
enslaved to.

> +
> +- with VLAN filtering turned off, these VLAN devices must be fully funct=
ional
> +  since the hardware is allowed VID frames. Enslaving VLAN devices into =
the

"the hardware is allowed VID frames" ?

> +  bridge might be allowed provided that there is sufficient separation u=
sing
> +  e.g.: a reserved VLAN ID (4095 for instance) for untagged traffic.
> +
> +- with VLAN filtering turned on, these VLAN devices should not be allowe=
d to
> +  be created because they duplicate functionality/use case with the brid=
ge's
> +  VLAN functionality.

We always allow VLAN devices to be created. It is just that we don't
allow their *enslavement* to VLAN-aware bridges.

> +
> +Because VLAN filtering can be turned on/off at runtime, the switchdev dr=
iver
> +must be able to re-configure the underlying hardware on the fly to honor=
 the
> +toggling of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the VL=
AN
> +filtering knob at runtime and require a destruction of the bridge device=
(s) and
> +creation of new bridge device(s) with a different VLAN filtering value t=
o
> +ensure VLAN awareness is pushed down to the HW.
> +
> +IGMP snooping
> +~~~~~~~~~~~~~
> +
> +The Linux bridge allows the configuration of IGMP snooping (compile and =
run
> +time) which must be observed by the underlying switchdev network device/=
hardware
> +in the following way:
> +
> +- when IGMP snooping is turned off, multicast traffic must be flooded to=
 all
> +  switch ports within the same broadcast domain. The CPU/management port
> +  should ideally not be flooded and continue to learn multicast traffic =
through
> +  the network stack notifications. If the hardware is not capable of doi=
ng that
> +  then the CPU/management port must also be flooded and multicast filter=
ing
> +  happens in software.
> +
> +- when IGMP snooping is turned on, multicast traffic must selectively fl=
ow
> +  to the appropriate network ports (including CPU/management port) and n=
ot flood
> +  the switch.
> +
> +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Networ=
k
> +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and should a=
lways
> +be flooded.

I'm not sure that these paragraphs are actually needed. You're basically
describing RFC 4541 on which the IGMP snooping functionality in the
Linux bridge is based on.

> +
> +Because IGMP snooping can be turned on/off at runtime, the switchdev dri=
ver must
> +be able to re-configure the underlying hardware on the fly to honor the =
toggling
> +of that option and behave appropriately.
> +
> +A switchdev driver can also refuse to support dynamic toggling of the mu=
lticast
> +snooping knob at runtime and require the destruction of the bridge devic=
e(s)
> +and creation of a new bridge device(s) with a different multicast snoopi=
ng
> +value.

You should probably get the patch that allows this vetoing merged before
sending this documentation patch.

> --=20
> 2.17.1
>=20
