Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rMXcoMtY4tfRD+KIYYini9vBDpBrUAnADMOFbEeoq5I=;
	b=XSJ62TRfDSl3xtQXnI02rGJJ6H3KjZ8/eoU6dpqQjUfS37i/wsieoIjLaWhrAp4/WDDXED11lFW0RNe/344oDTNl4bh9aAIeNC4wX4UMTwB2n+dRcriLSMfyUFjpFgOeq+oMVvsEIxhLI9MHgbCw0DNrbNBP4kIK8XOD+TK8xvs=
From: Ido Schimmel <idosch@mellanox.com>
Date: Mon, 11 Feb 2019 21:40:44 +0000
Message-ID: <20190211214039.GA4947@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
	<20190211.121657.2204380606625115977.davem@davemloft.net>
In-Reply-To: <20190211.121657.2204380606625115977.davem@davemloft.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A59CAE415BE5F943B2174DFFA1A0595D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 0/9] net: Remove switchdev_ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>

On Mon, Feb 11, 2019 at 12:16:57PM -0800, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Mon, 11 Feb 2019 11:09:52 -0800
>=20
> > David, I would like to get Ido's feedback on this to make sure I did no=
t
> > miss something, thank you!
>=20
> Ok, Ido please look at this when you can.

Will review tomorrow. I was occupied with other stuff last couple of
days. Sorry
