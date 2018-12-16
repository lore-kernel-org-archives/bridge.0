Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KpS3oYsdp/nEyVbG/IqAhpgXUv6vwhxPx9gkQfugG28=;
	b=tZti7ePNPNSlMnfkwBiWprRUhql4oIpyyeNGj8jEOHsa8SW+J7pXuFH7bVLuTqMlKl+Xc8d5YFlpaXDMxO9LI0fanfaEIYzk55A0GTmG43RrW5idtrPG8GcB1jrYsiQoUryumXNuAHhnAk183pOfClb+lDz46yQ9gQgLW5DCVvk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 16 Dec 2018 08:25:19 +0000
Message-ID: <20181216082517.GA31098@splinter>
References: <20181212230943.757-1-f.fainelli@gmail.com>
In-Reply-To: <20181212230943.757-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CD1B11964D72546A7B1CB7F0148D14F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] Documentation: networking: Clarify
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:
> This patch provides details on the expected behavior of switchdev
> enabled network devices when operating in a "stand alone" mode, as well
> as when being bridge members. This clarifies a number of things that
> recently came up during a bug fixing session on the b53 DSA switch
> driver.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Hi all,
>=20
> Please review carefully, and let me know if you think some of the
> behaviors described below do not make any sense. Thanks!
>=20
>  Documentation/networking/switchdev.txt | 86 ++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/Documentation/networking/switchdev.txt b/Documentation/netwo=
rking/switchdev.txt
> index 82236a17b5e6..8c83174b477b 100644
> --- a/Documentation/networking/switchdev.txt
> +++ b/Documentation/networking/switchdev.txt
> @@ -392,3 +392,89 @@ switchdev_trans_item_dequeue()
> =20
>  If a transaction is aborted during "prepare" phase, switchdev code will =
handle
>  cleanup of the queued-up objects.
> +
> +Switchdev enabled network device expected behavior
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Below is a set of defined behavior that switchdev enabled network device=
 must be
> +adhering to.
> +
> +Configuration less state
> +------------------------
> +
> +Upon driver bring up, the network devices must be fully operational, and=
 the
> +backing driver must be configuring the network device such that it is po=
ssible
> +to send and receive to this network device such that it is properly sepa=
rate
> +from other network devices/ports (e.g: as is frequenty with a switch ASI=
C). How
> +this is achieved is heavily hardware dependent, but a simple solution ca=
n be to
> +use per-port VLAN identifiers.
> +
> +The network device must be capable of running a full IP protocol stack m=
ust be
> +working, including multicast, DHCP, IPv4/6, etc. If necessary, it should=
 be
> +programming the appropriate filters for VLAN, multicast, unicast etc. Th=
e
> +underlying device driver must effectively be configured in a similar fas=
hion to
> +what it would do when IGMP snooping is enabled for IP multicast over the=
se
> +switchdev network devices and unsollicited multicast must be filtered as=
 early
> +as possible into the hardware.
> +
> +When configuring VLANs on top of the network device, all VLANs must be w=
orking,
> +irrespective of the state of other network devices (e.g: other ports bei=
ng part
> +of a VLAN aware bridge doing ingress VID checking). See below for detail=
s.
> +
> +Bridged network devices
> +-----------------------
> +
> +When a switchdev enabled network device is added as a bridge member, it =
should
> +not be disrupting any functionality of non-bridged network devices and t=
hey
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

mlxsw doesn't support it. These bridges are mainly used with VLAN
devices where the packets ingress the bridge untagged. When configured
over physical ports, we only allow untagged packets into such a bridge.

> +
> +- with VLAN filtering turned on: frames ingressing the device with a VID=
 that is
> +  not programmed into the bridges/switch's VLAN table must be dropped.

ack

> +
> +Non-bridged network ports of the same switch fabric must not be disturbe=
d in any
> +way, shape or form by the enabling of VLAN filtering.
> +
> +VLAN devices configured on top of a switchdev network device (e.g: sw0p1=
.100)
> +which is a bridge port member must also observe the following behavior:
> +
> +- with VLAN filtering turned off, these VLAN devices must be fully funct=
ional
> +  since the hardware is allowed VID frames
> +
> +- with VLAN filtering turned on, these VLAN devices are not going to be
> +  functional unless the bridge's VLAN database is also configured to hav=
e that
> +  VID enabled for the underlying network device/port
> +  (e.g: bridge vlan add vid 100 dev sw0p1)

mlxsw forbids the enslavement of VLAN devices to VLAN-aware bridges. It
doesn't really make sense to enable VLAN filtering when all the packets
are untagged.

But I disagree with the comment about the underlying port. When you
configured the VLAN device, it should have enabled the VLAN filters on
the real device via ndo_vlan_rx_add_vid().

> +
> +Because VLAN filtering can be turned on/off at runtime, the switchdev dr=
iver
> +must be able to re-configure the underlying hardware on the fly to honor=
 the
> +toggling of that option and behave appropriately.

Please mention that switchdev drivers can refuse the operation.
