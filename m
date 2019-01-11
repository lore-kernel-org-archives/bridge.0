Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JwxmY34s3I0BXIK1MktaYWuH15UJq1Towf0251sjd6Y=;
	b=dV55cbZlHFGqU1tmzN2CYx+wYaW0vrHSaN1D/QsuOmfIkV3YJO//twV+ng9oiqgunuLzNuq8mmKAcCcCC3BxDk4j688TdxLKZTJmXworammaoiJJvawalFzrOI/umH47lyHJKoqrNFPRUxUh5RRehkj7vZBO9cgjaVpJWh4409E=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 11 Jan 2019 15:53:08 +0000
Message-ID: <20190111155306.GA13197@splinter.mtl.com>
References: <20190110193206.9872-1-f.fainelli@gmail.com>
	<20190111150637.GA897@splinter.mtl.com>
	<20190111154331.GE20924@lunn.ch>
In-Reply-To: <20190111154331.GE20924@lunn.ch>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56E563C58EBE924EAC7BB506CC1F23CE@eurprd05.prod.outlook.com>
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "ivan.khoronzhuk@linaro.org" <ivan.khoronzhuk@linaro.org>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>

On Fri, Jan 11, 2019 at 04:43:31PM +0100, Andrew Lunn wrote:
> > > +IGMP snooping
> > > +~~~~~~~~~~~~~
> > > +
> > > +The Linux bridge allows the configuration of IGMP snooping (compile =
and run
> > > +time) which must be observed by the underlying switchdev network dev=
ice/hardware
> > > +in the following way:
> > > +
> > > +- when IGMP snooping is turned off, multicast traffic must be floode=
d to all
> > > +  switch ports within the same broadcast domain. The CPU/management =
port
> > > +  should ideally not be flooded and continue to learn multicast traf=
fic through
> > > +  the network stack notifications. If the hardware is not capable of=
 doing that
> > > +  then the CPU/management port must also be flooded and multicast fi=
ltering
> > > +  happens in software.
> > > +
> > > +- when IGMP snooping is turned on, multicast traffic must selectivel=
y flow
> > > +  to the appropriate network ports (including CPU/management port) a=
nd not flood
> > > +  the switch.
> > > +
> > > +Note: reserved multicast addresses (e.g.: BPDUs) as well as Local Ne=
twork
> > > +Control block (224.0.0.0 - 224.0.0.255) do not require IGMP and shou=
ld always
> > > +be flooded.
> >=20
> > I'm not sure that these paragraphs are actually needed. You're basicall=
y
> > describing RFC 4541 on which the IGMP snooping functionality in the
> > Linux bridge is based on.
>=20
> Hi Ido
>=20
> My experience talking with people is that IGMP snooping is a bit
> mystical and not well understood. I would not be surprised if
> community driver writers, as opposed to vendor driver writers, don't
> actually know how snooping works. So i find having some hints is good.

Can we at least mention this RFC is the doc? It's very well written IMO
