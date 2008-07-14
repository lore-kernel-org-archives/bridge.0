Message-ID: <487B18CD.5020502@katalix.com>
Date: Mon, 14 Jul 2008 10:13:49 +0100
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
References: <4876FDF0.1030807@iki.fi> <487AA0CD.9090600@snapgear.com>
	<487AFF82.4090707@iki.fi> <487B11D9.7090800@snapgear.com>
In-Reply-To: <487B11D9.7090800@snapgear.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Craig <philipc@snapgear.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, =?ISO-8859-1?Q?Timo_Ter=E4s?= <timo.teras@iki.fi>

Philip Craig wrote:
> Timo Ter=E4s wrote:
> I posted a cleaner version that's similar to what the old patch
> did, see http://marc.info/?l=3Dlinux-netdev&m=3D115449948503549&w=3D2
>=20
> But I don't think that is the right approach:
> - it forces you to use bridging if you only want ethernet over GRE
> - the change fundamentally has nothing to do with bridging

I agree.

> It could be a new device that sits on top of GRE and simply does
> ethernet encapsulation then passes it to the raw GRE device.

This would be my preferred approach. There are other drivers that use a=20
netdev to do some encap/decap processing on packets which are then=20
passed on to another driver, e.g. macvlan, and it works well.

--=20
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development

