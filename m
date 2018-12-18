Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lFPm2vwi0oSAEeJaVmqrGCzLbzby+W/TUoG5R2504Xw=;
	b=QDwSbpK6Ga1trY8xmQLbevIO65fPtLsclBrGQhFK7SuFxs2ACxUpscZ3dqUq0rwlFoDGl9Q9ulFjywNIyM2xie78LHxFsLXP2S/Zq/RrfJ3PeH8EAjig3DuRvxM1vFYtJFXZZY/MDl/W090RAcVckCfmC6EE5NUqBwFHvwwH56o=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 18 Dec 2018 07:01:36 +0000
Message-ID: <20181218070134.GA19817@splinter>
References: <20181212230943.757-1-f.fainelli@gmail.com>
	<20181216082517.GA31098@splinter>
	<af53dd72-aac6-4b35-933a-17b27d3398ef@gmail.com>
In-Reply-To: <af53dd72-aac6-4b35-933a-17b27d3398ef@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CA68C28986584B4FB651FEEEF8A3A390@eurprd05.prod.outlook.com>
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

On Sun, Dec 16, 2018 at 09:14:09AM -0800, Florian Fainelli wrote:
> Le 12/16/18 =E0 12:25 AM, Ido Schimmel a =E9crit=A0:
> > On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:
> >> +Non-bridged network ports of the same switch fabric must not be distu=
rbed in any
> >> +way, shape or form by the enabling of VLAN filtering.
> >> +
> >> +VLAN devices configured on top of a switchdev network device (e.g: sw=
0p1.100)
> >> +which is a bridge port member must also observe the following behavio=
r:
> >> +
> >> +- with VLAN filtering turned off, these VLAN devices must be fully fu=
nctional
> >> +  since the hardware is allowed VID frames
> >> +
> >> +- with VLAN filtering turned on, these VLAN devices are not going to =
be
> >> +  functional unless the bridge's VLAN database is also configured to =
have that
> >> +  VID enabled for the underlying network device/port
> >> +  (e.g: bridge vlan add vid 100 dev sw0p1)
> >=20
> > mlxsw forbids the enslavement of VLAN devices to VLAN-aware bridges. It
> > doesn't really make sense to enable VLAN filtering when all the packets
> > are untagged.
>=20
> Did you mean VLAN-unaware here, otherwise that would contradict the
> statement that VLAN-aware bridges mean everything untagged, or am I
> incorrectly understanding things here?

I meant VLAN-aware... In a VLAN-unaware bridge the VLAN is meaningless.
For example, there is no filtering based on VLAN at ingress/egress and
FDB entries are only searched based on MAC (VLAN is always 0). This is
in contrast to a VLAN-aware bridge.

When you enslave VLAN netdevs to a bridge, the bridge sees untagged
packets. The VLAN tag is pulled from the packet in Rx path and then the
packet is injected to the bridge via the Rx handler configured on the
VLAN netdev. Therefore, there is point in enslaving these device to a
VLAN-aware bridge.

Also, mlxsw only supports a single VLAN-aware bridge. You can however,
configure 1K VLAN-unaware bridges.

> > But I disagree with the comment about the underlying port. When you
> > configured the VLAN device, it should have enabled the VLAN filters on
> > the real device via ndo_vlan_rx_add_vid().
>=20
> That is really why I submitted this patch, because right now I have a
> patch (yet to be submitted) which adds ndo_vlan_rx_{add,kill}_vid() and
> if the underlying device is enslaved into a bridge, I just do nothing
> and let the bridge control the VLAN membership, hence my comment and
> example here.
>=20
> What you are saying is that we should have these two cases:
>=20
> 1) VLAN devices on top of VLAN unaware bridge: allow the VLAN device and
> program VLAN filter on the underlying switch port to permit VLAN tagging

When you say "on top" you mean enslaved to?

> 2) VLAN devices on top of a VLAN aware bridge: deny the VLAN device
> creation and let the bridge, which is VLAN aware manage the port VLAN
> membership

mlxsw does not forbid the creation of the VLAN device. It only forbids
its enslavement to a VLAN-aware bridge.

> In case 1) or 2) if the desire is to have a VLAN aware network device
> this can be either done through a VLAN device on top of the switch port,
> or through a VLAN device on top of the bridge master itself, and in
> either case, this amounts to doing about the same thing.
>=20
> Did I get this right?

I'm saying that a VLAN-aware bridge with VIDs 10-100 (for example) is
equivalent to VLAN devices with VIDs 10-100 enslaved to br10-br100,
respectively. It is up to you if you want to / can support both modes.
We support both, but most / all users use the VLAN-aware bridge.
