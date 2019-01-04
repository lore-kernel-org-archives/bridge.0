Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=28AGc0HiJHfpxT8qHSz2y36U9i6yalY9MijZ4ERXzYM=;
	b=aNFU5utlUINNyEQvImB29CkGF8E3qxlMSTaJ13yBmaMmObnPopqBBWMM9I7tfF/WnHRgB8lKsD/ckQQNha6flNOIlG3hMc1dG5fSEUo9AvfxrRsFqBS4Mu/3ZYK3nFz+3qupbyzvIj58eau4v95gSJBUt52hymMnZ7xT3Nz8zac=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 4 Jan 2019 13:58:40 +0000
Message-ID: <20190104135837.GB11955@splinter>
References: <20190103224702.21541-1-f.fainelli@gmail.com>
In-Reply-To: <20190103224702.21541-1-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CED3462114767444B1D45481FBF61D36@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2] Documentation: networking: Clarify
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

On Thu, Jan 03, 2019 at 02:47:02PM -0800, Florian Fainelli wrote:
> +A switchdev driver can also refuse to support dynamic toggling of the VL=
AN
> +filtering knob at runtime and require a destruction of the bridge device=
(s) and
> +a creation of new bridge device(s) with a different VLAN filtering value=
 to
> +ensure VLAN awareness is pushed down to the HW.

...

> +Similarly to VLAN filtering, if dynamic toggling of the IGMP snooping

I think you meant to continue this sentence with something about vetoing
the operation. Note that it is not currently possible as
br_mc_disabled_update() returns void. Can be extended if needed.

> --=20
> 2.17.1
>=20
