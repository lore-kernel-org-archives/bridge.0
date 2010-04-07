From: "Ryan King" <ryank@globaldial.com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>	<000001cad5e4$fcc81030$f6583090$@com>	<g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>	<p2m1803dfd21004061941zfc89ca1fve66f35ec099e8ea6@mail.gmail.com>
	<n2hc5b98f841004062001ie80b2130ma08829633315c3c@mail.gmail.com>
In-Reply-To: <n2hc5b98f841004062001ie80b2130ma08829633315c3c@mail.gmail.com>
Date: Wed, 7 Apr 2010 11:21:07 +0800
Message-ID: <000101cad601$5d42a300$17c7e900$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-au
Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Robert LeBlanc' <robert@leblancnet.us>, Ryan Whelan <ryan.whelan@tbamerica.com>
Cc: bridge@lists.linux-foundation.org

> -----Original Message-----
> From: bridge-bounces@lists.linux-foundation.org [mailto:bridge-
> bounces@lists.linux-foundation.org] On Behalf Of Robert LeBlanc
> Sent: Wednesday, 7 April 2010 11:02 AM
> To: Ryan Whelan
> Cc: bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
>=20
> On Tue, Apr 6, 2010 at 8:41 PM, Ryan Whelan =
<ryan.whelan@tbamerica.com>
> wrote:
> > oh good- glad to find out im not crazy. we do have 2 pNICs in the
> external
> > facing vSwitch.=A0 Even when setting them as active/passive, its =
still
> an
> > issue.
> >
> > so its a confirmed issue with vmware- do they have any intention on
> > correcting it? do we know?
> >
>=20
> Yes as long as the pNIC is attached, even if in standby mode it causes
> a problem.
>=20
> It is an issue, but they won't fix it for two reasons. 1. They will
> never create a bridge between two vSwitches/VLANs, and 2. a fix would
> introduce more overhead and reduce flexibility and since they adhere
> to #1, it doesn't make sense. The flexibility they lose is multiple
> pNICs to one or more switches without having to have any trunking
> protocols.
>=20
> You can get around the problem by buying the Cisco Nexus virtual
> switch, it's a real layer 3 switch, but it's a pricy option.
>=20
> If you want a bridge in a VM, then only pNIC per switch (no
> redundancy). The other option, try to make the bridge a router
> instead. For us we wanted a transparent firewall, so it was easy to
> change the configuration to proxyarp for a transparent router instead.
>=20

Just to clarify our setup:

The physical server has 4 physical nics.  vswitch1 uses 2 pnics in
active/active.  vswitch2 uses 2 pnics in active/active.

The VM (running openvpn) has a bridge with one vnic on vswitch1 and one =
vnic
on vswitch2.  Since moving the 2nd interface to vswitch2, I have not
experienced this issue any more (ie: previously, both vnics were on =
vswitch1
- this was where we saw this issue).

Ryan King



