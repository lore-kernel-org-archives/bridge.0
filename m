Return-Path: <ioana.ciornei@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pEjT/2fo2QnyQ+APAtTGrsQpk67QJ8XNuYPuVUbdoY=;
 b=PuT2BKiXh/q7+W+yvtn8bpxmuNEH0XqwjDPBiILzE2sOfttV5rksJeyaDJjMUuKGYJ8NvqyIMh7VekakluRIAPcunDwN3SO2esZd66QRfgaSTgh/8/YrHkUR1ImrFg8p61tlN7ycd9yqpauwRsfdNLmwbptvl/w4L6yk3wz66R4=
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Mon, 19 Jul 2021 09:18:45 +0000
Message-ID: <20210719091844.p3sxdudgiahy4cjs@skbuf>
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-3-vladimir.oltean@nxp.com>
In-Reply-To: <20210718214434.3938850-3-vladimir.oltean@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB453C80B7E28B4AADCBE2B92D46DB0E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 02/15] net: dpaa2-switch: refactor
 prechangeupper sanity checks
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

On Mon, Jul 19, 2021 at 12:44:21AM +0300, Vladimir Oltean wrote:
> Make more room for some extra code in the NETDEV_PRECHANGEUPPER handler
> by moving what already exists into a dedicated function.
>=20
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>
