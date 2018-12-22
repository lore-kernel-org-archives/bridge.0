Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; bh=APXgaTAGYFKoYPXG0Ac93mDlqQ1YAmcb/GDYqu8Ch
	oQ=; b=Bv2IfrdZwCJaPDUv0DLfVMKmDJzpHLtkRLFWz93fZbQr1s7X9yLfKX3Ve
	hrCRWAZGyBk+4nsmPx3ZRSRDwo/4inWSpky3eb022eK8nsDlPBGIHtP3NaMlv3PM
	lBCxmaxEgEsbk7PcQ1fqRdDi2WTHsJa9kVuodzs7j1k7RjhXyddHn6539xp8OUjt
	1vlWNGFfXnWDfQ52T4WVh5Qk2xrEjOOkBbf0tCGVEfH92MKkLMtiEbgWPY7nBVh3
	VD1ocW+vibNPdyu0400tyE9IwqsyYD0UTE/hhLgSfzcNhCt0cGa1j6DnTeWxUqr9
	bUWFDGa/huoWSCQQv1hNGCFRAcnaw==
Date: Sat, 22 Dec 2018 22:29:12 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181222202912.GA20191@splinter>
References: <20181212230943.757-1-f.fainelli@gmail.com>
	<20181216082517.GA31098@splinter>
	<af53dd72-aac6-4b35-933a-17b27d3398ef@gmail.com>
	<20181218070134.GA19817@splinter>
	<d8c02429-0cab-a798-f1c9-4b8d5cb2dd33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d8c02429-0cab-a798-f1c9-4b8d5cb2dd33@gmail.com>
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Dec 18, 2018 at 12:13:38PM -0800, Florian Fainelli wrote:
> On 12/17/18 11:01 PM, Ido Schimmel wrote:
> > On Sun, Dec 16, 2018 at 09:14:09AM -0800, Florian Fainelli wrote:
> >> Le 12/16/18 =E0 12:25 AM, Ido Schimmel a =E9crit=A0:
> >>> On Wed, Dec 12, 2018 at 03:09:43PM -0800, Florian Fainelli wrote:
> >>>> +Non-bridged network ports of the same switch fabric must not be dis=
turbed in any
> >>>> +way, shape or form by the enabling of VLAN filtering.
> >>>> +
> >>>> +VLAN devices configured on top of a switchdev network device (e.g: =
sw0p1.100)
> >>>> +which is a bridge port member must also observe the following behav=
ior:
> >>>> +
> >>>> +- with VLAN filtering turned off, these VLAN devices must be fully =
functional
> >>>> +  since the hardware is allowed VID frames
> >>>> +
> >>>> +- with VLAN filtering turned on, these VLAN devices are not going t=
o be
> >>>> +  functional unless the bridge's VLAN database is also configured t=
o have that
> >>>> +  VID enabled for the underlying network device/port
> >>>> +  (e.g: bridge vlan add vid 100 dev sw0p1)
> >>>
> >>> mlxsw forbids the enslavement of VLAN devices to VLAN-aware bridges. =
It
> >>> doesn't really make sense to enable VLAN filtering when all the packe=
ts
> >>> are untagged.
> >>
> >> Did you mean VLAN-unaware here, otherwise that would contradict the
> >> statement that VLAN-aware bridges mean everything untagged, or am I
> >> incorrectly understanding things here?
> >=20
> > I meant VLAN-aware... In a VLAN-unaware bridge the VLAN is meaningless.
> > For example, there is no filtering based on VLAN at ingress/egress and
> > FDB entries are only searched based on MAC (VLAN is always 0). This is
> > in contrast to a VLAN-aware bridge.
> >=20
> > When you enslave VLAN netdevs to a bridge, the bridge sees untagged
> > packets. The VLAN tag is pulled from the packet in Rx path and then the
> > packet is injected to the bridge via the Rx handler configured on the
> > VLAN netdev. Therefore, there is point in enslaving these device to a
> > VLAN-aware bridge.
>=20
> I see what you describe and that is not quite what I was talking about,
> see below.
>=20
> >=20
> > Also, mlxsw only supports a single VLAN-aware bridge. You can however,
> > configure 1K VLAN-unaware bridges.
>=20
> OK, how do you enforce that in the driver? I was going to do something
> as basic as: loop around all ports that are not the one being changed by
> VLAN filtering attribute, if bridge device associated is non-NULL and
> br_vlan_enabled() returns true for that bridge and we want to turn off
> VLAN filtering, then this is not possible since that would break the
> other bridge devices we have which are VLAN filtering enabled.

See mlxsw_sp_bridge_device_create(). We basically keep a list of bridges
we care about. If one is already VLAN aware, then we fail the creation
of another bridge.

>=20
> >=20
> >>> But I disagree with the comment about the underlying port. When you
> >>> configured the VLAN device, it should have enabled the VLAN filters on
> >>> the real device via ndo_vlan_rx_add_vid().
> >>
> >> That is really why I submitted this patch, because right now I have a
> >> patch (yet to be submitted) which adds ndo_vlan_rx_{add,kill}_vid() and
> >> if the underlying device is enslaved into a bridge, I just do nothing
> >> and let the bridge control the VLAN membership, hence my comment and
> >> example here.
> >>
> >> What you are saying is that we should have these two cases:
> >>
> >> 1) VLAN devices on top of VLAN unaware bridge: allow the VLAN device a=
nd
> >> program VLAN filter on the underlying switch port to permit VLAN taggi=
ng
> >=20
> > When you say "on top" you mean enslaved to?
>=20
> I meant to write: a VLAN device created on (top of) a switch port, and
> this switch port being a bridge member. The VLAN device would not be
> added as a bridge member (did not really think about it).
>=20
> >=20
> >> 2) VLAN devices on top of a VLAN aware bridge: deny the VLAN device
> >> creation and let the bridge, which is VLAN aware manage the port VLAN
> >> membership
> >=20
> > mlxsw does not forbid the creation of the VLAN device. It only forbids
> > its enslavement to a VLAN-aware bridge.
>=20
> That's done in mlxsw_sp_netdevice_port_vlan_event() right?

Almost :) See mlxsw_sp_bridge_8021q_port_join()
