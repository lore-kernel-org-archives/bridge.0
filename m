Return-Path: <ioana.ciornei@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGc3gl8RjegVmXP7SKg8cy3ohNLVad0xr3bfCMugcxA=;
 b=lkm1wljBmIDXDMk53PCwvet1IRmyaEMxT4Q9Nb800iX9Z5NauQ02DFd50OR2uewrMx8ivcbsOiDNVAyZb93U1tAKvfvJB+yW+4qBwyFCLZmP0/EpTTLu5tHBwjQlMfObIofFqjUinncfbbXKbmdLGD/k8VeXiRVtgY+RBftyUEA=
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Mon, 19 Jul 2021 09:17:00 +0000
Message-ID: <20210719091658.lqczq4w3icqvuhj4@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-2-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-2-vladimir.oltean@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <828456CF8CC1924BB34F2EA70D4E0831@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 01/15] net: dpaa2-switch: use
 extack in dpaa2_switch_port_bridge_join
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 19, 2021 at 12:44:20AM +0300, Vladimir Oltean wrote:
> We need to propagate the extack argument for
> dpaa2_switch_port_bridge_join to use it in a future patch, and it looks
> like there is already an error message there which is currently printed
> to the console. Move it over netlink so it is properly transmitted to
> user space.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>=
