From: "Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu>
References: <0199E0D51A61344794750DC57738F58E6D6A6CD7F6@GVW1118EXC.americas.hpqcorp.net>
In-Reply-To: 
Date: Fri, 7 Aug 2009 12:10:07 -0700
Message-ID: <004f01ca1792$b24a7a90$16df6fb0$@edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: drobbins@funtoo.org
Cc: ogerlitz@voltaire.com, herbert@gondor.apana.org.au, 'Arnd Bergmann' <arnd@arndb.de>, mst@redhat.com, "'Fischer,
	Anna'" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "'Paul Congdon (UC Davis)'" <ptcongdon@ucdavis.edu>, evb@yahoogroups.com, davem@davemloft.net

Responding to Daniel's questions...

> I have some general questions about the intended use and benefits of=20
> VEPA, from an IT perspective:
>=20
> In which virtual machine setups and technologies do you forsee this=20
> interface being used?

The benefit of VEPA is the coordination and unification with the =
external network switch.  So, in environments where you are =
needing/wanting your feature rich, wire speed, external network device =
(firewall/switch/IPS/content-filter) to provide consistent policy =
enforcement, and you want your VMs traffic to be subject to that =
enforcement, you will want their traffic directed externally.  Perhaps =
you have some VMs that are on a DMZ or clustering an application or =
implementing a multi-tier application where you would normally place a =
firewall in-between the tiers.

> Is this new interface to be used within a virtual machine or=20
> container, on the master node, or both?

It is really an interface to a new type of virtual switch.  When you =
create virtual network, I would imagine it being a new mode of operation =
(bridge, NAT, VEPA, etc).

> What interface(s) would need to be configured for a single virtual=20
> machine to use VEPA to access the network?

It would be the same as if that machine were configure to use a bridge =
to access the network, but the bridge mode would be different.

> What are the current flexibility, security or performance limitations=20
> of tun/tap and bridge that make this new interface necessary or=20
> beneficial?

If you have VMs that will be communicating with one another on the same =
physical machine, and you want their traffic to be exposed to an in-line =
network device such as a application firewall/IPS/content-filter =
(without this feature) you will have to have this device co-located =
within the same physical server.  This will use up CPU cycles that you =
presumable purchased to run applications, it will require a lot of =
consistent configuration on all physical machines, it could invoke =
potentially a lot of software licensing, additional cost, etc..  =
Everything would need to be replicated on each physical machine.  With =
the VEPA capability, you can leverage all this functionality in an =
external network device and have it managed and configured in one place. =
 The external implementation is likely a higher performance, silicon =
based implementation.  It should make it easier to migrate machines from =
one physical server to another and maintain the same network policy =
enforcement.

> Is this new interface useful at all for VPN solutions or is it
> *specifically* targeted for connecting virtual machines to the=20
> network?

I'm not sure I see the benefit for VPN solutions, but I'd have to =
understand the deployment scenario better.  Certainly this is targeting =
connecting VMs to the adjacent physical LAN.

> Is this essentially a bridge with layer-2 isolation for the virtual=20
> machine interfaces built-in? If isolation is provided, what mechanism=20
> is used to accomplish this, and how secure is it?

That might be an over simplification, but you can achieve layer-2 =
isolation if you connect to a standard external switch.  If that switch =
has 'hairpin' forwarding, then the VMs can talk at L2, but their traffic =
is forced through the bridge.  If that bridge is a security device (e.g. =
firewall), then their traffic is exposed to that.

The isolation in the outbound direction is created by the way frames are =
forwarded.  They are simply dropped on the wire, so no VMs can talk =
directly to one another without their traffic first going external.  In =
the inbound direction, the isolation is created using the forwarding =
table. =20

> Does VEPA look like a regular ethernet interface (eth0) on the virtual =

> machine side?

Yes

> Are there any associated user-space tools required for configuring a=20
> VEPA?
>

The standard brctl utility has been augmented to enable/disable the =
capability.
=20
> Do you have any HOWTO-style documentation that would demonstrate how=20
> this interface would be used in production? Or a FAQ?
>

None yet.
=20
> This seems like a very interesting effort but I don't quite have a=20
> good grasp of VEPA's benefits and limitations -- I imagine that others =

> are in the same boat too.
>=20

There are some seminar slides available on the IEEE 802.1 web-site and =
elsewhere.  The patch had a reference to a seminar, but here is another =
one you might find helpful:

http://www.internet2.edu/presentations/jt2009jul/20090719-congdon.pdf

I'm happy to try to explain further...

Paul


